#include "cudaglobal.h"
#include "global.h"
#include "complex.h"
#include "stdlib.h"
#include "stdio.h"
#include "su3manip.h"
#include <math.h>
#include "rngs.h"

void su3zero(su3* M){
 int i,j;
 complex czero = initcomplex(0.0l,0.0l);
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*M)[i][j] = czero;
    }
  }
return;
}


void su3mult(su3* erg, su3 * M1, su3 * M2){
  complex help1, help2;
  complex zero=initcomplex(0.0,0.0);
  int i,j,k;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
    
      help2 = zero;
      for(k=0; k<3; k++){
          help1 = cmult((*M1)[i][k],(*M2)[k][j]);
          help2 = cadd(help1, help2);
        }
        (*erg)[i][j] = help2;
        
    }
  }
}




void su3dagger(su3 * erg, su3 * M){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){  
      (*erg)[i][j] = cconj((*M)[j][i]);
    }
  }
}



complex su3trace( su3 * M){
  complex erg;
  int i;
  erg = initcomplex(0.0,0.0);
  for(i=0; i<3; i++){
    erg = cadd(erg, (*M)[i][i]);
  }
  return(erg);
}



void su3sub(su3* erg, su3 * M1, su3 * M2){
  int i,j;
  
  for(i=0;i<3;i++){
    for(j=0;j<3;j++){
      (*erg)[i][j] = csub((*M1)[i][j],(*M2)[i][j]);
    }
  }
}


void su3add(su3* erg, su3 * M1, su3 * M2){
  int i,j;
  
  for(i=0;i<3;i++){
    for(j=0;j<3;j++){
      (*erg)[i][j] = cadd((*M1)[i][j],(*M2)[i][j]);
    }
  }

}



void su3skalarmult(su3* erg,complex skalar, su3 * M){
  int i,j;
  
  for(i=0;i<3;i++){
    for(j=0;j<3;j++){
      (*erg)[i][j] = cmult(skalar,(*M)[i][j]);
    }
  }
}



void su3copy(su3 * to, su3 * from){

  int i,j;
  for(i=0; i<3; i++){
    for(j=0; j<3; j++){
      (*to)[i][j] = (*from)[i][j];
    }
  }
return;
}





void show_su3(su3 * M){
  int i,j;
  su3 Mdagger, MdaggerM;
  
  
  printf("{");
  for(i=0; i<3; i++){
    printf("{");
    for(j=0; j<3; j++){
     printf("%f + %f I, ", (*M)[i][j].re, (*M)[i][j].im);
    }
    printf("}\n");
  }
  printf("}\n\n");
   
  double help =  (*M)[0][0].re*(*M)[0][0].re + (*M)[0][0].im*(*M)[0][0].im + 
                 (*M)[0][1].re*(*M)[0][1].re + (*M)[0][1].im*(*M)[0][1].im + 
                 (*M)[0][2].re*(*M)[0][2].re + (*M)[0][2].im*(*M)[0][2].im;
  printf("a^2 = %f\n", help);
  
  help =  (*M)[1][0].re*(*M)[1][0].re + (*M)[1][0].im*(*M)[1][0].im + 
          (*M)[1][1].re*(*M)[1][1].re + (*M)[1][1].im*(*M)[1][1].im + 
          (*M)[1][2].re*(*M)[1][2].re + (*M)[1][2].im*(*M)[1][2].im;
  printf("b^2 = %f\n", help);


  double ab0_re = (*M)[0][0].re * (*M)[1][0].re + (*M)[0][0].im * (*M)[1][0].im;
  double ab0_im = -(*M)[0][0].re * (*M)[1][0].im + (*M)[0][0].im * (*M)[1][0].re;
  double ab1_re = (*M)[0][1].re * (*M)[1][1].re + (*M)[0][1].im * (*M)[1][1].im;
  double ab1_im = -(*M)[0][1].re * (*M)[1][1].im + (*M)[0][1].im * (*M)[1][1].re;  
  double ab2_re = (*M)[0][2].re * (*M)[1][2].re + (*M)[0][2].im * (*M)[1][2].im;
  double ab2_im = -(*M)[0][2].re * (*M)[1][2].im + (*M)[0][2].im * (*M)[1][2].re;  
  
  printf("a*b = (%f, %f)\n", ab0_re+ab1_re+ab2_re, ab0_im+ab1_im+ab2_im);
  
  complex det = su3_det(M);
  printf("det = (%f, %f)\n", det.re, det.im);
  
  su3dagger(&(Mdagger), M);
  su3mult(&(MdaggerM), &(Mdagger), M);
  
  
  printf("M^+ * M = \n");
  printf("{");
  for(i=0; i<3; i++){
    printf("{");
    for(j=0; j<3; j++){
     printf("%f + %f I, ", (MdaggerM)[i][j].re, (MdaggerM)[i][j].im);
    }
    printf("}\n");
  }
  printf("}\n\n");
  
}





complex su3_det(su3 * M){
  complex help1, help2;
  complex term1, term2, term3, term4, term5, term6;
  complex det;
  
  help1 = cmult( (*M)[0][0], (*M)[1][1] );
  term1 = cmult( help1, (*M)[2][2] );
  det = term1;
  
  help1 = cmult( (*M)[0][1], (*M)[1][2] );
  term2 = cmult( help1, (*M)[2][0] );
  det = cadd(det, term2);
  
  help1 = cmult( (*M)[0][2], (*M)[1][0] );
  term3 = cmult( help1, (*M)[2][1] );
  det = cadd(det, term3); 
  
  help1 = cmult( (*M)[0][0], (*M)[1][2] );
  term4 = cmult( help1, (*M)[2][1] );
  det = csub(det, term4);
  
  help1 = cmult( (*M)[0][1], (*M)[1][0] );
  term5 = cmult( help1, (*M)[2][2] );
  det = csub(det, term5); 
  
  help1 = cmult( (*M)[0][2], (*M)[1][1] );
  term6 = cmult( help1, (*M)[2][0] );
  det = csub(det, term6);   
  
  return(det);
}





void su3to2v(su3* gf, dev_su3_2v* h2d_gf){
  int i;
  for (i=0;i<4*VOLUME;i++){
   //first row
    h2d_gf[6*i].x   =  gf[i][0][0].re;
    h2d_gf[6*i].y   =  gf[i][0][0].im;
    h2d_gf[6*i+1].x = gf[i][0][1].re;
    h2d_gf[6*i+1].y = gf[i][0][1].im;
    h2d_gf[6*i+2].x = gf[i][0][2].re;
    h2d_gf[6*i+2].y = gf[i][0][2].im;      
   //second row
    h2d_gf[6*i+3].x = gf[i][1][0].re;
    h2d_gf[6*i+3].y = gf[i][1][0].im;
    h2d_gf[6*i+4].x = gf[i][1][1].re;
    h2d_gf[6*i+4].y = gf[i][1][1].im;
    h2d_gf[6*i+5].x = gf[i][1][2].re;
    h2d_gf[6*i+5].y = gf[i][1][2].im;      
  }
}



void su3to8(su3* gf, dev_su3_8* h2d_gf){
  int i;
  for (i=0;i<4*VOLUME;i++){
   // a2, a3
    h2d_gf[4*i].x   = gf[i][0][1].re;
    h2d_gf[4*i].y   = gf[i][0][1].im;
    h2d_gf[4*i+1].x = gf[i][0][2].re;
    h2d_gf[4*i+1].y = gf[i][0][2].im;
    
   // theta_a1, theta_c1
   // use atan2 for this: following the reference, atan2 should give an angle -pi < phi < +pi  
   h2d_gf[4*i+2].x = ( atan2(gf[i][0][0].im, gf[i][0][0].re ));
   h2d_gf[4*i+2].y = ( atan2(gf[i][2][0].im, gf[i][2][0].re ));
     
   // b1
    h2d_gf[4*i+3].x = gf[i][1][0].re ;
    h2d_gf[4*i+3].y = gf[i][1][0].im ;
     
 }
}



void su3to8_trafo(su3* gf, dev_su3_8* h2d_gf){
  int i;
  for (i=0;i<VOLUME;i++){
   // a2, a3
    h2d_gf[4*i].x =  gf[i][0][1].re;
    h2d_gf[4*i].y =  gf[i][0][1].im;
    h2d_gf[4*i+1].x =  gf[i][0][2].re;
    h2d_gf[4*i+1].y =  gf[i][0][2].im;
    
   // theta_a1, theta_c1
   // use atan2 for this: following the reference, atan2 should give an angle -pi < phi < +pi  
   h2d_gf[4*i+2].x = ( atan2( gf[i][0][0].im, gf[i][0][0].re ));
   h2d_gf[4*i+2].y =  ( atan2( gf[i][2][0].im,gf[i][2][0].re ));
     
   // b1
    h2d_gf[4*i+3].x =  gf[i][1][0].re ;
    h2d_gf[4*i+3].y =  gf[i][1][0].im ;
     
 }
}




void su3to2v_trafo(su3* gf, dev_su3_2v* h2d_gf){
  int i;
  for (i=0;i<VOLUME;i++){
   //first row
    h2d_gf[6*i].x   = gf[i][0][0].re;
    h2d_gf[6*i].y   = gf[i][0][0].im;
    h2d_gf[6*i+1].x = gf[i][0][1].re;
    h2d_gf[6*i+1].y = gf[i][0][1].im;
    h2d_gf[6*i+2].x = gf[i][0][2].re;
    h2d_gf[6*i+2].y = gf[i][0][2].im;      
   //second row
    h2d_gf[6*i+3].x =  gf[i][1][0].re;
    h2d_gf[6*i+3].y =  gf[i][1][0].im;
    h2d_gf[6*i+4].x =  gf[i][1][1].re;
    h2d_gf[6*i+4].y =  gf[i][1][1].im;
    h2d_gf[6*i+5].x =  gf[i][1][2].re;
    h2d_gf[6*i+5].y =  gf[i][1][2].im;      
  }
}



void from2vtosu3_trafo(su3* g, dev_su3_2v* h2d){
  int i;
  complex a0, a1, a2, b0, b1, b2, help1, help2;
  
  for (i=0;i<VOLUME;i++){
   //first row
    g[i][0][0].re = h2d[6*i].x;
    g[i][0][0].im = h2d[6*i].y; 
    g[i][0][1].re = h2d[6*i+1].x;
    g[i][0][1].im = h2d[6*i+1].y;
    g[i][0][2].re = h2d[6*i+2].x;
    g[i][0][2].im = h2d[6*i+2].y;
    

   //second row
    g[i][1][0].re = h2d[6*i+3].x;
    g[i][1][0].im = h2d[6*i+3].y;
    g[i][1][1].re = h2d[6*i+4].x;
    g[i][1][1].im = h2d[6*i+4].y;
    g[i][1][2].re = h2d[6*i+5].x;
    g[i][1][2].im = h2d[6*i+5].y;


   a0.re = h2d[6*i].x;
   a0.im = h2d[6*i].y;
   a1.re = h2d[6*i+1].x;
   a1.im = h2d[6*i+1].y; 
   a2.re = h2d[6*i+2].x;
   a2.im = h2d[6*i+2].y; 
 
   b0.re = h2d[6*i+3].x;
   b0.im = h2d[6*i+3].y;
   b1.re = h2d[6*i+4].x;
   b1.im = h2d[6*i+4].y; 
   b2.re = h2d[6*i+5].x;
   b2.im = h2d[6*i+5].y;  
 
 
  // c = (a X b)*
  help1 = cmult(a1,b2);
  help2 = cmult(a2,b1);
  help1 = cconj(csub(help1,help2));
  g[i][2][0] = help1;

  
  help1 = cmult(a2,b0);
  help2 = cmult(a0,b2);
  help1 = cconj(csub(help1,help2));
  g[i][2][1] = help1;
  
  help1 = cmult(a0,b1);
  help2 = cmult(a1,b0);
  help1 = cconj(csub(help1,help2));
  g[i][2][2] = help1;

  }
}







void from8tosu3_trafo(su3* g, dev_su3_2v* h2d){
  int i;
  double one_over_N, help; 
  complex p1,p2;
  double2 gfin, gfin2;
  
  for (i=0;i<VOLUME;i++){
  

   gfin = h2d[4*i];

  // read a2 a3
  g[i][0][1].re = gfin.x;
  g[i][0][1].im = gfin.y;
  

    gfin2 = h2d[4*i+1];
  
  g[i][0][2].re = gfin2.x;
  g[i][0][2].im = gfin2.y;  
 
  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y; // use later on
  one_over_N = rsqrt(p1.re); //reciprocal sqrt


    gfin = h2d[4*i+2]; 
    gfin2 = h2d[4*i+3];

  
  // reconstruct a1 use sqrt instead of sin
  p1.re = sqrt(1.0 - p1.re);

  
 // sincos(gfin.x, &g[i][0][0].im, &g[i][0][0].re);
  g[i][0][0].re = cos(gfin.x) * p1.re;
  g[i][0][0].im = sin(gfin.x) * p1.re;
  
  
  
  // assign b1
  g[i][1][0].re = gfin2.x;
  g[i][1][0].im = gfin2.y;
  
  // p2 = 1/N b1
  p2.re = one_over_N*g[i][1][0].re;
  p2.im = one_over_N*g[i][1][0].im;  


  // reconstruct c1 use sqrt instead of sin
  p1.re = sqrt(1.0 - 
              g[i][0][0].re * g[i][0][0].re - g[i][0][0].im * g[i][0][0].im - 
              g[i][1][0].re * g[i][1][0].re - g[i][1][0].im * g[i][1][0].im
          );
  
  //sincos(gfin.y, &g[i][2][0].im, &g[i][2][0].re);
  g[i][2][0].re = cos(gfin.y) * p1.re; 
  g[i][2][0].im = sin(gfin.y) * p1.re;
   
  
  
  // p1 = 1/N*cconj(c1)
  p1.re = one_over_N*g[i][2][0].re;
  p1.im = - one_over_N*g[i][2][0].im;
  
  
  
  //use the last reconstructed gf component gf[2][2] (c3) as a help variable for b2,b3 and c2
  //this is in order to save registers and to prevent extra loading and storing from global mem
  // calculate b2
  
  g[i][1][1].re = p1.re*g[i][0][2].re;
  g[i][1][1].re += p1.im*g[i][0][2].im;
  g[i][1][1].im = p1.im*g[i][0][2].re;
  g[i][1][1].im -= p1.re*g[i][0][2].im;
  
  g[i][2][2].re = g[i][0][0].re * g[i][0][1].re;
  g[i][2][2].re += g[i][0][0].im * g[i][0][1].im;
  
  g[i][2][2].im = g[i][0][0].re * g[i][0][1].im;
  g[i][2][2].im -= g[i][0][0].im * g[i][0][1].re;
  g[i][2][2] = cmult(p2, g[i][2][2]);
  
  g[i][1][1].re = -one_over_N*( g[i][1][1].re + g[i][2][2].re);
  g[i][1][1].im = -one_over_N*(g[i][1][1].im + g[i][2][2].im);
  
  
  
  
  
  // calculate b3
  g[i][1][2].re = p1.re*g[i][0][1].re;
  g[i][1][2].re += p1.im*g[i][0][1].im;
  g[i][1][2].im = p1.im*g[i][0][1].re;
  g[i][1][2].im -= p1.re*g[i][0][1].im;
  
  g[i][2][2].re = g[i][0][0].re*g[i][0][2].re;
  g[i][2][2].re += g[i][0][0].im*g[i][0][2].im;
  g[i][2][2].im = g[i][0][0].re*g[i][0][2].im;
  g[i][2][2].im -= g[i][0][0].im*g[i][0][2].re;
  g[i][2][2] = cmult(p2,g[i][2][2]);
  
  g[i][1][2].re = one_over_N*( g[i][1][2].re - g[i][2][2].re);
  g[i][1][2].im = one_over_N*( g[i][1][2].im - g[i][2][2].im);
  
  
  // calculate c2
  g[i][2][1].re = p2.re*g[i][0][2].re;
  g[i][2][1].re -= p2.im*g[i][0][2].im;
  g[i][2][1].im = -p2.re*g[i][0][2].im;
  g[i][2][1].im -= p2.im*g[i][0][2].re;
  
  

  g[i][2][2].re = g[i][0][0].re*g[i][0][1].re;
  g[i][2][2].re += g[i][0][0].im*g[i][0][1].im;
  g[i][2][2].im = g[i][0][0].re* g[i][0][1].im;
  g[i][2][2].im -= g[i][0][0].im* g[i][0][1].re;
  help = g[i][2][2].re;
  g[i][2][2].re = p1.re*g[i][2][2].re;
  g[i][2][2].re += p1.im*g[i][2][2].im;
  g[i][2][2].im = p1.re*g[i][2][2].im - p1.im*help;
  
  
  g[i][2][1].re = one_over_N*(g[i][2][1].re - g[i][2][2].re);
  g[i][2][1].im = one_over_N*(g[i][2][1].im - g[i][2][2].im);
  
  // now we have to use p2 and p1 as a help variable, as this is not 
  // needed any more after the first
  // step
  // calculate c3
  g[i][2][2].re = p2.re * g[i][0][1].re;
  g[i][2][2].re -= p2.im * g[i][0][1].im;
  g[i][2][2].im = - p2.im*g[i][0][1].re;
  g[i][2][2].im -= p2.re*g[i][0][1].im;
  
  p2.re = g[i][0][0].re * g[i][0][2].re;
  p2.re += g[i][0][0].im * g[i][0][2].im;
  p2.im = g[i][0][0].re * g[i][0][2].im;
  p2.im -= g[i][0][0].im * g[i][0][2].re;
  p2 = cmult(  cconj(p1) , p2);
  
  g[i][2][2] = cadd(g[i][2][2], p2);
  g[i][2][2] = crealmult(g[i][2][2], -one_over_N);
       

 }
}




void unit_init_trafo(su3 * trafofield){
  int i,a,b;
  for(i=0;i<VOLUME; i++){
    for(a=0; a<3; a++){
      for(b=0; b<3; b++){
        trafofield[i][a][b].re = 0.0;
        trafofield[i][a][b].im = 0.0;
      }
    }
  }
  for(i=0;i<VOLUME; i++){
    trafofield[i][0][0].re = 1.0;
    trafofield[i][1][1].re = 1.0;
    trafofield[i][2][2].re = 1.0;
  }
}





void random_init_trafo(su3 * trafofield){
  int i,j;
  double help; 
  double norm = 0.0;
  double len;
  complex help1, help2;
  printf("Setting %d random gauge trafo fields\n",VOLUME);
  for(i=0;i<VOLUME; i++){
    // row vector 1
    help = Random();
    trafofield[i][0][0].re = help;
    norm=help*help;
    help = (1.0 - norm)* Random();
    trafofield[i][0][0].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    trafofield[i][0][1].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();    
    trafofield[i][0][1].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();   
    trafofield[i][0][2].re = help;
    norm+=help*help;
    trafofield[i][0][2].im = sqrt((1.0 - norm));   

    // row vector 2
    norm=0.0;
    help = Random();
    trafofield[i][1][0].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    trafofield[i][1][0].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    trafofield[i][1][1].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();    
    trafofield[i][1][1].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();   
    trafofield[i][1][2].re = help;
    norm+=help*help;
    trafofield[i][1][2].im = sqrt((1.0 - norm));   


  //projection first (a) onto second row (b)
  complex proj = initcomplex(0.0,0.0);
  for(j=0; j<3; j++){
    proj = cadd( proj , cmult(  trafofield[i][1][j] ,  cconj( trafofield[i][0][j])   ));
  }

  //orthogonalize -> new b
  for(j=0; j<3; j++){
    trafofield[i][1][j] = csub( trafofield[i][1][j] , cmult(proj, trafofield[i][0][j]  )  );
  }



  // get length b
  len =   trafofield[i][1][0].re*trafofield[i][1][0].re 
        + trafofield[i][1][0].im*trafofield[i][1][0].im 
        + trafofield[i][1][1].re*trafofield[i][1][1].re
        + trafofield[i][1][1].im*trafofield[i][1][1].im 
        + trafofield[i][1][2].re*trafofield[i][1][2].re 
        + trafofield[i][1][2].im*trafofield[i][1][2].im;
  
  len =  1.0/sqrt(len); 
  // normalize b
  for(j=0; j<3; j++){
    trafofield[i][1][j].re = trafofield[i][1][j].re*len;
    trafofield[i][1][j].im = trafofield[i][1][j].im*len;
  }





  //third row from cconj(cross product of first and second row)
  help1 = cmult(trafofield[i][0][1],trafofield[i][1][2]);
  help2 = cmult(trafofield[i][0][2],trafofield[i][1][1]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  trafofield[i][2][0].re = help1.re;
  trafofield[i][2][0].im = help1.im;
  
  help1 = cmult(trafofield[i][0][2],trafofield[i][1][0]);
  help2 = cmult(trafofield[i][0][0],trafofield[i][1][2]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  trafofield[i][2][1].re = help1.re;
  trafofield[i][2][1].im = help1.im;
  
  help1 = cmult(trafofield[i][0][0],trafofield[i][1][1]);
  help2 = cmult(trafofield[i][0][1],trafofield[i][1][0]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  trafofield[i][2][2].re = help1.re;
  trafofield[i][2][2].im = help1.im;
 
  }
  
}





void unit_init_gauge(su3 * gaugefield){
  int i,a,b;
  for(i=0;i<4*VOLUME; i++){
    for(a=0; a<3; a++){
      for(b=0; b<3; b++){
        gaugefield[i][a][b].re = 0.0;
        gaugefield[i][a][b].im = 0.0;
      }
    }
  }
  for(i=0;i<4*VOLUME; i++){
    gaugefield[i][0][0].re = 1.0;
    gaugefield[i][1][1].re = 1.0;
    gaugefield[i][2][2].re = 1.0;
  }
}


void random_init_gauge(su3 * gaugefield){
  int i,j;
  double help; 
  double norm = 0.0;
  double len;
  complex help1, help2;
  printf("Setting %d random gauge fields\n",VOLUME);
  for(i=0;i<4*VOLUME; i++){
    // row vector 1
    help = Random();
    gaugefield[i][0][0].re = help;
    norm=help*help;
    help = (1.0 - norm)* Random();
    gaugefield[i][0][0].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    gaugefield[i][0][1].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();    
    gaugefield[i][0][1].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();   
    gaugefield[i][0][2].re = help;
    norm+=help*help;
    gaugefield[i][0][2].im = sqrt((1.0 - norm));   

    // row vector 2
    norm=0.0;
    help = Random();
    gaugefield[i][1][0].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    gaugefield[i][1][0].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    gaugefield[i][1][1].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();    
    gaugefield[i][1][1].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();   
    gaugefield[i][1][2].re = help;
    norm+=help*help;
    gaugefield[i][1][2].im = sqrt((1.0 - norm));   


  //projection first (a) onto second row (b)
  complex proj = initcomplex(0.0,0.0);
  for(j=0; j<3; j++){
    proj = cadd( proj , cmult(  gaugefield[i][1][j] ,  cconj( gaugefield[i][0][j])   ));
  }

  //orthogonalize -> new b
  for(j=0; j<3; j++){
    gaugefield[i][1][j] = csub( gaugefield[i][1][j] , cmult(proj, gaugefield[i][0][j]  )  );
  }



  // get length b
  len =   gaugefield[i][1][0].re*gaugefield[i][1][0].re 
        + gaugefield[i][1][0].im*gaugefield[i][1][0].im 
        + gaugefield[i][1][1].re*gaugefield[i][1][1].re
        + gaugefield[i][1][1].im*gaugefield[i][1][1].im 
        + gaugefield[i][1][2].re*gaugefield[i][1][2].re 
        + gaugefield[i][1][2].im*gaugefield[i][1][2].im;
  
  len =  1.0/sqrt(len); 
  // normalize b
  for(j=0; j<3; j++){
    gaugefield[i][1][j].re = gaugefield[i][1][j].re*len;
    gaugefield[i][1][j].im = gaugefield[i][1][j].im*len;
  }





  //third row from cconj(cross product of first and second row)
  help1 = cmult(gaugefield[i][0][1],gaugefield[i][1][2]);
  help2 = cmult(gaugefield[i][0][2],gaugefield[i][1][1]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  gaugefield[i][2][0].re = help1.re;
  gaugefield[i][2][0].im = help1.im;
  
  help1 = cmult(gaugefield[i][0][2],gaugefield[i][1][0]);
  help2 = cmult(gaugefield[i][0][0],gaugefield[i][1][2]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  gaugefield[i][2][1].re = help1.re;
  gaugefield[i][2][1].im = help1.im;
  
  help1 = cmult(gaugefield[i][0][0],gaugefield[i][1][1]);
  help2 = cmult(gaugefield[i][0][1],gaugefield[i][1][0]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  gaugefield[i][2][2].re = help1.re;
  gaugefield[i][2][2].im = help1.im;
 
  }
  
}








void random_init_su3(su3 * M){
  int j;
  double len;
  double help; 
  double norm = 0.0;
  complex help1, help2;


    // row vector 1
    help = Random();
    (*M)[0][0].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    (*M)[0][0].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    (*M)[0][1].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();    
    (*M)[0][1].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();   
    (*M)[0][2].re = help;
    norm+=help*help;
    (*M)[0][2].im = sqrt((1.0 - norm));   
    //if(i==0)printf("norm = %f\n", norm);

    // row vector 2
    norm=0.0;
    help = Random();
    (*M)[1][0].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    (*M)[1][0].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();
    (*M)[1][1].re = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();    
    (*M)[1][1].im = help;
    norm+=help*help;
    help = (1.0 - norm)* Random();   
    (*M)[1][2].re = help;
    norm+=help*help;
    (*M)[1][2].im = sqrt((1.0 - norm));   


  //projection first (a) onto second row (b)
  complex proj = initcomplex(0.0,0.0);
  for(j=0; j<3; j++){
    proj = cadd( proj , cmult(  (*M)[1][j] ,  cconj( (*M)[0][j])   ));
  }

  //orthogonalize -> new b
  for(j=0; j<3; j++){
    (*M)[1][j] = csub( (*M)[1][j] , cmult(proj, (*M)[0][j]  )  );
  }



  // get length b
  len =   (*M)[1][0].re*(*M)[1][0].re 
        + (*M)[1][0].im*(*M)[1][0].im 
        + (*M)[1][1].re*(*M)[1][1].re
        + (*M)[1][1].im*(*M)[1][1].im 
        + (*M)[1][2].re*(*M)[1][2].re 
        + (*M)[1][2].im*(*M)[1][2].im;
  
  len =  1.0/sqrt(len); 
  // normalize b
  for(j=0; j<3; j++){
    (*M)[1][j].re = (*M)[1][j].re*len;
    (*M)[1][j].im = (*M)[1][j].im*len;
  }





  //third row from cconj(cross product of first and second row)
  help1 = cmult((*M)[0][1],(*M)[1][2]);
  help2 = cmult((*M)[0][2],(*M)[1][1]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  (*M)[2][0].re = help1.re;
  (*M)[2][0].im = help1.im;
  
  help1 = cmult((*M)[0][2],(*M)[1][0]);
  help2 = cmult((*M)[0][0],(*M)[1][2]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  (*M)[2][1].re = help1.re;
  (*M)[2][1].im = help1.im;
  
  help1 = cmult((*M)[0][0],(*M)[1][1]);
  help2 = cmult((*M)[0][1],(*M)[1][0]);
  help1 = csub(help1,help2);
  help1.im = -help1.im;
  (*M)[2][2].re = help1.re;
  (*M)[2][2].im = help1.im;
 
 
}


















