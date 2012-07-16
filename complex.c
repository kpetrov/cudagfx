#include "cudaglobal.h"
#include "global.h"
#include "complex.h"
#include "stdio.h"
#include "stdlib.h"
#include <math.h>


/*
inline complex crealmult(complex c1, double real){//multipliziert c1 mit reeller zahl re
  complex erg;
  erg.re = real*c1.re;
  erg.im = real*c1.im;
return erg;
}

inline complex cmult (complex c1, complex c2){//multiplizier zwei komplexe Zahlen
  complex erg;
  erg.re = c1.re * c2.re - c1.im * c2.im;
  erg.im = c1.re * c2.im + c1.im * c2.re;
return erg;
}
*/



complex cconj (complex c){ /*konjugiert komplexe Zahl*/
 complex erg;
 erg.re = c.re;
 erg.im = -1.0*c.im;
return erg;
}

void ccopy(complex* von, complex* nach){/*kopiert complex von nach complex nach*/
  nach->re = von->re;
  nach->im = von->im;
}

double cabssquare (complex c){ /*gibt abs^2 einer komplexen Zahl zurück*/
 return c.re*c.re + c.im*c.im;
}

double cabsolute (complex c){/*gibt Betrag einer kompl. zahl zurück*/
 return sqrt(c.re*c.re + c.im*c.im);
}


complex crealmult(complex c1, double real){ /*multipliziert c1 mit reeller zahl re*/
  complex erg;
  erg.re = real*c1.re;
  erg.im = real*c1.im;
return erg;
}

complex cmult (complex c1, complex c2){ /*multiplizier zwei komplexe Zahlen*/
  complex erg;
  erg.re = c1.re * c2.re - c1.im * c2.im;
  erg.im = c1.re * c2.im + c1.im * c2.re;
return erg;
}

complex cadd (complex c1, complex c2){ /*addiert zwei komplexe Zahlen */
  complex erg;
  erg.re = c1.re + c2.re;
  erg.im = c1.im + c2.im;
return erg;
}


complex cdiv(complex c1, complex c2) { /* dividiert c1 durch c2 */
  complex erg;
  double oneovernenner = 1.0/(c2.re*c2.re + c2.im*c2.im);
  erg.re = oneovernenner*(c1.re*c2.re + c1.im*c2.im);
  erg.im = oneovernenner*(c1.im*c2.re - c1.re*c2.im);
return erg;
}


complex csub(complex c1, complex c2){
   complex erg;
   erg.re = c1.re - c2.re;
   erg.im = c1.im - c2.im;
return erg;
}

void showcomplex(complex c){
  printf("(%f,%f)",(double)c.re,(double)c.im);
return;
}

complex initcomplex(double re, double im){/* gibt komplexe Zahl mit Realt re und Imt im zurück*/
  complex erg;
  erg.re = re;
  erg.im = im;
return erg;
}


double host_skalarprod_spinor_field(spinor* s1, spinor* s2){
  int i,j,k;
  double skalprod = 0.0l;
  complex conj;
  complex prod;
  for(i=0;i<VOLUME;i++){
    for(j=0;j<12;j++){
      conj = cconj(s1[i][j]);
      prod = cmult(conj,s2[i][j]);
      skalprod += prod.re;
    }
  }
  return skalprod;
}


void host_add_spinor_field(spinor* s1, spinor* s2, spinor* so){
  int i,j,k;

  for(i=0;i<VOLUME;i++){
    for(j=0;j<12;j++){
      so[i][j] = cadd(s1[i][j], s2[i][j]);
    }
  }
}

void host_skalarmult_spinor_field(spinor* s1, complex alpha, spinor* so){
  int i,j,k;

  for(i=0;i<VOLUME;i++){
    for(j=0;j<12;j++){
      so[i][j] = cmult(s1[i][j], alpha);
    }
  }
}







