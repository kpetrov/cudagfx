#include "cudaglobal.h"
#include "global.h"
#include"lime.h" 
#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<math.h>
#include "spinor_io.h"



extern LimeReader* limeCreateReader(FILE *fp);
extern void limeDestroyReader(LimeReader *r);
extern int limeReaderNextRecord(LimeReader *r);
extern char *limeReaderType(LimeReader *r);
extern LimeWriter* limeCreateWriter(FILE *fp);





void byte_swap_assign_double(void * out_ptr, void * in_ptr, int nmemb){
  int j;
  char * char_in_ptr, * char_out_ptr;
  double * double_in_ptr, * double_out_ptr;

  double_in_ptr = (double *) in_ptr;
  double_out_ptr = (double *) out_ptr;
  for(j = 0; j < nmemb; j++){
    char_in_ptr = (char *) double_in_ptr;
    char_out_ptr = (char *) double_out_ptr;
    
    char_out_ptr[7] = char_in_ptr[0];
    char_out_ptr[6] = char_in_ptr[1];
    char_out_ptr[5] = char_in_ptr[2];
    char_out_ptr[4] = char_in_ptr[3];
    char_out_ptr[3] = char_in_ptr[4];
    char_out_ptr[2] = char_in_ptr[5];
    char_out_ptr[1] = char_in_ptr[6];
    char_out_ptr[0] = char_in_ptr[7];
    double_in_ptr++;
    double_out_ptr++;
  }
}





void byte_swap_assign_float(void * out_ptr, void * in_ptr, int nmemb){
  int j;
  char * char_in_ptr, * char_out_ptr;
  float * float_in_ptr, * float_out_ptr;

  float_in_ptr = (float *) in_ptr;
  float_out_ptr = (float *) out_ptr;
  for(j = 0; j < nmemb; j++){
    char_in_ptr = (char *) float_in_ptr;
    char_out_ptr = (char *) float_out_ptr;
    
    char_out_ptr[3] = char_in_ptr[0];
    char_out_ptr[2] = char_in_ptr[1];
    char_out_ptr[1] = char_in_ptr[2];
    char_out_ptr[0] = char_in_ptr[3];
    
    float_in_ptr++;
    float_out_ptr++;
  }
}













int write_spinor(spinor * spin, char * filename, const int prec){/*schreibt den Spinor spin in Datei filename
                                                                   prec = 32 (single) prec = 64 (double)*/
  FILE * ofs;
  char * header_type = NULL;
  LimeWriter * limewriter = NULL;
  n_uint64_t bytes;
  int status = 0;  
  int ME_flag=1, MB_flag=1;
  bytes = LX*LY*LZ*T*(n_uint64_t)24*sizeof(double)*prec/64;
  int x,y,z,t,counter,i,j;
  char message[512];
  LimeRecordHeader * limeheader = NULL;
  
  int spinornumofdoubles = (sizeof(spinor)/sizeof(double));
  int spinornumofbytes = sizeof(spinor);
  
  float farray [24];
  double darray[24];
  
  float  farray2[24];
  double  darray2[24];
  
  spinor helpspinor;
  
  if((ofs = fopen(filename, "w")) == (FILE*)NULL) {
      fprintf(stderr, "Error opening file %s\n", filename);
    return(-1);
  }
 
  
  limewriter = limeCreateWriter( ofs );
  if(limewriter == (LimeWriter*)NULL) {
    fprintf(stderr, "LIME error in file %s for writing!\n Aborting...\n", filename);
    exit(500);
  }
  
  sprintf(message,"fft(DiracFermion_Sink)");
  bytes = strlen( message );
  limeheader = limeCreateHeader(MB_flag, ME_flag, "propagator-type", bytes);
  status = limeWriteRecordHeader(limeheader,limewriter);
  if(status < 0 ) {
    fprintf(stderr, "LIME write header error %d\n", status);
    exit(500);
  }
 
  limeDestroyHeader( limeheader );
  limeWriteRecordData(message, &bytes, limewriter);

  
  

  sprintf(message, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<etmcFormat>\n<field>diracFermion</field>\n<precision>%d</precision>\n<flavours>%d</flavours>\n<lx>%d</lx>\n<ly>%d</ly>\n<lz>%d</lz>\n<lt>%d</lt>\n</etmcFormat>", prec, 2, LX, LY, LZ, T);
  bytes = strlen( message );
  limeheader = limeCreateHeader(MB_flag, ME_flag, "etmc-propagator-format", bytes);
  status = limeWriteRecordHeader( limeheader, limewriter);
  if(status < 0 ) {
    fprintf(stderr, "LIME write header error %d\n", status);
    exit(500);
  }
  limeDestroyHeader( limeheader );
  limeWriteRecordData(message, &bytes, limewriter);

  if (prec == 64){
    bytes = T*LX*LY*LZ*spinornumofbytes;
  }
  else if(prec == 32){
    bytes = T*LX*LY*LZ*spinornumofbytes/2;
  }
  
  limeheader = limeCreateHeader(MB_flag, ME_flag, "scidac-binary-data", bytes);
  status = limeWriteRecordHeader( limeheader, limewriter);
  if(status < 0 ) {
    fprintf(stderr, "LIME write header (scidac-binary-data) error %d\n", status);
    exit(500);
  }
  limeDestroyHeader( limeheader );
  
  
 
  
  if(prec == 64){ 
    counter = 0;
    bytes =  24*sizeof(double);  /* number of bytes in spin[x] */
    
    for( t = 0; t < T; t++) {
      for(z = 0; z < LZ; z++) {
        for(y = 0; y < LY; y++) {
          for(x = 0; x < LX; x++) {
              memcpy(&(darray[0]),&(spin[counter]),spinornumofbytes);
#ifndef WORDS_BIGENDIAN 
              /* convert to big-endian (as necessary for linux)*/
              byte_swap_assign_double(&(darray2[0]),&(darray[0]),24);
              status = limeWriteRecordData((void*)darray2, &bytes, limewriter);
#else
              status = limeWriteRecordData((void*)darray, &bytes, limewriter); 
#endif              
              counter ++;            
          }
        }
      }
    }
  }
  else{
    if(prec == 32){
      counter = 0;
      bytes =  24*sizeof(float);  /* number of bytes in spin[x] */
      
      
      for( t = 0; t < T; t++) {
        for(z = 0; z < LZ; z++) {
          for(y = 0; y < LY; y++) {
            for(x = 0; x < LX; x++) {
               
              memcpy(&(darray[0]),&(spin[counter]), spinornumofbytes);
              for(i=0; i<24; i++){         /* convert to single */
                farray[i] = (float)(darray[i]); 
              }
#ifndef WORDS_BIGENDIAN 
              /* convert to big-endian (as necessary for linux)  */
              byte_swap_assign_float(&(farray2[0]),&(farray[0]),24);
                            
              
              status = limeWriteRecordData((void*)farray2, &bytes, limewriter);

#else
              status = limeWriteRecordData((void*)farray, &bytes, limewriter);
#endif              
              counter ++;
            }
          }
        }
      }    
    }
    else{
      fprintf(stderr, "Error in write_spinor: precision neither 64 nor 32! Aborting...\n");
      exit(500);
    }
  }

  limeDestroyWriter(limewriter);
  fflush(ofs);
  fclose(ofs);
  
}








int analyzeLimeFile(char* filename){
  FILE * ifs;
  char * header_type;
  LimeReader * limereader;
  
  char xmlentry[512];
  n_uint64_t bytes;
  int status = 0;


  if((ifs = fopen(filename, "r")) == (FILE*)NULL) {
      fprintf(stderr, "Error opening file %s\n", filename);
    return(-1);
  }

  limereader = limeCreateReader( ifs );
  if( limereader == (LimeReader *)NULL ) {
      fprintf(stderr, "Unable to open LimeReader\n");
    return(-1);
  }
  while( (status = limeReaderNextRecord(limereader)) != LIME_EOF ) {
    if(status != LIME_SUCCESS) {
      fprintf(stderr, "limeReaderNextRecord returned error with status = %d!\n", status);
      status = LIME_EOF;
      break;
    }
    
    header_type = limeReaderType(limereader);
    printf("LimeRecord found: %s \n", header_type);   
    
    if(!strcmp("etmc-propagator-format",header_type)){
      bytes = limeReaderBytes(limereader);
      limeReaderReadData(xmlentry,&bytes,limereader); 
      printf("Content:\n", header_type);
      printf("%s\n\n",xmlentry);
    }
    if(!strcmp("propagator-type",header_type)){
      bytes = limeReaderBytes(limereader);
      limeReaderReadData(xmlentry,&bytes,limereader); 
      printf("Content:\n", header_type);
      printf("%s\n\n",xmlentry);
    }    
    if(!strcmp("xlf-info",header_type)){
      bytes = limeReaderBytes(limereader);
      limeReaderReadData(xmlentry,&bytes,limereader); 
      printf("Content:\n", header_type);
      printf("%s\n\n",xmlentry);
    }      
    if(!strcmp("inverter-info",header_type)){
      bytes = limeReaderBytes(limereader);
      limeReaderReadData(xmlentry,&bytes,limereader); 
      printf("Content:\n", header_type);
      printf("%s\n\n",xmlentry);
    }  
    printf("\n");
  }
  if(status == LIME_EOF) {
    limeDestroyReader(limereader);
    fclose(ifs);
    return(0);
  }
  
  if(status < 0 && status != LIME_EOR) {
    fprintf(stderr, "LIME read error occured with status = %d while reading file %s!\n Aborting...\n", status, filename);
    exit(500);
  }


  return(0);
}





int getXmlEntry(char* searchstring, char* tagname, char* content){
  char begintag [256];
  char endtag[256];
  char help[256];
  char* begloc,* endloc;
  int length;
  
  strcpy (begintag, "<");
  strcat(begintag, tagname); 
  strcat(begintag, ">");
  
  /*printf("begintag: %s\n", begintag);*/
  if ((begloc = strstr(searchstring,begintag)) == (char*)NULL){
    return(0);
  }
  strcpy (endtag, "</");
  strcat(endtag, tagname); 
  strcat(endtag, ">");
  /*printf("endtag: %s\n", endtag);*/
  
  if ((endloc = strstr(searchstring,endtag)) == (char*)NULL){
    return(0);
  }
  begloc = begloc + strlen(begintag);
  length = endloc - begloc;
  strncpy(content, begloc, length);
  content[length] = '\0'; /* mit null terminieren*/
  
  return(1);
}






int read_etmc_format(char * filename){  /*reads the etmc format of a file for initialization of the dimension and precision*/
  FILE * ifs;
  int status=0,dimension,precision;
  char * header_type;
  LimeReader * limereader;
  n_uint64_t bytes;
  char xmlentry[512];
  char xmlcontent[256];
  
  if((ifs = fopen(filename, "r")) == (FILE*)NULL) {
      fprintf(stderr, "Error opening file %s\n", filename);
    return(-1);
  }
  else{
    printf("\nReading etmc-format out of file'%s'\n",filename);
  }

  limereader = limeCreateReader( ifs );
  if( limereader == (LimeReader *)NULL ) {
      fprintf(stderr, "Unable to open LimeReader\n");
    return(-1);
  }
  while( (status = limeReaderNextRecord(limereader)) != LIME_EOF ) {
    if(status != LIME_SUCCESS) {
      fprintf(stderr, "limeReaderNextRecord returned error with status = %d!\n", status);
      fclose(ifs);
      return(-1);
    }
    header_type = limeReaderType(limereader);
    
    if(!strcmp("etmc-propagator-format",header_type)){
      bytes = limeReaderBytes(limereader);
      strcpy(xmlentry,"");
      strcpy(xmlcontent,"");
      limeReaderReadData(xmlentry,&bytes,limereader); /* hier ganzer Eintrag in xmlentry*/
      
      getXmlEntry(xmlentry,"field", xmlcontent);
      printf("The field is of type: %s, with parameters set to:\n",xmlcontent);
      
      getXmlEntry(xmlentry,"precision", xmlcontent);
      sscanf(xmlcontent,"%d",&precision);
      printf("prec=%d,",precision);
      g_precision = precision;
      
      getXmlEntry(xmlentry,"lx", xmlcontent);
      sscanf(xmlcontent,"%d",&dimension);
      printf("LX=%d,",dimension);
      LX = dimension;
      
      getXmlEntry(xmlentry,"ly", xmlcontent);
      sscanf(xmlcontent,"%d",&dimension);
      printf("LY=%d,",dimension);
      LY = dimension;
      
      getXmlEntry(xmlentry,"lz", xmlcontent);
      sscanf(xmlcontent,"%d",&dimension);
      printf("LZ=%d,",dimension);
      LZ = dimension;
      
      getXmlEntry(xmlentry,"lt", xmlcontent);
      sscanf(xmlcontent,"%d",&dimension);
      printf("T=%d,",dimension);
      T = dimension;
      
      VOLUME = T*LX*LY*LZ;
      printf("->VOLUME=%d\n",VOLUME);
      
      fclose(ifs);
      return(0);
    }

  }
fclose(ifs);
return(-1);
}


int read_spinor(spinor * const  s, char * filename) {
  FILE * ifs;
  int t, x, y , z, k, status=0 , i=0;
  char character;
  n_uint64_t bytes = sizeof(float);
  n_uint64_t singlebyte = 1;
  char * header_type;
  LimeReader * limereader;
  float fhelp;
  double dhelp;
  int spinornumofdoubles = (sizeof(spinor)/sizeof(double));
  int spinornumofbytes = sizeof(spinor);
  
  float * farray = malloc(spinornumofdoubles*sizeof(float));
  double * darray = malloc(spinornumofbytes);
  
  char xmlentry[512];
  char xmlcontent[256];
  
  int readformat = 0;
  int precision = 0; /* 32 = single, 64 = double*/
  int dimension;
  int readprecision = 0;
  
  
  spinor test;
  spinor * sp = s;
  

  if((ifs = fopen(filename, "r")) == (FILE*)NULL) {
      fprintf(stderr, "Error opening file %s\n", filename);
    return(-1);
  }
  else{
    printf("\nReading spinor-field out of file'%s'\n",filename);
  }

  limereader = limeCreateReader( ifs );
  if( limereader == (LimeReader *)NULL ) {
      fprintf(stderr, "Unable to open LimeReader\n");
    return(-1);
  }
  while( (status = limeReaderNextRecord(limereader)) != LIME_EOF ) {
    if(status != LIME_SUCCESS) {
      fprintf(stderr, "limeReaderNextRecord returned error with status = %d!\n", status);
      status = LIME_EOF;
      break;
    }
    header_type = limeReaderType(limereader);
    
    /*printf("The selected file contains a record of type: %s\n",header_type);    */
    if(!strcmp("etmc-propagator-format",header_type)){
      bytes = limeReaderBytes(limereader);
      strcpy(xmlentry,"");
      strcpy(xmlcontent,"");
      limeReaderReadData(xmlentry,&bytes,limereader); /* hier ganzer Eintrag in xmlentry*/
      
      getXmlEntry(xmlentry,"field", xmlcontent);
      printf("The field is of type: %s, with parameters set to:\n",xmlcontent);
      
      getXmlEntry(xmlentry,"precision", xmlcontent);
      sscanf(xmlcontent,"%d",&precision);
      readprecision = 1; /* precision aus xml - entry gelesen*/
      printf("prec=%d,",precision);
      g_precision = precision;
      
      getXmlEntry(xmlentry,"lx", xmlcontent);
      sscanf(xmlcontent,"%d",&dimension);
      printf("LX=%d,",dimension);
      LX = dimension;
      
      getXmlEntry(xmlentry,"ly", xmlcontent);
      sscanf(xmlcontent,"%d",&dimension);
      printf("LY=%d,",dimension);
      LY = dimension;
      
      getXmlEntry(xmlentry,"lz", xmlcontent);
      sscanf(xmlcontent,"%d",&dimension);
      printf("LZ=%d,",dimension);
      LZ = dimension;
      
      getXmlEntry(xmlentry,"lt", xmlcontent);
      sscanf(xmlcontent,"%d",&dimension);
      printf("T=%d\n",dimension);
      T = dimension;
      
      if (!getXmlEntry(xmlentry,"spin", xmlcontent)){
        /*printf("No Xml-Entry 'spin' found! Should be 4. Otherwise sizes of data won't match!\n");*/
      }
      else{
        sscanf(xmlcontent,"%d",&dimension);
        printf("We have %d spinor components\n",dimension);
        if(dimension != 4){
          fprintf(stderr, "Wrong number of spinor components. Aborting... %s\n");   
         exit(500);     
       }
      }
      
      
      if(!getXmlEntry(xmlentry,"color", xmlcontent)){
       /* printf("No Xml-Entry 'color' found! Should be 3. Otherwise sizes of data won't match!\n");*/
      }
      else{
        sscanf(xmlcontent,"%d",&dimension);
        printf("We have %d colors\n",dimension);
        if(dimension != 4){
          fprintf(stderr, "This should be QCD! Wrong number of colors. Aborting... %s\n");   
          exit(500);     
        }
      }      
      
      readformat = 0;
    }

    if(!strcmp("scidac-binary-data",header_type)) break;
  }
  if(status == LIME_EOF) {
    limeDestroyReader(limereader);
    fclose(ifs);
    return(-1);
  }
  
  
  if(readformat != 0){
    fprintf(stderr, "Unable to read Xml-Format out of LimeReader\n");
    return(-1);    
  }
  bytes = limeReaderBytes(limereader);
  
  if(bytes == LX*LY*LZ*T*(uint64_t)(24*sizeof(float)) && ( (precision == 32) || (readprecision == 0) )) { /* file contains floats */


  bytes = sizeof(spinor)/2; /* halbe Größe, wegen floats */
  
  i=0;
     for(t = 0; t < T; t++){  
       for(z = 0; z < LZ; z++) {
         for(y = 0; y < LY; y++) { 
           for(x = 0; x < LX; x++) {
              limeReaderReadData(&farray[0], &bytes, limereader);
              
              for(k=0; k < spinornumofdoubles;k++){ /* convert to double and make little-endian */ 
#ifndef WORDS_BIGENDIAN   
                 fhelp = farray[k];          
                 byte_swap_assign_float(&(farray[k]), &fhelp , 1);
#else

#endif
                 darray[k] = (double) farray[k];
              }
              memcpy(&(s[i]) ,&darray[0], spinornumofbytes); 
              i++;
           }
         }
       }
     }
   }
   
  
  else{
  if(bytes == LX*LY*LZ*T*(uint64_t)(24*sizeof(double))&& ( (precision == 64) || (readprecision == 0) )) { /* file contains doubles */

  bytes = sizeof(spinor);  
  i=0;
     for(t = 0; t < T; t++){  
       for(z = 0; z < LZ; z++) {
         for(y = 0; y < LY; y++) { 
           for(x = 0; x < LX; x++) {
#ifndef WORDS_BIGENDIAN     
              limeReaderReadData(&darray[0], &bytes, limereader);
              byte_swap_assign_double(&(s[i]),&(darray[0]), 24);
#else
              limeReaderReadData(&(s[i]), &bytes, limereader);
#endif
              
              i++;
           }
         }
       }
     }
   }
   else{ /* precision xml-entry doesn't match size of data-block */
     fprintf(stderr, "Error in %s: Xml-Entry 'precision' does not match size of data block. Possible file corruption! Aborting...\n",filename);
     exit(500);
   }
 }
   
   
  if(status < 0 && status != LIME_EOR) {
    fprintf(stderr, "LIME read error occured with status = %d while reading file %s!\n Aborting...\n", status, filename);
    exit(500);
  }

  limeDestroyReader(limereader);
  fclose(ifs);
  free(farray);
  free(darray);
  return(0);
}




int readromprop(int nksquare, int nmass, char* filename, propmatrix* field){
  complex readdummy;
  complex swapreim;
  int s1,s2,c1,c2, iksquare,imass;
  FILE * infile;
  if((infile = fopen(filename, "r")) == (FILE*)NULL) {
      fprintf(stderr, "Error in readromprop while opening file %s\n", filename);
    return(-1);
  }
  
  for(imass=0; imass<nmass; imass++){
    for(iksquare=0;iksquare<nksquare;iksquare++){
      for(c1=0;c1<3;c1++){
        for(s1=0;s1<4;s1++){
          for(c2=0; c2<3;c2++){
            for(s2=0;s2<4;s2++){
              fread(&readdummy,16,1,infile);  /* sizeof(complex) = 2*sizeof(double) = 16*/
              field[nksquare*imass+iksquare][s2*3+c2][s1*3+c1] = readdummy;
            }
          }
        }
      }
    }
  }
  
  fclose(infile);
return 0;
}


int writeromprop(int nksquare, int nmass, char* filename, propmatrix* field){
  int s1,s2,c1,c2, iksquare,imass;
  complex writedummy;
  FILE * outfile;
  if((outfile = fopen(filename, "w")) == (FILE*)NULL) {
      fprintf(stderr, "Error in writeromprop while opening file %s\n", filename);
    exit(300);
  }
  printf("Writing propagator in rom format to file '%s'\n\n",filename); 
  for(imass=0; imass<nmass; imass++){
    for(iksquare=0;iksquare<nksquare;iksquare++){
      for(c1=0;c1<3;c1++){
        for(s1=0;s1<4;s1++){
          for(c2=0; c2<3;c2++){
            for(s2=0;s2<4;s2++){
              writedummy = field[nksquare*imass+iksquare][s2*3+c2][s1*3+c1];
              fwrite(&writedummy,16,1,outfile);  /* sizeof(complex) = 2*sizeof(double) = 16*/
            }
          }
        }
      }
    }
  }
  fclose(outfile);
return(0);
}



