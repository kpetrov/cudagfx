
#define MAIN_PROGRAM

#include <cuda.h>
#include <cuda_runtime.h>
#include "cublas.h"
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "cudaglobal.h"
#include <math.h>
#include "global.h"
#include <getopt.h>
#include <time.h>
#include <assert.h>
#include "dev_su3.h"

extern "C" {
 #include "complex.h"
 #include "gauge_io.h"
 #include "rngs.h"
 #include "su3manip.h"
 #include "observables.h"
 #include "read_input.h"
}



#  define CUDA_SAFE_CALL( call) {                                    \
    cudaError err = call;                                                    \
    if( cudaSuccess != err) {                                                \
        fprintf(stderr, "Cuda error : %s.\n",  cudaGetErrorString( err) );   \
        exit(EXIT_FAILURE);                                                  \
    } }








__device__  int  dev_LX,dev_LY,dev_LZ,dev_T,dev_VOLUME;

// the reduction fields for the global sums of the functional F, dAdA and maxdAdA
__device__ double * dev_redfield_F;
__device__ double * dev_redfield_dAdA;
__device__ double * dev_redfield_maxdAdA;
__device__ double * dev_redfield_plaq;
__constant__ __device__ double sa_beta;
__constant__ __device__ double therm_beta;

/* include the cuda code files here, necessary, because nvcc does not support external calls, all cuda functions must be inlined*/

#include "dev_su3.cu"
#include "overrelax.cu"
#include "MersenneTwister.cu"
#include "simulated_annealing.cu"
#include "heatbath_thermalization.cu"





extern int read_gf_ildg(su3 gf[], char* filename);



void initnn(){
  int t,x,y,z,pos, count;
  count=0;
  for(t=0;t<T;t++){
    for(z=0; z<LZ; z++){
      for(y=0; y<LY; y++){
        for(x=0; x<LX; x++){
          pos= x + LX*(y + LY*(z + LZ*t));
          ind[count] = pos;
          //plus direction
          nn[8*pos+3] = x + LX*(y + LY*(z + LZ*((t+1)%T)));
          nn[8*pos+2] = x + LX*(y + LY*((z+1)%LZ + LZ*t));
          nn[8*pos+1] = x + LX*((y+1)%LY + LY*(z + LZ*t));
          nn[8*pos+0] = (x+1)%LX + LX*(y + LY*(z + LZ*t));
          //minus direction
          if(t==0){
            nn[8*pos+7] = x + LX*(y + LY*(z + LZ*((T-1))));
          }
          else{
            nn[8*pos+7] = x + LX*(y + LY*(z + LZ*((t-1))));
          }
          if(z==0){
            nn[8*pos+6] = x + LX*(y + LY*((LZ-1) + LZ*t));
          }
          else{
            nn[8*pos+6] = x + LX*(y + LY*((z-1) + LZ*t));
          }
          if(y==0){
            nn[8*pos+5] = x + LX*((LY-1) + LY*(z + LZ*t));
          }
          else{
            nn[8*pos+5] = x + LX*((y-1) + LY*(z + LZ*t));
          }
          if(x==0){
            nn[8*pos+4] = (LX-1) + LX*(y + LY*(z + LZ*t));
          }
          else{
            nn[8*pos+4] = (x-1) + LX*(y + LY*(z + LZ*t));
          }          
        
        
        count++;
        }
      }
    } 
  }
}








//initialize nearest-neighbour table for gpu with even-odd enabled
//init_nn must have been called before for initialization of nn
void initnn_eo(){
  int x,y,z,t,index,nnpos,j, count;
  int evenpos=0;
  int oddpos=0;

  // here we initialize the conversion field lexic2eo
  evenpos=0;
  oddpos=0;
  count=0;
  for(t=0;t<T;t++){
    for(z=0;z<LZ;z++){
      for(y=0;y<LY;y++){
        for(x=0;x<LX;x++){
          if(  ((x+y+z+t) %2)==0){
            lexic2eo[count] = evenpos;
            evenpos++;
          }
          else{
            lexic2eo[count] = oddpos;
            oddpos++;
          }
          count++;
        }
      }
    }
  }
  
  
  
  
  evenpos=0;
  oddpos=0;
  count=0;
  for(t=0;t<T;t++){
   for(z=0;z<LZ;z++){
    for(y=0;y<LY;y++){
     for(x=0;x<LX;x++){
          index = ind[count];
          
          if(((t+x+y+z)%2 == 0)){
            nnpos = lexic2eo[index];
            for(j=0;j<4;j++){
              nn_eo[8*nnpos+j] = lexic2eo[ nn[8*index+j] ];
            }
            for(j=0;j<4;j++){
              nn_eo[8*nnpos+4+j] = lexic2eo[ nn[8*index+4+j] ];
            }
            eoidx_even[evenpos] = index;
            evenpos++;
          }
          else{
            nnpos = lexic2eo[index];
            for(j=0;j<4;j++){
              nn_oe[8*nnpos+j] = lexic2eo[ nn[8*index+j] ];
            }
            for(j=0;j<4;j++){
              nn_oe[8*nnpos+4+j] = lexic2eo[ nn[8*index+4+j] ];
            }
            eoidx_odd[oddpos] = index;
            oddpos++;
          }
        
        count++;
        }
      }
    }
  }
}







void init_gaugefixing(su3* gf, su3* trafo){
cudaError_t cudaerr;

  // the gauge field
  #ifdef GF_8
  /* allocate 8 doubles of gf = 4*4*VOLUME double2's*/
  size_t dev_gfsize = 4*4*VOLUME * sizeof(dev_su3_8);
  #else
  /* allocate 2 rows of gf = 6*4*VOLUME double2's*/
  size_t dev_gfsize = 6*4*VOLUME * sizeof(dev_su3_2v); 
  #endif
  
  if((cudaerr=cudaMalloc((void **) &dev_gf, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of gauge field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated gauge field on device\n");
  }  

 #ifdef USETEXTURE
  /*
  if((cudaerr=cudaMalloc((void **) &dev_gf2, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of gauge field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated gauge field 2 on device\n");
  } 
  */
 #endif
  
  #ifdef GF_8
  h2d_gf = (dev_su3_8 *)malloc(dev_gfsize); // Allocate conversion gf on host
  su3to8(gf,h2d_gf);  
  #else
  h2d_gf = (dev_su3_2v *)malloc(dev_gfsize); // Allocate conversion gf on host
  su3to2v(gf,h2d_gf);
  #endif
  cudaMemcpy(dev_gf, h2d_gf, dev_gfsize, cudaMemcpyHostToDevice);
  



// the trafo fields
  #ifdef GF_8
  /* allocate 8 doubles of trafo = 4*VOLUME double2's*/
  dev_gfsize = 4*VOLUME * sizeof(dev_su3_8);
  #else
  /* allocate 2 rows of gf = 6*VOLUME double2's*/
  dev_gfsize = 6*VOLUME * sizeof(dev_su3_2v); 
  #endif
  
  if((cudaerr=cudaMalloc((void **) &dev_trafo1, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of trafo field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated trafo field 1 on device\n");
  }  
  
  #ifdef USETEXTURE //we only need a second trafo field, if we use textures as texture fields are read-only!
  if((cudaerr=cudaMalloc((void **) &dev_trafo2, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of trafo field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated trafo field 2 on device\n");
  }
  #endif
  
  #ifdef GF_8
  h2d_trafo = (dev_su3_8 *)malloc(dev_gfsize); 
  su3to8_trafo(trafo,h2d_trafo);  
  #else
  h2d_trafo = (dev_su3_2v *)malloc(dev_gfsize); 
  su3to2v_trafo(trafo,h2d_trafo);
  #endif
  cudaMemcpy(dev_trafo1, h2d_trafo, dev_gfsize, cudaMemcpyHostToDevice);
  
  #ifdef USETEXTURE
  cudaMemcpy(dev_trafo2, h2d_trafo, dev_gfsize, cudaMemcpyHostToDevice);
  #endif
  

//grid 
  size_t nnsize = 8*VOLUME*sizeof(int);
  nn = (int *) malloc(nnsize);
  cudaMalloc((void **) &dev_nn, nnsize);
  
  size_t indsize = VOLUME*sizeof(int);
  ind = (int *) malloc(indsize);
  
  lexic2eo = (int *) malloc(indsize);
 
 
  // nearest neighbours EO
  size_t nnsize_evenodd = (size_t)8*VOLUME/2*sizeof(int);
  nn_oe = (int *) malloc(nnsize_evenodd);
  cudaMalloc((void **) &dev_nn_oe, nnsize_evenodd);
  nn_eo = (int *) malloc(nnsize_evenodd);
  cudaMalloc((void **) &dev_nn_eo, nnsize_evenodd);
  
  // index EO
  size_t indsize_evenodd = (size_t)VOLUME/2*sizeof(int);
  eoidx_even = (int *) malloc(indsize_evenodd);
  cudaMalloc((void **) &dev_eoidx_even, indsize_evenodd);
  eoidx_odd = (int *) malloc(indsize_evenodd);
  cudaMalloc((void **) &dev_eoidx_odd, indsize_evenodd);
  
  
  initnn();
  initnn_eo();
  
  //shownn();
  //showcompare_gf(T-1, LX-1, LY-1, LZ-1, 3);
  
  // copy to device index arrays
  cudaMemcpy(dev_nn, nn, nnsize, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_nn_eo, nn_eo, nnsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_nn_oe, nn_oe, nnsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_eoidx_even, eoidx_even, indsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_eoidx_odd, eoidx_odd, indsize_evenodd, cudaMemcpyHostToDevice);


  output_size = LZ*T*sizeof(double); // parallel in t and z direction
  cudaMalloc((void **) &dev_output, output_size);   // output array
  double * host_output = (double*) malloc(output_size);

  int grid[5];
  grid[0]=LX; grid[1]=LY; grid[2]=LZ; grid[3]=T; grid[4]=VOLUME;
 
  cudaMalloc((void **) &dev_grid, (size_t)(5*sizeof(int)));
  cudaMemcpy(dev_grid, &(grid[0]), (size_t)(5*sizeof(int)), cudaMemcpyHostToDevice);
  
  //init grid
    dev_gfix_init<<< 1, 1 >>> (dev_grid);
  
  
  //reduction field for functional  
  if(VOLUME%BLOCK != 0){
   printf("Error: VOLUME is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  

  int redfieldsize = VOLUME/BLOCK;
  printf("VOLUME/BLOCK = %d\n", VOLUME/BLOCK);
  cudaMalloc((void **) &dev_redfield_F, redfieldsize*sizeof(double));
  if((redfield_F = (double*)malloc(redfieldsize*sizeof(double)))==(void*)NULL){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(F)\n");
  }
  cudaMalloc((void **) &dev_redfield_dAdA, redfieldsize*sizeof(double));
  if((redfield_dAdA = (double*)malloc(redfieldsize*sizeof(double)))==(void*)NULL){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(dAdA)\n");
  }   
  
  cudaMalloc((void **) &dev_redfield_maxdAdA, redfieldsize*sizeof(double));
  if((redfield_maxdAdA = (double*)malloc(redfieldsize*sizeof(double)))==(void*)NULL){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(maxdAdA)\n");
  } 

  cudaMalloc((void **) &dev_redfield_plaq, T*sizeof(double));
  if((redfield_plaq = (double*)malloc(T*sizeof(double)))==(void*)NULL){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(plaq)\n");
  }
  
   
printf("%s\n", cudaGetErrorString(cudaGetLastError()));

}






void finalize_gaugefixing(){

  cudaFree(dev_gf);
  cudaFree(dev_trafo1);
  #ifdef USETEXTURE
  //cudaFree(dev_gf2);
  cudaFree(dev_trafo2);
  #endif
  
  cudaFree(dev_grid);
  cudaFree(dev_output);
  cudaFree(dev_nn);
  cudaFree(dev_redfield_F);
  cudaFree(dev_redfield_dAdA);
  cudaFree(dev_redfield_maxdAdA);
  cudaFree(dev_redfield_plaq);
  cudaFree(dev_nn_eo);
  cudaFree(dev_nn_oe);
  cudaFree(dev_eoidx_even);
  cudaFree(dev_eoidx_odd);
  free(h2d_gf);
  free(h2d_trafo);
  free(redfield_F);
  free(redfield_dAdA);
  free(redfield_maxdAdA);
  free(redfield_plaq);
  free(nn);
  free(nn_eo);
  free(nn_oe);
  free(eoidx_even);
  free(eoidx_odd);
  free(lexic2eo);
  free(ind);
}





void init_thermalization(su3* gf){
cudaError_t cudaerr;

  // the gauge field
  #ifdef GF_8
  /* allocate 8 doubles of gf = 4*4*VOLUME double2's*/
  size_t dev_gfsize = 4*4*VOLUME * sizeof(dev_su3_8);
  #else
  /* allocate 2 rows of gf = 6*4*VOLUME double2's*/
  size_t dev_gfsize = 6*4*VOLUME * sizeof(dev_su3_2v); 
  #endif
  
  if((cudaerr=cudaMalloc((void **) &dev_gf, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of gauge field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated gauge field on device\n");
  }  


  if((cudaerr=cudaMalloc((void **) &dev_gf2, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of gauge field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated gauge field 2 on device\n");
  } 
 


  
  #ifdef GF_8
  h2d_gf = (dev_su3_8 *)malloc(dev_gfsize); // Allocate conversion gf on host
  su3to8(gf,h2d_gf);  
  #else
  h2d_gf = (dev_su3_2v *)malloc(dev_gfsize); // Allocate conversion gf on host
  su3to2v(gf,h2d_gf);
  #endif
  cudaMemcpy(dev_gf, h2d_gf, dev_gfsize, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_gf2, h2d_gf, dev_gfsize, cudaMemcpyHostToDevice);


// the staples field; we do EVEN/ODD update, so we only need half the gauge field size
  #ifdef GF_8
  /* allocate 8 doubles of gf = 4*4*VOLUME/2 double2's*/
   dev_gfsize = 4*4*VOLUME/2 * sizeof(dev_su3_8);
  #else
  /* allocate 2 rows of gf = 6*4*VOLUME/2 double2's*/
   dev_gfsize = 6*4*VOLUME/2 * sizeof(dev_su3_2v); 
  #endif
  
  if((cudaerr=cudaMalloc((void **) &dev_staples, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of staple field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated staple field on device\n");
  }  
  
  
//grid 
  size_t nnsize = 8*VOLUME*sizeof(int);
  nn = (int *) malloc(nnsize);
  cudaMalloc((void **) &dev_nn, nnsize);
  
  size_t indsize = VOLUME*sizeof(int);
  ind = (int *) malloc(indsize);
  
  lexic2eo = (int *) malloc(indsize);
 
 
  // nearest neighbours EO
  size_t nnsize_evenodd = (size_t)8*VOLUME/2*sizeof(int);
  nn_oe = (int *) malloc(nnsize_evenodd);
  cudaMalloc((void **) &dev_nn_oe, nnsize_evenodd);
  nn_eo = (int *) malloc(nnsize_evenodd);
  cudaMalloc((void **) &dev_nn_eo, nnsize_evenodd);
  
  // index EO
  size_t indsize_evenodd = (size_t)VOLUME/2*sizeof(int);
  eoidx_even = (int *) malloc(indsize_evenodd);
  cudaMalloc((void **) &dev_eoidx_even, indsize_evenodd);
  eoidx_odd = (int *) malloc(indsize_evenodd);
  cudaMalloc((void **) &dev_eoidx_odd, indsize_evenodd);
  
  
  initnn();
  initnn_eo();
  
  //shownn();
  //showcompare_gf(T-1, LX-1, LY-1, LZ-1, 3);
  
  // copy to device index arrays
  cudaMemcpy(dev_nn, nn, nnsize, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_nn_eo, nn_eo, nnsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_nn_oe, nn_oe, nnsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_eoidx_even, eoidx_even, indsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_eoidx_odd, eoidx_odd, indsize_evenodd, cudaMemcpyHostToDevice);


  output_size = LZ*T*sizeof(double); // parallel in t and z direction
  cudaMalloc((void **) &dev_output, output_size);   // output array
  double * host_output = (double*) malloc(output_size);

  int grid[5];
  grid[0]=LX; grid[1]=LY; grid[2]=LZ; grid[3]=T; grid[4]=VOLUME;
 
  cudaMalloc((void **) &dev_grid, (size_t)(5*sizeof(int)));
  cudaMemcpy(dev_grid, &(grid[0]), (size_t)(5*sizeof(int)), cudaMemcpyHostToDevice);
  
  //init grid
    dev_gfix_init<<< 1, 1 >>> (dev_grid);
  
  
  //reduction field for functional  
  if(VOLUME%BLOCK != 0){
   printf("Error: VOLUME is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  
  cudaMalloc((void **) &dev_redfield_plaq, T*sizeof(double));
  if((redfield_plaq = (double*)malloc(T*sizeof(double)))==(void*)NULL){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(plaq)\n");
  }
  
   
  printf("%s\n", cudaGetErrorString(cudaGetLastError()));

}






void finalize_thermalization(){
  cudaFree(dev_gf);
  cudaFree(dev_staples);
  cudaFree(dev_grid);
  cudaFree(dev_output);
  cudaFree(dev_nn);
  cudaFree(dev_redfield_plaq);
  cudaFree(dev_nn_eo);
  cudaFree(dev_nn_oe);
  cudaFree(dev_eoidx_even);
  cudaFree(dev_eoidx_odd);
  free(h2d_gf);
  free(redfield_plaq);
  free(nn);
  free(nn_eo);
  free(nn_oe);
  free(eoidx_even);
  free(eoidx_odd);
  free(lexic2eo);
  free(ind);
}





void intro(){
  fprintf(stdout, "\n");
  fprintf(stdout, "########       This is cuda_GF                       ########\n");
  fprintf(stdout, "########       a program to fix lattice Landau gauge ########\n");
  fprintf(stdout, "########       Copyright: Florian Burger             ########\n\n\n");
  
}


void usage() {
  fprintf(stdout, "Code to compute Landau gauge on gauge field\n");
  fprintf(stdout, "Usage:   cudagaugefix -i [inputfile] [gaugefile]\n");
  exit(0);
}


int main(int argc, char *argv[]){

  int ret;
  double F,dada;
  double plaq;
  int c;
  int gfDEVICE;
  int gridsize;  
  if(VOLUME%BLOCK != 0){
   printf("Error: VOLUME is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(BLOCK,1,1);
  if( VOLUME >= BLOCK){
   gridsize =VOLUME/BLOCK;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1);   
  
  
  char inputfilename[100];
  char gaugefilename[100];
  char fixedgaugename[100];

if ((argc != 4) && (argc != 3)){
    // usage();
} 

intro();
gfDEVICE=0;
while ((c = getopt(argc, argv, "h?:i:d:f:")) != -1) {
      switch (c) {
          case 'i':
              strcpy ( &(inputfilename[0])  , optarg );
              printf("The input file is: %s\n", &(inputfilename[0]));
              break;
          case 'd':
              gfDEVICE=atoi(optarg);

               break;
          case 'f':
                 strcpy ( &(gaugefilename[0])  , optarg );
                 strcpy ( &(fixedgaugename[0])  , "landau_" );
                 strcat ( &(fixedgaugename[0])  , optarg );  
;
              printf("The gauge  file is: %s\n", &(gaugefilename[0]));
              printf("The fixed gauge  file is: %s\n", &(fixedgaugename[0]));
   break;
          case 'h':
          case '?':
          default:
              usage();
              break;
      }
  }
printf("setting device to %d\n", gfDEVICE);
fflush(stdout);
cudaSetDevice(gfDEVICE);
int deVice;
cudaGetDevice(&deVice);
printf("set device to %d\n", deVice);

  printf("%s\n", cudaGetErrorString(cudaGetLastError()));


  read_input(&(inputfilename[0]));  
  printf("LX = %d, LY = %d, LZ = %d, T = %d\n", LX, LY, LZ, T);
  
  g_gf = (su3*) malloc(4*VOLUME*sizeof(su3));
  trafo1 = (su3*) malloc(VOLUME*sizeof(su3));
  trafo2 = (su3*) malloc(VOLUME*sizeof(su3));  
     read_gf_ildg(g_gf, &(gaugefilename[0]));

  // if(argc>2){
//    strcpy ( &(gaugefilename[0])  , argv[argc+1] );
//    strcpy ( &(fixedgaugename[0])  , argv[argc+1] );
//    strcat ( &(fixedgaugename[0])  , "_landau" );  
//    printf("The gaugefield file is: %s\n", &(gaugefilename[0]));  
//    read_gf_ildg(g_gf, &(gaugefilename[0]));
//   } 
  
  
 
  printf("Setting random seed to %d\n", randseed);
  PlantSeeds(randseed);


  if(thermflag==1){
   
    if(thermparam.startcond==0){
      unit_init_gauge(g_gf);
    }
    else{
      random_init_gauge(g_gf);
    }
    
    init_thermalization(g_gf);
    init_MT(4*VOLUME/2, 4*4*VOLUME/2); // we need 4 sets of (1/4) (gauss/unif) numbers
                                       // for 4 links per site
    plaq = calc_plaquette(dev_gf,1);
    printf("%s\n", cudaGetErrorString(cudaGetLastError()));
    
    thermalize_gauge();
    
    finalize_thermalization();
  }
  else{
  //unit_init_trafo(trafo1);
  random_init_trafo(trafo1);
  init_gaugefixing(g_gf, trafo1);
  init_MT(VOLUME/2, 4*VOLUME/2); // need one gauss rnd and 4 unif. rnd for all lattice points 
  
  
  //calculate plaquette
  
  
  plaq = calc_plaquette(dev_gf,1);
  printf("%s\n", cudaGetErrorString(cudaGetLastError()));
  
  F = gauge_functional(g_gf);
  dada = dAdA(g_gf);
  printf("HOST FUNC = %.16e\tHOST dAdA = %.16e\n", F, dada);
  
 
  //small benchmark
  //benchmark();
  //exit(100);
  //end small benchmark

 // do the simulated annealing
 if(saflag==1){
   printf("Starting simulated annealing...\n");
   printf("Tmin = %f, Tmax = %f, N = %d, expo = %f\n", saparam.Tmin, saparam.Tmax, saparam.N, saparam.expo);
   simannealing_gauge(); 
 }


 // do the overrelaxation
 if(orxflag==1){
   printf("Starting overrelaxation...\n");
   ret = overrelax_gauge(orxmaxit, orxeps, orxcheckinterval);  
    if(ret < 0){
     printf("Gauge condition not reached. Aborting...\n");
     finalize_gaugefixing();
     free(trafo1);
     free(trafo2);
     free(g_gf);
     exit(300);
   }
 } 
  
  
   
   #ifdef USETEXTURE
   // apply the trafo dev_gf -> dev_gf2
     /*
     bind_texture_trafo(dev_trafo1);
     dev_apply_trafo<<< griddim, blockdim >>> (dev_gf2, dev_gf, dev_trafo1, dev_nn);
     unbind_texture_trafo();
     */
     
     
     bind_texture_gf(dev_gf);
     plaq = calc_plaquette(dev_gf,1);
     unbind_texture_gf();
   #else
   // apply the trafo dev_gf -> dev_gf  (only one field on GPU)
   
     /* this does not work yet
     dev_apply_trafo<<< griddim, blockdim >>> (dev_gf, dev_gf, dev_trafo1, dev_nn);
     */
     
     plaq = calc_plaquette(dev_gf,1);
   #endif
 
      
  
  printf("%s\n", cudaGetErrorString(cudaGetLastError()));
  
  // Copy to Host Mem:
  //trafo
  printf("Transferring back to host...\n");
  
  printf("Applying trafo on host...\n");
   
  #ifdef GF_8
   size_t dev_gfsize = 4*VOLUME * sizeof(dev_su3_8);
   cudaMemcpy(h2d_trafo, dev_trafo1, dev_gfsize, cudaMemcpyDeviceToHost);
   from8tosu3_trafo(trafo1, h2d_trafo); 
  #else
    size_t dev_gfsize = 6*VOLUME * sizeof(dev_su3_2v);
    cudaMemcpy(h2d_trafo, dev_trafo1, dev_gfsize, cudaMemcpyDeviceToHost);
    from2vtosu3_trafo(trafo1, h2d_trafo);
  #endif
  g_trafo(g_gf, trafo1);
  plaq = mean_plaq(g_gf);
  PLAQ = plaq;
  dada = dAdA(g_gf);
  DADA = dada;
  F = gauge_functional(g_gf);
  FUNC = F;
  printf("Final HOST values:\n");
  printf("PLAQ = %.16f\n", PLAQ); 
  printf("F = %.16e \t dAdA = %.16e\t max(dAdA) = %.16e\n", FUNC, DADA, maxDADA); 

  
  printf("Writing out the gauge fixed field ...");
  ret = write_gf_ildg(g_gf, &(fixedgaugename[0]), 64);
  if(ret!=0){
    fprintf(stderr, "Error writing gauge field. Aborting...\n");
    exit(400);
  }
  printf("done.\n");
  
  //gf
  //dev_gfsize = 6*4*VOLUME * sizeof(dev_su3_2v);
  //cudaMemcpy(h2d_gf, dev_gf, dev_gfsize, cudaMemcpyDeviceToHost);
  
  

  finalize_gaugefixing();
  }
  
  
  
  free(trafo1);
  free(trafo2);
  free(g_gf);
}





