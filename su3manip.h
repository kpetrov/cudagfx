#ifndef _SU3MANIP_H
#define _SU3MANIP_H



void su3zero(su3* M);
void su3mult(su3* erg, su3 * M1, su3 * M2);
void su3dagger(su3 * erg, su3 * M);
complex su3trace( su3 * M);
void su3sub(su3* erg, su3 * M1, su3 * M2);
void su3skalarmult(su3* erg,complex skalar, su3 * M);
void su3copy(su3 * to, su3 * from);
void show_su3(su3 * M);
complex su3_det(su3 * M);

void su3to2v(su3* gf, dev_su3_2v* h2d_gf);
void su3to8(su3* gf, dev_su3_8* h2d_gf);
void su3to8_trafo(su3* gf, dev_su3_8* h2d_gf);
void su3to2v_trafo(su3* gf, dev_su3_2v* h2d_gf);
void from8tosu3_trafo(su3* g, dev_su3_2v* h2d);
void from2vtosu3_trafo(su3* g, dev_su3_2v* h2d);

void unit_init_trafo(su3 * trafofield);
void random_init_trafo(su3 * trafofield);
void unit_init_gauge(su3 * gaugefield);
void random_init_gauge(su3 * gaugefield);
void random_init_su3(su3 * M);


#endif

