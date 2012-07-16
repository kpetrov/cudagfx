


 /* texture for gauge field */
 texture<int4,1> gf_tex;
 const textureReference* gf_texRefPtr = NULL;
 cudaChannelFormatDesc gf_channelDesc;
 
 /* texture for trafo field */
 texture<int4,1> trafo_tex;
 const textureReference* trafo_texRefPtr = NULL;
 cudaChannelFormatDesc trafo_channelDesc;




__device__ inline dev_complex dev_cconj (dev_complex c){ /*konjugiert komplexe Zahl*/
 dev_complex erg;
 erg.re = c.re;
 erg.im = -1.0*c.im;
return erg;
}

__device__ inline void dev_ccopy(dev_complex* von, dev_complex* nach){/*kopiert complex von nach complex nach*/
  nach->re = von->re;
  nach->im = von->im;
}

__device__ inline double dev_cabssquare (dev_complex c){ /*gibt abs^2 einer komplexen Zahl zurück*/
 return c.re*c.re + c.im*c.im;
}

__device__ inline double dev_cabsolute (dev_complex c){/*gibt Betrag einer kompl. zahl zurück*/
 return sqrt(c.re*c.re + c.im*c.im);
}



__device__ inline  dev_complex dev_crealmult(dev_complex c1, double real){ /*multipliziert c1 mit reeller zahl re*/
  dev_complex erg;
  erg.re = real*c1.re;
  erg.im = real*c1.im;
return erg;
}

__device__ inline dev_complex dev_cmult (dev_complex c1, dev_complex c2){ /*multiplizier zwei komplexe Zahlen*/
  dev_complex erg;
  erg.re = c1.re * c2.re - c1.im * c2.im;
  erg.im = c1.re * c2.im + c1.im * c2.re;
return erg;
}

__device__ inline dev_complex dev_cadd (dev_complex c1, dev_complex c2){ /*addiert zwei komplexe Zahlen */
  dev_complex erg;
  erg.re = c1.re + c2.re;
  erg.im = c1.im + c2.im;
return erg;
}


__device__ inline dev_complex dev_cdiv(dev_complex c1, dev_complex c2) { /* dividiert c1 durch c2 */
  dev_complex erg;
  double oneovernenner = 1.0/(c2.re*c2.re + c2.im*c2.im);
  erg.re = oneovernenner*(c1.re*c2.re + c1.im*c2.im);
  erg.im = oneovernenner*(c1.im*c2.re - c1.re*c2.im);
return erg;
}


__device__ inline dev_complex dev_csub(dev_complex c1, dev_complex c2){
   dev_complex erg;
   erg.re = c1.re - c2.re;
   erg.im = c1.im - c2.im;
return erg;
}


__device__ inline dev_complex dev_initcomplex(double re, double im){/* gibt komplexe Zahl mit Realt re und Imt im zurück*/
    dev_complex erg;
    erg.re = re;
    erg.im = im;
return (erg);
}



__device__ void dev_unitsu3(dev_su3 * g){
  (*g)[0][0].re = 1.0;
  (*g)[0][0].im = 0.0;
  (*g)[0][1].re = 0.0;
  (*g)[0][1].im = 0.0;
  (*g)[0][2].re = 0.0;
  (*g)[0][2].im = 0.0;
  
  (*g)[1][0].re = 0.0;
  (*g)[1][0].im = 0.0;
  (*g)[1][1].re = 1.0;
  (*g)[1][1].im = 0.0;
  (*g)[1][2].re = 0.0;
  (*g)[1][2].im = 0.0; 
   
  (*g)[2][0].re = 0.0;
  (*g)[2][0].im = 0.0;
  (*g)[2][1].re = 0.0;
  (*g)[2][1].im = 0.0;
  (*g)[2][2].re = 1.0;
  (*g)[2][2].im = 0.0;
   
}








__device__ void dev_storetrafo_2v(int pos, dev_su3_2v* trafofield , dev_su3* g){

   trafofield[6*pos].x = (*g)[0][0].re;
   trafofield[6*pos].y = (*g)[0][0].im;
   trafofield[6*pos+1].x = (*g)[0][1].re;
   trafofield[6*pos+1].y = (*g)[0][1].im;
   
   trafofield[6*pos+2].x = (*g)[0][2].re;
   trafofield[6*pos+2].y = (*g)[0][2].im;
   trafofield[6*pos+3].x = (*g)[1][0].re;
   trafofield[6*pos+3].y = (*g)[1][0].im;
   
   trafofield[6*pos+4].x = (*g)[1][1].re;
   trafofield[6*pos+4].y = (*g)[1][1].im;
   trafofield[6*pos+5].x = (*g)[1][2].re;
   trafofield[6*pos+5].y = (*g)[1][2].im;
   
}


__device__ void dev_storegf_2v(int pos, dev_su3_2v* gfield , dev_su3* U){

   gfield[6*pos].x = (*U)[0][0].re;
   gfield[6*pos].y = (*U)[0][0].im;
   gfield[6*pos+1].x = (*U)[0][1].re;
   gfield[6*pos+1].y = (*U)[0][1].im;
   
   gfield[6*pos+2].x = (*U)[0][2].re;
   gfield[6*pos+2].y = (*U)[0][2].im;
   gfield[6*pos+3].x = (*U)[1][0].re;
   gfield[6*pos+3].y = (*U)[1][0].im;
   
   gfield[6*pos+4].x = (*U)[1][1].re;
   gfield[6*pos+4].y = (*U)[1][1].im;
   gfield[6*pos+5].x = (*U)[1][2].re;
   gfield[6*pos+5].y = (*U)[1][2].im;
   
}




__device__ void dev_storegf_8(int pos, dev_su3_2v* trafofield , dev_su3* U){


   // a2, a3
    trafofield[4*pos].x   = (*U)[0][1].re;
    trafofield[4*pos].y   = (*U)[0][1].im;
    trafofield[4*pos+1].x = (*U)[0][2].re;
    trafofield[4*pos+1].y = (*U)[0][2].im;
    
   // theta_a1, theta_c1
   // use atan2 for this: following the reference, atan2 should give an angle -pi < phi < +pi  
   trafofield[4*pos+2].x = ( atan2((*U)[0][0].im, (*U)[0][0].re ));
   trafofield[4*pos+2].y = ( atan2((*U)[2][0].im, (*U)[2][0].re ));
     
   // b1
    trafofield[4*pos+3].x = (*U)[1][0].re ;
    trafofield[4*pos+3].y = (*U)[1][0].im ;

}



__device__ void dev_storetrafo_8(int pos, dev_su3_2v* gfield , dev_su3* g){


   // a2, a3
    gfield[4*pos].x   = (*g)[0][1].re;
    gfield[4*pos].y   = (*g)[0][1].im;
    gfield[4*pos+1].x = (*g)[0][2].re;
    gfield[4*pos+1].y = (*g)[0][2].im;
    
   // theta_a1, theta_c1
   // use atan2 for this: following the reference, atan2 should give an angle -pi < phi < +pi  
   gfield[4*pos+2].x = ( atan2((*g)[0][0].im, (*g)[0][0].re ));
   gfield[4*pos+2].y = ( atan2((*g)[2][0].im, (*g)[2][0].re ));
     
   // b1
    gfield[4*pos+3].x = (*g)[1][0].re ;
    gfield[4*pos+3].y = (*g)[1][0].im ;

}







__inline__ __device__ double2 tex1Dfetch_gf(const int& i)
{
int4 v=tex1Dfetch(gf_tex, i);
return make_double2(__hiloint2double(v.y, v.x),__hiloint2double(v.w, v.z));
}

__inline__ __device__ double2 tex1Dfetch_trafo(const int& i)
{
int4 v=tex1Dfetch(trafo_tex, i);
return make_double2(__hiloint2double(v.y, v.x),__hiloint2double(v.w, v.z));
}




// reconstruction of the link fields from two rows of the su3 matrix
// numbers are fetched from texture cache
__device__ void dev_reconstructgf_2vtexref (dev_su3_2v * field, int pos, dev_su3* gf){
  dev_complex help1;
  dev_complex help2;
  double2 gfin;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos);
    gfin = tex1Dfetch_gf(6*pos);
  #else
    gfin = field[6*pos];
  #endif  
  
  //first row
  (*gf)[0][0].re = gfin.x;
  (*gf)[0][0].im = gfin.y;
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+1);
    gfin = tex1Dfetch_gf(6*pos+1);
  #else
    gfin = field[6*pos+1];
  #endif   
  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = gfin.y;
  
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+2);
    gfin = tex1Dfetch_gf(6*pos+2);
  #else
    gfin = field[6*pos+2];
  #endif  
  (*gf)[0][2].re = gfin.x;
  (*gf)[0][2].im = gfin.y;
  
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+3);
    gfin = tex1Dfetch_gf(6*pos+3);
  #else
    gfin = field[6*pos+3];
  #endif    
  //second row
  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = gfin.y;
    
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+4);
    gfin = tex1Dfetch_gf(6*pos+4);
  #else
    gfin = field[6*pos+4];
  #endif  
  (*gf)[1][1].re = gfin.x;
  (*gf)[1][1].im = gfin.y;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+5);
    gfin = tex1Dfetch_gf(6*pos+5);
  #else
    gfin = field[6*pos+5];
  #endif    
  (*gf)[1][2].re = gfin.x;
  (*gf)[1][2].im = gfin.y;
  
  //third row from cconj(cross product of first and second row)
  help1 = dev_cmult((*gf)[0][1],(*gf)[1][2]);
  help2 = dev_cmult((*gf)[0][2],(*gf)[1][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[2][0] = help1;

  
  help1 = dev_cmult((*gf)[0][2],(*gf)[1][0]);
  help2 = dev_cmult((*gf)[0][0],(*gf)[1][2]);
  help1 = dev_cconj(dev_csub(help1,help2));
  
  (*gf)[2][1] = help1;
  
  help1 = dev_cmult((*gf)[0][0],(*gf)[1][1]);
  help2 = dev_cmult((*gf)[0][1],(*gf)[1][0]);
  help1 = dev_cconj(dev_csub(help1,help2));
  
  (*gf)[2][2] = help1;
  
  return;
}




// su3 - dagger reconstruction from two rows  
__device__ void dev_reconstructgf_2vtexref_dagger (dev_su3_2v * field, int pos, dev_su3* gf){
  dev_complex help1;
  dev_complex help2;
  double2 gfin;
  
  
  //first column (minus in im for complex conj.)

  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos);
    gfin = tex1Dfetch_gf(6*pos);
  #else
    gfin = field[6*pos];
  #endif  
  (*gf)[0][0].re = gfin.x;
  (*gf)[0][0].im = -gfin.y;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+1);
    gfin = tex1Dfetch_gf(6*pos+1);
  #else
    gfin = field[6*pos+1];
  #endif    
  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = -gfin.y;

  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+2);
    gfin = tex1Dfetch_gf(6*pos+2);
  #else
    gfin = field[6*pos+2];
  #endif  
  (*gf)[2][0].re = gfin.x;
  (*gf)[2][0].im = -gfin.y;


  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+3);
    gfin = tex1Dfetch_gf(6*pos+3);
  #else
    gfin = field[6*pos+3];
  #endif    
  //second  column (minus in im for complex conj.)
  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = -gfin.y;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+4);
    gfin = tex1Dfetch_gf(6*pos+4);
  #else
    gfin = field[6*pos+4];
  #endif  
  (*gf)[1][1].re = gfin.x;
  (*gf)[1][1].im = -gfin.y;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,6*pos+5);
    gfin = tex1Dfetch_gf(6*pos+5);
  #else
    gfin = field[6*pos+5];
  #endif    
  (*gf)[2][1].re = gfin.x;
  (*gf)[2][1].im = -gfin.y;
  
  //third column from (cross product of cconj(first column) and cconj(second column))
 
  help1 = dev_cconj(dev_cmult((*gf)[1][0],(*gf)[2][1]));
  help2 = dev_cconj(dev_cmult((*gf)[2][0],(*gf)[1][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[0][2] = help1;

  
  help1 = dev_cconj(dev_cmult((*gf)[2][0],(*gf)[0][1]));
  help2 = dev_cconj(dev_cmult((*gf)[0][0],(*gf)[2][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[1][2] = help1;

  
  help1 = dev_cconj(dev_cmult((*gf)[0][0],(*gf)[1][1]));
  help2 = dev_cconj(dev_cmult((*gf)[1][0],(*gf)[0][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[2][2] = help1;
  
  
  /* does this also work?
  help1 = dev_cmult((*gf)[1][0],(*gf)[2][1]);
  help2 = dev_cmult((*gf)[2][0],(*gf)[1][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[0][2] = help1;

  
  help1 = dev_cmult((*gf)[2][0],(*gf)[0][1]);
  help2 = dev_cmult((*gf)[0][0],(*gf)[2][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[1][2] = help1;

  
  help1 = dev_cmult((*gf)[0][0],(*gf)[1][1]);
  help2 = dev_cmult((*gf)[1][0],(*gf)[0][1]));
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[2][2] = help1;
  */
}








// reconstruction of the gf using 8 real parameters as 
// described in the appendix of hep-lat 0911.3191 (M.Clark et al.)
// optimized once
__device__ void dev_reconstructgf_8texref (dev_su3_8 * field, int pos, dev_su3* gf){

  double2 gfin, gfin2;
  double one_over_N, help;
  dev_complex p1,p2;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,4*pos);
    gfin = tex1Dfetch_gf(4*pos);
  #else
    gfin = field[4*pos];
  #endif  
  // read a2 a3
  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = gfin.y;
  
  #ifdef USETEXTURE
    //gfin2 = tex1Dfetch(gf_tex,4*pos+1);
    gfin2 = tex1Dfetch_gf(4*pos+1);
  #else
    gfin2 = field[4*pos+1];
  #endif    
  (*gf)[0][2].re = gfin2.x;
  (*gf)[0][2].im = gfin2.y;  
 
  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y; // use later on
  one_over_N = rsqrt(p1.re); //reciprocal sqrt

  // read theta_a1, theta_c1, b1
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,4*pos+2);
    gfin = tex1Dfetch_gf(4*pos+2);
  #else
    gfin = field[4*pos+2];
  #endif  

  #ifdef USETEXTURE
    //gfin2 = tex1Dfetch(gf_tex,4*pos+3);
    gfin2 = tex1Dfetch_gf(4*pos+3);
  #else
    gfin2 = field[4*pos+3];
  #endif 
  
  // reconstruct a1 use sqrt instead of sin
  help = 1.0 - p1.re;
  if(help > 0.0){
     p1.re = sqrtf(help);
  }
  else{
    p1.re = 0.0;
  }

  
  sincos(gfin.x, &(*gf)[0][0].im, &(*gf)[0][0].re);
  (*gf)[0][0].re = (*gf)[0][0].re * p1.re;
  (*gf)[0][0].im = (*gf)[0][0].im * p1.re;
  
  
  
  // assign b1
  (*gf)[1][0].re = gfin2.x;
  (*gf)[1][0].im = gfin2.y;
  
  // p2 = 1/N b1
  p2.re = one_over_N*(*gf)[1][0].re;
  p2.im = one_over_N*(*gf)[1][0].im;  


  // reconstruct c1 use sqrt instead of sin
  help =1.0 - 
              (*gf)[0][0].re * (*gf)[0][0].re - (*gf)[0][0].im * (*gf)[0][0].im - 
              (*gf)[1][0].re * (*gf)[1][0].re - (*gf)[1][0].im * (*gf)[1][0].im;
  if(help > 0.0){
    p1.re = sqrtf(help);
  }   
  else{      
    p1.re = 0.0;  
  }
  sincos(gfin.y, &(*gf)[2][0].im, &(*gf)[2][0].re);
  (*gf)[2][0].re = (*gf)[2][0].re * p1.re; 
  (*gf)[2][0].im = (*gf)[2][0].im * p1.re;
   
  
  
  // p1 = 1/N*cconj(c1)
  p1.re = one_over_N*(*gf)[2][0].re;
  p1.im = - one_over_N*(*gf)[2][0].im;
  
  
  
  //use the last reconstructed gf component gf[2][2] (c3) as a help variable for b2,b3 and c2
  //this is in order to save registers and to prevent extra loading and storing from global mem
  // calculate b2
  
  (*gf)[1][1].re = p1.re*(*gf)[0][2].re;
  (*gf)[1][1].re += p1.im*(*gf)[0][2].im;
  (*gf)[1][1].im = p1.im*(*gf)[0][2].re;
  (*gf)[1][1].im -= p1.re*(*gf)[0][2].im;
  
  (*gf)[2][2].re = (*gf)[0][0].re * (*gf)[0][1].re;
  (*gf)[2][2].re += (*gf)[0][0].im * (*gf)[0][1].im;
  
  (*gf)[2][2].im = (*gf)[0][0].re * (*gf)[0][1].im;
  (*gf)[2][2].im -= (*gf)[0][0].im * (*gf)[0][1].re;
  (*gf)[2][2] = dev_cmult(p2, (*gf)[2][2]);
  
  (*gf)[1][1].re = -one_over_N*( (*gf)[1][1].re + (*gf)[2][2].re);
  (*gf)[1][1].im = -one_over_N*((*gf)[1][1].im + (*gf)[2][2].im);
  
  
  
  
  
  // calculate b3
  (*gf)[1][2].re = p1.re*(*gf)[0][1].re;
  (*gf)[1][2].re += p1.im*(*gf)[0][1].im;
  (*gf)[1][2].im = p1.im*(*gf)[0][1].re;
  (*gf)[1][2].im -= p1.re*(*gf)[0][1].im;
  
  (*gf)[2][2].re = (*gf)[0][0].re*(*gf)[0][2].re;
  (*gf)[2][2].re += (*gf)[0][0].im*(*gf)[0][2].im;
  (*gf)[2][2].im = (*gf)[0][0].re*(*gf)[0][2].im;
  (*gf)[2][2].im -= (*gf)[0][0].im*(*gf)[0][2].re;
  (*gf)[2][2] = dev_cmult(p2,(*gf)[2][2]);
  
  (*gf)[1][2].re = one_over_N*( (*gf)[1][2].re - (*gf)[2][2].re);
  (*gf)[1][2].im = one_over_N*( (*gf)[1][2].im - (*gf)[2][2].im);
  
  
  // calculate c2
  (*gf)[2][1].re = p2.re*(*gf)[0][2].re;
  (*gf)[2][1].re -= p2.im*(*gf)[0][2].im;
  (*gf)[2][1].im = -p2.re*(*gf)[0][2].im;
  (*gf)[2][1].im -= p2.im*(*gf)[0][2].re;
  
  

  (*gf)[2][2].re = (*gf)[0][0].re*(*gf)[0][1].re;
  (*gf)[2][2].re += (*gf)[0][0].im*(*gf)[0][1].im;
  (*gf)[2][2].im = (*gf)[0][0].re* (*gf)[0][1].im;
  (*gf)[2][2].im -= (*gf)[0][0].im* (*gf)[0][1].re;
  help = (*gf)[2][2].re;
  (*gf)[2][2].re = p1.re*(*gf)[2][2].re;
  (*gf)[2][2].re += p1.im*(*gf)[2][2].im;
  (*gf)[2][2].im = p1.re*(*gf)[2][2].im - p1.im*help;
  
  
  (*gf)[2][1].re = one_over_N*((*gf)[2][1].re - (*gf)[2][2].re);
  (*gf)[2][1].im = one_over_N*((*gf)[2][1].im - (*gf)[2][2].im);
  
  // now we have to use p2 and p1 as a help variable, as this is not 
  // needed any more after the first
  // step
  // calculate c3
  (*gf)[2][2].re = p2.re * (*gf)[0][1].re;
  (*gf)[2][2].re -= p2.im * (*gf)[0][1].im;
  (*gf)[2][2].im = - p2.im*(*gf)[0][1].re;
  (*gf)[2][2].im -= p2.re*(*gf)[0][1].im;
  
  p2.re = (*gf)[0][0].re * (*gf)[0][2].re;
  p2.re += (*gf)[0][0].im * (*gf)[0][2].im;
  p2.im = (*gf)[0][0].re * (*gf)[0][2].im;
  p2.im -= (*gf)[0][0].im * (*gf)[0][2].re;
  p2 = dev_cmult(  dev_cconj(p1) , p2);
  
  (*gf)[2][2] = dev_cadd((*gf)[2][2], p2);
  (*gf)[2][2] = dev_crealmult((*gf)[2][2], -one_over_N);
                      
}






__device__ void dev_reconstructgf_8texref_dagger (dev_su3_8 * field, int pos, dev_su3* gf){


  double2 gfin, gfin2;
  double one_over_N, help;
  dev_complex p1,p2;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,4*pos);
    gfin = tex1Dfetch_gf(4*pos);
  #else
    gfin = field[4*pos];
  #endif 
  // read a2 a3
  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = -gfin.y;
  
  #ifdef USETEXTURE
    //gfin2 = tex1Dfetch(gf_tex,4*pos+1);
    gfin2 = tex1Dfetch_gf(4*pos+1);
  #else
    gfin2 = field[4*pos+1];
  #endif   
  (*gf)[2][0].re = gfin2.x;
  (*gf)[2][0].im = -gfin2.y;  
 
  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y; // use later on
  one_over_N = rsqrt(p1.re);  // reciprocal sqrt

  
  // read theta_a1, theta_c1, b1
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(gf_tex,4*pos+2);
    gfin = tex1Dfetch_gf(4*pos+2);
  #else
    gfin = field[4*pos+2];
  #endif 

  #ifdef USETEXTURE
    //gfin2 = tex1Dfetch(gf_tex,4*pos+3);
    gfin2 = tex1Dfetch_gf(4*pos+3);
  #else
    gfin2 = field[4*pos+3];
  #endif 
  
  // reconstruct a1
  help = 1.0 - p1.re;
  if(help > 0.0){
     p1.re = sqrtf(help);   
  }
  else{
    p1.re = 0.0;
  }
  //(*gf)[0][0].re = p1.re*cos(gfin.x);
  //(*gf)[0][0].im = -p1.re*sin(gfin.x);
  
  sincos(gfin.x, &(*gf)[0][0].im, &(*gf)[0][0].re);
  (*gf)[0][0].re = (*gf)[0][0].re * p1.re;
  (*gf)[0][0].im = -(*gf)[0][0].im * p1.re;
    
  
  
  
  // assign b1
  (*gf)[0][1].re = gfin2.x;
  (*gf)[0][1].im = -gfin2.y;
  
  // p2 = 1/N b1
  p2.re = one_over_N*(*gf)[0][1].re;
  p2.im = -one_over_N*(*gf)[0][1].im;  


  // reconstruct c1
  help = 1.0 - 
              (*gf)[0][0].re * (*gf)[0][0].re - (*gf)[0][0].im * (*gf)[0][0].im - 
              (*gf)[0][1].re * (*gf)[0][1].re - (*gf)[0][1].im * (*gf)[0][1].im;
  if(help > 0.0){
    p1.re = sqrtf(help);
  }
  else{
    p1.re = 0.0;
  }
  //(*gf)[0][2].re = p1.re*cos(gfin.y);
  //(*gf)[0][2].im = -p1.re*sin(gfin.y);
  
  sincos(gfin.y, &(*gf)[0][2].im, &(*gf)[0][2].re);
  (*gf)[0][2].re = (*gf)[0][2].re * p1.re;
  (*gf)[0][2].im = -(*gf)[0][2].im * p1.re;
     
  
  // p1 = 1/N*cconj(c1)
  p1.re = one_over_N*(*gf)[0][2].re;
  p1.im = one_over_N*(*gf)[0][2].im;
  
  //use the last reconstructed gf component gf[2][2] (c3) as a help variable for b2,b3 and c2
  //this is in order to save registers and to prevent extra loading and storing from global mem
  // calculate b2
  (*gf)[1][1] = dev_cmult(p1,   (*gf)[2][0]    );
  (*gf)[2][2] = dev_cmult(p2, dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[1][0] ))  );
  (*gf)[1][1] = dev_cadd((*gf)[1][1], (*gf)[2][2]);
  (*gf)[1][1] = dev_cconj(dev_crealmult((*gf)[1][1], -one_over_N));
  
  // calculate b3
  (*gf)[2][1] = dev_cmult(p1,   (*gf)[1][0]    );
  (*gf)[2][2] = dev_cmult(p2, dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[2][0] ))  );
  (*gf)[2][1] = dev_csub((*gf)[2][1], (*gf)[2][2]);
  (*gf)[2][1] = dev_cconj(dev_crealmult((*gf)[2][1], one_over_N));
  
  // calculate c2
  (*gf)[1][2] = dev_cmult(  dev_cconj(p2) ,  (*gf)[2][0]    );
  (*gf)[2][2] = dev_cmult(  dev_cconj(p1) , 
                       dev_cmult(   (*gf)[0][0]  , dev_cconj( (*gf)[1][0]) )
                     );
  (*gf)[1][2] = dev_csub((*gf)[1][2], (*gf)[2][2]);
  (*gf)[1][2] = dev_cconj(dev_crealmult((*gf)[1][2], one_over_N));
  
  // use p2 as help variable after the first step
  // calculate c3
  (*gf)[2][2] = dev_cmult(  dev_cconj(p2) ,   (*gf)[1][0]    );
  p2 = dev_cmult(  dev_cconj(p1) , 
                       dev_cmult(   (*gf)[0][0]  , dev_cconj((*gf)[2][0] ) )
                     );
  (*gf)[2][2] = dev_cadd((*gf)[2][2], p2);
  (*gf)[2][2] = dev_cconj(dev_crealmult((*gf)[2][2], -one_over_N));

}




//***********************  reconstruct trafo ************************************

// reconstruction of the link fields from two rows of the su3 matrix
// numbers are fetched from texture cache
__device__ void dev_reconstructtrafo_2vtexref (dev_su3_2v * field, int pos, dev_su3* gf){
  dev_complex help1;
  dev_complex help2;
  double2 gfin;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos);
    gfin = tex1Dfetch_trafo(6*pos);
  #else
    gfin = field[6*pos];
  #endif
  //first row
  (*gf)[0][0].re = gfin.x;
  (*gf)[0][0].im = gfin.y;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+1);
    gfin = tex1Dfetch_trafo(6*pos+1);
  #else
    gfin = field[6*pos+1];
  #endif  
  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = gfin.y;

  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,3*pos+2);
    gfin = tex1Dfetch_trafo(6*pos+2);
  #else
    gfin = field[6*pos+2];
  #endif

  (*gf)[0][2].re = gfin.x;
  (*gf)[0][2].im = gfin.y;
  //second row
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+3);
    gfin = tex1Dfetch_trafo(6*pos+3);
  #else
    gfin = field[6*pos+3];
  #endif  
  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = gfin.y;

  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+4);
    gfin = tex1Dfetch_trafo(6*pos+4);
  #else
    gfin = field[6*pos+4];
  #endif

  (*gf)[1][1].re = gfin.x;
  (*gf)[1][1].im = gfin.y;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+5);
    gfin = tex1Dfetch_trafo(6*pos+5);
  #else
    gfin = field[6*pos+5];
  #endif  
  (*gf)[1][2].re = gfin.x;
  (*gf)[1][2].im = gfin.y;
  
  //third row from cconj(cross product of first and second row)
  help1 = dev_cmult((*gf)[0][1],(*gf)[1][2]);
  help2 = dev_cmult((*gf)[0][2],(*gf)[1][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[2][0] = help1;

  
  help1 = dev_cmult((*gf)[0][2],(*gf)[1][0]);
  help2 = dev_cmult((*gf)[0][0],(*gf)[1][2]);
  help1 = dev_cconj(dev_csub(help1,help2));
  
  (*gf)[2][1] = help1;
  
  help1 = dev_cmult((*gf)[0][0],(*gf)[1][1]);
  help2 = dev_cmult((*gf)[0][1],(*gf)[1][0]);
  help1 = dev_cconj(dev_csub(help1,help2));
  
  (*gf)[2][2] = help1;
  
  return;
}




// su3 - dagger reconstruction from two rows  
__device__ void dev_reconstructtrafo_2vtexref_dagger (dev_su3_2v * field, int pos, dev_su3* gf){
  dev_complex help1;
  dev_complex help2;
  double2 gfin;
  
  
  //first column (minus in im for complex conj.)
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos);
    gfin = tex1Dfetch_trafo(6*pos);
  #else
    gfin = field[6*pos];
  #endif

  (*gf)[0][0].re = gfin.x;
  (*gf)[0][0].im = -gfin.y;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+1);
    gfin = tex1Dfetch_trafo(6*pos+1);
  #else
    gfin = field[6*pos+1];
  #endif
  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = -gfin.y;

  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+2);
    gfin = tex1Dfetch_trafo(6*pos+2);
  #else
    gfin = field[6*pos+2];
  #endif
  
  (*gf)[2][0].re = gfin.x;
  (*gf)[2][0].im = -gfin.y;

  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+3);
    gfin = tex1Dfetch_trafo(6*pos+3);
  #else
    gfin = field[6*pos+3];
  #endif  
  //second  column (minus in im for complex conj.)
  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = -gfin.y;

  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+4);
    gfin = tex1Dfetch_trafo(6*pos+4);
  #else
    gfin = field[6*pos+4];
  #endif
  
  (*gf)[1][1].re = gfin.x;
  (*gf)[1][1].im = -gfin.y;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,6*pos+5);
    gfin = tex1Dfetch_trafo(6*pos+5);
  #else
    gfin = field[6*pos+5];
  #endif  
  (*gf)[2][1].re = gfin.x;
  (*gf)[2][1].im = -gfin.y;
  
  //third column from (cross product of cconj(first column) and cconj(second column))
 
  help1 = dev_cconj(dev_cmult((*gf)[1][0],(*gf)[2][1]));
  help2 = dev_cconj(dev_cmult((*gf)[2][0],(*gf)[1][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[0][2] = help1;

  
  help1 = dev_cconj(dev_cmult((*gf)[2][0],(*gf)[0][1]));
  help2 = dev_cconj(dev_cmult((*gf)[0][0],(*gf)[2][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[1][2] = help1;

  
  help1 = dev_cconj(dev_cmult((*gf)[0][0],(*gf)[1][1]));
  help2 = dev_cconj(dev_cmult((*gf)[1][0],(*gf)[0][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[2][2] = help1;
  
  
  /* does this also work?
  help1 = dev_cmult((*gf)[1][0],(*gf)[2][1]);
  help2 = dev_cmult((*gf)[2][0],(*gf)[1][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[0][2] = help1;

  
  help1 = dev_cmult((*gf)[2][0],(*gf)[0][1]);
  help2 = dev_cmult((*gf)[0][0],(*gf)[2][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[1][2] = help1;

  
  help1 = dev_cmult((*gf)[0][0],(*gf)[1][1]);
  help2 = dev_cmult((*gf)[1][0],(*gf)[0][1]));
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[2][2] = help1;
  */
}









// reconstruction of the gf using 8 real parameters as 
// described in the appendix of hep-lat 0911.3191 (M.Clark et al.)
// optimized once
__device__ void dev_reconstructtrafo_8texref (dev_su3_8 * field, int pos, dev_su3* gf){

  double2 gfin, gfin2;
  double one_over_N, help;
  dev_complex p1,p2;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,4*pos);
    gfin = tex1Dfetch_trafo(4*pos);
  #else
    gfin = field[4*pos];
  #endif
  // read a2 a3
  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = gfin.y;
  
  #ifdef USETEXTURE
    //gfin2 = tex1Dfetch(trafo_tex,4*pos+1);
    gfin2 = tex1Dfetch_trafo(4*pos+1);
  #else
    gfin2 = field[4*pos+1];
  #endif  
  (*gf)[0][2].re = gfin2.x;
  (*gf)[0][2].im = gfin2.y;  
 
  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y; // use later on
  one_over_N = rsqrt(p1.re); //reciprocal sqrt

  // read theta_a1, theta_c1, b1
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,4*pos+2);
    gfin = tex1Dfetch_trafo(4*pos+2);
  #else
    gfin = field[4*pos+2];
  #endif

  #ifdef USETEXTURE
    //gfin2 = tex1Dfetch(trafo_tex,4*pos+3);
    gfin2 = tex1Dfetch_trafo(4*pos+3);
  #else
    gfin2 = field[4*pos+3];
  #endif    
  // reconstruct a1 use sqrt instead of sin
  help = 1.0 - p1.re;
  if(help > 0.0){
     p1.re = sqrtf(help);
  }
  else{
    p1.re = 0.0;
  }

  
  sincos(gfin.x, &(*gf)[0][0].im, &(*gf)[0][0].re);
  (*gf)[0][0].re = (*gf)[0][0].re * p1.re;
  (*gf)[0][0].im = (*gf)[0][0].im * p1.re;
  
    
  // assign b1
  (*gf)[1][0].re = gfin2.x;
  (*gf)[1][0].im = gfin2.y;
  
  // p2 = 1/N b1
  p2.re = one_over_N*(*gf)[1][0].re;
  p2.im = one_over_N*(*gf)[1][0].im;  


  // reconstruct c1 use sqrt instead of sin
  help =1.0 - 
              (*gf)[0][0].re * (*gf)[0][0].re - (*gf)[0][0].im * (*gf)[0][0].im - 
              (*gf)[1][0].re * (*gf)[1][0].re - (*gf)[1][0].im * (*gf)[1][0].im;
  if(help > 0.0){
    p1.re = sqrtf(help);
  }   
  else{      
    p1.re = 0.0;  
  }
  sincos(gfin.y, &(*gf)[2][0].im, &(*gf)[2][0].re);
  (*gf)[2][0].re = (*gf)[2][0].re * p1.re; 
  (*gf)[2][0].im = (*gf)[2][0].im * p1.re;
   
  
  
  // p1 = 1/N*cconj(c1)
  p1.re = one_over_N*(*gf)[2][0].re;
  p1.im = - one_over_N*(*gf)[2][0].im;
  
 
  //use the last reconstructed gf component gf[2][2] (c3) as a help variable for b2,b3 and c2
  //this is in order to save registers and to prevent extra loading and storing from global mem
  // calculate b2
  
  (*gf)[1][1].re = p1.re*(*gf)[0][2].re;
  (*gf)[1][1].re += p1.im*(*gf)[0][2].im;
  (*gf)[1][1].im = p1.im*(*gf)[0][2].re;
  (*gf)[1][1].im -= p1.re*(*gf)[0][2].im;
  
  (*gf)[2][2].re = (*gf)[0][0].re * (*gf)[0][1].re;
  (*gf)[2][2].re += (*gf)[0][0].im * (*gf)[0][1].im;
  
  (*gf)[2][2].im = (*gf)[0][0].re * (*gf)[0][1].im;
  (*gf)[2][2].im -= (*gf)[0][0].im * (*gf)[0][1].re;
  (*gf)[2][2] = dev_cmult(p2, (*gf)[2][2]);
  
  (*gf)[1][1].re = -one_over_N*( (*gf)[1][1].re + (*gf)[2][2].re);
  (*gf)[1][1].im = -one_over_N*((*gf)[1][1].im + (*gf)[2][2].im);
  

  // calculate b3
  (*gf)[1][2].re = p1.re*(*gf)[0][1].re;
  (*gf)[1][2].re += p1.im*(*gf)[0][1].im;
  (*gf)[1][2].im = p1.im*(*gf)[0][1].re;
  (*gf)[1][2].im -= p1.re*(*gf)[0][1].im;
  
  (*gf)[2][2].re = (*gf)[0][0].re*(*gf)[0][2].re;
  (*gf)[2][2].re += (*gf)[0][0].im*(*gf)[0][2].im;
  (*gf)[2][2].im = (*gf)[0][0].re*(*gf)[0][2].im;
  (*gf)[2][2].im -= (*gf)[0][0].im*(*gf)[0][2].re;
  (*gf)[2][2] = dev_cmult(p2,(*gf)[2][2]);
  
  (*gf)[1][2].re = one_over_N*( (*gf)[1][2].re - (*gf)[2][2].re);
  (*gf)[1][2].im = one_over_N*( (*gf)[1][2].im - (*gf)[2][2].im);
  
  
  // calculate c2
  (*gf)[2][1].re = p2.re*(*gf)[0][2].re;
  (*gf)[2][1].re -= p2.im*(*gf)[0][2].im;
  (*gf)[2][1].im = -p2.re*(*gf)[0][2].im;
  (*gf)[2][1].im -= p2.im*(*gf)[0][2].re;
  
  

  (*gf)[2][2].re = (*gf)[0][0].re*(*gf)[0][1].re;
  (*gf)[2][2].re += (*gf)[0][0].im*(*gf)[0][1].im;
  (*gf)[2][2].im = (*gf)[0][0].re* (*gf)[0][1].im;
  (*gf)[2][2].im -= (*gf)[0][0].im* (*gf)[0][1].re;
  help = (*gf)[2][2].re;
  (*gf)[2][2].re = p1.re*(*gf)[2][2].re;
  (*gf)[2][2].re += p1.im*(*gf)[2][2].im;
  (*gf)[2][2].im = p1.re*(*gf)[2][2].im - p1.im*help;
  
  
  (*gf)[2][1].re = one_over_N*((*gf)[2][1].re - (*gf)[2][2].re);
  (*gf)[2][1].im = one_over_N*((*gf)[2][1].im - (*gf)[2][2].im);
  
  // now we have to use p2 and p1 as a help variable, as this is not 
  // needed any more after the first
  // step
  // calculate c3
  (*gf)[2][2].re = p2.re * (*gf)[0][1].re;
  (*gf)[2][2].re -= p2.im * (*gf)[0][1].im;
  (*gf)[2][2].im = - p2.im*(*gf)[0][1].re;
  (*gf)[2][2].im -= p2.re*(*gf)[0][1].im;
  
  p2.re = (*gf)[0][0].re * (*gf)[0][2].re;
  p2.re += (*gf)[0][0].im * (*gf)[0][2].im;
  p2.im = (*gf)[0][0].re * (*gf)[0][2].im;
  p2.im -= (*gf)[0][0].im * (*gf)[0][2].re;
  p2 = dev_cmult(  dev_cconj(p1) , p2);
  
  (*gf)[2][2] = dev_cadd((*gf)[2][2], p2);
  (*gf)[2][2] = dev_crealmult((*gf)[2][2], -one_over_N);
}





__device__ void dev_reconstructtrafo_8texref_dagger (dev_su3_8 * field, int pos, dev_su3* gf){
  double2 gfin, gfin2;
  double one_over_N, help;
  dev_complex p1,p2;
  
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,4*pos);
    gfin = tex1Dfetch_trafo(4*pos);
  #else
    gfin = field[4*pos];
  #endif  

  // read a2 a3
  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = -gfin.y;
  
  #ifdef USETEXTURE
    //gfin2 = tex1Dfetch(trafo_tex,4*pos+1);
    gfin2 = tex1Dfetch_trafo(4*pos+1);
  #else
    gfin2 = field[4*pos+1];
  #endif    
  
  (*gf)[2][0].re = gfin2.x;
  (*gf)[2][0].im = -gfin2.y;  
 
  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y; // use later on
  one_over_N = rsqrt(p1.re);  // reciprocal sqrt

  
  // read theta_a1, theta_c1, b1
  #ifdef USETEXTURE
    //gfin = tex1Dfetch(trafo_tex,4*pos+2);
    gfin = tex1Dfetch_trafo(4*pos+2);
  #else
    gfin = field[4*pos+2];
  #endif


  #ifdef USETEXTURE
    //gfin2 = tex1Dfetch(trafo_tex,4*pos+3);
    gfin2 = tex1Dfetch_trafo(4*pos+3);
  #else
    gfin2 = field[4*pos+3];
  #endif
  
  // reconstruct a1
  help = 1.0 - p1.re;
  if(help > 0.0){
     p1.re = sqrtf(help);   
  }
  else{
    p1.re = 0.0;
  }
  //(*gf)[0][0].re = p1.re*cos(gfin.x);
  //(*gf)[0][0].im = -p1.re*sin(gfin.x);
  
  sincos(gfin.x, &(*gf)[0][0].im, &(*gf)[0][0].re);
  (*gf)[0][0].re = (*gf)[0][0].re * p1.re;
  (*gf)[0][0].im = -(*gf)[0][0].im * p1.re;
    
  
  // assign b1
  (*gf)[0][1].re = gfin2.x;
  (*gf)[0][1].im = -gfin2.y;
  
  // p2 = 1/N b1
  p2.re = one_over_N*(*gf)[0][1].re;
  p2.im = -one_over_N*(*gf)[0][1].im;  


  // reconstruct c1
  help = 1.0 - 
              (*gf)[0][0].re * (*gf)[0][0].re - (*gf)[0][0].im * (*gf)[0][0].im - 
              (*gf)[0][1].re * (*gf)[0][1].re - (*gf)[0][1].im * (*gf)[0][1].im;
  if(help > 0.0){
    p1.re = sqrtf(help);
  }
  else{
    p1.re = 0.0;
  }
  //(*gf)[0][2].re = p1.re*cos(gfin.y);
  //(*gf)[0][2].im = -p1.re*sin(gfin.y);
  
  sincos(gfin.y, &(*gf)[0][2].im, &(*gf)[0][2].re);
  (*gf)[0][2].re = (*gf)[0][2].re * p1.re;
  (*gf)[0][2].im = -(*gf)[0][2].im * p1.re;
     
  
  // p1 = 1/N*cconj(c1)
  p1.re = one_over_N*(*gf)[0][2].re;
  p1.im = one_over_N*(*gf)[0][2].im;
  
  //use the last reconstructed gf component gf[2][2] (c3) as a help variable for b2,b3 and c2
  //this is in order to save registers and to prevent extra loading and storing from global mem
  // calculate b2
  (*gf)[1][1] = dev_cmult(p1,   (*gf)[2][0]    );
  (*gf)[2][2] = dev_cmult(p2, dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[1][0] ))  );
  (*gf)[1][1] = dev_cadd((*gf)[1][1], (*gf)[2][2]);
  (*gf)[1][1] = dev_cconj(dev_crealmult((*gf)[1][1], -one_over_N));
  
  // calculate b3
  (*gf)[2][1] = dev_cmult(p1,   (*gf)[1][0]    );
  (*gf)[2][2] = dev_cmult(p2, dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[2][0] ))  );
  (*gf)[2][1] = dev_csub((*gf)[2][1], (*gf)[2][2]);
  (*gf)[2][1] = dev_cconj(dev_crealmult((*gf)[2][1], one_over_N));
  
  // calculate c2
  (*gf)[1][2] = dev_cmult(  dev_cconj(p2) ,  (*gf)[2][0]    );
  (*gf)[2][2] = dev_cmult(  dev_cconj(p1) , 
                       dev_cmult(   (*gf)[0][0]  , dev_cconj( (*gf)[1][0]) )
                     );
  (*gf)[1][2] = dev_csub((*gf)[1][2], (*gf)[2][2]);
  (*gf)[1][2] = dev_cconj(dev_crealmult((*gf)[1][2], one_over_N));
  
  // use p2 as help variable after the first step
  // calculate c3
  (*gf)[2][2] = dev_cmult(  dev_cconj(p2) ,   (*gf)[1][0]    );
  p2 = dev_cmult(  dev_cconj(p1) , 
                       dev_cmult(   (*gf)[0][0]  , dev_cconj((*gf)[2][0] ) )
                     );
  (*gf)[2][2] = dev_cadd((*gf)[2][2], p2);
  (*gf)[2][2] = dev_cconj(dev_crealmult((*gf)[2][2], -one_over_N));


}






void show_su3_2v(dev_su3_2v * M){
 complex a0, a1, a2;
 complex b0, b1, b2;
 complex c0, c1, c2;
 complex help1, help2;
    
 printf("(%e,%e) ", (*M).x, (*M).y);
 printf("(%e,%e) ", (*(M+1)).x, (*(M+1)).y);
 printf("(%e,%e) ", (*(M+2)).x, (*(M+2)).y);
 printf("\n");
 
 printf("(%e,%e) ", (*(M+3)).x, (*(M+3)).y);
 printf("(%e,%e) ", (*(M+4)).x, (*(M+4)).y);
 printf("(%e,%e) ", (*(M+5)).x, (*(M+5)).y);
 
 printf("\n");
 double re1 = (*M).x * (*(M+3)).x + (*M).y * (*(M+3)).y;
 double im1 = - (*M).x * (*(M+3)).y + (*M).y * (*(M+3)).x;

 double re2 = (*(M+1)).x * (*(M+4)).x + (*(M+1)).y * (*(M+4)).y;
 double im2 = - (*(M+1)).x * (*(M+4)).y + (*(M+1)).y * (*(M+4)).x;
 
 double re3 = (*(M+2)).x * (*(M+5)).x + (*(M+2)).y * (*(M+5)).y;
 double im3 = - (*(M+2)).x * (*(M+5)).y + (*(M+2)).y * (*(M+5)).x;
 
 double allre = (re1+re2+re3);
 double allim = im1+im2+im3;
 
 printf("a b* = (%.16e, %.16e) \n", allre, allim);
 
 double norm = (*M).x*(*M).x + (*M).y*(*M).y + (*(M+1)).x*(*(M+1)).x + (*(M+1)).y*(*(M+1)).y + (*(M+2)).x*(*(M+2)).x + (*(M+2)).y*(*(M+2)).y;
 printf("a^2 = %.16e\n", norm);
 
 norm = (*(M+3)).x * (*(M+3)).x + (*(M+3)).y * (*(M+3)).y + (*(M+4)).x * (*(M+4)).x + (*(M+4)).y * (*(M+4)).y + (*(M+5)).x * (*(M+5)).x + (*(M+5)).y * (*(M+5)).y; 
 printf("b^2 = %.16e\n", norm);
 
 a0.re = (*M).x;
 a0.im = (*M).y;
 a1.re = (*(M+1)).x;
 a1.im = (*(M+1)).y; 
 a2.re = (*(M+2)).x;
 a2.im = (*(M+2)).y; 
 
 b0.re = (*(M+3)).x;
 b0.im = (*(M+3)).y;
 b1.re = (*(M+4)).x;
 b1.im = (*(M+4)).y; 
 b2.re = (*(M+5)).x;
 b2.im = (*(M+5)).y;  
 
 
  // c = (a X b)*
  help1 = cmult(a1,b2);
  help2 = cmult(a2,b1);
  help1 = cconj(csub(help1,help2));
  c0 = help1;

  
  help1 = cmult(a2,b0);
  help2 = cmult(a0,b2);
  help1 = cconj(csub(help1,help2));
  c1 = help1;
  
  help1 = cmult(a0,b1);
  help2 = cmult(a1,b0);
  help1 = cconj(csub(help1,help2));
  c2 = help1;
  
  
  norm = c0.re*c0.re + c0.im*c0.im + c1.re*c1.re + c1.im*c1.im + c2.re*c2.re + c2.im*c2.im;
 printf("c^2 = %.16e\n", norm); 
  
  
}






__device__ void dev_su3zero(dev_su3* M){
 int i,j;
 dev_complex czero = dev_initcomplex(0.0,0.0);
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*M)[i][j] = czero;
    }
  }
return;
}



// erg = M^+
__device__ void dev_su3dagger(dev_su3 * erg, dev_su3 * M){
  int i,j;
  
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){  
      (*erg)[i][j] = dev_cconj((*M)[j][i]);
    }
  }
return;
}


__device__ dev_complex dev_su3trace(dev_su3 * M){
  dev_complex erg;
  int i;
  erg = dev_initcomplex(0.0,0.0);
  for(i=0; i<3; i++){
    erg = dev_cadd(erg, (*M)[i][i]);
  }
return erg;
}



__device__ double dev_su3Retrace(dev_su3 * M){
  double erg;
  int i;
  erg = 0.0;
  for(i=0; i<3; i++){
    erg = erg + (*M)[i][i].re;
  }
return erg;
}



//erg = C*M, C complex 
__device__ void dev_su3skalarmult(dev_su3 * erg, dev_complex skalar, dev_su3 * M){
  int i,j;
  
  for(i=0;i<3;i++){
    for(j=0;j<3;j++){
      (*erg)[i][j] = dev_cmult(skalar,(*M)[i][j]);
    }
  }

return;
}


__device__ void dev_su2_ti_su2(dev_su2 * r, dev_su2* a, dev_su2* b){

  (*r).a.x =   (*a).a.x * (*b).a.x - (*a).a.y * (*b).a.y 
             - (*a).b.x * (*b).b.x - (*a).b.y * (*b).b.y;
  
  (*r).a.y =   (*a).a.x * (*b).a.y + (*a).a.y * (*b).a.x 
             - (*a).b.x * (*b).b.y + (*a).b.y * (*b).b.x;
  
  (*r).b.x =   (*a).a.x * (*b).b.x + (*a).b.x * (*b).a.x 
             - (*a).b.y * (*b).a.y + (*a).a.y * (*b).b.y;
  
  (*r).b.y =   (*a).a.x * (*b).b.y + (*a).b.y * (*b).a.x 
             - (*a).a.y * (*b).b.x + (*a).b.x * (*b).a.y;

}




// to := from
__device__ void dev_su3copy( dev_su3 * to, dev_su3 * from){
  int i,j;
  for(i=0; i<3; i++){
    for(j=0; j<3; j++){
      (*to)[i][j] = (*from)[i][j];
    }
  }
return;
}



// u = v * w
__device__ void dev_su3_ti_su3(dev_su3* u, dev_su3 * v, dev_su3 * w){
  dev_complex help1, help2;
  dev_complex zero = dev_initcomplex(0.0,0.0);
  int i,j,k;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
    
      help2 = zero;
      for(k=0; k<3; k++){
          help1 = dev_cmult((*v)[i][k],(*w)[k][j]);
          help2 = dev_cadd(help1, help2);
        }
        (*u)[i][j] = help2;    
    }
  }
}





// u = u + v * w
__device__ void dev_add_su3_ti_su3(dev_su3* u, dev_su3 * v, dev_su3 * w){
  dev_complex help1, help2;
  dev_complex zero = dev_initcomplex(0.0,0.0);
  int i,j,k;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
    
      help2 = zero;
      for(k=0; k<3; k++){
          help1 = dev_cmult((*v)[i][k],(*w)[k][j]);
          help2 = dev_cadd(help1, help2);
        }
        (*u)[i][j].re += help2.re;  
        (*u)[i][j].im += help2.im; 
    }
  }
}



// u = v* w^+
__device__ void dev_su3_ti_su3d(dev_su3* u, dev_su3 * v, dev_su3 * w){
  dev_complex help1, help2;
  dev_complex zero = dev_initcomplex(0.0,0.0);
  int i,j,k;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){ 
      help2 = zero;
      for(k=0; k<3; k++){
          help1 = dev_cmult((*v)[i][k],dev_cconj( (*w)[j][k] ) );
          help2 = dev_cadd(help1, help2);
        }
        (*u)[i][j] = help2;   
    }
  }
}


// a = a-b
__device__ void dev_su3_sub(dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){ 
      (*a)[i][j] = dev_csub((*a)[i][j], (*b)[i][j]);
    }
  }
}





// c = a-b
__device__ void dev_su3_sub_assign(dev_su3* c,dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){ 
      (*c)[i][j] = dev_csub((*a)[i][j], (*b)[i][j]);
    }
  }
}





// a = a+b
__device__ void dev_su3_add(dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){ 
      (*a)[i][j] = dev_cadd((*a)[i][j], (*b)[i][j]);
    }
  }
}


// c = a+b
__device__ void dev_su3_add_assign(dev_su3* c, dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){ 
      (*c)[i][j] = dev_cadd((*a)[i][j], (*b)[i][j]);
    }
  }
}



// a:=R*a
__device__ void dev_su3_real_mult(dev_su3* a, double R){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){ 
      (*a)[i][j].re = (*a)[i][j].re*R;
      (*a)[i][j].im = (*a)[i][j].im*R;
    }
  }
}




// erg=R*a
__device__ void dev_su3_real_mult_assign(dev_su3* erg, dev_su3* a, double R){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){ 
      (*erg)[i][j].re = (*a)[i][j].re*R;
      (*erg)[i][j].im = (*a)[i][j].im*R;
    }
  }
}




// a:= b
__device__ void dev_su3_assign(dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){ 
      (*a)[i][j] = (*b)[i][j];
    }
  }
}



__device__ void dev_su3_normalize(dev_su3* u){
  int i;
  double len;
  dev_complex proj, help1, help2;
  //length of first row (a)
  len = ((*u)[0][0].re*(*u)[0][0].re + (*u)[0][0].im*(*u)[0][0].im) +
        ((*u)[0][1].re*(*u)[0][1].re + (*u)[0][1].im*(*u)[0][1].im) +
        ((*u)[0][2].re*(*u)[0][2].re + (*u)[0][2].im*(*u)[0][2].im) ;
  //normalize a
  
  len =  rsqrt(len); // 1/sqrt(len)
  
  #pragma unroll 3
  for(i=0; i<3; i++){
    (*u)[0][i].re = (*u)[0][i].re*len;
    (*u)[0][i].im = (*u)[0][i].im*len;
  }     
  
  //projection on second row b (f=a*b)
  proj = dev_initcomplex(0.0,0.0);
  #pragma unroll 3
  for(i=0; i<3; i++){
    proj = dev_cadd( proj , dev_cmult(  (*u)[1][i] ,  dev_cconj( (*u)[0][i])   ));
  }
  
  
  //orthogonalize -> new b
  #pragma unroll 3
  for(i=0; i<3; i++){
    (*u)[1][i] = dev_csub( (*u)[1][i] , dev_cmult(proj, (*u)[0][i]  )  );
  }
  
  
 
  // get length b
  len = ((*u)[1][0].re*(*u)[1][0].re + (*u)[1][0].im*(*u)[1][0].im) +
        ((*u)[1][1].re*(*u)[1][1].re + (*u)[1][1].im*(*u)[1][1].im) +
        ((*u)[1][2].re*(*u)[1][2].re + (*u)[1][2].im*(*u)[1][2].im) ;
  
  len =  rsqrt(len); // 1/sqrt(len)
  // normalize b
  #pragma unroll 3
  for(i=0; i<3; i++){
    (*u)[1][i].re = (*u)[1][i].re*len;
    (*u)[1][i].im = (*u)[1][i].im*len;
  }


  // c = (a X b)*
  help1 = dev_cmult((*u)[0][1],(*u)[1][2]);
  help2 = dev_cmult((*u)[0][2],(*u)[1][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*u)[2][0] = help1;

  
  help1 = dev_cmult((*u)[0][2],(*u)[1][0]);
  help2 = dev_cmult((*u)[0][0],(*u)[1][2]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*u)[2][1] = help1;
  
  help1 = dev_cmult((*u)[0][0],(*u)[1][1]);
  help2 = dev_cmult((*u)[0][1],(*u)[1][0]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*u)[2][2] = help1;
        
}









extern "C" int bind_texture_gf(dev_su3_2v * gfield){
 //printf("Binding texture to gaugefield\n");
 
 #ifdef GF_8
 size_t size = sizeof(double2)*4*VOLUME*4;
 #else
 size_t size = sizeof(double2)*6*VOLUME*4;
 #endif
 
 cudaGetTextureReference(&gf_texRefPtr, "gf_tex");
 gf_channelDesc =  cudaCreateChannelDesc<int4>();
 cudaBindTexture(0, gf_texRefPtr, (int4 *) gfield, &gf_channelDesc, size);
 //printf("%s\n", cudaGetErrorString(cudaGetLastError()));    
 return(0);
}


extern "C" int unbind_texture_gf(){
 //printf("Unbinding texture from gaugefield\n");
 cudaUnbindTexture(gf_texRefPtr);
 //printf("%s\n", cudaGetErrorString(cudaGetLastError()));    
 return(0);
}




extern "C" int bind_texture_trafo(dev_su3_2v * trafofield){
 //printf("Binding texture to trafo field\n");
 
 #ifdef GF_8
 size_t size = sizeof(double2)*4*VOLUME;
 #else
 size_t size = sizeof(double2)*6*VOLUME;
 #endif
 
 cudaGetTextureReference(&trafo_texRefPtr, "trafo_tex");
 trafo_channelDesc =  cudaCreateChannelDesc<int4>();
 cudaBindTexture(0, trafo_texRefPtr, (int4 *) trafofield, &trafo_channelDesc, size);
 //printf("%s\n", cudaGetErrorString(cudaGetLastError()));    
 return(0);
}


extern "C" int unbind_texture_trafo(){
 //printf("Unbinding texture from trafo field\n");
 cudaUnbindTexture(trafo_texRefPtr);
 //printf("%s\n", cudaGetErrorString(cudaGetLastError()));    
 return(0);
}



