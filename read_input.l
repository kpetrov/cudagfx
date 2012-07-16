
SPC [[:blank:]]+
CMD [:][[:space:]]+
RLN [1-9(10)(11)(12)(13)(14)(15)(16)][:]
DIGIT [[:digit:]]
ZT [0-9(10)(11)]
IDXEX ("-"{DIGIT}+)
SIGN ("+"|"-")
FLT {SIGN}?{DIGIT}*+"."{DIGIT}*(e("-"|"+")?{DIGIT}+)?
FILENAME [a-zA-Z0-9_".""-""/"][a-zA-z0-9"."_"-""/"]+
NAME [a-zA-Z0-9_]+
TYPE [0-9A-Z]+

%{
#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include"cudaglobal.h"
#include"global.h"
#include"read_input.h"

int line_of_file=1;
int comment_caller;
int a,b;
float c;
char name[100];
  
  
// Overrelaxation parameters
int orxmaxit;
int orxcheckinterval;
double orxeps;  
int orxflag = 0;


// Sim. ann. parameters
SAPARAM_LIST saparam;
int saflag = 0;
//saparam.checkint = 1;

// Therm. parameters
THERMPARAM_LIST thermparam;
int thermflag = 0;
//thermparam.checkint = 1;

int randseed;
  
  /* Name of the parsing routine */
#define YY_DECL         int parse_input()
#define YY_NO_UNPUT
%}

%option never-interactive


%x TT
%x LL
%x INITORX
%x OVERRELAX


%x INITSA
%x SIMANN

%x INITTHERM
%x THERM

%x RND

%x ERROR
%x COMMENT

%%

^T{SPC}*={SPC}*                            BEGIN(TT);
^L{SPC}*={SPC}*                            BEGIN(LL);
^BeginORX		                   BEGIN(INITORX);
^RandSeed{SPC}*={SPC}* 			   BEGIN(RND);
^BeginSA                                   BEGIN(INITSA);
^BeginTHERM                                BEGIN(INITTHERM);


<TT>{DIGIT}+                  {
  T = atoi(yytext);
  printf("T = %s\n", yytext);
}
<LL>{DIGIT}+                  {
  L = atoi(yytext);
  printf("L = %s\n", yytext);
}


<RND>{DIGIT}+                  {
  randseed = atoi(yytext);
  printf("Random Seed = %s\n", yytext);
}


<INITSA>Init{SPC}* {
 printf("Found sim. annealing block in line %d\n", line_of_file); 
 BEGIN(SIMANN);
 }
<SIMANN>{
  {SPC}*Tmin{SPC}*={SPC}*{FLT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %f", name, &c);
    saparam.Tmin = c;
    printf(" SA Tmin set to %e in line %d\n", c, line_of_file);
  }
  {SPC}*Tmax{SPC}*={SPC}*{FLT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %f", name, &c);
    saparam.Tmax = c;
    printf(" SA Tmax set to %e in line %d\n", c, line_of_file);
  } 
  {SPC}*Nstep{SPC}*={SPC}*{DIGIT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %d", name, &a);
    saparam.N = a;
    printf(" SA steps set to %d line %d\n", a, line_of_file);
  }
  {SPC}*ckinterval{SPC}*={SPC}*{DIGIT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %d", name, &a);
    saparam.checkint = a;
    printf(" SA check interval set to %d line %d\n", a, line_of_file);
  }
  {SPC}*expo{SPC}*={SPC}*{FLT} {
    sscanf(yytext, " %[2a-zA-Z] = %f", name, &c);
    saparam.expo = c;
    printf(" SA temperature expo set to %e in line %d\n", c, line_of_file);
  }  
  EndSAInit{SPC}* {
  saflag=1;
  printf("End sim. annealing block in line %d\n\n", line_of_file);
  BEGIN(0);
  }
}






<INITTHERM>Init{SPC}* {
 printf("Found thermalization block in line %d\n", line_of_file); 
 BEGIN(THERM);
 }
<THERM>{
  {SPC}*Nsweep{SPC}*={SPC}*{DIGIT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %d", name, &a);
    thermparam.Nsweep = a;
    printf(" Nsweep set to %d line %d\n", a, line_of_file);
  }
  {SPC}*Nsave{SPC}*={SPC}*{DIGIT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %d", name, &a);
    thermparam.Nsave = a;
    printf(" Nsave set to %d line %d\n", a, line_of_file);
  }  
  {SPC}*ckinterval{SPC}*={SPC}*{DIGIT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %d", name, &a);
    thermparam.checkint = a;
    printf(" Therm. check interval set to %d line %d\n", a, line_of_file);
  }
  {SPC}*beta{SPC}*={SPC}*{FLT} {
    sscanf(yytext, " %[2a-zA-Z] = %f", name, &c);
    thermparam.beta = c;
    printf(" beta set to %e in line %d\n", c, line_of_file);
  }
  {SPC}*start{SPC}*={SPC}*hot {
    thermparam.startcond = 1;
    printf(" using hot start in line %d\n", line_of_file);
  }
  {SPC}*start{SPC}*={SPC}*cold {
    thermparam.startcond = 0;
    printf(" using cold start in line %d\n", line_of_file);
  }
  EndTHERMInit{SPC}* {
  thermflag=1;
  printf("End thermalization block in line %d\n\n", line_of_file);
  BEGIN(0);
  }
}



<INITORX>Init{SPC}* {
 printf("Found overrelaxation block in line %d\n", line_of_file); 
 BEGIN(OVERRELAX);
 }
<OVERRELAX>{
  {SPC}*eps{SPC}*={SPC}*{FLT} {
    sscanf(yytext, " %[2a-zA-Z] = %f", name, &c);
    orxeps = c;
    printf(" Overrelaxation dAdA epsilon set to %e in line %d\n", c, line_of_file);
  }
  {SPC}*maxit{SPC}*={SPC}*{DIGIT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %d", name, &a);
    orxmaxit = a;
    printf(" Overrelaxation max iterations set to %d line %d\n", a, line_of_file);
  }
  {SPC}*ckinterval{SPC}*={SPC}*{DIGIT}+ {
    sscanf(yytext, " %[2a-zA-Z] = %d", name, &a);
    orxcheckinterval = a;
    printf(" Overrelaxation check interval set to %d line %d\n", a, line_of_file);
  }  
  EndORXInit{SPC}* {
  orxflag=1;
  printf("End overrelaxation block in line %d\n\n", line_of_file);
  BEGIN(0);
  }
}









<*>^#   {
   comment_caller = YY_START;   
   BEGIN(COMMENT);
}
<*>{SPC}*#    {
   comment_caller = YY_START;
   BEGIN(COMMENT);
}
<COMMENT>[^\n]*             {
  BEGIN(comment_caller);
}

<*>. {
  BEGIN(ERROR);
}
<ERROR>[^\t\n]*             {
  printf("Parsing error in line %d\nAborting...!\n", line_of_file);
  printf("%s\n",yytext);
  exit(1);
}


<INITORX,OVERRELAX,INITSA,SIMANN,INITTHERM,THERM>\n {
  line_of_file++;
}
<*>\n                       {
  line_of_file++;
  BEGIN(0);
}





%%


/*
 *  Dummy (but not dumb) routine - well, function
 */

int yywrap()
{
  return(1);
}


int read_input(char * conf_file){

  if ((yyin = fopen(conf_file, "rt")) == NULL){
    return(2);
  }
  
  yyout = fopen("/dev/null", "w");
  
  parse_input();  
 
  
  LX=L;
  LY=L;
  LZ=L;
  VOLUME=LX*LY*LZ*T;
   
  fclose(yyout);
  fclose(yyin);
  return(0);
}


