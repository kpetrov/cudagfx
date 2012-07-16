
#ifndef _DEV_SU3_



__device__ inline dev_complex dev_cconj (dev_complex c);
__device__ inline void dev_ccopy(dev_complex* von, dev_complex* nach);
__device__ inline double dev_cabssquare (dev_complex c);
__device__ inline double dev_cabsolute (dev_complex c);
__device__ inline  dev_complex dev_crealmult(dev_complex c1, double real);
__device__ inline dev_complex dev_cmult (dev_complex c1, dev_complex c2);
__device__ inline dev_complex dev_cadd (dev_complex c1, dev_complex c2);
__device__ inline dev_complex dev_cdiv(dev_complex c1, dev_complex c2);
__device__ inline dev_complex dev_csub(dev_complex c1, dev_complex c2);
__device__ inline dev_complex dev_initcomplex(double re, double im);
__device__ void dev_storetrafo_2v(int pos, dev_su3_2v* trafofield , dev_su3* g);
__device__ void dev_storegf_2v(int pos, dev_su3_2v* gfield , dev_su3* U);
__device__ void dev_storegf_8(int pos, dev_su3_2v* trafofield , dev_su3* U);
__device__ void dev_storetrafo_8(int pos, dev_su3_2v* gfield , dev_su3* g);
__inline__ __device__ double2 tex1Dfetch_gf(const int& i);
__inline__ __device__ double2 tex1Dfetch_trafo(const int& i);
__device__ void dev_reconstructgf_2vtexref (dev_su3_2v * field, int pos, dev_su3* gf);
__device__ void dev_reconstructgf_2vtexref_dagger (dev_su3_2v * field, int pos, dev_su3* gf);
__device__ void dev_reconstructgf_8texref (dev_su3_8 * field, int pos, dev_su3* gf);
__device__ void dev_reconstructgf_8texref_dagger (dev_su3_8 * field, int pos, dev_su3* gf);
__device__ void dev_reconstructtrafo_2vtexref (dev_su3_2v * field, int pos, dev_su3* gf); 
__device__ void dev_reconstructtrafo_2vtexref_dagger (dev_su3_2v * field, int pos, dev_su3* gf);
__device__ void dev_reconstructtrafo_8texref (dev_su3_8 * field, int pos, dev_su3* gf);
__device__ void dev_reconstructtrafo_8texref_dagger (dev_su3_8 * field, int pos, dev_su3* gf);


extern "C" void show_su3_2v(dev_su3_2v * M);


__device__ void dev_su3zero(dev_su3* M);
__device__ void dev_su3dagger(dev_su3 * erg, dev_su3 * M);
__device__ dev_complex dev_su3trace(dev_su3 * M);
__device__ double dev_su3Retrace(dev_su3 * M);
__device__ void dev_su3skalarmult(dev_su3 * erg, dev_complex skalar, dev_su3 * M);
__device__ void dev_su3copy( dev_su3 * to, dev_su3 * from);
__device__ void dev_su3_ti_su3(dev_su3* u, dev_su3 * v, dev_su3 * w);
__device__ void dev_add_su3_ti_su3(dev_su3* u, dev_su3 * v, dev_su3 * w);
__device__ void dev_su3_ti_su3d(dev_su3* u, dev_su3 * v, dev_su3 * w);
__device__ void dev_su3_sub(dev_su3* a, dev_su3* b);
__device__ void dev_su3_sub_assign(dev_su3* c,dev_su3* a, dev_su3* b);
__device__ void dev_su3_add(dev_su3* a, dev_su3* b);
__device__ void dev_su3_add_assign(dev_su3* c, dev_su3* a, dev_su3* b);
__device__ void dev_su3_real_mult(dev_su3* a, double R);
__device__ void dev_su3_real_mult_assign(dev_su3* erg, dev_su3* a, double R);
__device__ void dev_su3_assign(dev_su3* a, dev_su3* b);
__device__ void dev_su3_normalize(dev_su3* u);



extern "C" int bind_texture_gf(dev_su3_2v * gfield);
extern "C" int unbind_texture_gf();
extern "C" int bind_texture_trafo(dev_su3_2v * trafofield);
extern "C" int unbind_texture_trafo();



#define _DEV_SU3_
#endif









