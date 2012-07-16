#ifndef _SPINOR_IO_H
#define _SPINOR_IO_H

#include "lime.h"


void byte_swap_assign_double(void * out_ptr, void * in_ptr, int nmemb);
void byte_swap_assign_float(void * out_ptr, void * in_ptr, int nmemb);
int getXmlEntry(char* searchstring, char* tagname, char* content);
int get_unformatted_entry(char* searchstring,char* tagname, char* content);
void showsu3(su3 M);

int write_ildg_format_xml(char *filename, LimeWriter * limewriter, const int prec);
int read_gf_header_ildg(char* filename);
int write_gf_ildg(su3 * gf, char * filename, const int prec);
int read_gf_ildg(su3 * gf , char* filename);

int read_gf_bqcd(su3 * gf,char* basefilename , type_conf_info confinfo, type_cksum cksums[]);
int write_gf_bqcd( su3 * gf,char * basefilename);
int write_conf_info(char* filename, type_conf_info confinfo, type_cksum cksums[]);
int read_conf_info(char* filename,type_conf_info confinfo);

int read_gtrafo_info(char* filename, type_conf_info confinfo,int firstbest);
int calculate_cksums_trafo(type_cksum cksums[],char* basefilename, su3 * trafofield);
int read_trafo_bqcd(su3 * trafofield ,char* basefilename , type_cksum cksums[]);




void transpose_gf(su3* gf);
void transpose_trafo(su3* trafo);

void swap_directions_gf(su3* gf);
#endif









