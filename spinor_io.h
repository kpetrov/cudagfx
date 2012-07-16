#ifndef _SPINOR_IO_H
#define _SPINOR_IO_H



void byte_swap_assign_double(void * out_ptr, void * in_ptr, int nmemb);
void byte_swap_assign_float(void * out_ptr, void * in_ptr, int nmemb);
int getXmlEntry(char* searchstring, char* tagname, char* content);
int read_spinor(spinor * const  s, char * filename);
int analyzeLimeFile(char* filename);
int write_spinor(spinor * spin, char * filename, const int prec);
int write_wave_source(char* filename, int kt, int kx, int ky, int kz,spinor seed, spinor* lattice, int prec);
int read_etmc_format(char * filename);
int readromprop(int nksquare, int nmass, char* filename, propmatrix* field);
int writeromprop(int nksquare, int nmass, char* filename, propmatrix* field);
#endif









