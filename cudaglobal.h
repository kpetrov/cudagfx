#include <cuda.h>
#include <cuda_runtime.h>

/* GPU Stuff */



#define BLOCK 128// Block Size 
#define BLOCK2 96// Block Size 
#define BLOCKPLAQ 64 // Block Size for plaquette calculation, must be LARGER than LZ !!!!


//#define USETEXTURE
#define maxblockdim 512

//#define GF_8

typedef struct  {
  double re;
  double im;
} dev_complex;

/* Device Gauge Fields */
typedef dev_complex dev_su3 [3][3];  /* su(3)-Matrix 3x3 komplexe Einträge DEVICE */
typedef double2 su3_2v ;  /* 2 Zeilen der su(3)-Matrix, 6 komplexe Einträge HOST  
                           3*4*VOLUME in array -> texture */
typedef double2 dev_su3_2v ;  /* 2 Zeilen der su(3)-Matrix 
                             3*2 komplexe Einträge DEVICE 3*4*VOLUME in array -> texture*/
                             

typedef double2 dev_su3_8 ;  /* 8 numbers to reconstruc the gauge field as described in M. Clark */   


typedef struct { 
  double2 a;
  double2 b;
} dev_su2; /* su(2) matrix represented by 4 numbers*/
                                             
/* Device Spinor Fields */
typedef float4 dev_spinor;
typedef struct dev_spinor_smem{
  dev_spinor spin;
  float dummy;
} dev_spinor_smem;
typedef dev_complex dev_propmatrix[12][12];
typedef dev_complex dev_fbyf[4][4];




/* END GPU Stuff */

