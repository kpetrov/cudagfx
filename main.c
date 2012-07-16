

#include <cuda.h>
#include <cuda_runtime.h>
#include "cublas.h"
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "cudaglobal.h"
#include "mixed_solve.h"
#include <math.h>


extern "C" {
 #include su3.h
 #include gauge_io.h
}

#define ACCUM_N 2048
#define DOTPROD_DIM 128

//#define GF_8


int g_numofgpu;

#ifdef GF_8
dev_su3_8 * dev_gf;
dev_su3_8 * h2d_gf;
#else
dev_su3_2v * dev_gf;
dev_su3_2v * h2d_gf;
#endif

#ifdef GF_8
dev_su3_8 * dev_trafo;
dev_su3_8 * h2d_trafo;
#else
dev_su3_2v * dev_trafo;
dev_su3_2v * h2d_trafo;
#endif


int * nn;

size_t output_size;
int* dev_grid;
float * dev_output;


__device__  int  dev_LX,dev_LY,dev_LZ,dev_T,dev_VOLUME;


 /* texture for gauge field */
 texture<float4,1, cudaReadModeElementType> gf_tex;
 const textureReference* gf_texRefPtr = NULL;
 cudaChannelFormatDesc gf_channelDesc;
 
 /* texture for trafo field */
 texture<float4,1, cudaReadModeElementType> trafo_tex;
 const textureReference* trafo_texRefPtr = NULL;
 cudaChannelFormatDesc trafo_channelDesc;






// get 2 first rows of gf float4 type
//  
//
void su3to2vf4(su3** gf, dev_su3_2v* h2d_gf){
  int i,j;
  for (i=0;i<VOLUME;i++){
   for(j=0;j<4;j++){
   //first row
    h2d_gf[3*(4*i+j)].x = (REAL) gf[i][j].c00.re;
    h2d_gf[3*(4*i+j)].y = (REAL) gf[i][j].c00.im;
    h2d_gf[3*(4*i+j)].z = (REAL) gf[i][j].c01.re;
    h2d_gf[3*(4*i+j)].w = (REAL) gf[i][j].c01.im;
    h2d_gf[3*(4*i+j)+1].x = (REAL) gf[i][j].c02.re;
    h2d_gf[3*(4*i+j)+1].y = (REAL) gf[i][j].c02.im;      
   //second row
    h2d_gf[3*(4*i+j)+1].z = (REAL) gf[i][j].c10.re;
    h2d_gf[3*(4*i+j)+1].w = (REAL) gf[i][j].c10.im;
    h2d_gf[3*(4*i+j)+2].x = (REAL) gf[i][j].c11.re;
    h2d_gf[3*(4*i+j)+2].y = (REAL) gf[i][j].c11.im;
    h2d_gf[3*(4*i+j)+2].z = (REAL) gf[i][j].c12.re;
    h2d_gf[3*(4*i+j)+2].w = (REAL) gf[i][j].c12.im;      
  } 
 }
}




// bring gf into the form
// a2 a3, theta_a1, theta_c1, b1
// 
void su3to8(su3** gf, dev_su3_8* h2d_gf){
  int i,j;
  for (i=0;i<VOLUME;i++){
   for(j=0;j<4;j++){
   // a2, a3
    h2d_gf[2*(4*i+j)].x = (REAL) gf[i][j].c01.re;
    h2d_gf[2*(4*i+j)].y = (REAL) gf[i][j].c01.im;
    h2d_gf[2*(4*i+j)].z = (REAL) gf[i][j].c02.re;
    h2d_gf[2*(4*i+j)].w = (REAL) gf[i][j].c02.im;
    
   // theta_a1, theta_c1
   // use atan2 for this: following the reference, atan2 should give an angle -pi < phi < +pi  
   h2d_gf[2*(4*i+j)+1].x = (REAL)( atan2((REAL) gf[i][j].c00.im,(REAL) gf[i][j].c00.re ));
   h2d_gf[2*(4*i+j)+1].y = (REAL) ( atan2((REAL) gf[i][j].c20.im,(REAL)gf[i][j].c20.re ));
     
   // b1
    h2d_gf[2*(4*i+j)+1].z = (REAL) gf[i][j].c10.re ;
    h2d_gf[2*(4*i+j)+1].w = (REAL) gf[i][j].c10.im ;
     
  } 
 }
}





void init_gaugefixing(su3** gf, su3** trafo){
cudaError_t cudaerr;

  // the gauge field
  #ifdef GF_8
  /* allocate 8 floats of gf = 2*4*VOLUME float4's*/
  size_t dev_gfsize = 2*4*VOLUME * sizeof(dev_su3_8);
  #else
  /* allocate 2 rows of gf = 3*4*VOLUME float4's*/
  size_t dev_gfsize = 3*4*VOLUME * sizeof(dev_su3_2v); 
  #endif
  
  if((cudaerr=cudaMalloc((void **) &dev_gf, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of gauge field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated gauge field on device\n");
  }  
  
  #ifdef GF_8
  h2d_gf = (dev_su3_8 *)malloc(dev_gfsize); // Allocate REAL conversion gf on host
  su3to8(gf,h2d_gf);  
  #else
  h2d_gf = (dev_su3_2v *)malloc(dev_gfsize); // Allocate REAL conversion gf on host
  su3to2vf4(gf,h2d_gf);
  #endif
  cudaMemcpy(dev_gf, h2d_gf, dev_gfsize, cudaMemcpyHostToDevice);


// the trafo fields
  #ifdef GF_8
  /* allocate 8 floats of trafo = 2*VOLUME float4's*/
  size_t dev_gfsize = 2*VOLUME * sizeof(dev_su3_8);
  #else
  /* allocate 2 rows of gf = 3*4*VOLUME float4's*/
  size_t dev_gfsize = 3*VOLUME * sizeof(dev_su3_2v); 
  #endif
  
  if((cudaerr=cudaMalloc((void **) &dev_trafo, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of gauge field failed. Aborting...\n");
    exit(200);
  }   // Allocate array on device
  else{
    printf("Allocated gauge field on device\n");
  }  
  
  #ifdef GF_8
  h2d_trafo = (dev_su3_8 *)malloc(dev_gfsize); // Allocate REAL conversion gf on host
  su3to8(trafo,h2d_trafo);  
  #else
  h2d_trafo = (dev_su3_2v *)malloc(dev_gfsize); // Allocate REAL conversion gf on host
  su3to2vf4(trafo,h2d_trafo);
  #endif
  cudaMemcpy(dev_trafo, h2d_trafo, dev_gfsize, cudaMemcpyHostToDevice);

//grid 
  size_t nnsize = 8*VOLUME*sizeof(int);
  nn = (int *) malloc(nnsize);
  cudaMalloc((void **) &dev_nn, nnsize);
  
  initnn();
  //shownn();
  //showcompare_gf(T-1, LX-1, LY-1, LZ-1, 3);
  cudaMemcpy(dev_nn, nn, nnsize, cudaMemcpyHostToDevice);
  
  //free again
  free(nn);


  output_size = LZ*T*sizeof(float); // parallel in t and z direction
  cudaMalloc((void **) &dev_output, output_size);   // output array
  float * host_output = (float*) malloc(output_size);

  int grid[5];
  grid[0]=LX; grid[1]=LY; grid[2]=LZ; grid[3]=T; grid[4]=VOLUME;
 
  cudaMalloc((void **) &dev_grid, 5*sizeof(int));
  cudaMemcpy(dev_grid, &(grid[0]), 5*sizeof(int), cudaMemcpyHostToDevice);
  
}








