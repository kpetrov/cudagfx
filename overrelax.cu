





// init the gpu inner solver, assign constants etc.
__global__ void dev_gfix_init (int* grid){
  dev_LX = grid[0];
  dev_LY = grid[1];
  dev_LZ = grid[2];
  dev_T = grid[3];
  dev_VOLUME = grid[4]; // grid[4] is initialized 1/2 VOLUME for eo
}


// init the gpu inner solver, assign constants etc.
__global__ void dev_check_geom (int* grid){
  grid[0] = dev_LX;
  grid[1] = dev_LY;
  grid[2] = dev_LZ;
  grid[3] = dev_T;
  grid[4] = dev_VOLUME;
}




// calculates the mean plaquette of the gauge field
// uses 2d parallelization:
// N_grid = T, N_block = LZ
// CPU has to do last summation over T
// BLOCKPLAQ MUST be larger than LZ !!! -> define correctly in cudaglobal.h
__global__ void dev_mean_plaq(double* reductionfield_plaq, int * dev_nn, dev_su3_2v * gf){
  double mplaq = 0.0;
  int x0pos, x1pos, x2pos ; /* x0pos = basepoint of plaquette, x1pos = x0pos + e_mu, x2pos = x0pos + e_nu */
  int iz,x,y,z,t,mu,nu;
  dev_su3 su3matrix,su3matrix2, M1,M2,M3,M4;
  dev_complex chelp;
  


  
  __shared__ double output[BLOCKPLAQ];
  t = blockIdx.x;
  z = threadIdx.x;
  

      for(y=0; y<dev_LY; y++){
        for(x=0; x<dev_LX; x++){
          for(nu=0;nu <3; nu++){
            for(mu =nu+1; mu < 4; mu++){
              x0pos = x + dev_LX*(y + dev_LY*(z + dev_LZ*t));
              x1pos = dev_nn[8*x0pos + mu];
              x2pos = dev_nn[8*x0pos + nu];          

/* U_nu(x) */
            #ifdef GF_8
              dev_reconstructgf_8texref(gf, (4*x0pos+mu),&M1);
            #else
              dev_reconstructgf_2vtexref(gf, (4*x0pos+mu),&M1);
            #endif
/* U_mu(x+e_mu) */
            #ifdef GF_8
              dev_reconstructgf_8texref(gf, (4*x1pos+nu),&M2);
            #else
              dev_reconstructgf_2vtexref(gf, (4*x1pos+nu),&M2);
            #endif

/* Udagger_nu(x+e_nu) */
            #ifdef GF_8
              dev_reconstructgf_8texref_dagger(gf, (4*x2pos+mu),&M3);
            #else
              dev_reconstructgf_2vtexref_dagger(gf, (4*x2pos+mu),&M3);
            #endif
/* Udagger_mu(x)*/
            #ifdef GF_8
              dev_reconstructgf_8texref_dagger(gf, (4*x0pos+nu),&M4);
            #else
              dev_reconstructgf_2vtexref_dagger(gf, (4*x0pos+nu),&M4);
            #endif
  
              /* multiply these and store in su3matrix*/
              dev_su3_ti_su3(&su3matrix, &M3,&M4);
              dev_su3_ti_su3(&su3matrix2, &M2,&su3matrix);
              dev_su3_ti_su3(&su3matrix, &M1,&su3matrix2);

              chelp = dev_su3trace(&su3matrix);
              mplaq += chelp.re/3.0; /* Realteile von Tr UUUU aufsummieren*/
            }
          }
           
        }
      } 
    output[z] = mplaq;

  __syncthreads();
  
  if(threadIdx.x == 0){
    
    /* normieren */
    double accum = 0.0;
    for(iz=0; iz < dev_LZ; iz++){
      accum += output[iz];  
    }
    accum = accum*(1.0/(6.0*dev_VOLUME));
    reductionfield_plaq[t] = accum;
  }
  __syncthreads();
  
}



double calc_plaquette(dev_su3_2v * U, int outputyn){
   double erg=0.0;
   int j;
   
   #ifdef USETEXTURE
    bind_texture_gf(U);
   #endif
   dev_mean_plaq <<< T , LZ >>> (dev_redfield_plaq, dev_nn, U) ;
   #ifdef USETEXTURE
   unbind_texture_gf();
   #endif   
   

   
   cudaMemcpy(redfield_plaq, dev_redfield_plaq, (size_t)(T*sizeof(double)), cudaMemcpyDeviceToHost);


   for(j=0; j<T; j++){
     erg+=redfield_plaq[j];
     //printf("%e\n", redfield_plaq[j]);
   }
   if(outputyn==1) printf("PLAQ = %.16f\n",erg);
   return(erg);
}






// Returns g = R^w * g  where R^w = SUM_{i=0..N} C(w,i)*{R}^i
// and R = gn * g^+ - 1 . Here C(w,i) = GAMMA(w+1)/ GAMMA(w+1-i)i!
// where GAMMA(n) is the gamma function 

__device__ void overrelax ( dev_su3 * g, dev_su3 * gn, double w, int N){

  int i;
  dev_su3 one, R, a, Rw, help;
  
  dev_unitsu3(&(one));
  
  dev_su3_ti_su3d (&(R), gn, g ); 
  dev_su3_sub(&(R), &(one)); // R=gn*g^+ - 1

  dev_su3_assign(&(Rw), &(one));
  dev_su3_assign(&(a), &(one));
  
  for(i=1; i<N; i++){
    // a = a*R
    dev_su3_ti_su3(&(help), &(a), &(R));
    dev_su3_assign(&(a), &(help));
    
    dev_su3_real_mult(&(a),  (1.0 + w - i)/i );
    dev_su3_add(&(Rw), &(a));
    
  }
  dev_su3_normalize(&(Rw));
  
  // g= Rw*g
  dev_su3_ti_su3(&(help), &(Rw), g);
  dev_su3_assign(g, &(help));
  
}






/* this is the SU(2) relax routine 
   the SU(2) matrices are double2s that represent the matrices: 
   u = double2.a.x * ID + double2.a.y * sigma1 + double2.b.x * sigma2 + double2.b.y * sigma3
*/
__device__ void relax_su2(dev_su2 * out, dev_su2 * in){
  double det = (*in).a.x*(*in).a.x + (*in).a.y*(*in).a.y + (*in).b.x*(*in).b.x + (*in).b.y*(*in).b.y;
  det = rsqrt(det); // 1/sqrt(det)
  
  
  (*out).a.x = (*in).a.x*det;  
  (*out).a.y = (*in).a.y*det;
  (*out).b.x = (*in).b.x*det;
  (*out).b.y = (*in).b.y*det;
 
}




__device__ void cabibbo_marinari_relax(dev_su3 * g, dev_su3 * star){

// this routine does an relaxation update of an SU(3) matrix g


  int a,b,c;
  dev_su3 X;
  dev_su2 w, alpha;
  dev_complex dummy, dummy2, dummy3;

  
    for(a=0; a<2; a++){
      for(b=a+1; b<3; b++){
      
      dev_su3_ti_su3(&(X), g, star);
      
  
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
  
    
      relax_su2(&(alpha), &(w));  
       
        
 
        
        
        
        
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



__global__ void dev_apply_trafo(dev_su3_2v * gf_new, dev_su3_2v * gf, dev_su3_2v * trafo, int* dev_nn){
int pos,hoppos,mu;
    // trafo and gauge fields read and reconstructed --> shared mem
    
    
     __shared__ dev_su3 gfsmem[BLOCK];
     __shared__ dev_su3 trafosmem[BLOCK];
     dev_su3  help;
    

  pos = threadIdx.x + blockDim.x*blockIdx.x;  
  int ix = threadIdx.x;
  if(pos < dev_VOLUME){
  

    for(mu=0;mu<4;mu++){
      
      hoppos = dev_nn[8*pos+mu];
      //gauge_field  U_mu(x)
      #ifdef GF_8
        dev_reconstructgf_8texref(gf, (4*pos+mu),&(gfsmem[ix]));
      #else
        dev_reconstructgf_2vtexref(gf, (4*pos+mu),&(gfsmem[ix]));
      #endif
      
      
      
      //trafo_field  g^+(x+mu)
      #ifdef GF_8
        dev_reconstructtrafo_8texref_dagger(trafo, hoppos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));
      #endif
      
      
      dev_su3_ti_su3(&(help), &(gfsmem[ix]),  &(trafosmem[ix]) );
      
      
      //trafo_field  g(x)
      #ifdef GF_8
        dev_reconstructtrafo_8texref(trafo, pos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref(trafo, pos,&(trafosmem[ix]));
      #endif

      
      dev_su3_ti_su3(&(gfsmem[ix]), &(trafosmem[ix]), &(help) );
      
      
      
      #ifdef GF_8
       dev_storegf_8((4*pos+mu), gf_new ,&(gfsmem[ix]) );
      #else
          dev_storegf_2v((4*pos+mu), gf_new ,&(gfsmem[ix]) );
      #endif       
       
    }
  }
}



__global__ void dev_overrelax_step(dev_su3_2v * trafo_new, dev_su3_2v * gf, dev_su3_2v * trafo, int * dev_indeo_thissite, int * dev_indeo_nextside, int * dev_nn){
    int eofieldpos, pos,hoppos,mu;
    // trafo and gauge fields read and reconstructed --> shared mem
    
    
     __shared__ dev_su3 gfsmem[BLOCK];
     __shared__ dev_su3 trafosmem[BLOCK];
    
    dev_su3 help, star;
    
  eofieldpos = threadIdx.x + blockDim.x*blockIdx.x;  
  int ix = threadIdx.x;
  if(eofieldpos < dev_VOLUME/2){
  
  pos = dev_indeo_thissite[eofieldpos];
  dev_su3zero( &(star) );
  
  // calculate the STAR
    //#pragma unroll 4
    for(mu=0;mu<4;mu++){
 //positive dir
      hoppos = dev_nn[8*pos+mu];
      //gauge_field  U_mu(x)
      #ifdef GF_8
        dev_reconstructgf_8texref(gf, (4*pos+mu),&(gfsmem[ix]));
      #else
        dev_reconstructgf_2vtexref(gf, (4*pos+mu),&(gfsmem[ix]));
      #endif
      //trafo_field  g^+(x+mu)
      #ifdef GF_8
        dev_reconstructtrafo_8texref_dagger(trafo, hoppos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));
      #endif
      
      
      //dev_su3_ti_su3( &(gt), &(gfsmem[ix]), &(trafosmem[ix]) );    
      //dev_su3_add( &(star), &(gt));
      dev_add_su3_ti_su3(&(star) , &(gfsmem[ix]), &(trafosmem[ix]) );
      
  //negative dir
      hoppos = dev_nn[8*pos+4+mu];
      //gauge_field  U_mu(x-mu)^+
      #ifdef GF_8
       dev_reconstructgf_8texref_dagger(gf, 4*hoppos+mu,&(gfsmem[ix]));
      #else
       dev_reconstructgf_2vtexref_dagger(gf, 4*hoppos+mu,&(gfsmem[ix]));
      #endif
      
      //trafo_field  g^+(x-mu)
      #ifdef GF_8
        dev_reconstructtrafo_8texref_dagger(trafo, hoppos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));
      #endif 
      //dev_su3_ti_su3( &(gt), &(gfsmem[ix]), &(trafosmem[ix]) );
      //dev_su3_add( &(star), &(gt));
      dev_add_su3_ti_su3( &(star), &(gfsmem[ix]), &(trafosmem[ix]) );
  
  }

    //load g(x)
      #ifdef GF_8
        dev_reconstructtrafo_8texref(trafo, pos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref(trafo, pos,&(trafosmem[ix]));
      #endif
    
    
   /*
   dev_su3dagger(&(help),&(star));
   dev_su3copy( &(star),  &(help) ); 
   */
   
   dev_su3copy( &(help) , &(trafosmem[ix]) );
   
   cabibbo_marinari_relax( &(help),  &(star) );
   // now the old trafo field is in trafosmem the new field in help 
   dev_su3_normalize(&(help)); 
   

   overrelax(&(trafosmem[ix]), &(help), 1.68, 3);    
   dev_su3_normalize( &(trafosmem[ix]) ); 
   
   #ifdef GF_8
     dev_storetrafo_8(pos, trafo_new ,&(trafosmem[ix]) );
   #else
     dev_storetrafo_2v(pos, trafo_new ,&(trafosmem[ix]) );
   #endif 


   
   #ifdef USETEXTURE
     // copy the trafofields of the sites that are not updated to destination field
     // e.g. if EVEN is updated just copy ODD trafos
     pos = dev_indeo_nextside[eofieldpos];
     //load g(x)
     #ifdef GF_8
        dev_reconstructtrafo_8texref(trafo, pos,&(trafosmem[ix]));
     #else
        dev_reconstructtrafo_2vtexref(trafo, pos,&(trafosmem[ix]));
     #endif
     // and store it
     #ifdef GF_8
       dev_storetrafo_8(pos, trafo_new ,&(trafosmem[ix]) );
     #else
       dev_storetrafo_2v(pos, trafo_new ,&(trafosmem[ix]) );
     #endif    
   #endif
   
  }//pos < dev_VOLUME
}




__device__ void dev_vectorpotential(dev_su3* U){
 
 dev_su3 temp;
 dev_complex i_half = dev_initcomplex(0.0, 0.5);
 dev_complex trace;
 
 dev_su3dagger(&(temp), U);
 dev_su3_sub( &(temp), U);  // U+ - U
 dev_su3skalarmult(U, i_half, &(temp)); // U -> - i/2 * (U - U^+)
 
 // get traceless part
 
 //trace
 trace = dev_su3trace(U);
 // trace/3
 trace.re = trace.re/3.0;
 trace.im = trace.im/3.0;
 // subtract from diagonal
 (*U)[0][0] = dev_csub((*U)[0][0], trace);
 (*U)[1][1] = dev_csub((*U)[1][1], trace);
 (*U)[2][2] = dev_csub((*U)[2][2], trace);
 
}






// calculates F = \sum_{mu,x} g(x) u_mu(x) g^+(x+mu)
// i.e. the functional for Landau gauge
__global__ void dev_functional(dev_su3_2v * gf, dev_su3_2v * trafo, int * dev_nn, double * reduction_field_F, double * reduction_field_dAdA, double * reduction_field_maxdAdA){
  
  int pos, mu, hoppos, i;

  __shared__ dev_su3 gfsmem[BLOCK];
  __shared__ dev_su3 trafosmem[BLOCK];
  __shared__ double Flocal[BLOCK];
  __shared__ double dAdAlocal[BLOCK];
  
  dev_su3 gather, help, fw, bw;
  
  pos= threadIdx.x + blockDim.x*blockIdx.x;  
  
  int ix = threadIdx.x;
  
  
  if(pos < dev_VOLUME){

   dev_su3zero(&(gather));

    Flocal[ix] = 0.0;
    dAdAlocal[ix] = 0.0;
    //#pragma unroll 4
    for(mu=0;mu<4;mu++){

//FORWARD      
      hoppos = dev_nn[8*pos+mu];
      
      //gauge_field x
      #ifdef GF_8
        dev_reconstructgf_8texref(gf, (4*pos+mu),&(gfsmem[ix]));
      #else
        dev_reconstructgf_2vtexref(gf, (4*pos+mu),&(gfsmem[ix]));
      #endif
      
      
      //trafo field x
      #ifdef GF_8
        dev_reconstructtrafo_8texref(trafo, pos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref(trafo, pos,&(trafosmem[ix]));
      #endif         
      
      // help = g(x) * u(x) 
      dev_su3_ti_su3(&(help), &(trafosmem[ix]), &(gfsmem[ix]) );
      
      //g^+(x+mu)
      #ifdef GF_8
        dev_reconstructtrafo_8texref_dagger(trafo, hoppos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));
      #endif    
     
     // g u g+
      dev_su3_ti_su3(&(fw), &(help), &(trafosmem[ix]));
      Flocal[ix] += dev_su3Retrace(&(fw));


// BACKWARD
    hoppos = dev_nn[8*pos+4+mu];
      
      //gauge_field u(x-mu)
      #ifdef GF_8
        dev_reconstructgf_8texref(gf, (4*hoppos+mu),&(gfsmem[ix]));
      #else
        dev_reconstructgf_2vtexref(gf, (4*hoppos+mu),&(gfsmem[ix]));
      #endif
      
      
      //trafo field g(x-mu)
      #ifdef GF_8
        dev_reconstructtrafo_8texref(trafo, hoppos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref(trafo, hoppos,&(trafosmem[ix]));
      #endif         
      
      // help = g(x-mu) * u(x-mu) 
      dev_su3_ti_su3(&(help), &(trafosmem[ix]) , &(gfsmem[ix]));
      
      //g^+(x)
      #ifdef GF_8
        dev_reconstructtrafo_8texref_dagger(trafo, pos,&(trafosmem[ix]));
      #else
        dev_reconstructtrafo_2vtexref_dagger(trafo, pos,&(trafosmem[ix]));
      #endif    
   
   // g u g
   // backward term into bw
   dev_su3_ti_su3( &(bw), &(help), &(trafosmem[ix]) );
   
   dev_vectorpotential(&(fw));
   dev_vectorpotential(&(bw));
   dev_su3_sub(&(bw), &(fw)); // backward - forward
   
   
 // add up all backward - forward terms in gatherb  
  dev_su3_add(&(gather), &(bw));
 
   }//mu
  
  // sum_mu (dA) -> gather 
   // help = gather^+
   dev_su3_ti_su3d( &(help),&(gather), &(gather));  
   dAdAlocal[ix] += dev_su3Retrace( &(help)  ); 

  }// pos < dev_VOLUME
  
  
  __syncthreads();
  if(ix==0){
    reduction_field_F[blockIdx.x] = 0.0;
    reduction_field_dAdA[blockIdx.x] = 0.0;
    double actualmax = 0.0;
    for(i=0; i<blockDim.x; i++){
      reduction_field_F[blockIdx.x] += Flocal[i];
      reduction_field_dAdA[blockIdx.x] += dAdAlocal[i];
      if(dAdAlocal[i] > actualmax){
        actualmax = dAdAlocal[i];
      }
    }
    reduction_field_maxdAdA[blockIdx.x] = actualmax;
  }
  __syncthreads();
}




double calc_functional(dev_su3_2v * gf, dev_su3_2v * trafo){
  int i,gridsize;
  double F = 0.0;
  double dada = 0.0;
  double maxdada = 0.0;
  if(VOLUME%BLOCK != 0){
   printf("Error: VOLUME is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(BLOCK,1,1);
  if( VOLUME >= BLOCK){
   gridsize =VOLUME/BLOCK;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1); 
  
  
  int redfieldsize = VOLUME/BLOCK; 
   
   #ifdef USETEXTURE
     bind_texture_trafo(trafo);
   #endif
     dev_functional<<< griddim, blockdim >>> (gf, trafo, dev_nn, dev_redfield_F, dev_redfield_dAdA, dev_redfield_maxdAdA);
   #ifdef USETEXTURE
     unbind_texture_trafo();
   #endif
   
   
   CUDA_SAFE_CALL(cudaMemcpy(redfield_F, dev_redfield_F, (size_t)(redfieldsize*sizeof(double)), cudaMemcpyDeviceToHost));
   CUDA_SAFE_CALL(cudaMemcpy(redfield_dAdA, dev_redfield_dAdA, (size_t)(redfieldsize*sizeof(double)), cudaMemcpyDeviceToHost));
   CUDA_SAFE_CALL(cudaMemcpy(redfield_maxdAdA, dev_redfield_maxdAdA, (size_t)(redfieldsize*sizeof(double)), cudaMemcpyDeviceToHost));   
   
   for(i=0;i<redfieldsize;i++){
     // sum up F and dAdA
     F += redfield_F[i];
     dada += redfield_dAdA[i];
     // find maxdAdA
     if(redfield_maxdAdA[i] > maxdada){
       maxdada = redfield_maxdAdA[i];
     }
     
     /*
     if(i<redfieldsize){ 
      printf("%d  %f\n", i, redfield_F[i]);
     }
     */
   }
   
   F=F/(4.0*VOLUME);
   dada=dada/(VOLUME);
   
   // set global values  ///////
   FUNC=F;
   DADA=dada;
   maxDADA=maxdada;
   //////////////////////////
  

   return(maxdada);
}




// perform overrelaxation gauge fixing
int overrelax_gauge(int maxit, double eps, int checkinterval){ 

  int gridsize;
  double maxdada = 0.0;
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

  
  
// Start timer
  assert((start = clock())!=-1);  
  
 #ifdef USETEXTURE
   bind_texture_gf(dev_gf);
 #endif


  for(i=0; i<maxit; i++){


   // overrelax update
   #ifdef USETEXTURE
    // update of EVEN  
     bind_texture_trafo(dev_trafo1);
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo2, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn); 
     unbind_texture_trafo();

   // update of ODD
     bind_texture_trafo(dev_trafo2);
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo2, dev_eoidx_odd, dev_eoidx_even, dev_nn);
     unbind_texture_trafo();
   
    #else  //USETEXTURE

    // update of EVEN  
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn); 

   // update of ODD
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_odd, dev_eoidx_even, dev_nn);  
    #endif  //USETEXTURE
    
    
// test 64 bit error
 
//  int grid[5];
//  dev_check_geom<<< 1, 1 >>> (dev_grid);
//  /*
//  if((cudaerr=cudaGetLastError()) != cudaSuccess){
//       printf("%s\n", cudaGetErrorString(cudaerr));
//       exit(200);
//     }
//   */ 
//  size_t dev_size = (size_t)  (5 * sizeof(int));
//  printf("size=%d\n", dev_size);
//  cudaMemcpy(&(grid[0]), dev_grid, dev_size, cudaMemcpyDeviceToHost);
//  printf("LX=%d, LY=%d, LZ=%d, T=%d, VOL=%d\n", grid[0], grid[1], grid[2], grid[3], grid[4]);
//  
//  
//  #ifdef GF_8
//    size_t dev_gfsize = 4*VOLUME * sizeof(dev_su3_8);
//    cudaMemcpy(h2d_trafo, dev_trafo1, dev_gfsize, cudaMemcpyDeviceToHost);
//    from8tosu3_trafo(trafo1, h2d_trafo);
//    show_su3(&(trafo1[10])); 
//   #else
//     size_t dev_gfsize = 6*VOLUME * sizeof(dev_su3_2v);
//     cudaMemcpy(h2d_trafo, dev_trafo1, dev_gfsize, cudaMemcpyDeviceToHost);
//     from2vtosu3_trafo(trafo1, h2d_trafo);
//     show_su3(&(trafo1[10]));
//   #endif

// test 64 bit error    
/*    
    
    
   if((cudaerr=cudaGetLastError()) != cudaSuccess){
      printf("%s\n", cudaGetErrorString(cudaerr));
      exit(200);
    }*/




    if((i%checkinterval) == 0){    
      #ifdef USETEXTURE
        bind_texture_trafo(dev_trafo1);
      #endif
   //recalculate dAdA
      maxdada = calc_functional(dev_gf, dev_trafo1);   
      
      printf("iter %6d:\t FUNC = %.16e \t dAdA = %.16e\t max(dAdA) = %.16e\n",i, FUNC, DADA, maxdada);
      #ifdef USETEXTURE
       unbind_texture_trafo();
      #endif
      
      //double plaq = calc_plaquette(dev_gf,0);
      //printf("PLAQ = %.16e\n",plaq);
    }
    
    
    
    
    if(maxdada < eps){
      printf("CONVERGENCE!\nFinal values: F = %.16e dAdA = %.16e, maxdAdA = %.16e\n", FUNC, DADA, maxDADA);
     assert((stop = clock())!=-1);
     timeelapsed = (double) (stop-start)/CLOCKS_PER_SEC;
     printf("Overrelaxation finished after %f sec\n", timeelapsed);      
     #ifdef USETEXTURE
       unbind_texture_gf();
     #endif 
     return(i);
    }

  }//i
 
  #ifdef USETEXTURE
    unbind_texture_gf();
  #endif 

  assert((stop = clock())!=-1);
  timeelapsed = (double) (stop-start)/CLOCKS_PER_SEC;
  printf("Overrelaxation finished after %f sec\n", timeelapsed);

  
  if(maxdada > eps){
      printf("FAIL! Gauge condition not reached!\nFinal values: F = %.16e dAdA = %.16e, maxdAdA = %.16e\n", FUNC, DADA, maxDADA);
      return(-1);
    }
   else{
     return(i);
   }
}

  
  
  
  
  
void benchmark(){
  
  double timeelapsed = 0.0;
  clock_t start, stop;
  int i;
  int gridsize;


  if((VOLUME/2)%BLOCK != 0){
   printf("Error: VOLUME/2 is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(BLOCK,1,1);
  if( (VOLUME/2) >= BLOCK){
   gridsize =VOLUME/BLOCK;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1); 




  assert((start = clock())!=-1);
  #ifdef USETEXTURE
     bind_texture_gf(dev_gf);
  #endif
  
  printf("Doing small benchmark...");
  
for(i=0; i<100; i++){
   // overrelax update
   #ifdef USETEXTURE
    // update of EVEN  
     bind_texture_trafo(dev_trafo1);
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo2, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn); 
     unbind_texture_trafo();

   // update of ODD
     bind_texture_trafo(dev_trafo2);
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo2, dev_eoidx_odd, dev_eoidx_even, dev_nn);
     unbind_texture_trafo();
   
    #else  //USETEXTURE

    // update of EVEN  
     cudaFuncSetCacheConfig(dev_overrelax_step, cudaFuncCachePreferShared);
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn); 

   // update of ODD
     cudaFuncSetCacheConfig(dev_overrelax_step, cudaFuncCachePreferShared);
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_odd, dev_eoidx_even, dev_nn);  
    #endif  //USETEXTURE
    
}

  #ifdef USETEXTURE
    unbind_texture_gf();
  #endif 

  printf("Done\n"); 
  
  assert((stop = clock())!=-1);
  timeelapsed = (double) (stop-start)/CLOCKS_PER_SEC;
  
 // x2 because 2x overrelaxstep per iteration
  double benchres = 4766.0*2*(VOLUME/2)* 100 / timeelapsed / 1.0e9;
  printf("Benchmark: %f Gflops\n", benchres); 
   
  #ifdef USETEXTURE
    unbind_texture_gf();
  #endif
}

  
  
  
void calc_star(){
   
  int gridsize;
  double F = 0.0;

  
  if((VOLUME/2)%BLOCK != 0){
   printf("Error: VOLUME/2 is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(BLOCK,1,1);
  if( (VOLUME/2) >= BLOCK){
   gridsize =VOLUME/BLOCK;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1); 
  //printf("Setting up GPU configuration: threads/block = %d\t blocks = %d\n", BLOCK, gridsize);
   
   
    
    
   #ifdef USETEXTURE
     bind_texture_gf(dev_gf);
   #endif
   
 /*
   size_t dev_gfsize = 6*VOLUME*sizeof(dev_su3_2v);
   cudaMemcpy(h2d_trafo, dev_trafo1, dev_gfsize, cudaMemcpyDeviceToHost);

    
   for(i=0; i<10; i++){
    show_su3_2v(&(h2d_trafo[6*i]));
   }
   printf("\n\n"); 
  */
 
  
   //calculate initial F
   F = calc_functional(dev_gf,dev_trafo1);
   
   //calculate star
   
   #ifdef USETEXTURE
     bind_texture_trafo(dev_trafo1);
   #endif
      // update of EVEN 
      dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn); 
   #ifdef USETEXTURE
     unbind_texture_trafo();
   #endif
   

   
  //recalculate F
   F = calc_functional(dev_gf, dev_trafo1);
   
   #ifdef USETEXTURE
     bind_texture_trafo(dev_trafo2);
   #endif
      // update of ODD
      dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_odd, dev_eoidx_even, dev_nn);
   #ifdef USETEXTURE
     unbind_texture_trafo();
   #endif
   
//printf("%s\n", cudaGetErrorString(cudaGetLastError())); 


   
  #ifdef USETEXTURE
    unbind_texture_gf();
  #endif 
  
}



