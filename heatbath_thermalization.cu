

#define MICRO_OVERRELAX_RESOLUTION 1.0e-9

/*


// calculates the staples and stores them in a staples field
//                pos + nu
//  x-------<--------x-------->-------x
//  |                |                |
//  |                |                |
//  |                |                |   
//  v                ^                v
//  |                |                |
//  |                |                |
//  |                |                | 
//  x------->--------x--------<-------x
//                  pos             pos + mu
//
//                  
//                   nu
//                    ^
//                    |
//                     ---> mu 
//
__global__ void dev_get_staples(dev_su3_2v * gf, dev_su3_2v * staples,  int * dev_indeo_thissite, int * dev_indeo_nextside, int * dev_nn){


    int eofieldpos, pos, hoppos, mu, nu;
    // trafo and gauge fields read and reconstructed --> shared mem
    
    
     __shared__ dev_su3 help1[BLOCK];
     __shared__ dev_su3 help2[BLOCK];
     dev_su3 help3, staple;
   
    
  eofieldpos = threadIdx.x + blockDim.x*blockIdx.x;  
  int ix = threadIdx.x;
  if(eofieldpos < dev_VOLUME/2){

    pos = dev_indeo_thissite[eofieldpos];

    for(mu=0; mu<4; mu++){
      for(nu=0; nu<4; nu++){
        if(mu!=nu){
       
      //staple in forward nu 
          //link in nu dir at (pos + mu)
          hoppos = dev_nn[8*pos + mu];
          #ifdef GF_8
           dev_reconstructgf_8texref(gf, (4*hoppos+nu),&(help1[ix]));
          #else
           dev_reconstructgf_2vtexref(gf, (4*hoppos+nu),&(help1[ix]));
          #endif
          
          //link^+ in mu dir at (pos + nu)
          hoppos = dev_nn[8*pos + nu];
          #ifdef GF_8
            dev_reconstructtrafo_8texref_dagger(gf, (4*hoppos+mu),&(help2[ix]));
          #else
            dev_reconstructtrafo_2vtexref_dagger(gf, (4*hoppos+mu),&(help2[ix]));
          #endif
          
          dev_su3_ti_su3(&(help3), &(help1[ix]), &(help2[ix]));

          //link^+ in nu dir at (pos)
          #ifdef GF_8
            dev_reconstructtrafo_8texref_dagger(gf, (4*pos+nu),&(help1[ix]));
          #else
            dev_reconstructtrafo_2vtexref_dagger(gf, (4*pos+nu),&(help1[ix]));
          #endif
          
          dev_su3_ti_su3(&(staple), &(help3), &(help1[ix]));
      
     //staple in backward nu dir
          //link^+ in nu dir at (pos + mu - nu)
          hoppos = dev_nn[8*pos + mu];
          hoppos = dev_nn[8*hoppos + 4 + nu];
          #ifdef GF_8
           dev_reconstructgf_8texref_dagger(gf, (4*hoppos+nu),&(help1[ix]));
          #else
           dev_reconstructgf_2vtexref_dagger(gf, (4*hoppos+nu),&(help1[ix]));
          #endif
          
          //link^+ in mu dir at (pos - nu)
          hoppos = dev_nn[8*pos + 4 + nu];
          #ifdef GF_8
            dev_reconstructtrafo_8texref_dagger(gf, (4*hoppos+mu),&(help2[ix]));
          #else
            dev_reconstructtrafo_2vtexref_dagger(gf, (4*hoppos+mu),&(help2[ix]));
          #endif
          
          dev_su3_ti_su3(&(help3), &(help1[ix]), &(help2[ix]));

          //link in nu dir at (pos - nu)
          hoppos = dev_nn[8*pos + 4 + nu];
          #ifdef GF_8
            dev_reconstructtrafo_8texref(gf, (4*pos+nu),&(help1[ix]));
          #else
            dev_reconstructtrafo_2vtexref(gf, (4*pos+nu),&(help1[ix]));
          #endif
          
          dev_add_su3_ti_su3(&(staple), &(help3), &(help1[ix]));
       
        }//if(mu!=nu)
      }//nu
      
      //now store the staple of the link in mu dir at pos in the staples field 
      //which has size VOLUME/2!!
     #ifdef GF_8
       dev_storegf_8((4*eofieldpos+mu), staples , &(staple) );
     #else
       dev_storegf_2v((4*eofieldpos+mu), staples , &(staple) );
     #endif  
 
    }//mu
  }
}






// do a thermalization gauge heatbath update of either the even or the odd sites depending on the dev_indeo_thissite and dev_indeo_nextside
// index fields

__global__ void dev_gauge_heatbath_sweep (dev_su3_2v * gf_new, dev_su3_2v * staples, dev_su3_2v * gf, int * dev_indeo_thissite, int * dev_indeo_nextside, int * dev_nn, float* rndgauss_field, float* rndunif_field){

    int eofieldpos, pos,mu;
    // trafo and gauge fields read and reconstructed --> shared mem
    
     __shared__ dev_su3 gfsmem[BLOCK];
     __shared__ dev_su3 staple[BLOCK];
     dev_su3 help;
    
  eofieldpos = threadIdx.x + blockDim.x*blockIdx.x;  
  int ix = threadIdx.x;
  if(eofieldpos < dev_VOLUME/2){
    pos = dev_indeo_thissite[eofieldpos];
    
    for(mu=0; mu<4; mu++){
      
      //load u_mu(x)
        #ifdef GF_8
          dev_reconstructgf_8texref(gf, (4*pos+mu),&(gfsmem[ix]));
        #else
          dev_reconstructgf_2vtexref(gf, (4*pos+mu),&(gfsmem[ix]));
        #endif

      //load staple of u_mu(x)
      #ifdef USETEXTURE //workaround for not having to implement yet another texture
        #define USETEXTURE_YES 
      #endif
      #undef USETEXTURE
        #ifdef GF_8
          dev_reconstructgf_8texref(staples, (4*eofieldpos+mu),&(staple[ix]));
        #else
          dev_reconstructgf_2vtexref(staples, (4*eofieldpos+mu),&(staple[ix]));
        #endif
      #ifdef USETEXTURE_YES
        #undef USETEXTURE_YES 
        #define USETEXTURE
      #endif

       dev_su3copy( &(help) , &(gfsmem[ix]) );  
       cabibbo_marinari_heatbath( &(help),  &(staple[ix]) , therm_beta, rndgauss_field, rndunif_field, eofieldpos); 
                    //also append the position of g, for the rng!
   		    //the global sa_beta is used for beta
   								 
     dev_su3_normalize(&(help)); 
   
     #ifdef GF_8
       dev_storegf_8(pos, gf_new ,&(help));
     #else
       dev_storegf_2v(pos, gf_new ,&(help));
     #endif 
   
   }
   
   #ifdef USETEXTURE
    for(mu=0; mu<4; mu++){
     // copy the trafofields of the sites that are not updated to destination field
     // e.g. if EVEN is updated just copy ODD trafos
     pos = dev_indeo_nextside[eofieldpos];
     //load g(x)
     #ifdef GF_8
        dev_reconstructgf_8texref(gf, (4*pos+mu) ,&(gfsmem[ix]));
     #else
        dev_reconstructgf_2vtexref(gf, (4*pos+mu) ,&(gfsmem[ix]));
     #endif
     // and store it
     #ifdef GF_8
       dev_storegf_8((4*pos+mu), gf_new ,&(gfsmem[ix]) );
     #else
       dev_storegf_2v((4*pos+mu), gf_new ,&(gfsmem[ix]) );
     #endif    
   }
   #endif
   
   
  }
}

*/








// calculates the staples and stores them in a staples field
//                pos + nu
//  x-------<--------x-------->-------x
//  |                |                |
//  |                |                |
//  |                |                |   
//  v                ^                v
//  |                |                |
//  |                |                |
//  |                |                | 
//  x------->--------x--------<-------x
//                  pos             pos + mu
//
//                  
//                   nu
//                    ^
//                    |
//                     ---> mu 
//
__device__ void dev_get_staple(dev_su3_2v * gf, dev_su3 * staple, int * dev_nn, int pos, int nu){


    int  hoppos, mu;
    // trafo and gauge fields read and reconstructed --> shared mem
    
     dev_su3 help1, help2, help3;
     
     dev_su3zero( staple );

      for(mu=0; mu<4; mu++){
        if(mu!=nu){
       
      //staple in forward nu 
          //link in mu dir at (pos + nu)
          hoppos = dev_nn[8*pos + nu];
          #ifdef GF_8
           dev_reconstructgf_8texref(gf, (4*hoppos+mu),&(help1));
          #else
           dev_reconstructgf_2vtexref(gf, (4*hoppos+mu),&(help1));
          #endif
          
          //link^+ in nu dir at (pos + mu)
          hoppos = dev_nn[8*pos + mu];
          #ifdef GF_8
            dev_reconstructtrafo_8texref_dagger(gf, (4*hoppos+nu),&(help2));
          #else
            dev_reconstructtrafo_2vtexref_dagger(gf, (4*hoppos+nu),&(help2));
          #endif
          
          dev_su3_ti_su3(&(help3), &(help1), &(help2));

          //link^+ in mu dir at (pos)
          #ifdef GF_8
            dev_reconstructtrafo_8texref_dagger(gf, (4*pos+mu),&(help1));
          #else
            dev_reconstructtrafo_2vtexref_dagger(gf, (4*pos+mu),&(help1));
          #endif
          
          dev_add_su3_ti_su3(staple, &(help3), &(help1));
      
     //staple in backward mu dir
          //link^+ in mu dir at (pos + nu - mu)
          hoppos = dev_nn[8*pos + nu];
          hoppos = dev_nn[8*hoppos + 4 + mu];
          #ifdef GF_8
           dev_reconstructgf_8texref_dagger(gf, (4*hoppos+mu),&(help1));
          #else
           dev_reconstructgf_2vtexref_dagger(gf, (4*hoppos+mu),&(help1));
          #endif
          
          //link^+ in nu dir at (pos - mu)
          hoppos = dev_nn[8*pos + 4 + mu];
          #ifdef GF_8
            dev_reconstructtrafo_8texref_dagger(gf, (4*hoppos+nu),&(help2));
          #else
            dev_reconstructtrafo_2vtexref_dagger(gf, (4*hoppos+nu),&(help2));
          #endif
          
          dev_su3_ti_su3(&(help3), &(help1), &(help2));

          //link in mu dir at (pos - mu)
          hoppos = dev_nn[8*pos + 4 + mu];
          #ifdef GF_8
            dev_reconstructtrafo_8texref(gf, (4*hoppos+mu),&(help1));
          #else
            dev_reconstructtrafo_2vtexref(gf, (4*hoppos+mu),&(help1));
          #endif
          
          dev_add_su3_ti_su3(staple, &(help3), &(help1));
       
        }//if(mu!=nu)
      }//nu 
}









__device__ void dev_microorx_su2(dev_su2 * out, dev_su2 * in){

  double Tr_WW = (*in).a.x*(*in).a.x + (*in).a.y*(*in).a.y + (*in).b.x*(*in).b.x +  (*in).b.y*(*in).b.y;
  double fac;
  
  if(abs(Tr_WW) < MICRO_OVERRELAX_RESOLUTION){
     (*out).a.x = 1.0;
     (*out).a.y = 0.0;
     (*out).b.x = 0.0;
     (*out).b.y = 0.0;
  }
  else{
    fac = 2.0*(*in).a.x/ Tr_WW;
    (*out).a.x = fac*(*in).a.x;
    (*out).a.y = fac*(*in).a.y;
    (*out).b.x = fac*(*in).b.x;
    (*out).b.y = fac*(*in).b.y;
    (*out).a.x = (*out).a.x - 1.0;
  }

}


__device__ void cabibbo_marinari_microorx(dev_su3 * g, dev_su3 * staple){
// this routine does an microoverrelaxation update of an SU(3) matrix g


  int a,b,c;
  dev_su3 X;
  dev_su2 w, alpha;
  dev_complex dummy, dummy2, dummy3;

  
    for(a=0; a<2; a++){
      for(b=a+1; b<3; b++){
      
      dev_su3_ti_su3(&(X), g, staple);
      
  
  w.a.x = X[a][a].re + X[b][b].re;
  w.b.y = -X[a][a].im + X[b][b].im;
  w.a.y = -X[a][b].im - X[b][a].im; 
  w.b.x = -X[a][b].re + X[b][a].re;
  
 
  
  /*
     my definitions: U = w0 ID + i ( w1 sigma1 + w2 sigma2 + w3 sigma3 )
     
               | 0  1 |           | 0  -i |            | 1  0 |
     sigma1 =  |      |  sigma2 = |       |   sigma3 = |      |
               | 1  0 |           | i   0 |            | 0 -1 |
  */
  
    
      dev_microorx_su2(&(alpha), &(w));  
       
        
      for(c=0; c<3; c++){
      
        
      //dummy  =  cmplx(alpha(0),alpha(3), kind=RKIND) * u(a,c)     &
      //             + cmplx(alpha(2),alpha(1), kind=RKIND) * u(b,c)

       dummy = dev_cmult(dev_initcomplex(alpha.a.x,alpha.b.y),(*g)[a][c]);
       dummy2 = dev_cmult(dev_initcomplex(alpha.b.x,alpha.a.y),(*g)[b][c]);
       dummy = dev_cadd(dummy, dummy2);
       
       //     u(b,c) =  cmplx(-alpha(2), alpha(1), kind=RKIND) * u(a,c)   &
       //             + cmplx( alpha(0),-alpha(3), kind=RKIND) * u(b,c)
       
       dummy2 = dev_cmult(dev_initcomplex(-alpha.b.x,alpha.a.y),(*g)[a][c]);
       dummy3 = dev_cmult(dev_initcomplex(alpha.a.x,-alpha.b.y),(*g)[b][c]); 
       (*g)[b][c] = dev_cadd(dummy2, dummy3);
       
       //     u(a,c) = dummy   
       
       (*g)[a][c] = dummy;
       
      } 
         
    }
  } 
}






// do a thermalization gauge microoverrelax update of either the even or the odd sites depending on the dev_indeo_thissite and dev_indeo_nextside
// index fields

__global__ void dev_gauge_microorx_sweep (dev_su3_2v * gf_new, dev_su3_2v * staples, dev_su3_2v * gf, int * dev_indeo_thissite, int * dev_indeo_nextside, int * dev_nn, float* rndgauss_field, float* rndunif_field, int nu){

    int eofieldpos, pos;
    // trafo and gauge fields read and reconstructed --> shared mem
    
     __shared__ dev_su3 gfsmem[BLOCK];
     __shared__ dev_su3 staple[BLOCK];
     dev_su3 help;
    
  eofieldpos = threadIdx.x + blockDim.x*blockIdx.x;  
  int ix = threadIdx.x;
  if(eofieldpos < dev_VOLUME/2){
    pos = dev_indeo_thissite[eofieldpos];
    
    //for(mu=0; mu<4; mu++){
      
      //load u_mu(x)
        #ifdef GF_8
          dev_reconstructgf_8texref(gf, (4*pos+nu),&(gfsmem[ix]));
        #else
          dev_reconstructgf_2vtexref(gf, (4*pos+nu),&(gfsmem[ix]));
        #endif

      //construct staple of u_mu(x)
      dev_get_staple(gf, &(staple[ix]), dev_nn, pos, nu);
      
      dev_su3copy( &(help) , &(gfsmem[ix]) );  
      cabibbo_marinari_microorx( &(help),  &(staple[ix]));
      
       //also append the position of g, for the rng!
       //the global sa_beta is used for beta
   								 
     dev_su3_normalize(&(help)); 
   
     #ifdef GF_8
       dev_storegf_8(pos, gf_new ,&(help));
     #else
       dev_storegf_2v(pos, gf_new ,&(help));
     #endif 
   
   //}
   
   #ifdef USETEXTURE
    //for(mu=0; mu<4; mu++){
     // copy the trafofields of the sites that are not updated to destination field
     // e.g. if EVEN is updated just copy ODD trafos
     pos = dev_indeo_nextside[eofieldpos];
     //load g(x)
     #ifdef GF_8
        dev_reconstructgf_8texref(gf, (4*pos+nu) ,&(gfsmem[ix]));
     #else
        dev_reconstructgf_2vtexref(gf, (4*pos+nu) ,&(gfsmem[ix]));
     #endif
     // and store it
     #ifdef GF_8
       dev_storegf_8((4*pos+nu), gf_new ,&(gfsmem[ix]) );
     #else
       dev_storegf_2v((4*pos+nu), gf_new ,&(gfsmem[ix]) );
     #endif    
   //}
   #endif
   
  }
}















// do a thermalization gauge heatbath update of either the even or the odd sites depending on the dev_indeo_thissite and dev_indeo_nextside
// index fields

__global__ void dev_gauge_heatbath_sweep (dev_su3_2v * gf_new, dev_su3_2v * staples, dev_su3_2v * gf, int * dev_indeo_thissite, int * dev_indeo_nextside, int * dev_nn, float* rndgauss_field, float* rndunif_field, int nu){

    int eofieldpos, pos;
    // trafo and gauge fields read and reconstructed --> shared mem
    
     __shared__ dev_su3 gfsmem[BLOCK];
     __shared__ dev_su3 staple[BLOCK];
     dev_su3 help;
    
  eofieldpos = threadIdx.x + blockDim.x*blockIdx.x;  
  int ix = threadIdx.x;
  if(eofieldpos < dev_VOLUME/2){
    pos = dev_indeo_thissite[eofieldpos];
     
      //load u_nu(x)
        #ifdef GF_8
          dev_reconstructgf_8texref(gf, (4*pos+nu),&(gfsmem[ix]));
        #else
          dev_reconstructgf_2vtexref(gf, (4*pos+nu),&(gfsmem[ix]));
        #endif

      //construct staple of u_nu(x)
      dev_get_staple(gf, &(staple[ix]), dev_nn, pos, nu);
      
      dev_su3copy( &(help) , &(gfsmem[ix]) );  
      cabibbo_marinari_heatbath( &(help),  &(staple[ix]) , therm_beta, rndgauss_field, rndunif_field, 4*eofieldpos+nu); 
                    //also append the position of g, for the rng!
   		    //the global sa_beta is used for beta
   								 
     dev_su3_normalize(&(help)); 
   
     #ifdef GF_8
       dev_storegf_8(pos, gf_new ,&(help));
     #else
       dev_storegf_2v(pos, gf_new ,&(help));
     #endif 
   
   
   #ifdef USETEXTURE
     // copy the trafofields of the sites that are not updated to destination field
     // e.g. if EVEN is updated just copy ODD trafos
     pos = dev_indeo_nextside[eofieldpos];
     //load g(x)
     #ifdef GF_8
        dev_reconstructgf_8texref(gf, pos ,&(gfsmem[ix]));
     #else
        dev_reconstructgf_2vtexref(gf, pos ,&(gfsmem[ix]));
     #endif
     // and store it
     #ifdef GF_8
       dev_storegf_8(pos, gf_new ,&(gfsmem[ix]) );
     #else
       dev_storegf_2v(pos, gf_new ,&(gfsmem[ix]) );
     #endif    
   #endif
   
  }
}






void set_beta(double b){
   double beta;
   beta = b/3.0; // -> beta = b/3 for NCOL!!  
   //set this beta on device
   CUDA_SAFE_CALL( cudaMemcpyToSymbol("therm_beta", &beta, sizeof(double)) ) ;
}




// perform thermalization (simulation) of gauge field
void thermalize_gauge(){

  int gridsize, mu, imicro;
  double plaq;
  int i;
  clock_t start, stop; 
  double timeelapsed = 0.0;
  cudaError_t cudaerr;
  
  if((VOLUME/2)%BLOCK != 0){
   printf("Error: VOLUME/2 is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(BLOCK,1,1);
  if( (VOLUME/2) >= BLOCK){
   gridsize =VOLUME/2/BLOCK;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1); 
  
  printf("Kernel parameter: gridsize = %d, blocksize = %d, V = %d\n", gridsize, BLOCK, gridsize*BLOCK);
  
  
  FILE * plaqfile = fopen("plaq.txt", "w");
  if(!plaqfile){
    fprintf(stderr, "Could not open file 'plaq.txt'\n");
  }
  
// Start timer
  assert((start = clock())!=-1);  
   
 //set the beta
 printf("Setting beta to %f\n", thermparam.beta);
 set_beta(thermparam.beta);
 
 for(i=0; i<thermparam.Nsweep; i++){
   
   //printf("Doing microorx sweep...\n");
  cudaThreadSynchronize();
   cudaerr = cudaGetLastError();
   if(cudaerr != cudaSuccess){
     printf("%s\n", cudaGetErrorString(cudaerr)); 
   } 
   // microorx update
   

for(imicro=0; imicro<0; imicro++){  // ***************** MICRO_OVERRELAXATION
#ifdef USETEXTURE
  for(mu=0; mu<4; mu++){
   // update of EVEN  
      bind_texture_gf(dev_gf);
      /*
      dev_get_staples<<< griddim, blockdim >>>(dev_gf, dev_staples, 
                                       dev_eoidx_even, dev_eoidx_odd, dev_nn);
      */  
      dev_gauge_microorx_sweep<<< griddim, blockdim >>> (dev_gf2, dev_staples,
       			  dev_gf, dev_eoidx_even, dev_eoidx_odd, 
                          dev_nn, dev_rndgauss_field,dev_rndunif_field, mu); 
                                                
                                                 
      unbind_texture_gf();
      cudaThreadSynchronize();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }
  // update of ODD
      bind_texture_gf(dev_gf2);
      /*
      dev_get_staples<<< griddim, blockdim >>>(dev_gf2, dev_staples, 
                                       dev_eoidx_even, dev_eoidx_odd, dev_nn);
      */

      dev_gauge_microorx_sweep<<< griddim, blockdim >>> (dev_gf, dev_staples, dev_gf2, 
                                   dev_eoidx_odd, dev_eoidx_even, dev_nn,
                                   dev_rndgauss_field, dev_rndunif_field, mu);    
                                                                                                    
      unbind_texture_gf();
     
      cudaThreadSynchronize();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }   
  }//mu       
#else  //USETEXTURE
  for(mu=0; mu<4; mu++){
   // update of EVEN  
       /*
       dev_get_staples<<< griddim, blockdim >>>(dev_gf, dev_staples, 
                                       dev_eoidx_even, dev_eoidx_odd, dev_nn);
       */

       dev_gauge_microorx_sweep<<< griddim, blockdim >>> (dev_gf, dev_staples,
                                   dev_gf,  dev_eoidx_even, dev_eoidx_odd, 
                                   dev_nn, dev_rndgauss_field, dev_rndunif_field, mu);

      cudaThreadSynchronize();  
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }  
    
  // update of ODD
      /*
      dev_get_staples<<< griddim, blockdim >>>(dev_gf, dev_staples, 
                                       dev_eoidx_even, dev_eoidx_odd, dev_nn);
      */
      dev_gauge_microorx_sweep<<< griddim, blockdim >>> (dev_gf, dev_staples, dev_gf, 
                                 dev_eoidx_odd, dev_eoidx_even, dev_nn,
                                 dev_rndgauss_field, dev_rndunif_field, mu);
                                                
      cudaThreadSynchronize();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      } 
   }//mu
#endif  //USETEXTURE
    
}//imicro                          // ***************** MICRO_OVERRELAXATION



   
   cudaThreadSynchronize();
   cudaerr = cudaGetLastError();
   if(cudaerr != cudaSuccess){
     printf("%s\n", cudaGetErrorString(cudaerr)); 
   } 
                                   // ********************  HEATBATH
 
#ifdef USETEXTURE
  for(mu=0; mu<4; mu++){
   // update of EVEN  
      bind_texture_gf(dev_gf);
      /*
      dev_get_staples<<< griddim, blockdim >>>(dev_gf, dev_staples, 
                                       dev_eoidx_even, dev_eoidx_odd, dev_nn);
      */  
      dev_gauge_heatbath_sweep<<< griddim, blockdim >>> (dev_gf2, dev_staples,
       			  dev_gf, dev_eoidx_even, dev_eoidx_odd, 
                          dev_nn, dev_rndgauss_field,dev_rndunif_field, mu); 
                                                
                                                 
      unbind_texture_gf();
      cudaThreadSynchronize();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }
     
     
      // generate new random numbers
      //printf("Updating the random numbers...\n");
      cudaGetLastError();
      update_MT();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }     
     
  // update of ODD
      bind_texture_gf(dev_gf2);
      /*
      dev_get_staples<<< griddim, blockdim >>>(dev_gf2, dev_staples, 
                                       dev_eoidx_even, dev_eoidx_odd, dev_nn);
      */

      dev_gauge_heatbath_sweep<<< griddim, blockdim >>> (dev_gf, dev_staples, dev_gf2, 
                                   dev_eoidx_odd, dev_eoidx_even, dev_nn,
                                   dev_rndgauss_field, dev_rndunif_field, mu);    
                                                                                                    
      unbind_texture_gf();
     
      cudaThreadSynchronize();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }   

      // generate new random numbers
      //printf("Updating the random numbers...\n");
      cudaGetLastError();
      update_MT();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }   
  }//mu       
#else  //USETEXTURE
  for(mu=0; mu<4; mu++){
   // update of EVEN  
       /*
       dev_get_staples<<< griddim, blockdim >>>(dev_gf, dev_staples, 
                                       dev_eoidx_even, dev_eoidx_odd, dev_nn);
       */

       dev_gauge_heatbath_sweep<<< griddim, blockdim >>> (dev_gf, dev_staples,
                                   dev_gf,  dev_eoidx_even, dev_eoidx_odd, 
                                   dev_nn, dev_rndgauss_field, dev_rndunif_field, mu);

      cudaThreadSynchronize();  
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }


      // generate new random numbers
      //printf("Updating the random numbers...\n");
      cudaGetLastError();
      update_MT();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }    
    
  // update of ODD
      /*
      dev_get_staples<<< griddim, blockdim >>>(dev_gf, dev_staples, 
                                       dev_eoidx_even, dev_eoidx_odd, dev_nn);
      */
      dev_gauge_heatbath_sweep<<< griddim, blockdim >>> (dev_gf, dev_staples, dev_gf, 
                                 dev_eoidx_odd, dev_eoidx_even, dev_nn,
                                 dev_rndgauss_field, dev_rndunif_field, mu);
                                                
      cudaThreadSynchronize();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }

      // generate new random numbers
      //printf("Updating the random numbers...\n");
      cudaGetLastError();
      update_MT();
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }     
   }//mu
#endif  //USETEXTURE                     // ********************  HEATBATH
    

    if((i%thermparam.checkint) == 0){    

      cudaGetLastError();
      plaq = calc_plaquette(dev_gf,0);
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }
      
      //plaq = 6.0*(1.0-plaq);
      fprintf(plaqfile, "%d %.16e\n", i, plaq);
      printf("therm %6d:\t PLAQ = %.16e\n",i, plaq);
    }
   

  }//i
 
  #ifdef USETEXTURE
    unbind_texture_gf();
  #endif 
  
  
  assert((stop = clock())!=-1);
  timeelapsed = (double) (stop-start)/CLOCKS_PER_SEC;
  fclose(plaqfile);
  printf("Thermalization finished after %f sec\n", timeelapsed); 
}








