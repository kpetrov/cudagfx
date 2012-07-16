#include "cudaglobal.h"
#include "global.h"
#include "complex.h"
#ifdef USEOPENMP
 #include <omp.h>
#endif 
#include "su3manip.h"
#include "observables.h"


extern int LX,LY,LZ,T,VOLUME;
extern int *nn;




void g_trafo(su3* u, su3 * g){
  int x,y,z,t,mu;
  int xpos, gplusmupos,gpos;

  su3 h1,h2;
  
  #ifdef USEOPENMP
  #pragma omp parallel for private(z,x,y,mu, xpos, gplusmupos, gpos, h1,h2)
  #endif
  for(t=0; t<T; t++){
    for(z=0; z<LZ; z++){  
      for(y=0; y<LY; y++){
        for(x=0; x<LX; x++){  
          
          gpos = x+LX*(y+LY*(z+LZ*t));
          for(mu=0;mu<4;mu++){
             gplusmupos=nn[8*gpos+mu];
             xpos = 4*gpos + mu;
             su3mult(&h1,&(g[gpos]),&(u[xpos])); /* g(gpos) * u_mu(xpos) */
             su3dagger(&h2,&(g[gplusmupos]));    /* g(gplusmupos) daggern */
             su3mult(&(u[xpos]),&(h1),&(h2));
          }
        }
      }
    }
  }
  #ifdef USEOPENMP
  #pragma omp barrier
  #endif
return;
}





double gauge_functional(su3* gf){/* SUM (x,mu) Re Tr (U_mu(x)) /(4*VOLUME)*/
  double help = 0.0;
  int k;
  complex chelp;
  for(k=0;k<4*VOLUME;k++){
    chelp = su3trace(&(gf[k]));
    help += chelp.re;
  }
return( help / (4.0*(double)VOLUME));
}







double dAdA(su3 * gf){                 
 /* dAdA = SUM_{x} tr dAdA(x)/volume
 where dA(x) = SUM_{mu} [A_{mu}(x+mu) - A_{mu}(x)]*/
                            /*   M1             M2          */
  int x,y,z,t,mu;
  int xpos, xplusmupos,xminusmupos;

  su3 h1,h2,h3, h4,M1,M2;
  su3 dA;
  complex chelp;
  double dAdAsum = 0.0;
  double maxdAdA = 0.0;

  #ifdef USEOPENMP
  #pragma omp parallel for private(z,x,y,mu, xpos, \
  				xplusmupos, xminusmupos, dA, h1, h2, h3,h4, M1, M2, \
  				chelp)
  #endif
  for(t=0; t<T; t++){
    for(z=0; z<LZ; z++){  
      for(y=0; y<LY; y++){
        for(x=0; x<LX; x++){ 
          xpos = x+LX*(y+LY*(z+LZ*t));
          su3zero(&dA);  /* dA = 0 */ 
          for(mu=0;mu<4;mu++){
              xplusmupos = nn[8*xpos+mu];
              xminusmupos = nn[8*xpos+4+mu];
              

              su3copy( &h1, &gf[4*xminusmupos+mu]); /* h1 = U_mu(x-mu) */
              su3copy(&h2,&(gf[4*xpos+mu]));      /* h2 = U_mu(x)  */
              
              vectorpotential(&M1, &h1); /* M1 = A(x+mu) */
              vectorpotential(&M2, &h2); /*  M2 = A(x) */

              su3sub(&h3,&M1,&M2);              /*  A(x+mu) - A(x) */

              su3add(&dA,&h3, &dA);           /* sum over mu */

          }
          su3dagger(&h1,&dA);
          su3mult(&h4,&dA,&h1); /* dA dAdagger (x) */
          chelp = su3trace(&h4);
          #ifdef USEOPENMP
            #pragma omp critical
          #endif
          {
            dAdAsum += chelp.re; 
          }
          #ifdef USEOPENMP
            #pragma omp critical
          #endif
          {
            if(chelp.re > maxdAdA){
              maxdAdA = chelp.re;
            }
          }
          /*printf("%.9E ",dAdAtrace.re);*/
        }
      }
    }
  }
#ifdef USEOPENMP
   #pragma omp barrier
#endif  
  //printf("max(dAdA) calc = %.16e\n\n", maxdAdA);
  maxDADA = maxdAdA;
return(dAdAsum/(double)VOLUME);

/*return maxdAdA;*/
}



void vectorpotential(su3 *A, su3 * U){ /* returns standard vector pot.*/
                                /* gA(x) = 1/(2i) (U(x) - Udagger(x))_traceless*/
   int k;
   su3 h1, h2;   
   complex oneovertwoi = initcomplex(0.0,-0.5);      
   complex trace;   
   complex chelp;                 
   
   su3dagger(&h1,U);   /* Udagger */
   su3sub(&h2,U,&h1);   /* U - Udagger */

   su3skalarmult(A,oneovertwoi, &h2) ;

   trace = su3trace(A);  /* - 1/3 trace (U-Udagger) */
   trace.re = trace.re/3.0;
   trace.im = trace.im/3.0;
    
    for(k=0;k<3;k++){ 
      chelp = csub((*A)[k][k],trace);
      (*A)[k][k] = chelp;
    }
}





/* calculate mean plaquette

	we have: t,z,y,x 
	and:  mu 0=x, 1=y, 2=z, 3=t
 */
double mean_plaq(su3 * gf){
  double help;
  double mplaq;
  int x0pos, x1pos, x2pos ; /* x0pos = basepoint of plaquette, x1pos = x0pos + e_mu, x2pos = x0pos + e_nu */
  int x,y,z,t,mu,nu;
  su3 *su3h1, *su3h2;
  su3 su3matrix, su3matrix2, M1,M2,M3,M4;
  complex chelp;
  
  help = 0.0;
  mplaq = 0.0;
    
  #ifdef USEOPENMP
  #pragma omp parallel for private(z,x,y,mu,nu, su3h1, su3h2, su3matrix, \
  su3matrix2,M1, M2, M3, M4, chelp, x0pos, x1pos, x2pos, help)
  #endif
  for(t=0; t<T; t++){
    for(z=0; z<LZ; z++){  
      for(y=0; y<LY; y++){
        for(x=0; x<LX; x++){
          for(nu=0;nu <3; nu++){
            for(mu =nu+1; mu < 4; mu++){
              x0pos = x + LX*(y + LY*(z + LZ*t));
              x1pos = nn[8*x0pos+mu];
              x2pos = nn[8*x0pos+nu];
              
              su3h1 = &(gf[(4*x0pos)+mu]);  /* U_nu(x) */
              su3copy(&M1,su3h1);
              su3h2 = &(gf[(4*x1pos)+nu]);  /* U_mu(x+e_mu) */
              su3copy( &M2, su3h2);
              su3dagger(&M3,&(gf[(4*x2pos)+mu])); /* Udagger_nu(x+e_nu) */
              su3dagger(&M4,&(gf[(4*x0pos)+nu])); /* Udagger_mu(x)*/
              
              
              /*
              showsu3(su3mult(su3h1,su3dagger(su3h1)));
              chelp = su3trace(su3mult(su3h1,su3dagger(su3h1)));
              printf("%f\n",chelp.re);
              */
              
              /* multiply these and store in su3matrix*/
              su3mult(&su3matrix,&M3,&M4);
              su3mult(&su3matrix2, &M2,&su3matrix);
              su3mult(&su3matrix,&M1,&su3matrix2);
              
              
     
              chelp = su3trace(&su3matrix);
              /* printf("%f ", chelp.re); */
              #ifdef USEOPENMP
              #pragma omp critical
              #endif
              {
              mplaq += chelp.re/3.0; /* Realteile von Tr UUUU aufsummieren*/
              }
	      /*printf("%f ", mplaq);*/
            }
          }
           
        }
      }
    }
  }
  /* normieren */
  mplaq = mplaq*(1.0/(6.0*(double)VOLUME));
  return mplaq;
}


