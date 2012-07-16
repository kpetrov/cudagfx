





//generates a psuedo-random double between 0.0 and 0.999...
double randdouble()
{
    return rand()/(double(RAND_MAX)+1);
}

//generates a psuedo-random double between 0.0 and max
double randdouble(double max)
{
    return randdouble()*max;
}

