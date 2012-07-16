CUDA_HOME= /phn/cuda01a/cuda
CUDACC = $(CUDA_HOME)/bin/nvcc
CC = gcc
LEX=flex
#limedir = ~/codepackages/c-lime/build/lib
limedir = /mnt/data/kpetrov/QUDA/lib
headers =  global.h 
objects =   complex.o gauge_io.o spinor_io.o rngs.o cksum.o su3manip.o observables.o cudagaugefix.o read_input.o 
flags = -gencode=arch=compute_20,code=sm_20 -ftz=false -prec-div=false -prec-sqrt=false
        #-arch=sm_20 -ftz=false -prec-div=false -prec-sqrt=false
        #-arch=sm_13
        #
        #-gencode=arch=compute_20,code=sm_20
        #-gencode=arch=compute_20,code=compute_20
includes = -I //mnt/data/kpetrov/QUDA/include
libs =  -lcuda -lcudart -lcublas -L $(limedir) -llime -lm

lime = $(limedir)lime_header.o $(limedir)lime_reader.o $(limedir)lime_utils.o $(limedir)lime_writer.o $(limedir)lime_fseeko.o
linkobjects =

COMPILE = ${CUDACC}   -c $(includes) -O3 -o $@ ${flags}
CUDACOMPILE = ${CUDACC}  -c   -O3  $(includes) -o $@ ${flags}
##--use_fast_math 

LINK = ${CUDACC} -o $@ $(libs) ${flags}


cudagaugefix: $(objects) 
	$(LINK) $(linkobjects) $(objects)
rngs.o: rngs.c
	$(COMPILE) $<	
cudagaugefix.o: cudagaugefix.cu overrelax.cu simulated_annealing.cu MersenneTwister.cu heatbath_thermalization.cu dev_su3.cu
	$(CUDACOMPILE) $<
gauge_io.o: gauge_io.c
	$(COMPILE) $<
cksum.o: cksum.c
	$(COMPILE) $<
complex.o: complex.c
	$(COMPILE) $<
spinor_io.o: spinor_io.c
	$(COMPILE) $<
su3manip.o: su3manip.c
	$(COMPILE) $<
observables.o: observables.c
	$(COMPILE) $<
read_input.o: read_input.c
	$(COMPILE) $<
read_input.c: read_input.l
	$(LEX) -o$@ $^
clean:
	rm *.o
