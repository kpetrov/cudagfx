/*
 * Copyright 1993-2010 NVIDIA Corporation.  All rights reserved.
 *
 * NVIDIA Corporation and its licensors retain all intellectual property and 
 * proprietary rights in and to this software and related documentation. 
 * Any use, reproduction, disclosure, or distribution of this software 
 * and related documentation without an express license agreement from
 * NVIDIA Corporation is strictly prohibited.
 *
 * Please refer to the applicable NVIDIA end user license agreement (EULA) 
 * associated with this source code for terms and conditions that govern 
 * your use of this NVIDIA software.
 * 
 */

/*
 * This sample implements Mersenne Twister random number generator 
 * and Cartesian Box-Muller transformation on the GPU.
 * See supplied whitepaper for more explanations.
 */


#include "MersenneTwister.h"



///////////////////////////////////////////////////////////////////////////////
// Common host and device function 
///////////////////////////////////////////////////////////////////////////////
//ceil(a / b)
extern "C" int iDivUp(int a, int b){
    return ((a % b) != 0) ? (a / b + 1) : (a / b);
}

//floor(a / b)
extern "C" int iDivDown(int a, int b){
    return a / b;
}

//Align a to nearest higher multiple of b
extern "C" int iAlignUp(int a, int b){
    return ((a % b) != 0) ?  (a - a % b + b) : a;
}

//Align a to nearest lower multiple of b
extern "C" int iAlignDown(int a, int b){
    return a - a % b;
}



///////////////////////////////////////////////////////////////////////////////
// Data configuration
///////////////////////////////////////////////////////////////////////////////
static int    PATH_N_GAUSS;
static int    PATH_N_UNIF;
static int    N_PER_RNG_GAUSS;
static int    N_PER_RNG_UNIF;
static int    RAND_N_GAUSS;
static int    RAND_N_UNIF;





__device__  mt_struct_stripped ds_MT[MT_RNG_COUNT];
static mt_struct_stripped h_MT[MT_RNG_COUNT];
__device__ unsigned int d_mtstatus[MT_RNG_COUNT][MT_NN];


// fields for the MT random number generator
//__device__ float * dev_rndunif_field;
//__device__ float * dev_rndgauss_field;




//Load twister configurations
void loadMTGPU(const char *fname){
    FILE *fd = fopen(fname, "rb");
    if(!fd){
        printf("initMTGPU(): failed to open %s\n", fname);
        printf("FAILED\n");
        exit(0);
    }
    if( !fread(h_MT, sizeof(h_MT), 1, fd) ){
        printf("initMTGPU(): failed to load %s\n", fname);
        printf("FAILED\n");
        exit(0);
    }
    fclose(fd);
}




//Initialize/seed twister for current GPU context
void seedMTGPU(){
    int i;
    //Need to be thread-safe
    mt_struct_stripped *MT = (mt_struct_stripped *)malloc(MT_RNG_COUNT * sizeof(mt_struct_stripped));

    /* initialize poor rng: */
    srand ( time(NULL) );

    /* initialize MT rng seeds */
    for(i = 0; i < MT_RNG_COUNT; i++){
        MT[i]      = h_MT[i];
        MT[i].seed = (unsigned int) rand();
    }
    CUDA_SAFE_CALL( cudaMemcpyToSymbol(ds_MT, MT, sizeof(h_MT)) );

    free(MT);
}



//Save twister for current GPU context
void saveMTGPU(const char *fname){
    FILE *fd = fopen(fname, "w");
    if(!fd){
        printf("saveMTGPU(): failed to open %s\n", fname);
        printf("FAILED\n");
        exit(0);
    }
    fwrite(h_MT, sizeof(h_MT), 1, fd);
    fclose(fd);
}




////////////////////////////////////////////////////////////////////////////////
// Write MT_RNG_COUNT vertical lanes of NPerRng random numbers to *d_Random.
// For coalesced global writes MT_RNG_COUNT should be a multiple of warp size.
// Initial states for each generator are the same, since the states are
// initialized from the global seed. In order to improve distribution properties
// on small NPerRng supply dedicated (local) seed to each twister.
// The local seeds, in their turn, can be extracted from global seed
// by means of any simple random number generator, like LCG.
////////////////////////////////////////////////////////////////////////////////
__global__ void RandomGPU(
    float *d_Random,
    int NPerRng, int initialized
){
    const int      tid = blockDim.x * blockIdx.x + threadIdx.x;
    const int THREAD_N = blockDim.x * gridDim.x;

    int iState, iState1, iStateM, iOut;
    unsigned int mti, mti1, mtiM, x;
    unsigned int mt[MT_NN];

    for(int iRng = tid; iRng < MT_RNG_COUNT; iRng += THREAD_N){
        //Load bit-vector Mersenne Twister parameters
        mt_struct_stripped config = ds_MT[iRng];

       if(!initialized){
         // initialize seed and construct status mt must be initialized from host before
         mt[0] = ds_MT[iRng].seed;
         for(iState = 1; iState < MT_NN; iState++)
            mt[iState] = (1812433253U * (mt[iState - 1] ^ (mt[iState - 1] >> 30)) + iState) & MT_WMASK;
       } 
       else{
         for(iState = 0; iState < MT_NN; iState++) mt[iState] = d_mtstatus[iRng][iState];
       } 
        
        iState = 0;
        mti1 = mt[0];
        for(iOut = 0; iOut < NPerRng; iOut++){
            //iState1 = (iState +     1) % MT_NN
            //iStateM = (iState + MT_MM) % MT_NN
            iState1 = iState + 1;
            iStateM = iState + MT_MM;
            if(iState1 >= MT_NN) iState1 -= MT_NN;
            if(iStateM >= MT_NN) iStateM -= MT_NN;
            mti  = mti1;
            mti1 = mt[iState1];
            mtiM = mt[iStateM];

            x    = (mti & MT_UMASK) | (mti1 & MT_LMASK);
            x    =  mtiM ^ (x >> 1) ^ ((x & 1) ? config.matrix_a : 0);
            mt[iState] = x;
            iState = iState1;

            //Tempering transformation
            x ^= (x >> MT_SHIFT0);
            x ^= (x << MT_SHIFTB) & config.mask_b;
            x ^= (x << MT_SHIFTC) & config.mask_c;
            x ^= (x >> MT_SHIFT1);

            //Convert to (0, 1] float and write to global memory
            d_Random[iRng + iOut * MT_RNG_COUNT] = ((float)x + 1.0f) / 4294967296.0f;
        }
        
       // save status of mt
       ds_MT[iRng].seed = mt[0]; 
       for(iState = 0; iState < MT_NN; iState++) d_mtstatus[iRng][iState] = mt[iState]; 
    }
}



////////////////////////////////////////////////////////////////////////////////
// Transform each of MT_RNG_COUNT lanes of NPerRng uniformly distributed 
// random samples, produced by RandomGPU(), to normally distributed lanes
// using Cartesian form of Box-Muller transformation.
// NPerRng must be even.
////////////////////////////////////////////////////////////////////////////////
#define PIf 3.14159265358979f
__device__ inline void BoxMuller(float& u1, float& u2){
    float   r = sqrtf(-2.0f * logf(u1));
    float phi = 2 * PIf * u2;
    u1 = r * __cosf(phi);
    u2 = r * __sinf(phi);
}



__global__ void BoxMullerGPU(float *d_Random, int NPerRng){
    const int      tid = blockDim.x * blockIdx.x + threadIdx.x;
    const int THREAD_N = blockDim.x * gridDim.x;

    for(int iRng = tid; iRng < MT_RNG_COUNT; iRng += THREAD_N)
        for(int iOut = 0; iOut < NPerRng; iOut += 2)
            BoxMuller(
                d_Random[iRng + (iOut + 0) * MT_RNG_COUNT],
                d_Random[iRng + (iOut + 1) * MT_RNG_COUNT]
            );
}






extern "C" void init_MT(int n_gaussnumbers, int n_unifnumbers){
 
 
  cudaError_t cudaerr;
  //determine sizes for gauss numbers
  
  printf("Initializing MT random number generator...\n");
  
  
  PATH_N_GAUSS = n_gaussnumbers;
  N_PER_RNG_GAUSS = iAlignUp(iDivUp(PATH_N_GAUSS, MT_RNG_COUNT), 2);
  RAND_N_GAUSS = MT_RNG_COUNT * N_PER_RNG_GAUSS;
  printf("No. of gauss random numbers: %d\n", RAND_N_GAUSS );
   
  //determine sizes for unif. numbers 
  PATH_N_UNIF = n_unifnumbers;
  N_PER_RNG_UNIF = iAlignUp(iDivUp(PATH_N_UNIF, MT_RNG_COUNT), 2);
  RAND_N_UNIF = MT_RNG_COUNT * N_PER_RNG_UNIF; 
  printf("No. of unif. dist. random numbers: %d\n", RAND_N_UNIF );
   
  // load and initialize twister configurations on device 
  // seed the twisters
  const char *dat_path = "MersenneTwister.dat";
  printf("Loading GPU twisters configurations from file %s...\n", dat_path);
  loadMTGPU(dat_path);
  seedMTGPU();

  //allocate fields for random numbers
  printf("Allocating device memory for random numbers...\n");
  CUDA_SAFE_CALL(cudaMalloc((void **)&dev_rndgauss_field, RAND_N_GAUSS * sizeof(float)) );
  CUDA_SAFE_CALL(cudaMalloc((void **)&dev_rndunif_field, RAND_N_UNIF * sizeof(float)));


 // CREATE FIRST RANDOM NUMBERS 
 /* update the random field for gauss numbers -> BoxMuller afterwards*/
    cudaThreadSynchronize();
    RandomGPU<<<32, 128>>>(dev_rndgauss_field, N_PER_RNG_GAUSS,0);
    BoxMullerGPU<<<32, 128>>>(dev_rndgauss_field, N_PER_RNG_GAUSS);

  /* update the random field for unif. dist. numbers*/
    cudaThreadSynchronize();
    RandomGPU<<<32, 128>>>(dev_rndunif_field, N_PER_RNG_UNIF,0);
    cudaThreadSynchronize();
   


   cudaerr = cudaGetLastError();
   if(cudaerr != cudaSuccess){
     printf("%s\n", cudaGetErrorString(cudaerr)); 
   } 



}





extern "C" void update_MT(){


  /* update the random field for gauss numbers -> BoxMuller afterwards*/
    cudaThreadSynchronize();
    RandomGPU<<<32, 128>>>(dev_rndgauss_field, N_PER_RNG_GAUSS,1);
    BoxMullerGPU<<<32, 128>>>(dev_rndgauss_field, N_PER_RNG_GAUSS);
    cudaThreadSynchronize();

    
  /* update the random field for unif. dist. numbers*/  
    RandomGPU<<<32, 128>>>(dev_rndunif_field, N_PER_RNG_UNIF, 1);
    cudaThreadSynchronize();
    
/*
   float * blub = (float*) malloc(RAND_N_UNIF*sizeof(float));
   printf("%d \n", RAND_N_UNIF);
   
   CUDA_SAFE_CALL(cudaMemcpy(blub, dev_rndunif_field, (size_t)(RAND_N_UNIF*sizeof(float)), cudaMemcpyDeviceToHost));
   for(int k=0; k<4; k++){
     for(int j=VOLUME/2-10; j<VOLUME/2; j++){
       printf("%f, ", blub[4*j+k]);
     }
   }
   printf("\n\n");
   free(blub);
 */

}



extern "C" void finalize_MT(){
  cudaFree(dev_rndgauss_field);
  cudaFree(dev_rndunif_field);
}





