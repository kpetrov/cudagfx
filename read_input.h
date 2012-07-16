#ifndef _READ_INPUT_H



int read_input(char * conf_file);

extern int randseed;
extern int orxmaxit;
extern int orxcheckinterval;
extern double orxeps;
extern SAPARAM_LIST saparam;
extern THERMPARAM_LIST thermparam;
extern int saflag;
extern int orxflag;
extern int thermflag;

#define _READ_INPUT_H
#endif 

