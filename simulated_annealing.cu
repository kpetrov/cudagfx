



__device__ int dev_get_a0(double *a0, double kb, float* rndgauss_field, float* rndunif_field, int ind){

  float a,b,y,help;
  
  a = abs(rndgauss_field[ind]);  //  need gaussian dist
  b = -log(1.0f - rndunif_field[4*ind]);   // we need 4 unif randoms per site , use the 0th here

  
  
  y = a*a + b;
  y = y/kb;
  
  help =  rndunif_field[4*ind+1];  // we need 4 unif randoms per site , use the 1st here
  
  if((2.0f * (help*help)) <= (2.0f -y)){
    (*a0) = (double)(1.0f - y);
    return(1);
  }
  else{
   (*a0) = 0.0;
   return(0);
  }
}





__device__ void dev_heatbath_su2(dev_su2* alpha, dev_su2* w, double beta, float* rndgauss_field, float* rndunif_field, int ind){
  
  dev_su2 v, a;
  double k, rdet, cos_theta, sin_theta, phi, norm;
  int ret;
  
  k =  (*w).a.x*(*w).a.x + (*w).a.y*(*w).a.y + (*w).b.x*(*w).b.x + (*w).b.y*(*w).b.y ;
  rdet = rsqrt(k);
  
  v.a.x = (*w).a.x*rdet;
  v.a.y = (*w).a.y*rdet;
  v.b.x = (*w).b.x*rdet;
  v.b.y = (*w).b.y*rdet;
  
  
  ret = dev_get_a0(&(a.a.x), k*beta, rndgauss_field, rndunif_field, ind);
  
    norm = sqrt(1.0 - a.a.x*a.a.x);
    cos_theta = 2.0 * rndunif_field[4*ind+2] - 1.0;  // we need 4 unif randoms per site , use the 2nd here 
    sin_theta = sqrt( 1.0 - cos_theta*cos_theta );
    phi = 6.2831853071795862 * (double) rndunif_field[4*ind+3]; // we need 4 unif randoms per site , use the 3rd here
  
    sincos(phi, &(a.b.x), &(a.a.y));
    
    a.a.y = norm * sin_theta * a.a.y;
    a.b.x = norm * sin_theta * a.b.x; 
    a.b.y = norm * cos_theta;
    
   if(ret == 1){  
   // a0 was accepted in the first place in dev_get_a0 
     dev_su2_ti_su2(alpha,&a,&v);
   }
   else{
   // a0 was not accepted  in the first place -> no update -> put alpha = w  
     (*alpha).a.x = (*w).a.x;
     (*alpha).a.y = (*w).a.y;
     (*alpha).b.x = (*w).b.x;
     (*alpha).b.y = (*w).b.y;
   }
  
}







__device__ void cabibbo_marinari_heatbath(dev_su3 * g, dev_su3 * star, double beta, float* rndgauss_field, float* rndunif_field, int ind){

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
  
    
      dev_heatbath_su2(&(alpha), &(w), beta, rndgauss_field, rndunif_field,  ind);  
       
        
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







// do a trafo heatbath update of either the even or the odd sites depending on the dev_indeo_thissite and dev_indeo_nextside
// index fields

__global__ void dev_heatbath_sweep(dev_su3_2v * trafo_new, dev_su3_2v * gf, dev_su3_2v * trafo, int * dev_indeo_thissite, int * dev_indeo_nextside, int * dev_nn, float* rndgauss_field, float* rndunif_field){

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
    
    
   dev_su3copy( &(help) , &(trafosmem[ix]) );  
   cabibbo_marinari_heatbath( &(help),  &(star) , sa_beta, rndgauss_field, rndunif_field, eofieldpos); //also append the position of g, for the rng!
   								 //the global sa_beta is used for beta
   								 
   // now the old trafo field is in trafosmem the new field in help 
   dev_su3_normalize(&(help)); 
   
   #ifdef GF_8
     dev_storetrafo_8(pos, trafo_new ,&(help) );
   #else
     dev_storetrafo_2v(pos, trafo_new ,&(help) );
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

  }
}







void set_sa_temperature(int i){

    // Returns the temperature for a given i using a function 
    // proposed by Peter Schemel.
    double a, temperature, beta;
    
    //printf("Setting new SA temp: %d\n",i);
    if(saparam.Tmax == saparam.Tmin){
      temperature = saparam.Tmax;
    }   
    else{
       if(saparam.expo == 0){
          a = (double)(i) / (double) (saparam.N-1);
          temperature = pow( ( (double) saparam.Tmin/ (double) saparam.Tmax) , a) * (double) saparam.Tmax ;
       }
       else if(saparam.expo == -1){
          a = (double)(saparam.Tmin - saparam.Tmax) / (double) (saparam.N-1);    
          temperature = (a*i + saparam.Tmax);
       }
       else{
          a = pow(saparam.Tmin, -saparam.expo)- pow(saparam.Tmax, -saparam.expo);
          a = a / (double) (saparam.N-1);
          temperature = pow( (a*i + pow(saparam.Tmax,-saparam.expo))  , (-1.0/saparam.expo) );
       }
    }
   
   
   beta = 1.0/temperature; // -> beta = 1.0/(3 T)   , 3 for NCOL!!
   
   //printf("new SA temp = %f\n", temperature); 
   //printf("Tmin = %f, Tmax = %f, N = %d, expo = %f\n", saparam.Tmin, saparam.Tmax, saparam.N, saparam.expo);
   
   //set this beta on device
   CUDA_SAFE_CALL( cudaMemcpyToSymbol("sa_beta", &beta, sizeof(double)) ) ;
}








// perform simulated annealing gauge fixing
void simannealing_gauge(){ 

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


 for(i=0; i<saparam.N; i++){
   //set the temperature
   set_sa_temperature(i);
   cudaThreadSynchronize();
   cudaerr = cudaGetLastError();
   if(cudaerr != cudaSuccess){
     printf("%s\n", cudaGetErrorString(cudaerr)); 
   } 
   // heatbath update
   
   //printf("Doing heatbath sweep...\n");
   cudaGetLastError();
  #ifdef USETEXTURE
    // update of EVEN  
     bind_texture_trafo(dev_trafo1);
     dev_heatbath_sweep<<< griddim, blockdim >>> (dev_trafo2, dev_gf, dev_trafo1, 
                                                dev_eoidx_even, dev_eoidx_odd, 
                                                dev_nn, dev_rndgauss_field,
                                                 dev_rndunif_field); 
     unbind_texture_trafo();
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
     bind_texture_trafo(dev_trafo2);
           dev_heatbath_sweep<<< griddim, blockdim >>> (dev_trafo1, dev_gf,
                                                     dev_trafo2, dev_eoidx_odd,
                                                      dev_eoidx_even, dev_nn ,
                                                      dev_rndgauss_field, dev_rndunif_field);
     unbind_texture_trafo();
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
          
  #else  //USETEXTURE

    // update of EVEN  
       dev_heatbath_sweep<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, 
                                                  dev_eoidx_even, dev_eoidx_odd,
                                                   dev_nn, dev_rndgauss_field,
                                                    dev_rndunif_field); 
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
         dev_heatbath_sweep<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, 
                                                       dev_eoidx_odd, dev_eoidx_even,
                                                      dev_nn, dev_rndgauss_field, 
                                                      dev_rndunif_field);  
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
  #endif  //USETEXTURE
    
    
    

    if((i%saparam.checkint) == 0){    
      //printf("recalculating functional...\n");
   //recalculate dAdA
    #ifdef USETEXTURE
       bind_texture_trafo(dev_trafo1);
    #endif
      cudaGetLastError();
      maxdada = calc_functional(dev_gf, dev_trafo1);   
      cudaerr = cudaGetLastError();
      if(cudaerr != cudaSuccess){
        printf("%s\n", cudaGetErrorString(cudaerr)); 
      }
    #ifdef USETEXTURE
      unbind_texture_trafo();
    #endif      
      
      printf("iter %6d:\t FUNC = %.16e \t dAdA = %.16e\t max(dAdA) = %.16e\n",i, FUNC, DADA, maxdada);
    }
   

  }//i
 
  #ifdef USETEXTURE
    unbind_texture_gf();
  #endif 

  assert((stop = clock())!=-1);
  timeelapsed = (double) (stop-start)/CLOCKS_PER_SEC;
  printf("SA finished after %f sec\n", timeelapsed);

}























