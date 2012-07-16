#ifndef _COMPLEX_H


complex cconj (complex c);
void ccopy(complex* von, complex* nach);
double cabssquare (complex c);
double cabsolute (complex c);
void showcomplex(complex c);
complex initcomplex(double re, double im); 
complex crealmult(complex c1, double real);
complex cmult (complex c1, complex c2);
complex cdiv(complex c1, complex c2);
complex cadd (complex c1, complex c2);
complex csub(complex c1, complex c2);
void host_add_spinor_field(spinor* s1, spinor* s2, spinor* so);
double host_skalarprod_spinor_field(spinor* s1, spinor* s2);
void host_skalarmult_spinor_field(spinor* s1, complex alpha, spinor* so);
#define _COMPLEX_H
#endif

