#ifndef _OBSERVABLES_H
#define _OBSERVABLES_H


void su3zero(su3* M);
void su3mult(su3* erg, su3 * M1, su3 * M2);
void su3dagger(su3*erg, su3 * M);
complex su3trace(su3 * M);
void su3add(su3* erg, su3 * M1, su3 * M2);
void su3skalarmult(su3* erg,complex skalar, su3 * M);
void su3sub(su3* erg, su3 * M1, su3 * M2);
void vectorpotential(su3 *A, su3 * U);

double dAdA(su3 * gf);



void su3copy(su3 * to,su3 * from );
double mean_plaq(su3 * gf);
double mean_plaq_bqcd(su3 * gf);
double first_plaq(su3* gf);
double gauge_functional(su3* gf);
void g_trafo(su3* u, su3 * g);


#endif


