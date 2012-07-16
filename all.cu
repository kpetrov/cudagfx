# 1 "cudagaugefix.cu"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "cudagaugefix.cu"






# 1 "/usr/include/time.h" 1 3 4
# 28 "/usr/include/time.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 313 "/usr/include/features.h" 3 4
# 1 "/usr/include/bits/predefs.h" 1 3 4
# 314 "/usr/include/features.h" 2 3 4
# 346 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 353 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 354 "/usr/include/sys/cdefs.h" 2 3 4
# 347 "/usr/include/features.h" 2 3 4
# 378 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4



# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 5 "/usr/include/gnu/stubs.h" 2 3 4




# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 2 3 4
# 379 "/usr/include/features.h" 2 3 4
# 29 "/usr/include/time.h" 2 3 4









# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stddef.h" 1 3 4
# 211 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 39 "/usr/include/time.h" 2 3 4



# 1 "/usr/include/bits/time.h" 1 3 4
# 43 "/usr/include/time.h" 2 3 4
# 56 "/usr/include/time.h" 3 4
# 1 "/usr/include/bits/types.h" 1 3 4
# 28 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;







typedef long int __quad_t;
typedef unsigned long int __u_quad_t;
# 131 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 132 "/usr/include/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;

typedef int __daddr_t;
typedef long int __swblk_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;

typedef long int __ssize_t;



typedef __off64_t __loff_t;
typedef __quad_t *__qaddr_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;
# 57 "/usr/include/time.h" 2 3 4



typedef __clock_t clock_t;



# 74 "/usr/include/time.h" 3 4


typedef __time_t time_t;



# 92 "/usr/include/time.h" 3 4
typedef __clockid_t clockid_t;
# 104 "/usr/include/time.h" 3 4
typedef __timer_t timer_t;
# 120 "/usr/include/time.h" 3 4
struct timespec
  {
    __time_t tv_sec;
    long int tv_nsec;
  };








struct tm
{
  int tm_sec;
  int tm_min;
  int tm_hour;
  int tm_mday;
  int tm_mon;
  int tm_year;
  int tm_wday;
  int tm_yday;
  int tm_isdst;


  long int tm_gmtoff;
  __const char *tm_zone;




};








struct itimerspec
  {
    struct timespec it_interval;
    struct timespec it_value;
  };


struct sigevent;





typedef __pid_t pid_t;








extern clock_t clock (void) __attribute__ ((__nothrow__));


extern time_t time (time_t *__timer) __attribute__ ((__nothrow__));


extern double difftime (time_t __time1, time_t __time0)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern time_t mktime (struct tm *__tp) __attribute__ ((__nothrow__));





extern size_t strftime (char *__restrict __s, size_t __maxsize,
   __const char *__restrict __format,
   __const struct tm *__restrict __tp) __attribute__ ((__nothrow__));

# 215 "/usr/include/time.h" 3 4
# 1 "/usr/include/xlocale.h" 1 3 4
# 28 "/usr/include/xlocale.h" 3 4
typedef struct __locale_struct
{

  struct locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
} *__locale_t;


typedef __locale_t locale_t;
# 216 "/usr/include/time.h" 2 3 4

extern size_t strftime_l (char *__restrict __s, size_t __maxsize,
     __const char *__restrict __format,
     __const struct tm *__restrict __tp,
     __locale_t __loc) __attribute__ ((__nothrow__));
# 230 "/usr/include/time.h" 3 4



extern struct tm *gmtime (__const time_t *__timer) __attribute__ ((__nothrow__));



extern struct tm *localtime (__const time_t *__timer) __attribute__ ((__nothrow__));





extern struct tm *gmtime_r (__const time_t *__restrict __timer,
       struct tm *__restrict __tp) __attribute__ ((__nothrow__));



extern struct tm *localtime_r (__const time_t *__restrict __timer,
          struct tm *__restrict __tp) __attribute__ ((__nothrow__));





extern char *asctime (__const struct tm *__tp) __attribute__ ((__nothrow__));


extern char *ctime (__const time_t *__timer) __attribute__ ((__nothrow__));







extern char *asctime_r (__const struct tm *__restrict __tp,
   char *__restrict __buf) __attribute__ ((__nothrow__));


extern char *ctime_r (__const time_t *__restrict __timer,
        char *__restrict __buf) __attribute__ ((__nothrow__));




extern char *__tzname[2];
extern int __daylight;
extern long int __timezone;




extern char *tzname[2];



extern void tzset (void) __attribute__ ((__nothrow__));



extern int daylight;
extern long int timezone;





extern int stime (__const time_t *__when) __attribute__ ((__nothrow__));
# 313 "/usr/include/time.h" 3 4
extern time_t timegm (struct tm *__tp) __attribute__ ((__nothrow__));


extern time_t timelocal (struct tm *__tp) __attribute__ ((__nothrow__));


extern int dysize (int __year) __attribute__ ((__nothrow__)) __attribute__ ((__const__));
# 328 "/usr/include/time.h" 3 4
extern int nanosleep (__const struct timespec *__requested_time,
        struct timespec *__remaining);



extern int clock_getres (clockid_t __clock_id, struct timespec *__res) __attribute__ ((__nothrow__));


extern int clock_gettime (clockid_t __clock_id, struct timespec *__tp) __attribute__ ((__nothrow__));


extern int clock_settime (clockid_t __clock_id, __const struct timespec *__tp)
     __attribute__ ((__nothrow__));






extern int clock_nanosleep (clockid_t __clock_id, int __flags,
       __const struct timespec *__req,
       struct timespec *__rem);


extern int clock_getcpuclockid (pid_t __pid, clockid_t *__clock_id) __attribute__ ((__nothrow__));




extern int timer_create (clockid_t __clock_id,
    struct sigevent *__restrict __evp,
    timer_t *__restrict __timerid) __attribute__ ((__nothrow__));


extern int timer_delete (timer_t __timerid) __attribute__ ((__nothrow__));


extern int timer_settime (timer_t __timerid, int __flags,
     __const struct itimerspec *__restrict __value,
     struct itimerspec *__restrict __ovalue) __attribute__ ((__nothrow__));


extern int timer_gettime (timer_t __timerid, struct itimerspec *__value)
     __attribute__ ((__nothrow__));


extern int timer_getoverrun (timer_t __timerid) __attribute__ ((__nothrow__));
# 417 "/usr/include/time.h" 3 4

# 8 "cudagaugefix.cu" 2
# 1 "/usr/include/stdlib.h" 1 3 4
# 33 "/usr/include/stdlib.h" 3 4
# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stddef.h" 1 3 4
# 323 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stddef.h" 3 4
typedef int wchar_t;
# 34 "/usr/include/stdlib.h" 2 3 4


# 96 "/usr/include/stdlib.h" 3 4


typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;







__extension__ typedef struct
  {
    long long int quot;
    long long int rem;
  } lldiv_t;


# 140 "/usr/include/stdlib.h" 3 4
extern size_t __ctype_get_mb_cur_max (void) __attribute__ ((__nothrow__)) ;




extern double atof (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern int atoi (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern long int atol (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;





__extension__ extern long long int atoll (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;





extern double strtod (__const char *__restrict __nptr,
        char **__restrict __endptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





extern float strtof (__const char *__restrict __nptr,
       char **__restrict __endptr) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

extern long double strtold (__const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





extern long int strtol (__const char *__restrict __nptr,
   char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

extern unsigned long int strtoul (__const char *__restrict __nptr,
      char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




__extension__
extern long long int strtoq (__const char *__restrict __nptr,
        char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

__extension__
extern unsigned long long int strtouq (__const char *__restrict __nptr,
           char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





__extension__
extern long long int strtoll (__const char *__restrict __nptr,
         char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

__extension__
extern unsigned long long int strtoull (__const char *__restrict __nptr,
     char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

# 311 "/usr/include/stdlib.h" 3 4
extern char *l64a (long int __n) __attribute__ ((__nothrow__)) ;


extern long int a64l (__const char *__s)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;




# 1 "/usr/include/sys/types.h" 1 3 4
# 29 "/usr/include/sys/types.h" 3 4






typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;




typedef __loff_t loff_t;



typedef __ino_t ino_t;
# 62 "/usr/include/sys/types.h" 3 4
typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;





typedef __off_t off_t;
# 105 "/usr/include/sys/types.h" 3 4
typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;
# 147 "/usr/include/sys/types.h" 3 4
# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stddef.h" 1 3 4
# 148 "/usr/include/sys/types.h" 2 3 4



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;
# 195 "/usr/include/sys/types.h" 3 4
typedef int int8_t __attribute__ ((__mode__ (__QI__)));
typedef int int16_t __attribute__ ((__mode__ (__HI__)));
typedef int int32_t __attribute__ ((__mode__ (__SI__)));
typedef int int64_t __attribute__ ((__mode__ (__DI__)));


typedef unsigned int u_int8_t __attribute__ ((__mode__ (__QI__)));
typedef unsigned int u_int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int u_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int u_int64_t __attribute__ ((__mode__ (__DI__)));

typedef int register_t __attribute__ ((__mode__ (__word__)));
# 217 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 37 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 38 "/usr/include/endian.h" 2 3 4
# 61 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/byteswap.h" 1 3 4
# 28 "/usr/include/bits/byteswap.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/byteswap.h" 2 3 4
# 62 "/usr/include/endian.h" 2 3 4
# 218 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 23 "/usr/include/bits/select.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 24 "/usr/include/bits/select.h" 2 3 4
# 32 "/usr/include/sys/select.h" 2 3 4


# 1 "/usr/include/bits/sigset.h" 1 3 4
# 24 "/usr/include/bits/sigset.h" 3 4
typedef int __sig_atomic_t;




typedef struct
  {
    unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
  } __sigset_t;
# 35 "/usr/include/sys/select.h" 2 3 4



typedef __sigset_t sigset_t;







# 1 "/usr/include/bits/time.h" 1 3 4
# 69 "/usr/include/bits/time.h" 3 4
struct timeval
  {
    __time_t tv_sec;
    __suseconds_t tv_usec;
  };
# 47 "/usr/include/sys/select.h" 2 3 4


typedef __suseconds_t suseconds_t;





typedef long int __fd_mask;
# 67 "/usr/include/sys/select.h" 3 4
typedef struct
  {






    __fd_mask __fds_bits[1024 / (8 * sizeof (__fd_mask))];


  } fd_set;






typedef __fd_mask fd_mask;
# 99 "/usr/include/sys/select.h" 3 4

# 109 "/usr/include/sys/select.h" 3 4
extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
# 121 "/usr/include/sys/select.h" 3 4
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);



# 221 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/sysmacros.h" 1 3 4
# 30 "/usr/include/sys/sysmacros.h" 3 4
__extension__
extern unsigned int gnu_dev_major (unsigned long long int __dev)
     __attribute__ ((__nothrow__));
__extension__
extern unsigned int gnu_dev_minor (unsigned long long int __dev)
     __attribute__ ((__nothrow__));
__extension__
extern unsigned long long int gnu_dev_makedev (unsigned int __major,
            unsigned int __minor)
     __attribute__ ((__nothrow__));
# 224 "/usr/include/sys/types.h" 2 3 4
# 235 "/usr/include/sys/types.h" 3 4
typedef __blkcnt_t blkcnt_t;



typedef __fsblkcnt_t fsblkcnt_t;



typedef __fsfilcnt_t fsfilcnt_t;
# 270 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 23 "/usr/include/bits/pthreadtypes.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 24 "/usr/include/bits/pthreadtypes.h" 2 3 4
# 50 "/usr/include/bits/pthreadtypes.h" 3 4
typedef unsigned long int pthread_t;


typedef union
{
  char __size[56];
  long int __align;
} pthread_attr_t;



typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;
# 76 "/usr/include/bits/pthreadtypes.h" 3 4
typedef union
{
  struct __pthread_mutex_s
  {
    int __lock;
    unsigned int __count;
    int __owner;

    unsigned int __nusers;



    int __kind;

    int __spins;
    __pthread_list_t __list;
# 101 "/usr/include/bits/pthreadtypes.h" 3 4
  } __data;
  char __size[40];
  long int __align;
} pthread_mutex_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_mutexattr_t;




typedef union
{
  struct
  {
    int __lock;
    unsigned int __futex;
    __extension__ unsigned long long int __total_seq;
    __extension__ unsigned long long int __wakeup_seq;
    __extension__ unsigned long long int __woken_seq;
    void *__mutex;
    unsigned int __nwaiters;
    unsigned int __broadcast_seq;
  } __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;





typedef union
{

  struct
  {
    int __lock;
    unsigned int __nr_readers;
    unsigned int __readers_wakeup;
    unsigned int __writer_wakeup;
    unsigned int __nr_readers_queued;
    unsigned int __nr_writers_queued;
    int __writer;
    int __shared;
    unsigned long int __pad1;
    unsigned long int __pad2;


    unsigned int __flags;
  } __data;
# 187 "/usr/include/bits/pthreadtypes.h" 3 4
  char __size[56];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[32];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;
# 271 "/usr/include/sys/types.h" 2 3 4



# 321 "/usr/include/stdlib.h" 2 3 4






extern long int random (void) __attribute__ ((__nothrow__));


extern void srandom (unsigned int __seed) __attribute__ ((__nothrow__));





extern char *initstate (unsigned int __seed, char *__statebuf,
   size_t __statelen) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));



extern char *setstate (char *__statebuf) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));







struct random_data
  {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
  };

extern int random_r (struct random_data *__restrict __buf,
       int32_t *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));

extern int srandom_r (unsigned int __seed, struct random_data *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));

extern int initstate_r (unsigned int __seed, char *__restrict __statebuf,
   size_t __statelen,
   struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2, 4)));

extern int setstate_r (char *__restrict __statebuf,
         struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));






extern int rand (void) __attribute__ ((__nothrow__));

extern void srand (unsigned int __seed) __attribute__ ((__nothrow__));




extern int rand_r (unsigned int *__seed) __attribute__ ((__nothrow__));







extern double drand48 (void) __attribute__ ((__nothrow__));
extern double erand48 (unsigned short int __xsubi[3]) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern long int lrand48 (void) __attribute__ ((__nothrow__));
extern long int nrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern long int mrand48 (void) __attribute__ ((__nothrow__));
extern long int jrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern void srand48 (long int __seedval) __attribute__ ((__nothrow__));
extern unsigned short int *seed48 (unsigned short int __seed16v[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
extern void lcong48 (unsigned short int __param[7]) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





struct drand48_data
  {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    unsigned long long int __a;
  };


extern int drand48_r (struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int erand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int lrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int nrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int mrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int jrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int srand48_r (long int __seedval, struct drand48_data *__buffer)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));

extern int seed48_r (unsigned short int __seed16v[3],
       struct drand48_data *__buffer) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));

extern int lcong48_r (unsigned short int __param[7],
        struct drand48_data *__buffer)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));









extern void *malloc (size_t __size) __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;

extern void *calloc (size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;










extern void *realloc (void *__ptr, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__warn_unused_result__));

extern void free (void *__ptr) __attribute__ ((__nothrow__));




extern void cfree (void *__ptr) __attribute__ ((__nothrow__));



# 1 "/usr/include/alloca.h" 1 3 4
# 25 "/usr/include/alloca.h" 3 4
# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stddef.h" 1 3 4
# 26 "/usr/include/alloca.h" 2 3 4







extern void *alloca (size_t __size) __attribute__ ((__nothrow__));






# 498 "/usr/include/stdlib.h" 2 3 4




extern void *valloc (size_t __size) __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;




extern int posix_memalign (void **__memptr, size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




extern void abort (void) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
# 530 "/usr/include/stdlib.h" 3 4





extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));






extern void exit (int __status) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));
# 553 "/usr/include/stdlib.h" 3 4






extern void _Exit (int __status) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));






extern char *getenv (__const char *__name) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




extern char *__secure_getenv (__const char *__name)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





extern int putenv (char *__string) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





extern int setenv (__const char *__name, __const char *__value, int __replace)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));


extern int unsetenv (__const char *__name) __attribute__ ((__nothrow__));






extern int clearenv (void) __attribute__ ((__nothrow__));
# 604 "/usr/include/stdlib.h" 3 4
extern char *mktemp (char *__template) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 615 "/usr/include/stdlib.h" 3 4
extern int mkstemp (char *__template) __attribute__ ((__nonnull__ (1))) ;
# 635 "/usr/include/stdlib.h" 3 4
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 661 "/usr/include/stdlib.h" 3 4





extern int system (__const char *__command) ;

# 683 "/usr/include/stdlib.h" 3 4
extern char *realpath (__const char *__restrict __name,
         char *__restrict __resolved) __attribute__ ((__nothrow__)) ;






typedef int (*__compar_fn_t) (__const void *, __const void *);
# 701 "/usr/include/stdlib.h" 3 4



extern void *bsearch (__const void *__key, __const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     __attribute__ ((__nonnull__ (1, 2, 5))) ;



extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));
# 720 "/usr/include/stdlib.h" 3 4
extern int abs (int __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;
extern long int labs (long int __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;



__extension__ extern long long int llabs (long long int __x)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;







extern div_t div (int __numer, int __denom)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;
extern ldiv_t ldiv (long int __numer, long int __denom)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;




__extension__ extern lldiv_t lldiv (long long int __numer,
        long long int __denom)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;

# 756 "/usr/include/stdlib.h" 3 4
extern char *ecvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *fcvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *gcvt (double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3))) ;




extern char *qecvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qfcvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qgcvt (long double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3))) ;




extern int ecvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int fcvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));

extern int qecvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int qfcvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));







extern int mblen (__const char *__s, size_t __n) __attribute__ ((__nothrow__)) ;


extern int mbtowc (wchar_t *__restrict __pwc,
     __const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__)) ;


extern int wctomb (char *__s, wchar_t __wchar) __attribute__ ((__nothrow__)) ;



extern size_t mbstowcs (wchar_t *__restrict __pwcs,
   __const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__));

extern size_t wcstombs (char *__restrict __s,
   __const wchar_t *__restrict __pwcs, size_t __n)
     __attribute__ ((__nothrow__));








extern int rpmatch (__const char *__response) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 861 "/usr/include/stdlib.h" 3 4
extern int posix_openpt (int __oflag) ;
# 896 "/usr/include/stdlib.h" 3 4
extern int getloadavg (double __loadavg[], int __nelem)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
# 912 "/usr/include/stdlib.h" 3 4

# 9 "cudagaugefix.cu" 2
# 1 "/usr/include/stdio.h" 1 3 4
# 30 "/usr/include/stdio.h" 3 4




# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stddef.h" 1 3 4
# 35 "/usr/include/stdio.h" 2 3 4
# 45 "/usr/include/stdio.h" 3 4
struct _IO_FILE;



typedef struct _IO_FILE FILE;





# 65 "/usr/include/stdio.h" 3 4
typedef struct _IO_FILE __FILE;
# 75 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/libio.h" 1 3 4
# 32 "/usr/include/libio.h" 3 4
# 1 "/usr/include/_G_config.h" 1 3 4
# 15 "/usr/include/_G_config.h" 3 4
# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stddef.h" 1 3 4
# 16 "/usr/include/_G_config.h" 2 3 4




# 1 "/usr/include/wchar.h" 1 3 4
# 83 "/usr/include/wchar.h" 3 4
typedef struct
{
  int __count;
  union
  {

    unsigned int __wch;



    char __wchb[4];
  } __value;
} __mbstate_t;
# 21 "/usr/include/_G_config.h" 2 3 4

typedef struct
{
  __off_t __pos;
  __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
  __off64_t __pos;
  __mbstate_t __state;
} _G_fpos64_t;
# 53 "/usr/include/_G_config.h" 3 4
typedef int _G_int16_t __attribute__ ((__mode__ (__HI__)));
typedef int _G_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int _G_uint16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int _G_uint32_t __attribute__ ((__mode__ (__SI__)));
# 33 "/usr/include/libio.h" 2 3 4
# 53 "/usr/include/libio.h" 3 4
# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 54 "/usr/include/libio.h" 2 3 4
# 170 "/usr/include/libio.h" 3 4
struct _IO_jump_t; struct _IO_FILE;
# 180 "/usr/include/libio.h" 3 4
typedef void _IO_lock_t;





struct _IO_marker {
  struct _IO_marker *_next;
  struct _IO_FILE *_sbuf;



  int _pos;
# 203 "/usr/include/libio.h" 3 4
};


enum __codecvt_result
{
  __codecvt_ok,
  __codecvt_partial,
  __codecvt_error,
  __codecvt_noconv
};
# 271 "/usr/include/libio.h" 3 4
struct _IO_FILE {
  int _flags;




  char* _IO_read_ptr;
  char* _IO_read_end;
  char* _IO_read_base;
  char* _IO_write_base;
  char* _IO_write_ptr;
  char* _IO_write_end;
  char* _IO_buf_base;
  char* _IO_buf_end;

  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;



  int _flags2;

  __off_t _old_offset;



  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];



  _IO_lock_t *_lock;
# 319 "/usr/include/libio.h" 3 4
  __off64_t _offset;
# 328 "/usr/include/libio.h" 3 4
  void *__pad1;
  void *__pad2;
  void *__pad3;
  void *__pad4;
  size_t __pad5;

  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];

};


typedef struct _IO_FILE _IO_FILE;


struct _IO_FILE_plus;

extern struct _IO_FILE_plus _IO_2_1_stdin_;
extern struct _IO_FILE_plus _IO_2_1_stdout_;
extern struct _IO_FILE_plus _IO_2_1_stderr_;
# 364 "/usr/include/libio.h" 3 4
typedef __ssize_t __io_read_fn (void *__cookie, char *__buf, size_t __nbytes);







typedef __ssize_t __io_write_fn (void *__cookie, __const char *__buf,
     size_t __n);







typedef int __io_seek_fn (void *__cookie, __off64_t *__pos, int __w);


typedef int __io_close_fn (void *__cookie);
# 416 "/usr/include/libio.h" 3 4
extern int __underflow (_IO_FILE *);
extern int __uflow (_IO_FILE *);
extern int __overflow (_IO_FILE *, int);
# 458 "/usr/include/libio.h" 3 4
extern int _IO_getc (_IO_FILE *__fp);
extern int _IO_putc (int __c, _IO_FILE *__fp);
extern int _IO_feof (_IO_FILE *__fp) __attribute__ ((__nothrow__));
extern int _IO_ferror (_IO_FILE *__fp) __attribute__ ((__nothrow__));

extern int _IO_peekc_locked (_IO_FILE *__fp);





extern void _IO_flockfile (_IO_FILE *) __attribute__ ((__nothrow__));
extern void _IO_funlockfile (_IO_FILE *) __attribute__ ((__nothrow__));
extern int _IO_ftrylockfile (_IO_FILE *) __attribute__ ((__nothrow__));
# 488 "/usr/include/libio.h" 3 4
extern int _IO_vfscanf (_IO_FILE * __restrict, const char * __restrict,
   __gnuc_va_list, int *__restrict);
extern int _IO_vfprintf (_IO_FILE *__restrict, const char *__restrict,
    __gnuc_va_list);
extern __ssize_t _IO_padn (_IO_FILE *, int, __ssize_t);
extern size_t _IO_sgetn (_IO_FILE *, void *, size_t);

extern __off64_t _IO_seekoff (_IO_FILE *, __off64_t, int, int);
extern __off64_t _IO_seekpos (_IO_FILE *, __off64_t, int);

extern void _IO_free_backup_area (_IO_FILE *) __attribute__ ((__nothrow__));
# 76 "/usr/include/stdio.h" 2 3 4
# 89 "/usr/include/stdio.h" 3 4


typedef _G_fpos_t fpos_t;




# 141 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 142 "/usr/include/stdio.h" 2 3 4



extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;







extern int remove (__const char *__filename) __attribute__ ((__nothrow__));

extern int rename (__const char *__old, __const char *__new) __attribute__ ((__nothrow__));




extern int renameat (int __oldfd, __const char *__old, int __newfd,
       __const char *__new) __attribute__ ((__nothrow__));








extern FILE *tmpfile (void) ;
# 186 "/usr/include/stdio.h" 3 4
extern char *tmpnam (char *__s) __attribute__ ((__nothrow__)) ;





extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__)) ;
# 204 "/usr/include/stdio.h" 3 4
extern char *tempnam (__const char *__dir, __const char *__pfx)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;








extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);

# 229 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 243 "/usr/include/stdio.h" 3 4






extern FILE *fopen (__const char *__restrict __filename,
      __const char *__restrict __modes) ;




extern FILE *freopen (__const char *__restrict __filename,
        __const char *__restrict __modes,
        FILE *__restrict __stream) ;
# 272 "/usr/include/stdio.h" 3 4

# 283 "/usr/include/stdio.h" 3 4
extern FILE *fdopen (int __fd, __const char *__modes) __attribute__ ((__nothrow__)) ;
# 296 "/usr/include/stdio.h" 3 4
extern FILE *fmemopen (void *__s, size_t __len, __const char *__modes)
  __attribute__ ((__nothrow__)) ;




extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__)) ;






extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__));





extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__));








extern int fprintf (FILE *__restrict __stream,
      __const char *__restrict __format, ...);




extern int printf (__const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      __const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, __const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (__const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, __const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));





extern int snprintf (char *__restrict __s, size_t __maxlen,
       __const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));

# 394 "/usr/include/stdio.h" 3 4
extern int vdprintf (int __fd, __const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, __const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));








extern int fscanf (FILE *__restrict __stream,
     __const char *__restrict __format, ...) ;




extern int scanf (__const char *__restrict __format, ...) ;

extern int sscanf (__const char *__restrict __s,
     __const char *__restrict __format, ...) __attribute__ ((__nothrow__));
# 425 "/usr/include/stdio.h" 3 4
extern int fscanf (FILE *__restrict __stream, __const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf") ;


extern int scanf (__const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf") ;

extern int sscanf (__const char *__restrict __s, __const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__));
# 445 "/usr/include/stdio.h" 3 4








extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (__const char *__restrict __s,
      __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
# 476 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (__const char *__restrict __s, __const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf")



     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
# 504 "/usr/include/stdio.h" 3 4









extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);

# 532 "/usr/include/stdio.h" 3 4
extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 543 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);











extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);

# 576 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);








extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     ;






extern char *gets (char *__s) ;

# 638 "/usr/include/stdio.h" 3 4
extern __ssize_t __getdelim (char **__restrict __lineptr,
          size_t *__restrict __n, int __delimiter,
          FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
        size_t *__restrict __n, int __delimiter,
        FILE *__restrict __stream) ;







extern __ssize_t getline (char **__restrict __lineptr,
       size_t *__restrict __n,
       FILE *__restrict __stream) ;








extern int fputs (__const char *__restrict __s, FILE *__restrict __stream);





extern int puts (__const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (__const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s);

# 710 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (__const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream);








extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);

# 746 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off_t __off, int __whence);




extern __off_t ftello (FILE *__stream) ;
# 765 "/usr/include/stdio.h" 3 4






extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);




extern int fsetpos (FILE *__stream, __const fpos_t *__pos);
# 788 "/usr/include/stdio.h" 3 4

# 797 "/usr/include/stdio.h" 3 4


extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__)) ;




extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;








extern void perror (__const char *__s);






# 1 "/usr/include/bits/sys_errlist.h" 1 3 4
# 27 "/usr/include/bits/sys_errlist.h" 3 4
extern int sys_nerr;
extern __const char *__const sys_errlist[];
# 827 "/usr/include/stdio.h" 2 3 4




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;
# 846 "/usr/include/stdio.h" 3 4
extern FILE *popen (__const char *__command, __const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__));
# 886 "/usr/include/stdio.h" 3 4
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__));
# 916 "/usr/include/stdio.h" 3 4

# 10 "cudagaugefix.cu" 2
# 1 "/usr/include/assert.h" 1 3 4
# 68 "/usr/include/assert.h" 3 4



extern void __assert_fail (__const char *__assertion, __const char *__file,
      unsigned int __line, __const char *__function)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));


extern void __assert_perror_fail (int __errnum, __const char *__file,
      unsigned int __line,
      __const char *__function)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));




extern void __assert (const char *__assertion, const char *__file, int __line)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));



# 11 "cudagaugefix.cu" 2
# 1 "cudaglobal.h" 1
# 18 "cudaglobal.h"
typedef struct {
  double re;
  double im;
} dev_complex;


typedef dev_complex dev_su3 [3][3];
typedef double2 su3_2v ;

typedef double2 dev_su3_2v ;



typedef double2 dev_su3_8 ;


typedef struct {
  double2 a;
  double2 b;
} dev_su2;


typedef float4 dev_spinor;
typedef struct dev_spinor_smem{
  dev_spinor spin;
  float dummy;
} dev_spinor_smem;
typedef dev_complex dev_propmatrix[12][12];
typedef dev_complex dev_fbyf[4][4];
# 12 "cudagaugefix.cu" 2
# 1 "/usr/include/math.h" 1 3 4
# 30 "/usr/include/math.h" 3 4




# 1 "/usr/include/bits/huge_val.h" 1 3 4
# 35 "/usr/include/math.h" 2 3 4

# 1 "/usr/include/bits/huge_valf.h" 1 3 4
# 37 "/usr/include/math.h" 2 3 4
# 1 "/usr/include/bits/huge_vall.h" 1 3 4
# 38 "/usr/include/math.h" 2 3 4


# 1 "/usr/include/bits/inf.h" 1 3 4
# 41 "/usr/include/math.h" 2 3 4


# 1 "/usr/include/bits/nan.h" 1 3 4
# 44 "/usr/include/math.h" 2 3 4



# 1 "/usr/include/bits/mathdef.h" 1 3 4
# 26 "/usr/include/bits/mathdef.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 27 "/usr/include/bits/mathdef.h" 2 3 4




typedef float float_t;
typedef double double_t;
# 48 "/usr/include/math.h" 2 3 4
# 71 "/usr/include/math.h" 3 4
# 1 "/usr/include/bits/mathcalls.h" 1 3 4
# 53 "/usr/include/bits/mathcalls.h" 3 4


extern double acos (double __x) __attribute__ ((__nothrow__)); extern double __acos (double __x) __attribute__ ((__nothrow__));

extern double asin (double __x) __attribute__ ((__nothrow__)); extern double __asin (double __x) __attribute__ ((__nothrow__));

extern double atan (double __x) __attribute__ ((__nothrow__)); extern double __atan (double __x) __attribute__ ((__nothrow__));

extern double atan2 (double __y, double __x) __attribute__ ((__nothrow__)); extern double __atan2 (double __y, double __x) __attribute__ ((__nothrow__));


extern double cos (double __x) __attribute__ ((__nothrow__)); extern double __cos (double __x) __attribute__ ((__nothrow__));

extern double sin (double __x) __attribute__ ((__nothrow__)); extern double __sin (double __x) __attribute__ ((__nothrow__));

extern double tan (double __x) __attribute__ ((__nothrow__)); extern double __tan (double __x) __attribute__ ((__nothrow__));




extern double cosh (double __x) __attribute__ ((__nothrow__)); extern double __cosh (double __x) __attribute__ ((__nothrow__));

extern double sinh (double __x) __attribute__ ((__nothrow__)); extern double __sinh (double __x) __attribute__ ((__nothrow__));

extern double tanh (double __x) __attribute__ ((__nothrow__)); extern double __tanh (double __x) __attribute__ ((__nothrow__));

# 87 "/usr/include/bits/mathcalls.h" 3 4


extern double acosh (double __x) __attribute__ ((__nothrow__)); extern double __acosh (double __x) __attribute__ ((__nothrow__));

extern double asinh (double __x) __attribute__ ((__nothrow__)); extern double __asinh (double __x) __attribute__ ((__nothrow__));

extern double atanh (double __x) __attribute__ ((__nothrow__)); extern double __atanh (double __x) __attribute__ ((__nothrow__));







extern double exp (double __x) __attribute__ ((__nothrow__)); extern double __exp (double __x) __attribute__ ((__nothrow__));


extern double frexp (double __x, int *__exponent) __attribute__ ((__nothrow__)); extern double __frexp (double __x, int *__exponent) __attribute__ ((__nothrow__));


extern double ldexp (double __x, int __exponent) __attribute__ ((__nothrow__)); extern double __ldexp (double __x, int __exponent) __attribute__ ((__nothrow__));


extern double log (double __x) __attribute__ ((__nothrow__)); extern double __log (double __x) __attribute__ ((__nothrow__));


extern double log10 (double __x) __attribute__ ((__nothrow__)); extern double __log10 (double __x) __attribute__ ((__nothrow__));


extern double modf (double __x, double *__iptr) __attribute__ ((__nothrow__)); extern double __modf (double __x, double *__iptr) __attribute__ ((__nothrow__));

# 127 "/usr/include/bits/mathcalls.h" 3 4


extern double expm1 (double __x) __attribute__ ((__nothrow__)); extern double __expm1 (double __x) __attribute__ ((__nothrow__));


extern double log1p (double __x) __attribute__ ((__nothrow__)); extern double __log1p (double __x) __attribute__ ((__nothrow__));


extern double logb (double __x) __attribute__ ((__nothrow__)); extern double __logb (double __x) __attribute__ ((__nothrow__));






extern double exp2 (double __x) __attribute__ ((__nothrow__)); extern double __exp2 (double __x) __attribute__ ((__nothrow__));


extern double log2 (double __x) __attribute__ ((__nothrow__)); extern double __log2 (double __x) __attribute__ ((__nothrow__));








extern double pow (double __x, double __y) __attribute__ ((__nothrow__)); extern double __pow (double __x, double __y) __attribute__ ((__nothrow__));


extern double sqrt (double __x) __attribute__ ((__nothrow__)); extern double __sqrt (double __x) __attribute__ ((__nothrow__));





extern double hypot (double __x, double __y) __attribute__ ((__nothrow__)); extern double __hypot (double __x, double __y) __attribute__ ((__nothrow__));






extern double cbrt (double __x) __attribute__ ((__nothrow__)); extern double __cbrt (double __x) __attribute__ ((__nothrow__));








extern double ceil (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __ceil (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double fabs (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __fabs (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double floor (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __floor (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double fmod (double __x, double __y) __attribute__ ((__nothrow__)); extern double __fmod (double __x, double __y) __attribute__ ((__nothrow__));




extern int __isinf (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int __finite (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int isinf (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int finite (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double drem (double __x, double __y) __attribute__ ((__nothrow__)); extern double __drem (double __x, double __y) __attribute__ ((__nothrow__));



extern double significand (double __x) __attribute__ ((__nothrow__)); extern double __significand (double __x) __attribute__ ((__nothrow__));





extern double copysign (double __x, double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __copysign (double __x, double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));






extern double nan (__const char *__tagb) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __nan (__const char *__tagb) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int __isnan (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern int isnan (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double j0 (double) __attribute__ ((__nothrow__)); extern double __j0 (double) __attribute__ ((__nothrow__));
extern double j1 (double) __attribute__ ((__nothrow__)); extern double __j1 (double) __attribute__ ((__nothrow__));
extern double jn (int, double) __attribute__ ((__nothrow__)); extern double __jn (int, double) __attribute__ ((__nothrow__));
extern double y0 (double) __attribute__ ((__nothrow__)); extern double __y0 (double) __attribute__ ((__nothrow__));
extern double y1 (double) __attribute__ ((__nothrow__)); extern double __y1 (double) __attribute__ ((__nothrow__));
extern double yn (int, double) __attribute__ ((__nothrow__)); extern double __yn (int, double) __attribute__ ((__nothrow__));






extern double erf (double) __attribute__ ((__nothrow__)); extern double __erf (double) __attribute__ ((__nothrow__));
extern double erfc (double) __attribute__ ((__nothrow__)); extern double __erfc (double) __attribute__ ((__nothrow__));
extern double lgamma (double) __attribute__ ((__nothrow__)); extern double __lgamma (double) __attribute__ ((__nothrow__));






extern double tgamma (double) __attribute__ ((__nothrow__)); extern double __tgamma (double) __attribute__ ((__nothrow__));





extern double gamma (double) __attribute__ ((__nothrow__)); extern double __gamma (double) __attribute__ ((__nothrow__));






extern double lgamma_r (double, int *__signgamp) __attribute__ ((__nothrow__)); extern double __lgamma_r (double, int *__signgamp) __attribute__ ((__nothrow__));







extern double rint (double __x) __attribute__ ((__nothrow__)); extern double __rint (double __x) __attribute__ ((__nothrow__));


extern double nextafter (double __x, double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __nextafter (double __x, double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));

extern double nexttoward (double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __nexttoward (double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern double remainder (double __x, double __y) __attribute__ ((__nothrow__)); extern double __remainder (double __x, double __y) __attribute__ ((__nothrow__));



extern double scalbn (double __x, int __n) __attribute__ ((__nothrow__)); extern double __scalbn (double __x, int __n) __attribute__ ((__nothrow__));



extern int ilogb (double __x) __attribute__ ((__nothrow__)); extern int __ilogb (double __x) __attribute__ ((__nothrow__));




extern double scalbln (double __x, long int __n) __attribute__ ((__nothrow__)); extern double __scalbln (double __x, long int __n) __attribute__ ((__nothrow__));



extern double nearbyint (double __x) __attribute__ ((__nothrow__)); extern double __nearbyint (double __x) __attribute__ ((__nothrow__));



extern double round (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __round (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern double trunc (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __trunc (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));




extern double remquo (double __x, double __y, int *__quo) __attribute__ ((__nothrow__)); extern double __remquo (double __x, double __y, int *__quo) __attribute__ ((__nothrow__));






extern long int lrint (double __x) __attribute__ ((__nothrow__)); extern long int __lrint (double __x) __attribute__ ((__nothrow__));
extern long long int llrint (double __x) __attribute__ ((__nothrow__)); extern long long int __llrint (double __x) __attribute__ ((__nothrow__));



extern long int lround (double __x) __attribute__ ((__nothrow__)); extern long int __lround (double __x) __attribute__ ((__nothrow__));
extern long long int llround (double __x) __attribute__ ((__nothrow__)); extern long long int __llround (double __x) __attribute__ ((__nothrow__));



extern double fdim (double __x, double __y) __attribute__ ((__nothrow__)); extern double __fdim (double __x, double __y) __attribute__ ((__nothrow__));


extern double fmax (double __x, double __y) __attribute__ ((__nothrow__)); extern double __fmax (double __x, double __y) __attribute__ ((__nothrow__));


extern double fmin (double __x, double __y) __attribute__ ((__nothrow__)); extern double __fmin (double __x, double __y) __attribute__ ((__nothrow__));



extern int __fpclassify (double __value) __attribute__ ((__nothrow__))
     __attribute__ ((__const__));


extern int __signbit (double __value) __attribute__ ((__nothrow__))
     __attribute__ ((__const__));



extern double fma (double __x, double __y, double __z) __attribute__ ((__nothrow__)); extern double __fma (double __x, double __y, double __z) __attribute__ ((__nothrow__));








extern double scalb (double __x, double __n) __attribute__ ((__nothrow__)); extern double __scalb (double __x, double __n) __attribute__ ((__nothrow__));
# 72 "/usr/include/math.h" 2 3 4
# 94 "/usr/include/math.h" 3 4
# 1 "/usr/include/bits/mathcalls.h" 1 3 4
# 53 "/usr/include/bits/mathcalls.h" 3 4


extern float acosf (float __x) __attribute__ ((__nothrow__)); extern float __acosf (float __x) __attribute__ ((__nothrow__));

extern float asinf (float __x) __attribute__ ((__nothrow__)); extern float __asinf (float __x) __attribute__ ((__nothrow__));

extern float atanf (float __x) __attribute__ ((__nothrow__)); extern float __atanf (float __x) __attribute__ ((__nothrow__));

extern float atan2f (float __y, float __x) __attribute__ ((__nothrow__)); extern float __atan2f (float __y, float __x) __attribute__ ((__nothrow__));


extern float cosf (float __x) __attribute__ ((__nothrow__)); extern float __cosf (float __x) __attribute__ ((__nothrow__));

extern float sinf (float __x) __attribute__ ((__nothrow__)); extern float __sinf (float __x) __attribute__ ((__nothrow__));

extern float tanf (float __x) __attribute__ ((__nothrow__)); extern float __tanf (float __x) __attribute__ ((__nothrow__));




extern float coshf (float __x) __attribute__ ((__nothrow__)); extern float __coshf (float __x) __attribute__ ((__nothrow__));

extern float sinhf (float __x) __attribute__ ((__nothrow__)); extern float __sinhf (float __x) __attribute__ ((__nothrow__));

extern float tanhf (float __x) __attribute__ ((__nothrow__)); extern float __tanhf (float __x) __attribute__ ((__nothrow__));

# 87 "/usr/include/bits/mathcalls.h" 3 4


extern float acoshf (float __x) __attribute__ ((__nothrow__)); extern float __acoshf (float __x) __attribute__ ((__nothrow__));

extern float asinhf (float __x) __attribute__ ((__nothrow__)); extern float __asinhf (float __x) __attribute__ ((__nothrow__));

extern float atanhf (float __x) __attribute__ ((__nothrow__)); extern float __atanhf (float __x) __attribute__ ((__nothrow__));







extern float expf (float __x) __attribute__ ((__nothrow__)); extern float __expf (float __x) __attribute__ ((__nothrow__));


extern float frexpf (float __x, int *__exponent) __attribute__ ((__nothrow__)); extern float __frexpf (float __x, int *__exponent) __attribute__ ((__nothrow__));


extern float ldexpf (float __x, int __exponent) __attribute__ ((__nothrow__)); extern float __ldexpf (float __x, int __exponent) __attribute__ ((__nothrow__));


extern float logf (float __x) __attribute__ ((__nothrow__)); extern float __logf (float __x) __attribute__ ((__nothrow__));


extern float log10f (float __x) __attribute__ ((__nothrow__)); extern float __log10f (float __x) __attribute__ ((__nothrow__));


extern float modff (float __x, float *__iptr) __attribute__ ((__nothrow__)); extern float __modff (float __x, float *__iptr) __attribute__ ((__nothrow__));

# 127 "/usr/include/bits/mathcalls.h" 3 4


extern float expm1f (float __x) __attribute__ ((__nothrow__)); extern float __expm1f (float __x) __attribute__ ((__nothrow__));


extern float log1pf (float __x) __attribute__ ((__nothrow__)); extern float __log1pf (float __x) __attribute__ ((__nothrow__));


extern float logbf (float __x) __attribute__ ((__nothrow__)); extern float __logbf (float __x) __attribute__ ((__nothrow__));






extern float exp2f (float __x) __attribute__ ((__nothrow__)); extern float __exp2f (float __x) __attribute__ ((__nothrow__));


extern float log2f (float __x) __attribute__ ((__nothrow__)); extern float __log2f (float __x) __attribute__ ((__nothrow__));








extern float powf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __powf (float __x, float __y) __attribute__ ((__nothrow__));


extern float sqrtf (float __x) __attribute__ ((__nothrow__)); extern float __sqrtf (float __x) __attribute__ ((__nothrow__));





extern float hypotf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __hypotf (float __x, float __y) __attribute__ ((__nothrow__));






extern float cbrtf (float __x) __attribute__ ((__nothrow__)); extern float __cbrtf (float __x) __attribute__ ((__nothrow__));








extern float ceilf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __ceilf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float fabsf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __fabsf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float floorf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __floorf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float fmodf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __fmodf (float __x, float __y) __attribute__ ((__nothrow__));




extern int __isinff (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int __finitef (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int isinff (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int finitef (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float dremf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __dremf (float __x, float __y) __attribute__ ((__nothrow__));



extern float significandf (float __x) __attribute__ ((__nothrow__)); extern float __significandf (float __x) __attribute__ ((__nothrow__));





extern float copysignf (float __x, float __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __copysignf (float __x, float __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));






extern float nanf (__const char *__tagb) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __nanf (__const char *__tagb) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int __isnanf (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern int isnanf (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float j0f (float) __attribute__ ((__nothrow__)); extern float __j0f (float) __attribute__ ((__nothrow__));
extern float j1f (float) __attribute__ ((__nothrow__)); extern float __j1f (float) __attribute__ ((__nothrow__));
extern float jnf (int, float) __attribute__ ((__nothrow__)); extern float __jnf (int, float) __attribute__ ((__nothrow__));
extern float y0f (float) __attribute__ ((__nothrow__)); extern float __y0f (float) __attribute__ ((__nothrow__));
extern float y1f (float) __attribute__ ((__nothrow__)); extern float __y1f (float) __attribute__ ((__nothrow__));
extern float ynf (int, float) __attribute__ ((__nothrow__)); extern float __ynf (int, float) __attribute__ ((__nothrow__));






extern float erff (float) __attribute__ ((__nothrow__)); extern float __erff (float) __attribute__ ((__nothrow__));
extern float erfcf (float) __attribute__ ((__nothrow__)); extern float __erfcf (float) __attribute__ ((__nothrow__));
extern float lgammaf (float) __attribute__ ((__nothrow__)); extern float __lgammaf (float) __attribute__ ((__nothrow__));






extern float tgammaf (float) __attribute__ ((__nothrow__)); extern float __tgammaf (float) __attribute__ ((__nothrow__));





extern float gammaf (float) __attribute__ ((__nothrow__)); extern float __gammaf (float) __attribute__ ((__nothrow__));






extern float lgammaf_r (float, int *__signgamp) __attribute__ ((__nothrow__)); extern float __lgammaf_r (float, int *__signgamp) __attribute__ ((__nothrow__));







extern float rintf (float __x) __attribute__ ((__nothrow__)); extern float __rintf (float __x) __attribute__ ((__nothrow__));


extern float nextafterf (float __x, float __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __nextafterf (float __x, float __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));

extern float nexttowardf (float __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __nexttowardf (float __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern float remainderf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __remainderf (float __x, float __y) __attribute__ ((__nothrow__));



extern float scalbnf (float __x, int __n) __attribute__ ((__nothrow__)); extern float __scalbnf (float __x, int __n) __attribute__ ((__nothrow__));



extern int ilogbf (float __x) __attribute__ ((__nothrow__)); extern int __ilogbf (float __x) __attribute__ ((__nothrow__));




extern float scalblnf (float __x, long int __n) __attribute__ ((__nothrow__)); extern float __scalblnf (float __x, long int __n) __attribute__ ((__nothrow__));



extern float nearbyintf (float __x) __attribute__ ((__nothrow__)); extern float __nearbyintf (float __x) __attribute__ ((__nothrow__));



extern float roundf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __roundf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern float truncf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __truncf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));




extern float remquof (float __x, float __y, int *__quo) __attribute__ ((__nothrow__)); extern float __remquof (float __x, float __y, int *__quo) __attribute__ ((__nothrow__));






extern long int lrintf (float __x) __attribute__ ((__nothrow__)); extern long int __lrintf (float __x) __attribute__ ((__nothrow__));
extern long long int llrintf (float __x) __attribute__ ((__nothrow__)); extern long long int __llrintf (float __x) __attribute__ ((__nothrow__));



extern long int lroundf (float __x) __attribute__ ((__nothrow__)); extern long int __lroundf (float __x) __attribute__ ((__nothrow__));
extern long long int llroundf (float __x) __attribute__ ((__nothrow__)); extern long long int __llroundf (float __x) __attribute__ ((__nothrow__));



extern float fdimf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __fdimf (float __x, float __y) __attribute__ ((__nothrow__));


extern float fmaxf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __fmaxf (float __x, float __y) __attribute__ ((__nothrow__));


extern float fminf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __fminf (float __x, float __y) __attribute__ ((__nothrow__));



extern int __fpclassifyf (float __value) __attribute__ ((__nothrow__))
     __attribute__ ((__const__));


extern int __signbitf (float __value) __attribute__ ((__nothrow__))
     __attribute__ ((__const__));



extern float fmaf (float __x, float __y, float __z) __attribute__ ((__nothrow__)); extern float __fmaf (float __x, float __y, float __z) __attribute__ ((__nothrow__));








extern float scalbf (float __x, float __n) __attribute__ ((__nothrow__)); extern float __scalbf (float __x, float __n) __attribute__ ((__nothrow__));
# 95 "/usr/include/math.h" 2 3 4
# 141 "/usr/include/math.h" 3 4
# 1 "/usr/include/bits/mathcalls.h" 1 3 4
# 53 "/usr/include/bits/mathcalls.h" 3 4


extern long double acosl (long double __x) __attribute__ ((__nothrow__)); extern long double __acosl (long double __x) __attribute__ ((__nothrow__));

extern long double asinl (long double __x) __attribute__ ((__nothrow__)); extern long double __asinl (long double __x) __attribute__ ((__nothrow__));

extern long double atanl (long double __x) __attribute__ ((__nothrow__)); extern long double __atanl (long double __x) __attribute__ ((__nothrow__));

extern long double atan2l (long double __y, long double __x) __attribute__ ((__nothrow__)); extern long double __atan2l (long double __y, long double __x) __attribute__ ((__nothrow__));


extern long double cosl (long double __x) __attribute__ ((__nothrow__)); extern long double __cosl (long double __x) __attribute__ ((__nothrow__));

extern long double sinl (long double __x) __attribute__ ((__nothrow__)); extern long double __sinl (long double __x) __attribute__ ((__nothrow__));

extern long double tanl (long double __x) __attribute__ ((__nothrow__)); extern long double __tanl (long double __x) __attribute__ ((__nothrow__));




extern long double coshl (long double __x) __attribute__ ((__nothrow__)); extern long double __coshl (long double __x) __attribute__ ((__nothrow__));

extern long double sinhl (long double __x) __attribute__ ((__nothrow__)); extern long double __sinhl (long double __x) __attribute__ ((__nothrow__));

extern long double tanhl (long double __x) __attribute__ ((__nothrow__)); extern long double __tanhl (long double __x) __attribute__ ((__nothrow__));

# 87 "/usr/include/bits/mathcalls.h" 3 4


extern long double acoshl (long double __x) __attribute__ ((__nothrow__)); extern long double __acoshl (long double __x) __attribute__ ((__nothrow__));

extern long double asinhl (long double __x) __attribute__ ((__nothrow__)); extern long double __asinhl (long double __x) __attribute__ ((__nothrow__));

extern long double atanhl (long double __x) __attribute__ ((__nothrow__)); extern long double __atanhl (long double __x) __attribute__ ((__nothrow__));







extern long double expl (long double __x) __attribute__ ((__nothrow__)); extern long double __expl (long double __x) __attribute__ ((__nothrow__));


extern long double frexpl (long double __x, int *__exponent) __attribute__ ((__nothrow__)); extern long double __frexpl (long double __x, int *__exponent) __attribute__ ((__nothrow__));


extern long double ldexpl (long double __x, int __exponent) __attribute__ ((__nothrow__)); extern long double __ldexpl (long double __x, int __exponent) __attribute__ ((__nothrow__));


extern long double logl (long double __x) __attribute__ ((__nothrow__)); extern long double __logl (long double __x) __attribute__ ((__nothrow__));


extern long double log10l (long double __x) __attribute__ ((__nothrow__)); extern long double __log10l (long double __x) __attribute__ ((__nothrow__));


extern long double modfl (long double __x, long double *__iptr) __attribute__ ((__nothrow__)); extern long double __modfl (long double __x, long double *__iptr) __attribute__ ((__nothrow__));

# 127 "/usr/include/bits/mathcalls.h" 3 4


extern long double expm1l (long double __x) __attribute__ ((__nothrow__)); extern long double __expm1l (long double __x) __attribute__ ((__nothrow__));


extern long double log1pl (long double __x) __attribute__ ((__nothrow__)); extern long double __log1pl (long double __x) __attribute__ ((__nothrow__));


extern long double logbl (long double __x) __attribute__ ((__nothrow__)); extern long double __logbl (long double __x) __attribute__ ((__nothrow__));






extern long double exp2l (long double __x) __attribute__ ((__nothrow__)); extern long double __exp2l (long double __x) __attribute__ ((__nothrow__));


extern long double log2l (long double __x) __attribute__ ((__nothrow__)); extern long double __log2l (long double __x) __attribute__ ((__nothrow__));








extern long double powl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __powl (long double __x, long double __y) __attribute__ ((__nothrow__));


extern long double sqrtl (long double __x) __attribute__ ((__nothrow__)); extern long double __sqrtl (long double __x) __attribute__ ((__nothrow__));





extern long double hypotl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __hypotl (long double __x, long double __y) __attribute__ ((__nothrow__));






extern long double cbrtl (long double __x) __attribute__ ((__nothrow__)); extern long double __cbrtl (long double __x) __attribute__ ((__nothrow__));








extern long double ceill (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __ceill (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double fabsl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __fabsl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double floorl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __floorl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double fmodl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __fmodl (long double __x, long double __y) __attribute__ ((__nothrow__));




extern int __isinfl (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int __finitel (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int isinfl (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int finitel (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double dreml (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __dreml (long double __x, long double __y) __attribute__ ((__nothrow__));



extern long double significandl (long double __x) __attribute__ ((__nothrow__)); extern long double __significandl (long double __x) __attribute__ ((__nothrow__));





extern long double copysignl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __copysignl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));






extern long double nanl (__const char *__tagb) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __nanl (__const char *__tagb) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int __isnanl (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern int isnanl (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double j0l (long double) __attribute__ ((__nothrow__)); extern long double __j0l (long double) __attribute__ ((__nothrow__));
extern long double j1l (long double) __attribute__ ((__nothrow__)); extern long double __j1l (long double) __attribute__ ((__nothrow__));
extern long double jnl (int, long double) __attribute__ ((__nothrow__)); extern long double __jnl (int, long double) __attribute__ ((__nothrow__));
extern long double y0l (long double) __attribute__ ((__nothrow__)); extern long double __y0l (long double) __attribute__ ((__nothrow__));
extern long double y1l (long double) __attribute__ ((__nothrow__)); extern long double __y1l (long double) __attribute__ ((__nothrow__));
extern long double ynl (int, long double) __attribute__ ((__nothrow__)); extern long double __ynl (int, long double) __attribute__ ((__nothrow__));






extern long double erfl (long double) __attribute__ ((__nothrow__)); extern long double __erfl (long double) __attribute__ ((__nothrow__));
extern long double erfcl (long double) __attribute__ ((__nothrow__)); extern long double __erfcl (long double) __attribute__ ((__nothrow__));
extern long double lgammal (long double) __attribute__ ((__nothrow__)); extern long double __lgammal (long double) __attribute__ ((__nothrow__));






extern long double tgammal (long double) __attribute__ ((__nothrow__)); extern long double __tgammal (long double) __attribute__ ((__nothrow__));





extern long double gammal (long double) __attribute__ ((__nothrow__)); extern long double __gammal (long double) __attribute__ ((__nothrow__));






extern long double lgammal_r (long double, int *__signgamp) __attribute__ ((__nothrow__)); extern long double __lgammal_r (long double, int *__signgamp) __attribute__ ((__nothrow__));







extern long double rintl (long double __x) __attribute__ ((__nothrow__)); extern long double __rintl (long double __x) __attribute__ ((__nothrow__));


extern long double nextafterl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __nextafterl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));

extern long double nexttowardl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __nexttowardl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern long double remainderl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __remainderl (long double __x, long double __y) __attribute__ ((__nothrow__));



extern long double scalbnl (long double __x, int __n) __attribute__ ((__nothrow__)); extern long double __scalbnl (long double __x, int __n) __attribute__ ((__nothrow__));



extern int ilogbl (long double __x) __attribute__ ((__nothrow__)); extern int __ilogbl (long double __x) __attribute__ ((__nothrow__));




extern long double scalblnl (long double __x, long int __n) __attribute__ ((__nothrow__)); extern long double __scalblnl (long double __x, long int __n) __attribute__ ((__nothrow__));



extern long double nearbyintl (long double __x) __attribute__ ((__nothrow__)); extern long double __nearbyintl (long double __x) __attribute__ ((__nothrow__));



extern long double roundl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __roundl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern long double truncl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __truncl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));




extern long double remquol (long double __x, long double __y, int *__quo) __attribute__ ((__nothrow__)); extern long double __remquol (long double __x, long double __y, int *__quo) __attribute__ ((__nothrow__));






extern long int lrintl (long double __x) __attribute__ ((__nothrow__)); extern long int __lrintl (long double __x) __attribute__ ((__nothrow__));
extern long long int llrintl (long double __x) __attribute__ ((__nothrow__)); extern long long int __llrintl (long double __x) __attribute__ ((__nothrow__));



extern long int lroundl (long double __x) __attribute__ ((__nothrow__)); extern long int __lroundl (long double __x) __attribute__ ((__nothrow__));
extern long long int llroundl (long double __x) __attribute__ ((__nothrow__)); extern long long int __llroundl (long double __x) __attribute__ ((__nothrow__));



extern long double fdiml (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __fdiml (long double __x, long double __y) __attribute__ ((__nothrow__));


extern long double fmaxl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __fmaxl (long double __x, long double __y) __attribute__ ((__nothrow__));


extern long double fminl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __fminl (long double __x, long double __y) __attribute__ ((__nothrow__));



extern int __fpclassifyl (long double __value) __attribute__ ((__nothrow__))
     __attribute__ ((__const__));


extern int __signbitl (long double __value) __attribute__ ((__nothrow__))
     __attribute__ ((__const__));



extern long double fmal (long double __x, long double __y, long double __z) __attribute__ ((__nothrow__)); extern long double __fmal (long double __x, long double __y, long double __z) __attribute__ ((__nothrow__));








extern long double scalbl (long double __x, long double __n) __attribute__ ((__nothrow__)); extern long double __scalbl (long double __x, long double __n) __attribute__ ((__nothrow__));
# 142 "/usr/include/math.h" 2 3 4
# 157 "/usr/include/math.h" 3 4
extern int signgam;
# 198 "/usr/include/math.h" 3 4
enum
  {
    FP_NAN,

    FP_INFINITE,

    FP_ZERO,

    FP_SUBNORMAL,

    FP_NORMAL

  };
# 284 "/usr/include/math.h" 3 4
typedef enum
{
  _IEEE_ = -1,
  _SVID_,
  _XOPEN_,
  _POSIX_,
  _ISOC_
} _LIB_VERSION_TYPE;




extern _LIB_VERSION_TYPE _LIB_VERSION;
# 309 "/usr/include/math.h" 3 4
struct exception

  {
    int type;
    char *name;
    double arg1;
    double arg2;
    double retval;
  };




extern int matherr (struct exception *__exc);
# 465 "/usr/include/math.h" 3 4

# 13 "cudagaugefix.cu" 2
# 1 "global.h" 1
# 26 "global.h"
typedef struct {
  double re;
  double im;
} complex;



typedef complex su3 [3][3];


typedef struct type_conf_info{
  int dimension[4];
  int ensemble;
  double beta,plaq;
} type_conf_info;


typedef struct type_cksum{
  unsigned long sum;
  unsigned long bytes;
  char file[80];
} type_cksum;



typedef struct SAPARAM_LIST{
  int Tmin;
  int Tmax;
  double expo;
  int N;
  int checkint;
} SAPARAM_LIST;




typedef complex spinor[12];
typedef complex propmatrix[12][12];
typedef complex fbyf[4][4];




 int T, L, LX, LY, LZ, VOLUME;
 spinor ** g_spinor_field;
 int g_precision;
 int NMASS;
 int NKSQUARE;



 int ENSEMBLE;
 double PLAQ;
 double BETA;
 int JOB;
 type_conf_info CONFINFO;
 type_cksum * CHECKSUMS;
 type_cksum * GTRAFOCHECKSUMS;
 double FUNC;
 double DADA;
 double maxDADA;

 int g_numofgpu;


 su3 * gf;
 su3 * trafo1, * trafo2;



 int * nn;
 int * dev_nn;

 int * ind;
 int * lexic2eo;

 int * eoidx_even;
 int * eoidx_odd;
 int * dev_eoidx_even;
 int * dev_eoidx_odd;


 int * nn_eo;
 int * dev_nn_eo;
 int * nn_oe;
 int * dev_nn_oe;
# 120 "global.h"
 dev_su3_2v * dev_gf;
 dev_su3_2v * dev_gf2;
 dev_su3_2v * h2d_gf;
# 132 "global.h"
 dev_su3_2v * dev_trafo1;
 dev_su3_2v * dev_trafo2;
 dev_su3_2v * h2d_trafo;
# 144 "global.h"
 double* redfield_F;
 double* redfield_dAdA;
 double* redfield_maxdAdA;
 double* redfield_plaq;


 size_t dev_spinsize;
 size_t output_size;
 int* dev_grid;
 double * dev_output;


 float * dev_rndunif_field;
 float * dev_rndgauss_field;
# 14 "cudagaugefix.cu" 2
# 1 "/usr/include/getopt.h" 1 3 4
# 59 "/usr/include/getopt.h" 3 4
extern char *optarg;
# 73 "/usr/include/getopt.h" 3 4
extern int optind;




extern int opterr;



extern int optopt;
# 106 "/usr/include/getopt.h" 3 4
struct option
{
  const char *name;


  int has_arg;
  int *flag;
  int val;
};
# 152 "/usr/include/getopt.h" 3 4
extern int getopt (int ___argc, char *const *___argv, const char *__shortopts)
       __attribute__ ((__nothrow__));
# 175 "/usr/include/getopt.h" 3 4
extern int getopt_long (int ___argc, char *const *___argv,
   const char *__shortopts,
          const struct option *__longopts, int *__longind)
       __attribute__ ((__nothrow__));
extern int getopt_long_only (int ___argc, char *const *___argv,
        const char *__shortopts,
               const struct option *__longopts, int *__longind)
       __attribute__ ((__nothrow__));
# 15 "cudagaugefix.cu" 2

# 1 "/usr/include/assert.h" 1 3 4
# 17 "cudagaugefix.cu" 2
# 1 "dev_su3.h" 1





__device__ inline dev_complex dev_cconj (dev_complex c);
__device__ inline void dev_ccopy(dev_complex* von, dev_complex* nach);
__device__ inline double dev_cabssquare (dev_complex c);
__device__ inline double dev_cabsolute (dev_complex c);
__device__ inline dev_complex dev_crealmult(dev_complex c1, double real);
__device__ inline dev_complex dev_cmult (dev_complex c1, dev_complex c2);
__device__ inline dev_complex dev_cadd (dev_complex c1, dev_complex c2);
__device__ inline dev_complex dev_cdiv(dev_complex c1, dev_complex c2);
__device__ inline dev_complex dev_csub(dev_complex c1, dev_complex c2);
__device__ inline dev_complex dev_initcomplex(double re, double im);
__device__ void dev_storetrafo_2v(int pos, dev_su3_2v* trafofield , dev_su3* g);
__device__ void dev_storegf_2v(int pos, dev_su3_2v* gfield , dev_su3* U);
__device__ void dev_storegf_8(int pos, dev_su3_2v* trafofield , dev_su3* U);
__device__ void dev_storetrafo_8(int pos, dev_su3_2v* gfield , dev_su3* g);
__inline__ __device__ double2 tex1Dfetch_gf(const int& i);
__inline__ __device__ double2 tex1Dfetch_trafo(const int& i);
__device__ void dev_reconstructgf_2vtexref (dev_su3_2v * field, int pos, dev_su3* gf);
__device__ void dev_reconstructgf_2vtexref_dagger (dev_su3_2v * field, int pos, dev_su3* gf);
__device__ void dev_reconstructgf_8texref (dev_su3_8 * field, int pos, dev_su3* gf);
__device__ void dev_reconstructgf_8texref_dagger (dev_su3_8 * field, int pos, dev_su3* gf);
__device__ void dev_reconstructtrafo_2vtexref (dev_su3_2v * field, int pos, dev_su3* gf);
__device__ void dev_reconstructtrafo_2vtexref_dagger (dev_su3_2v * field, int pos, dev_su3* gf);
__device__ void dev_reconstructtrafo_8texref (dev_su3_8 * field, int pos, dev_su3* gf);
__device__ void dev_reconstructtrafo_8texref_dagger (dev_su3_8 * field, int pos, dev_su3* gf);


extern "C" void show_su3_2v(dev_su3_2v * M);


__device__ void dev_su3zero(dev_su3* M);
__device__ void dev_su3dagger(dev_su3 * erg, dev_su3 * M);
__device__ dev_complex dev_su3trace(dev_su3 * M);
__device__ double dev_su3Retrace(dev_su3 * M);
__device__ void dev_su3skalarmult(dev_su3 * erg, dev_complex skalar, dev_su3 * M);
__device__ void dev_su3copy( dev_su3 * to, dev_su3 * from);
__device__ void dev_su3_ti_su3(dev_su3* u, dev_su3 * v, dev_su3 * w);
__device__ void dev_add_su3_ti_su3(dev_su3* u, dev_su3 * v, dev_su3 * w);
__device__ void dev_su3_ti_su3d(dev_su3* u, dev_su3 * v, dev_su3 * w);
__device__ void dev_su3_sub(dev_su3* a, dev_su3* b);
__device__ void dev_su3_sub_assign(dev_su3* c,dev_su3* a, dev_su3* b);
__device__ void dev_su3_add(dev_su3* a, dev_su3* b);
__device__ void dev_su3_add_assign(dev_su3* c, dev_su3* a, dev_su3* b);
__device__ void dev_su3_real_mult(dev_su3* a, double R);
__device__ void dev_su3_real_mult_assign(dev_su3* erg, dev_su3* a, double R);
__device__ void dev_su3_assign(dev_su3* a, dev_su3* b);
__device__ void dev_su3_normalize(dev_su3* u);



extern "C" int bind_texture_gf(dev_su3_2v * gfield);
extern "C" int unbind_texture_gf();
extern "C" int bind_texture_trafo(dev_su3_2v * trafofield);
extern "C" int unbind_texture_trafo();
# 18 "cudagaugefix.cu" 2

extern "C" {
# 1 "complex.h" 1



complex cconj (complex c);
void ccopy(complex* von, complex* nach);
double cabssquare (complex c);
double cabsolute (complex c);
void showcomplex(complex c);
complex initcomplex(double re, double im);
complex crealmult(complex c1, double real);
complex cmult (complex c1, complex c2);
complex cdiv(complex c1, complex c2);
complex cadd (complex c1, complex c2);
complex csub(complex c1, complex c2);
void host_add_spinor_field(spinor* s1, spinor* s2, spinor* so);
double host_skalarprod_spinor_field(spinor* s1, spinor* s2);
void host_skalarmult_spinor_field(spinor* s1, complex alpha, spinor* so);
# 21 "cudagaugefix.cu" 2
# 1 "gauge_io.h" 1



# 1 "/usr/local/include/lime.h" 1 3



# 1 "/usr/local/include/lime_config.h" 1 3
# 15 "/usr/local/include/lime_config.h" 3
# 1 "/usr/local/include/lime_config_internal.h" 1 3
# 16 "/usr/local/include/lime_config.h" 2 3


static const char* const LIME_PACKAGE = "lime";
static const char* const LIME_PACKAGE_BUGREPORT = "detar@physics.utah.edu";
static const char* const LIME_PACKAGE_NAME = "lime";
static const char* const LIME_PACKAGE_STRING = "lime 1.3.2";
static const char* const LIME_PACKAGE_TARNAME = "lime";
static const char* const LIME_PACKAGE_VERSION = "1.3.2";
# 5 "/usr/local/include/lime.h" 2 3
# 1 "/usr/local/include/dcap-overload.h" 1 3
# 6 "/usr/local/include/lime.h" 2 3
# 1 "/usr/local/include/lime_defs.h" 1 3
# 7 "/usr/local/include/lime.h" 2 3
# 1 "/usr/local/include/lime_header.h" 1 3





# 1 "/usr/local/include/lime_fixed_types.h" 1 3



# 1 "/usr/local/include/lime_config.h" 1 3
# 5 "/usr/local/include/lime_fixed_types.h" 2 3





# 1 "/usr/include/stdint.h" 1 3 4
# 27 "/usr/include/stdint.h" 3 4
# 1 "/usr/include/bits/wchar.h" 1 3 4
# 28 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/stdint.h" 2 3 4
# 49 "/usr/include/stdint.h" 3 4
typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;

typedef unsigned int uint32_t;



typedef unsigned long int uint64_t;
# 66 "/usr/include/stdint.h" 3 4
typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef int int_least32_t;

typedef long int int_least64_t;






typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;

typedef unsigned long int uint_least64_t;
# 91 "/usr/include/stdint.h" 3 4
typedef signed char int_fast8_t;

typedef long int int_fast16_t;
typedef long int int_fast32_t;
typedef long int int_fast64_t;
# 104 "/usr/include/stdint.h" 3 4
typedef unsigned char uint_fast8_t;

typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long int uint_fast64_t;
# 120 "/usr/include/stdint.h" 3 4
typedef long int intptr_t;


typedef unsigned long int uintptr_t;
# 135 "/usr/include/stdint.h" 3 4
typedef long int intmax_t;
typedef unsigned long int uintmax_t;
# 11 "/usr/local/include/lime_fixed_types.h" 2 3


typedef uint16_t n_uint16_t;





typedef uint32_t n_uint32_t;





typedef uint64_t n_uint64_t;
# 7 "/usr/local/include/lime_header.h" 2 3


typedef struct {
  unsigned int lime_version;
  int MB_flag;
  int ME_flag;
  char *type;
  n_uint64_t data_length;
} LimeRecordHeader;





LimeRecordHeader *limeCreateHeader(int MB_flag,
       int ME_flag,
       char *type,
       n_uint64_t reclen);

void limeDestroyHeader(LimeRecordHeader *h);
# 8 "/usr/local/include/lime.h" 2 3
# 1 "/usr/local/include/lime_writer.h" 1 3
# 10 "/usr/local/include/lime_writer.h" 3
typedef struct {
  int first_record;
  int last_written;
  FILE* fp;
  int header_nextP;
  n_uint64_t bytes_total;
  n_uint64_t bytes_left;

  n_uint64_t rec_ptr;


  n_uint64_t rec_start;
  size_t bytes_pad;
  int isLastP;
} LimeWriter;







LimeWriter* limeCreateWriter(FILE *fp);


int limeDestroyWriter(LimeWriter *s);
# 46 "/usr/local/include/lime_writer.h" 3
int limeWriteRecordHeader( LimeRecordHeader *props, LimeWriter* d);
# 55 "/usr/local/include/lime_writer.h" 3
int limeWriteRecordData( void *source, n_uint64_t *nbytes, LimeWriter* d);





int limeWriterCloseRecord(LimeWriter *w);
# 70 "/usr/local/include/lime_writer.h" 3
int limeWriterSeek(LimeWriter *r, off_t offset, int whence);







int limeWriterSetState(LimeWriter *wdest, LimeWriter *wsrc);
# 9 "/usr/local/include/lime.h" 2 3
# 1 "/usr/local/include/lime_reader.h" 1 3
# 11 "/usr/local/include/lime_reader.h" 3
typedef struct {
  int first_read;
  int is_last;
  int header_nextP;
  FILE *fp;
  LimeRecordHeader *curr_header;

  n_uint64_t bytes_left;
  n_uint64_t bytes_total;
  n_uint64_t rec_ptr;


  n_uint64_t rec_start;
  size_t bytes_pad;
} LimeReader;






LimeReader* limeCreateReader(FILE *fp);







int limeSetReaderPointer(LimeReader *r, off_t offset);





off_t limeGetReaderPointer(LimeReader *r);





void limeDestroyReader(LimeReader *r);
# 71 "/usr/local/include/lime_reader.h" 3
int limeReaderNextRecord(LimeReader *r);





int limeReaderMBFlag(LimeReader *r);





int limeReaderMEFlag(LimeReader *r);





char *limeReaderType(LimeReader *r);





n_uint64_t limeReaderBytes(LimeReader *r);





size_t limeReaderPadBytes(LimeReader *r);
# 112 "/usr/local/include/lime_reader.h" 3
int limeReaderReadData(void *dest, n_uint64_t *nbytes, LimeReader *r);





int limeReaderCloseRecord(LimeReader *r);
# 127 "/usr/local/include/lime_reader.h" 3
int limeReaderSeek(LimeReader *r, off_t offset, int whence);







int limeReaderSetState(LimeReader *rdest, LimeReader *rsrc );

int limeEOM(LimeReader *r);
# 10 "/usr/local/include/lime.h" 2 3
# 5 "gauge_io.h" 2


void byte_swap_assign_double(void * out_ptr, void * in_ptr, int nmemb);
void byte_swap_assign_float(void * out_ptr, void * in_ptr, int nmemb);
int getXmlEntry(char* searchstring, char* tagname, char* content);
int get_unformatted_entry(char* searchstring,char* tagname, char* content);
void showsu3(su3 M);

int write_ildg_format_xml(char *filename, LimeWriter * limewriter, const int prec);
int read_gf_header_ildg(char* filename);
int write_gf_ildg(su3 * gf, char * filename, const int prec);
int read_gf_ildg(su3 * gf , char* filename);

int read_gf_bqcd(su3 * gf,char* basefilename , type_conf_info confinfo, type_cksum cksums[]);
int write_gf_bqcd( su3 * gf,char * basefilename);
int write_conf_info(char* filename, type_conf_info confinfo, type_cksum cksums[]);
int read_conf_info(char* filename,type_conf_info confinfo);

int read_gtrafo_info(char* filename, type_conf_info confinfo,int firstbest);
int calculate_cksums_trafo(type_cksum cksums[],char* basefilename, su3 * trafofield);
int read_trafo_bqcd(su3 * trafofield ,char* basefilename , type_cksum cksums[]);




void transpose_gf(su3* gf);
void transpose_trafo(su3* trafo);

void swap_directions_gf(su3* gf);
# 22 "cudagaugefix.cu" 2
# 1 "rngs.h" 1
# 12 "rngs.h"
double Random(void);
void PlantSeeds(long x);
void GetSeed(long *x);
void PutSeed(long x);
void SelectStream(int index);
void TestRandom(void);
# 23 "cudagaugefix.cu" 2
# 1 "su3manip.h" 1





void su3zero(su3* M);
void su3mult(su3* erg, su3 * M1, su3 * M2);
void su3dagger(su3 * erg, su3 * M);
complex su3trace( su3 * M);
void su3sub(su3* erg, su3 * M1, su3 * M2);
void su3skalarmult(su3* erg,complex skalar, su3 * M);
void su3copy(su3 * to, su3 * from);
void show_su3(su3 * M);
complex su3_det(su3 * M);

void su3to2v(su3* gf, dev_su3_2v* h2d_gf);
void su3to8(su3* gf, dev_su3_8* h2d_gf);
void su3to8_trafo(su3* gf, dev_su3_8* h2d_gf);
void su3to2v_trafo(su3* gf, dev_su3_2v* h2d_gf);
void from8tosu3_trafo(su3* g, dev_su3_2v* h2d);
void from2vtosu3_trafo(su3* g, dev_su3_2v* h2d);

void unit_init_trafo(su3 * trafofield);
void random_init_trafo(su3 * trafofield);
void random_init_su3(su3 * M);
# 24 "cudagaugefix.cu" 2
# 1 "observables.h" 1




void su3zero(su3* M);
void su3mult(su3* erg, su3 * M1, su3 * M2);
void su3dagger(su3*erg, su3 * M);
complex su3trace(su3 * M);
void su3add(su3* erg, su3 * M1, su3 * M2);
void su3skalarmult(su3* erg,complex skalar, su3 * M);
void su3sub(su3* erg, su3 * M1, su3 * M2);
void vectorpotential(su3 *A, su3 * U);

double dAdA(su3 * gf);



void su3copy(su3 * to,su3 * from );
double mean_plaq(su3 * gf);
double mean_plaq_bqcd(su3 * gf);
double first_plaq(su3* gf);
double gauge_functional(su3* gf);
void g_trafo(su3* u, su3 * g);
# 25 "cudagaugefix.cu" 2
# 1 "read_input.h" 1




int read_input(char * conf_file);

extern int randseed;
extern int orxmaxit;
extern int orxcheckinterval;
extern double orxeps;
extern SAPARAM_LIST saparam;
extern int saflag;
extern int orxflag;
# 26 "cudagaugefix.cu" 2
}
# 43 "cudagaugefix.cu"
__device__ dev_su3 *dev_M1, *dev_M2, *dev_erg1, *dev_erg2;
__device__ int dev_LX,dev_LY,dev_LZ,dev_T,dev_VOLUME;



# 1 "MersenneTwister.cu" 1
# 23 "MersenneTwister.cu"
# 1 "MersenneTwister.h" 1
# 27 "MersenneTwister.h"
typedef struct{
    unsigned int matrix_a;
    unsigned int mask_b;
    unsigned int mask_c;
    unsigned int seed;
} mt_struct_stripped;
# 47 "MersenneTwister.h"
extern "C" void init_MT(int n_gaussnumbers, int n_unifnumbers);
extern "C" void update_MT();
extern "C" void finalize_MT();
# 24 "MersenneTwister.cu" 2







extern "C" int iDivUp(int a, int b){
    return ((a % b) != 0) ? (a / b + 1) : (a / b);
}


extern "C" int iDivDown(int a, int b){
    return a / b;
}


extern "C" int iAlignUp(int a, int b){
    return ((a % b) != 0) ? (a - a % b + b) : a;
}


extern "C" int iAlignDown(int a, int b){
    return a - a % b;
}






static int PATH_N_GAUSS;
static int PATH_N_UNIF;
static int N_PER_RNG_GAUSS;
static int N_PER_RNG_UNIF;
static int RAND_N_GAUSS;
static int RAND_N_UNIF;





__device__ mt_struct_stripped ds_MT[4096];
static mt_struct_stripped h_MT[4096];
__device__ unsigned int d_mtstatus[4096][19];
# 79 "MersenneTwister.cu"
void loadMTGPU(const char *fname){
    FILE *fd = fopen(fname, "rb");
    if(!fd){
        printf("initMTGPU(): failed to open %s\n", fname);
        printf("FAILED\n");
        exit(0);
    }
    if( !fread(h_MT, sizeof(h_MT), 1, fd) ){
        printf("initMTGPU(): failed to load %s\n", fname);
        printf("FAILED\n");
        exit(0);
    }
    fclose(fd);
}





void seedMTGPU(){
    int i;

    mt_struct_stripped *MT = (mt_struct_stripped *)malloc(4096 * sizeof(mt_struct_stripped));


    srand ( time(((void *)0)) );


    for(i = 0; i < 4096; i++){
        MT[i] = h_MT[i];
        MT[i].seed = (unsigned int) rand();
    }
    { cudaError err = cudaMemcpyToSymbol(ds_MT, MT, sizeof(h_MT)); if( cudaSuccess != err) { fprintf(stderr, "Cuda error : %s.\n", cudaGetErrorString( err) ); exit(1); } };

    free(MT);
}




void saveMTGPU(const char *fname){
    FILE *fd = fopen(fname, "w");
    if(!fd){
        printf("saveMTGPU(): failed to open %s\n", fname);
        printf("FAILED\n");
        exit(0);
    }
    fwrite(h_MT, sizeof(h_MT), 1, fd);
    fclose(fd);
}
# 142 "MersenneTwister.cu"
__global__ void RandomGPU(
    float *d_Random,
    int NPerRng, int initialized
){
    const int tid = blockDim.x * blockIdx.x + threadIdx.x;
    const int THREAD_N = blockDim.x * gridDim.x;

    int iState, iState1, iStateM, iOut;
    unsigned int mti, mti1, mtiM, x;
    unsigned int mt[19];

    for(int iRng = tid; iRng < 4096; iRng += THREAD_N){

        mt_struct_stripped config = ds_MT[iRng];

       if(!initialized){

         mt[0] = ds_MT[iRng].seed;
         for(iState = 1; iState < 19; iState++)
            mt[iState] = (1812433253U * (mt[iState - 1] ^ (mt[iState - 1] >> 30)) + iState) & 0xFFFFFFFFU;
       }
       else{
         for(iState = 0; iState < 19; iState++) mt[iState] = d_mtstatus[iRng][iState];
       }

        iState = 0;
        mti1 = mt[0];
        for(iOut = 0; iOut < NPerRng; iOut++){


            iState1 = iState + 1;
            iStateM = iState + 9;
            if(iState1 >= 19) iState1 -= 19;
            if(iStateM >= 19) iStateM -= 19;
            mti = mti1;
            mti1 = mt[iState1];
            mtiM = mt[iStateM];

            x = (mti & 0xFFFFFFFEU) | (mti1 & 0x1U);
            x = mtiM ^ (x >> 1) ^ ((x & 1) ? config.matrix_a : 0);
            mt[iState] = x;
            iState = iState1;


            x ^= (x >> 12);
            x ^= (x << 7) & config.mask_b;
            x ^= (x << 15) & config.mask_c;
            x ^= (x >> 18);


            d_Random[iRng + iOut * 4096] = ((float)x + 1.0f) / 4294967296.0f;
        }


       ds_MT[iRng].seed = mt[0];
       for(iState = 0; iState < 19; iState++) d_mtstatus[iRng][iState] = mt[iState];
    }
}
# 210 "MersenneTwister.cu"
__device__ inline void BoxMuller(float& u1, float& u2){
    float r = sqrtf(-2.0f * logf(u1));
    float phi = 2 * 3.14159265358979f * u2;
    u1 = r * __cosf(phi);
    u2 = r * __sinf(phi);
}



__global__ void BoxMullerGPU(float *d_Random, int NPerRng){
    const int tid = blockDim.x * blockIdx.x + threadIdx.x;
    const int THREAD_N = blockDim.x * gridDim.x;

    for(int iRng = tid; iRng < 4096; iRng += THREAD_N)
        for(int iOut = 0; iOut < NPerRng; iOut += 2)
            BoxMuller(
                d_Random[iRng + (iOut + 0) * 4096],
                d_Random[iRng + (iOut + 1) * 4096]
            );
}






extern "C" void init_MT(int n_gaussnumbers, int n_unifnumbers){


  PATH_N_GAUSS = n_gaussnumbers;
  N_PER_RNG_GAUSS = iAlignUp(iDivUp(PATH_N_GAUSS, 4096), 2);
  RAND_N_GAUSS = 4096 * N_PER_RNG_GAUSS;
  printf("No. of gauss random numbers: %d\n", RAND_N_GAUSS );


  PATH_N_UNIF = n_unifnumbers;
  N_PER_RNG_UNIF = iAlignUp(iDivUp(PATH_N_UNIF, 4096), 2);
  RAND_N_UNIF = 4096 * N_PER_RNG_UNIF;
  printf("No. of unif. dist. random numbers: %d\n", RAND_N_UNIF );



  const char *dat_path = "MersenneTwister.dat";
  printf("Loading GPU twisters configurations from file %s...\n", dat_path);
  loadMTGPU(dat_path);
  seedMTGPU();


  printf("Allocating device memory for random numbers...\n");
  { cudaError err = cudaMalloc((void **)&dev_rndgauss_field, RAND_N_GAUSS * sizeof(float)); if( cudaSuccess != err) { fprintf(stderr, "Cuda error : %s.\n", cudaGetErrorString( err) ); exit(1); } };
  { cudaError err = cudaMalloc((void **)&dev_rndunif_field, RAND_N_UNIF * sizeof(float)); if( cudaSuccess != err) { fprintf(stderr, "Cuda error : %s.\n", cudaGetErrorString( err) ); exit(1); } };




    cudaThreadSynchronize();
    RandomGPU<<<32, 128>>>(dev_rndgauss_field, N_PER_RNG_GAUSS,0);
    BoxMullerGPU<<<32, 128>>>(dev_rndgauss_field, N_PER_RNG_GAUSS);


    cudaThreadSynchronize();
    RandomGPU<<<32, 128>>>(dev_rndunif_field, N_PER_RNG_UNIF,0);
    cudaThreadSynchronize();


}





extern "C" void update_MT(){



    cudaThreadSynchronize();
    RandomGPU<<<32, 128>>>(dev_rndgauss_field, N_PER_RNG_GAUSS,1);
    BoxMullerGPU<<<32, 128>>>(dev_rndgauss_field, N_PER_RNG_GAUSS);
    cudaThreadSynchronize();



    RandomGPU<<<32, 128>>>(dev_rndunif_field, N_PER_RNG_UNIF, 1);
    cudaThreadSynchronize();
}



extern "C" void finalize_MT(){
  cudaFree(dev_rndgauss_field);
  cudaFree(dev_rndunif_field);
}
# 49 "cudagaugefix.cu" 2
# 1 "dev_su3.cu" 1




 texture<int4,1> gf_tex;
 const textureReference* gf_texRefPtr = ((void *)0);
 cudaChannelFormatDesc gf_channelDesc;


 texture<int4,1> trafo_tex;
 const textureReference* trafo_texRefPtr = ((void *)0);
 cudaChannelFormatDesc trafo_channelDesc;




__device__ inline dev_complex dev_cconj (dev_complex c){
 dev_complex erg;
 erg.re = c.re;
 erg.im = -1.0*c.im;
return erg;
}

__device__ inline void dev_ccopy(dev_complex* von, dev_complex* nach){
  nach->re = von->re;
  nach->im = von->im;
}

__device__ inline double dev_cabssquare (dev_complex c){
 return c.re*c.re + c.im*c.im;
}

__device__ inline double dev_cabsolute (dev_complex c){
 return sqrt(c.re*c.re + c.im*c.im);
}



__device__ inline dev_complex dev_crealmult(dev_complex c1, double real){
  dev_complex erg;
  erg.re = real*c1.re;
  erg.im = real*c1.im;
return erg;
}

__device__ inline dev_complex dev_cmult (dev_complex c1, dev_complex c2){
  dev_complex erg;
  erg.re = c1.re * c2.re - c1.im * c2.im;
  erg.im = c1.re * c2.im + c1.im * c2.re;
return erg;
}

__device__ inline dev_complex dev_cadd (dev_complex c1, dev_complex c2){
  dev_complex erg;
  erg.re = c1.re + c2.re;
  erg.im = c1.im + c2.im;
return erg;
}


__device__ inline dev_complex dev_cdiv(dev_complex c1, dev_complex c2) {
  dev_complex erg;
  double oneovernenner = 1.0/(c2.re*c2.re + c2.im*c2.im);
  erg.re = oneovernenner*(c1.re*c2.re + c1.im*c2.im);
  erg.im = oneovernenner*(c1.im*c2.re - c1.re*c2.im);
return erg;
}


__device__ inline dev_complex dev_csub(dev_complex c1, dev_complex c2){
   dev_complex erg;
   erg.re = c1.re - c2.re;
   erg.im = c1.im - c2.im;
return erg;
}


__device__ inline dev_complex dev_initcomplex(double re, double im){
    dev_complex erg;
    erg.re = re;
    erg.im = im;
return (erg);
}



__device__ void dev_unitsu3(dev_su3 * g){
  (*g)[0][0].re = 1.0;
  (*g)[0][0].im = 0.0;
  (*g)[0][1].re = 0.0;
  (*g)[0][1].im = 0.0;
  (*g)[0][2].re = 0.0;
  (*g)[0][2].im = 0.0;

  (*g)[1][0].re = 0.0;
  (*g)[1][0].im = 0.0;
  (*g)[1][1].re = 1.0;
  (*g)[1][1].im = 0.0;
  (*g)[1][2].re = 0.0;
  (*g)[1][2].im = 0.0;

  (*g)[2][0].re = 0.0;
  (*g)[2][0].im = 0.0;
  (*g)[2][1].re = 0.0;
  (*g)[2][1].im = 0.0;
  (*g)[2][2].re = 1.0;
  (*g)[2][2].im = 0.0;

}
# 118 "dev_su3.cu"
__device__ void dev_storetrafo_2v(int pos, dev_su3_2v* trafofield , dev_su3* g){

   trafofield[6*pos].x = (*g)[0][0].re;
   trafofield[6*pos].y = (*g)[0][0].im;
   trafofield[6*pos+1].x = (*g)[0][1].re;
   trafofield[6*pos+1].y = (*g)[0][1].im;

   trafofield[6*pos+2].x = (*g)[0][2].re;
   trafofield[6*pos+2].y = (*g)[0][2].im;
   trafofield[6*pos+3].x = (*g)[1][0].re;
   trafofield[6*pos+3].y = (*g)[1][0].im;

   trafofield[6*pos+4].x = (*g)[1][1].re;
   trafofield[6*pos+4].y = (*g)[1][1].im;
   trafofield[6*pos+5].x = (*g)[1][2].re;
   trafofield[6*pos+5].y = (*g)[1][2].im;

}


__device__ void dev_storegf_2v(int pos, dev_su3_2v* gfield , dev_su3* U){

   gfield[6*pos].x = (*U)[0][0].re;
   gfield[6*pos].y = (*U)[0][0].im;
   gfield[6*pos+1].x = (*U)[0][1].re;
   gfield[6*pos+1].y = (*U)[0][1].im;

   gfield[6*pos+2].x = (*U)[0][2].re;
   gfield[6*pos+2].y = (*U)[0][2].im;
   gfield[6*pos+3].x = (*U)[1][0].re;
   gfield[6*pos+3].y = (*U)[1][0].im;

   gfield[6*pos+4].x = (*U)[1][1].re;
   gfield[6*pos+4].y = (*U)[1][1].im;
   gfield[6*pos+5].x = (*U)[1][2].re;
   gfield[6*pos+5].y = (*U)[1][2].im;

}




__device__ void dev_storegf_8(int pos, dev_su3_2v* trafofield , dev_su3* U){



    trafofield[4*pos].x = (*U)[0][1].re;
    trafofield[4*pos].y = (*U)[0][1].im;
    trafofield[4*pos+1].x = (*U)[0][2].re;
    trafofield[4*pos+1].y = (*U)[0][2].im;



   trafofield[4*pos+2].x = ( atan2((*U)[0][0].im, (*U)[0][0].re ));
   trafofield[4*pos+2].y = ( atan2((*U)[2][0].im, (*U)[2][0].re ));


    trafofield[4*pos+3].x = (*U)[1][0].re ;
    trafofield[4*pos+3].y = (*U)[1][0].im ;

}



__device__ void dev_storetrafo_8(int pos, dev_su3_2v* gfield , dev_su3* g){



    gfield[4*pos].x = (*g)[0][1].re;
    gfield[4*pos].y = (*g)[0][1].im;
    gfield[4*pos+1].x = (*g)[0][2].re;
    gfield[4*pos+1].y = (*g)[0][2].im;



   gfield[4*pos+2].x = ( atan2((*g)[0][0].im, (*g)[0][0].re ));
   gfield[4*pos+2].y = ( atan2((*g)[2][0].im, (*g)[2][0].re ));


    gfield[4*pos+3].x = (*g)[1][0].re ;
    gfield[4*pos+3].y = (*g)[1][0].im ;

}







__inline__ __device__ double2 tex1Dfetch_gf(const int& i)
{
int4 v=tex1Dfetch(gf_tex, i);
return make_double2(__hiloint2double(v.y, v.x),__hiloint2double(v.w, v.z));
}

__inline__ __device__ double2 tex1Dfetch_trafo(const int& i)
{
int4 v=tex1Dfetch(trafo_tex, i);
return make_double2(__hiloint2double(v.y, v.x),__hiloint2double(v.w, v.z));
}






__device__ void dev_reconstructgf_2vtexref (dev_su3_2v * field, int pos, dev_su3* gf){
  dev_complex help1;
  dev_complex help2;
  double2 gfin;





    gfin = field[6*pos];



  (*gf)[0][0].re = gfin.x;
  (*gf)[0][0].im = gfin.y;




    gfin = field[6*pos+1];

  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = gfin.y;






    gfin = field[6*pos+2];

  (*gf)[0][2].re = gfin.x;
  (*gf)[0][2].im = gfin.y;






    gfin = field[6*pos+3];


  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = gfin.y;





    gfin = field[6*pos+4];

  (*gf)[1][1].re = gfin.x;
  (*gf)[1][1].im = gfin.y;





    gfin = field[6*pos+5];

  (*gf)[1][2].re = gfin.x;
  (*gf)[1][2].im = gfin.y;


  help1 = dev_cmult((*gf)[0][1],(*gf)[1][2]);
  help2 = dev_cmult((*gf)[0][2],(*gf)[1][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[2][0] = help1;


  help1 = dev_cmult((*gf)[0][2],(*gf)[1][0]);
  help2 = dev_cmult((*gf)[0][0],(*gf)[1][2]);
  help1 = dev_cconj(dev_csub(help1,help2));

  (*gf)[2][1] = help1;

  help1 = dev_cmult((*gf)[0][0],(*gf)[1][1]);
  help2 = dev_cmult((*gf)[0][1],(*gf)[1][0]);
  help1 = dev_cconj(dev_csub(help1,help2));

  (*gf)[2][2] = help1;

  return;
}





__device__ void dev_reconstructgf_2vtexref_dagger (dev_su3_2v * field, int pos, dev_su3* gf){
  dev_complex help1;
  dev_complex help2;
  double2 gfin;
# 326 "dev_su3.cu"
    gfin = field[6*pos];

  (*gf)[0][0].re = gfin.x;
  (*gf)[0][0].im = -gfin.y;





    gfin = field[6*pos+1];

  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = -gfin.y;





    gfin = field[6*pos+2];

  (*gf)[2][0].re = gfin.x;
  (*gf)[2][0].im = -gfin.y;






    gfin = field[6*pos+3];


  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = -gfin.y;





    gfin = field[6*pos+4];

  (*gf)[1][1].re = gfin.x;
  (*gf)[1][1].im = -gfin.y;





    gfin = field[6*pos+5];

  (*gf)[2][1].re = gfin.x;
  (*gf)[2][1].im = -gfin.y;



  help1 = dev_cconj(dev_cmult((*gf)[1][0],(*gf)[2][1]));
  help2 = dev_cconj(dev_cmult((*gf)[2][0],(*gf)[1][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[0][2] = help1;


  help1 = dev_cconj(dev_cmult((*gf)[2][0],(*gf)[0][1]));
  help2 = dev_cconj(dev_cmult((*gf)[0][0],(*gf)[2][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[1][2] = help1;


  help1 = dev_cconj(dev_cmult((*gf)[0][0],(*gf)[1][1]));
  help2 = dev_cconj(dev_cmult((*gf)[1][0],(*gf)[0][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[2][2] = help1;
# 416 "dev_su3.cu"
}
# 428 "dev_su3.cu"
__device__ void dev_reconstructgf_8texref (dev_su3_8 * field, int pos, dev_su3* gf){

  double2 gfin, gfin2;
  double one_over_N, help;
  dev_complex p1,p2;





    gfin = field[4*pos];


  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = gfin.y;





    gfin2 = field[4*pos+1];

  (*gf)[0][2].re = gfin2.x;
  (*gf)[0][2].im = gfin2.y;

  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y;
  one_over_N = rsqrt(p1.re);






    gfin = field[4*pos+2];






    gfin2 = field[4*pos+3];



  p1.re = sqrt(1.0 - p1.re);


  sincos(gfin.x, &(*gf)[0][0].im, &(*gf)[0][0].re);
  (*gf)[0][0].re = (*gf)[0][0].re * p1.re;
  (*gf)[0][0].im = (*gf)[0][0].im * p1.re;




  (*gf)[1][0].re = gfin2.x;
  (*gf)[1][0].im = gfin2.y;


  p2.re = one_over_N*(*gf)[1][0].re;
  p2.im = one_over_N*(*gf)[1][0].im;



  p1.re = sqrt(1.0 -
              (*gf)[0][0].re * (*gf)[0][0].re - (*gf)[0][0].im * (*gf)[0][0].im -
              (*gf)[1][0].re * (*gf)[1][0].re - (*gf)[1][0].im * (*gf)[1][0].im
          );

  sincos(gfin.y, &(*gf)[2][0].im, &(*gf)[2][0].re);
  (*gf)[2][0].re = (*gf)[2][0].re * p1.re;
  (*gf)[2][0].im = (*gf)[2][0].im * p1.re;




  p1.re = one_over_N*(*gf)[2][0].re;
  p1.im = - one_over_N*(*gf)[2][0].im;







  (*gf)[1][1].re = p1.re*(*gf)[0][2].re;
  (*gf)[1][1].re += p1.im*(*gf)[0][2].im;
  (*gf)[1][1].im = p1.im*(*gf)[0][2].re;
  (*gf)[1][1].im -= p1.re*(*gf)[0][2].im;

  (*gf)[2][2].re = (*gf)[0][0].re * (*gf)[0][1].re;
  (*gf)[2][2].re += (*gf)[0][0].im * (*gf)[0][1].im;

  (*gf)[2][2].im = (*gf)[0][0].re * (*gf)[0][1].im;
  (*gf)[2][2].im -= (*gf)[0][0].im * (*gf)[0][1].re;
  (*gf)[2][2] = dev_cmult(p2, (*gf)[2][2]);

  (*gf)[1][1].re = -one_over_N*( (*gf)[1][1].re + (*gf)[2][2].re);
  (*gf)[1][1].im = -one_over_N*((*gf)[1][1].im + (*gf)[2][2].im);






  (*gf)[1][2].re = p1.re*(*gf)[0][1].re;
  (*gf)[1][2].re += p1.im*(*gf)[0][1].im;
  (*gf)[1][2].im = p1.im*(*gf)[0][1].re;
  (*gf)[1][2].im -= p1.re*(*gf)[0][1].im;

  (*gf)[2][2].re = (*gf)[0][0].re*(*gf)[0][2].re;
  (*gf)[2][2].re += (*gf)[0][0].im*(*gf)[0][2].im;
  (*gf)[2][2].im = (*gf)[0][0].re*(*gf)[0][2].im;
  (*gf)[2][2].im -= (*gf)[0][0].im*(*gf)[0][2].re;
  (*gf)[2][2] = dev_cmult(p2,(*gf)[2][2]);

  (*gf)[1][2].re = one_over_N*( (*gf)[1][2].re - (*gf)[2][2].re);
  (*gf)[1][2].im = one_over_N*( (*gf)[1][2].im - (*gf)[2][2].im);



  (*gf)[2][1].re = p2.re*(*gf)[0][2].re;
  (*gf)[2][1].re -= p2.im*(*gf)[0][2].im;
  (*gf)[2][1].im = -p2.re*(*gf)[0][2].im;
  (*gf)[2][1].im -= p2.im*(*gf)[0][2].re;



  (*gf)[2][2].re = (*gf)[0][0].re*(*gf)[0][1].re;
  (*gf)[2][2].re += (*gf)[0][0].im*(*gf)[0][1].im;
  (*gf)[2][2].im = (*gf)[0][0].re* (*gf)[0][1].im;
  (*gf)[2][2].im -= (*gf)[0][0].im* (*gf)[0][1].re;
  help = (*gf)[2][2].re;
  (*gf)[2][2].re = p1.re*(*gf)[2][2].re;
  (*gf)[2][2].re += p1.im*(*gf)[2][2].im;
  (*gf)[2][2].im = p1.re*(*gf)[2][2].im - p1.im*help;


  (*gf)[2][1].re = one_over_N*((*gf)[2][1].re - (*gf)[2][2].re);
  (*gf)[2][1].im = one_over_N*((*gf)[2][1].im - (*gf)[2][2].im);





  (*gf)[2][2].re = p2.re * (*gf)[0][1].re;
  (*gf)[2][2].re -= p2.im * (*gf)[0][1].im;
  (*gf)[2][2].im = - p2.im*(*gf)[0][1].re;
  (*gf)[2][2].im -= p2.re*(*gf)[0][1].im;

  p2.re = (*gf)[0][0].re * (*gf)[0][2].re;
  p2.re += (*gf)[0][0].im * (*gf)[0][2].im;
  p2.im = (*gf)[0][0].re * (*gf)[0][2].im;
  p2.im -= (*gf)[0][0].im * (*gf)[0][2].re;
  p2 = dev_cmult( dev_cconj(p1) , p2);

  (*gf)[2][2] = dev_cadd((*gf)[2][2], p2);
  (*gf)[2][2] = dev_crealmult((*gf)[2][2], -one_over_N);

}






__device__ void dev_reconstructgf_8texref_dagger (dev_su3_8 * field, int pos, dev_su3* gf){


  double2 gfin, gfin2;
  double one_over_N;
  dev_complex p1,p2;





    gfin = field[4*pos];


  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = -gfin.y;





    gfin2 = field[4*pos+1];

  (*gf)[2][0].re = gfin2.x;
  (*gf)[2][0].im = -gfin2.y;

  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y;
  one_over_N = rsqrt(p1.re);







    gfin = field[4*pos+2];






    gfin2 = field[4*pos+3];



  p1.re = sqrt(1.0 - p1.re);



  sincos(gfin.x, &(*gf)[0][0].im, &(*gf)[0][0].re);
  (*gf)[0][0].re = (*gf)[0][0].re * p1.re;
  (*gf)[0][0].im = -(*gf)[0][0].im * p1.re;





  (*gf)[0][1].re = gfin2.x;
  (*gf)[0][1].im = -gfin2.y;


  p2.re = one_over_N*(*gf)[0][1].re;
  p2.im = -one_over_N*(*gf)[0][1].im;



  p1.re = sqrt(1.0 -
              (*gf)[0][0].re * (*gf)[0][0].re - (*gf)[0][0].im * (*gf)[0][0].im -
              (*gf)[0][1].re * (*gf)[0][1].re - (*gf)[0][1].im * (*gf)[0][1].im
          );



  sincos(gfin.y, &(*gf)[0][2].im, &(*gf)[0][2].re);
  (*gf)[0][2].re = (*gf)[0][2].re * p1.re;
  (*gf)[0][2].im = -(*gf)[0][2].im * p1.re;



  p1.re = one_over_N*(*gf)[0][2].re;
  p1.im = one_over_N*(*gf)[0][2].im;




  (*gf)[1][1] = dev_cmult(p1, (*gf)[2][0] );
  (*gf)[2][2] = dev_cmult(p2, dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[1][0] )) );
  (*gf)[1][1] = dev_cadd((*gf)[1][1], (*gf)[2][2]);
  (*gf)[1][1] = dev_cconj(dev_crealmult((*gf)[1][1], -one_over_N));


  (*gf)[2][1] = dev_cmult(p1, (*gf)[1][0] );
  (*gf)[2][2] = dev_cmult(p2, dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[2][0] )) );
  (*gf)[2][1] = dev_csub((*gf)[2][1], (*gf)[2][2]);
  (*gf)[2][1] = dev_cconj(dev_crealmult((*gf)[2][1], one_over_N));


  (*gf)[1][2] = dev_cmult( dev_cconj(p2) , (*gf)[2][0] );
  (*gf)[2][2] = dev_cmult( dev_cconj(p1) ,
                       dev_cmult( (*gf)[0][0] , dev_cconj( (*gf)[1][0]) )
                     );
  (*gf)[1][2] = dev_csub((*gf)[1][2], (*gf)[2][2]);
  (*gf)[1][2] = dev_cconj(dev_crealmult((*gf)[1][2], one_over_N));



  (*gf)[2][2] = dev_cmult( dev_cconj(p2) , (*gf)[1][0] );
  p2 = dev_cmult( dev_cconj(p1) ,
                       dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[2][0] ) )
                     );
  (*gf)[2][2] = dev_cadd((*gf)[2][2], p2);
  (*gf)[2][2] = dev_cconj(dev_crealmult((*gf)[2][2], -one_over_N));

}
# 716 "dev_su3.cu"
__device__ void dev_reconstructtrafo_2vtexref (dev_su3_2v * field, int pos, dev_su3* gf){
  dev_complex help1;
  dev_complex help2;
  double2 gfin;





    gfin = field[6*pos];


  (*gf)[0][0].re = gfin.x;
  (*gf)[0][0].im = gfin.y;





    gfin = field[6*pos+1];

  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = gfin.y;





    gfin = field[6*pos+2];


  (*gf)[0][2].re = gfin.x;
  (*gf)[0][2].im = gfin.y;






    gfin = field[6*pos+3];

  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = gfin.y;





    gfin = field[6*pos+4];


  (*gf)[1][1].re = gfin.x;
  (*gf)[1][1].im = gfin.y;





    gfin = field[6*pos+5];

  (*gf)[1][2].re = gfin.x;
  (*gf)[1][2].im = gfin.y;


  help1 = dev_cmult((*gf)[0][1],(*gf)[1][2]);
  help2 = dev_cmult((*gf)[0][2],(*gf)[1][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*gf)[2][0] = help1;


  help1 = dev_cmult((*gf)[0][2],(*gf)[1][0]);
  help2 = dev_cmult((*gf)[0][0],(*gf)[1][2]);
  help1 = dev_cconj(dev_csub(help1,help2));

  (*gf)[2][1] = help1;

  help1 = dev_cmult((*gf)[0][0],(*gf)[1][1]);
  help2 = dev_cmult((*gf)[0][1],(*gf)[1][0]);
  help1 = dev_cconj(dev_csub(help1,help2));

  (*gf)[2][2] = help1;

  return;
}





__device__ void dev_reconstructtrafo_2vtexref_dagger (dev_su3_2v * field, int pos, dev_su3* gf){
  dev_complex help1;
  dev_complex help2;
  double2 gfin;







    gfin = field[6*pos];


  (*gf)[0][0].re = gfin.x;
  (*gf)[0][0].im = -gfin.y;





    gfin = field[6*pos+1];

  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = -gfin.y;





    gfin = field[6*pos+2];


  (*gf)[2][0].re = gfin.x;
  (*gf)[2][0].im = -gfin.y;





    gfin = field[6*pos+3];


  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = -gfin.y;





    gfin = field[6*pos+4];


  (*gf)[1][1].re = gfin.x;
  (*gf)[1][1].im = -gfin.y;





    gfin = field[6*pos+5];

  (*gf)[2][1].re = gfin.x;
  (*gf)[2][1].im = -gfin.y;



  help1 = dev_cconj(dev_cmult((*gf)[1][0],(*gf)[2][1]));
  help2 = dev_cconj(dev_cmult((*gf)[2][0],(*gf)[1][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[0][2] = help1;


  help1 = dev_cconj(dev_cmult((*gf)[2][0],(*gf)[0][1]));
  help2 = dev_cconj(dev_cmult((*gf)[0][0],(*gf)[2][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[1][2] = help1;


  help1 = dev_cconj(dev_cmult((*gf)[0][0],(*gf)[1][1]));
  help2 = dev_cconj(dev_cmult((*gf)[1][0],(*gf)[0][1]));
  help1 = dev_csub(help1,help2);
  (*gf)[2][2] = help1;
# 908 "dev_su3.cu"
}
# 921 "dev_su3.cu"
__device__ void dev_reconstructtrafo_8texref (dev_su3_8 * field, int pos, dev_su3* gf){

  double2 gfin, gfin2;
  double one_over_N, help;
  dev_complex p1,p2;





    gfin = field[4*pos];


  (*gf)[0][1].re = gfin.x;
  (*gf)[0][1].im = gfin.y;





    gfin2 = field[4*pos+1];

  (*gf)[0][2].re = gfin2.x;
  (*gf)[0][2].im = gfin2.y;

  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y;
  one_over_N = rsqrt(p1.re);






    gfin = field[4*pos+2];






    gfin2 = field[4*pos+3];


  p1.re = sqrt(1.0 - p1.re);


  sincos(gfin.x, &(*gf)[0][0].im, &(*gf)[0][0].re);
  (*gf)[0][0].re = (*gf)[0][0].re * p1.re;
  (*gf)[0][0].im = (*gf)[0][0].im * p1.re;



  (*gf)[1][0].re = gfin2.x;
  (*gf)[1][0].im = gfin2.y;


  p2.re = one_over_N*(*gf)[1][0].re;
  p2.im = one_over_N*(*gf)[1][0].im;



  p1.re = sqrt(1.0 -
              (*gf)[0][0].re * (*gf)[0][0].re - (*gf)[0][0].im * (*gf)[0][0].im -
              (*gf)[1][0].re * (*gf)[1][0].re - (*gf)[1][0].im * (*gf)[1][0].im
          );

  sincos(gfin.y, &(*gf)[2][0].im, &(*gf)[2][0].re);
  (*gf)[2][0].re = (*gf)[2][0].re * p1.re;
  (*gf)[2][0].im = (*gf)[2][0].im * p1.re;




  p1.re = one_over_N*(*gf)[2][0].re;
  p1.im = - one_over_N*(*gf)[2][0].im;






  (*gf)[1][1].re = p1.re*(*gf)[0][2].re;
  (*gf)[1][1].re += p1.im*(*gf)[0][2].im;
  (*gf)[1][1].im = p1.im*(*gf)[0][2].re;
  (*gf)[1][1].im -= p1.re*(*gf)[0][2].im;

  (*gf)[2][2].re = (*gf)[0][0].re * (*gf)[0][1].re;
  (*gf)[2][2].re += (*gf)[0][0].im * (*gf)[0][1].im;

  (*gf)[2][2].im = (*gf)[0][0].re * (*gf)[0][1].im;
  (*gf)[2][2].im -= (*gf)[0][0].im * (*gf)[0][1].re;
  (*gf)[2][2] = dev_cmult(p2, (*gf)[2][2]);

  (*gf)[1][1].re = -one_over_N*( (*gf)[1][1].re + (*gf)[2][2].re);
  (*gf)[1][1].im = -one_over_N*((*gf)[1][1].im + (*gf)[2][2].im);



  (*gf)[1][2].re = p1.re*(*gf)[0][1].re;
  (*gf)[1][2].re += p1.im*(*gf)[0][1].im;
  (*gf)[1][2].im = p1.im*(*gf)[0][1].re;
  (*gf)[1][2].im -= p1.re*(*gf)[0][1].im;

  (*gf)[2][2].re = (*gf)[0][0].re*(*gf)[0][2].re;
  (*gf)[2][2].re += (*gf)[0][0].im*(*gf)[0][2].im;
  (*gf)[2][2].im = (*gf)[0][0].re*(*gf)[0][2].im;
  (*gf)[2][2].im -= (*gf)[0][0].im*(*gf)[0][2].re;
  (*gf)[2][2] = dev_cmult(p2,(*gf)[2][2]);

  (*gf)[1][2].re = one_over_N*( (*gf)[1][2].re - (*gf)[2][2].re);
  (*gf)[1][2].im = one_over_N*( (*gf)[1][2].im - (*gf)[2][2].im);



  (*gf)[2][1].re = p2.re*(*gf)[0][2].re;
  (*gf)[2][1].re -= p2.im*(*gf)[0][2].im;
  (*gf)[2][1].im = -p2.re*(*gf)[0][2].im;
  (*gf)[2][1].im -= p2.im*(*gf)[0][2].re;



  (*gf)[2][2].re = (*gf)[0][0].re*(*gf)[0][1].re;
  (*gf)[2][2].re += (*gf)[0][0].im*(*gf)[0][1].im;
  (*gf)[2][2].im = (*gf)[0][0].re* (*gf)[0][1].im;
  (*gf)[2][2].im -= (*gf)[0][0].im* (*gf)[0][1].re;
  help = (*gf)[2][2].re;
  (*gf)[2][2].re = p1.re*(*gf)[2][2].re;
  (*gf)[2][2].re += p1.im*(*gf)[2][2].im;
  (*gf)[2][2].im = p1.re*(*gf)[2][2].im - p1.im*help;


  (*gf)[2][1].re = one_over_N*((*gf)[2][1].re - (*gf)[2][2].re);
  (*gf)[2][1].im = one_over_N*((*gf)[2][1].im - (*gf)[2][2].im);





  (*gf)[2][2].re = p2.re * (*gf)[0][1].re;
  (*gf)[2][2].re -= p2.im * (*gf)[0][1].im;
  (*gf)[2][2].im = - p2.im*(*gf)[0][1].re;
  (*gf)[2][2].im -= p2.re*(*gf)[0][1].im;

  p2.re = (*gf)[0][0].re * (*gf)[0][2].re;
  p2.re += (*gf)[0][0].im * (*gf)[0][2].im;
  p2.im = (*gf)[0][0].re * (*gf)[0][2].im;
  p2.im -= (*gf)[0][0].im * (*gf)[0][2].re;
  p2 = dev_cmult( dev_cconj(p1) , p2);

  (*gf)[2][2] = dev_cadd((*gf)[2][2], p2);
  (*gf)[2][2] = dev_crealmult((*gf)[2][2], -one_over_N);
}





__device__ void dev_reconstructtrafo_8texref_dagger (dev_su3_8 * field, int pos, dev_su3* gf){
  double2 gfin, gfin2;
  double one_over_N;
  dev_complex p1,p2;





    gfin = field[4*pos];



  (*gf)[1][0].re = gfin.x;
  (*gf)[1][0].im = -gfin.y;





    gfin2 = field[4*pos+1];


  (*gf)[2][0].re = gfin2.x;
  (*gf)[2][0].im = -gfin2.y;

  p1.re = gfin.x*gfin.x + gfin.y*gfin.y + gfin2.x*gfin2.x + gfin2.y*gfin2.y;
  one_over_N = rsqrt(p1.re);







    gfin = field[4*pos+2];







    gfin2 = field[4*pos+3];



  p1.re = sqrt(1.0 - p1.re);



  sincos(gfin.x, &(*gf)[0][0].im, &(*gf)[0][0].re);
  (*gf)[0][0].re = (*gf)[0][0].re * p1.re;
  (*gf)[0][0].im = -(*gf)[0][0].im * p1.re;



  (*gf)[0][1].re = gfin2.x;
  (*gf)[0][1].im = -gfin2.y;


  p2.re = one_over_N*(*gf)[0][1].re;
  p2.im = -one_over_N*(*gf)[0][1].im;



  p1.re = sqrt(1.0 -
              (*gf)[0][0].re * (*gf)[0][0].re - (*gf)[0][0].im * (*gf)[0][0].im -
              (*gf)[0][1].re * (*gf)[0][1].re - (*gf)[0][1].im * (*gf)[0][1].im
          );



  sincos(gfin.y, &(*gf)[0][2].im, &(*gf)[0][2].re);
  (*gf)[0][2].re = (*gf)[0][2].re * p1.re;
  (*gf)[0][2].im = -(*gf)[0][2].im * p1.re;



  p1.re = one_over_N*(*gf)[0][2].re;
  p1.im = one_over_N*(*gf)[0][2].im;




  (*gf)[1][1] = dev_cmult(p1, (*gf)[2][0] );
  (*gf)[2][2] = dev_cmult(p2, dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[1][0] )) );
  (*gf)[1][1] = dev_cadd((*gf)[1][1], (*gf)[2][2]);
  (*gf)[1][1] = dev_cconj(dev_crealmult((*gf)[1][1], -one_over_N));


  (*gf)[2][1] = dev_cmult(p1, (*gf)[1][0] );
  (*gf)[2][2] = dev_cmult(p2, dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[2][0] )) );
  (*gf)[2][1] = dev_csub((*gf)[2][1], (*gf)[2][2]);
  (*gf)[2][1] = dev_cconj(dev_crealmult((*gf)[2][1], one_over_N));


  (*gf)[1][2] = dev_cmult( dev_cconj(p2) , (*gf)[2][0] );
  (*gf)[2][2] = dev_cmult( dev_cconj(p1) ,
                       dev_cmult( (*gf)[0][0] , dev_cconj( (*gf)[1][0]) )
                     );
  (*gf)[1][2] = dev_csub((*gf)[1][2], (*gf)[2][2]);
  (*gf)[1][2] = dev_cconj(dev_crealmult((*gf)[1][2], one_over_N));



  (*gf)[2][2] = dev_cmult( dev_cconj(p2) , (*gf)[1][0] );
  p2 = dev_cmult( dev_cconj(p1) ,
                       dev_cmult( (*gf)[0][0] , dev_cconj((*gf)[2][0] ) )
                     );
  (*gf)[2][2] = dev_cadd((*gf)[2][2], p2);
  (*gf)[2][2] = dev_cconj(dev_crealmult((*gf)[2][2], -one_over_N));


}






void show_su3_2v(dev_su3_2v * M){
 complex a0, a1, a2;
 complex b0, b1, b2;
 complex c0, c1, c2;
 complex help1, help2;

 printf("(%e,%e) ", (*M).x, (*M).y);
 printf("(%e,%e) ", (*(M+1)).x, (*(M+1)).y);
 printf("(%e,%e) ", (*(M+2)).x, (*(M+2)).y);
 printf("\n");

 printf("(%e,%e) ", (*(M+3)).x, (*(M+3)).y);
 printf("(%e,%e) ", (*(M+4)).x, (*(M+4)).y);
 printf("(%e,%e) ", (*(M+5)).x, (*(M+5)).y);

 printf("\n");
 double re1 = (*M).x * (*(M+3)).x + (*M).y * (*(M+3)).y;
 double im1 = - (*M).x * (*(M+3)).y + (*M).y * (*(M+3)).x;

 double re2 = (*(M+1)).x * (*(M+4)).x + (*(M+1)).y * (*(M+4)).y;
 double im2 = - (*(M+1)).x * (*(M+4)).y + (*(M+1)).y * (*(M+4)).x;

 double re3 = (*(M+2)).x * (*(M+5)).x + (*(M+2)).y * (*(M+5)).y;
 double im3 = - (*(M+2)).x * (*(M+5)).y + (*(M+2)).y * (*(M+5)).x;

 double allre = (re1+re2+re3);
 double allim = im1+im2+im3;

 printf("a b* = (%.16e, %.16e) \n", allre, allim);

 double norm = (*M).x*(*M).x + (*M).y*(*M).y + (*(M+1)).x*(*(M+1)).x + (*(M+1)).y*(*(M+1)).y + (*(M+2)).x*(*(M+2)).x + (*(M+2)).y*(*(M+2)).y;
 printf("a^2 = %.16e\n", norm);

 norm = (*(M+3)).x * (*(M+3)).x + (*(M+3)).y * (*(M+3)).y + (*(M+4)).x * (*(M+4)).x + (*(M+4)).y * (*(M+4)).y + (*(M+5)).x * (*(M+5)).x + (*(M+5)).y * (*(M+5)).y;
 printf("b^2 = %.16e\n", norm);

 a0.re = (*M).x;
 a0.im = (*M).y;
 a1.re = (*(M+1)).x;
 a1.im = (*(M+1)).y;
 a2.re = (*(M+2)).x;
 a2.im = (*(M+2)).y;

 b0.re = (*(M+3)).x;
 b0.im = (*(M+3)).y;
 b1.re = (*(M+4)).x;
 b1.im = (*(M+4)).y;
 b2.re = (*(M+5)).x;
 b2.im = (*(M+5)).y;



  help1 = cmult(a1,b2);
  help2 = cmult(a2,b1);
  help1 = cconj(csub(help1,help2));
  c0 = help1;


  help1 = cmult(a2,b0);
  help2 = cmult(a0,b2);
  help1 = cconj(csub(help1,help2));
  c1 = help1;

  help1 = cmult(a0,b1);
  help2 = cmult(a1,b0);
  help1 = cconj(csub(help1,help2));
  c2 = help1;


  norm = c0.re*c0.re + c0.im*c0.im + c1.re*c1.re + c1.im*c1.im + c2.re*c2.re + c2.im*c2.im;
 printf("c^2 = %.16e\n", norm);


}






__device__ void dev_su3zero(dev_su3* M){
 int i,j;
 dev_complex czero = dev_initcomplex(0.0,0.0);
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*M)[i][j] = czero;
    }
  }
return;
}




__device__ void dev_su3dagger(dev_su3 * erg, dev_su3 * M){
  int i,j;

  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*erg)[i][j] = dev_cconj((*M)[j][i]);
    }
  }
return;
}


__device__ dev_complex dev_su3trace(dev_su3 * M){
  dev_complex erg;
  int i;
  erg = dev_initcomplex(0.0,0.0);
  for(i=0; i<3; i++){
    erg = dev_cadd(erg, (*M)[i][i]);
  }
return erg;
}



__device__ double dev_su3Retrace(dev_su3 * M){
  double erg;
  int i;
  erg = 0.0;
  for(i=0; i<3; i++){
    erg = erg + (*M)[i][i].re;
  }
return erg;
}




__device__ void dev_su3skalarmult(dev_su3 * erg, dev_complex skalar, dev_su3 * M){
  int i,j;

  for(i=0;i<3;i++){
    for(j=0;j<3;j++){
      (*erg)[i][j] = dev_cmult(skalar,(*M)[i][j]);
    }
  }

return;
}


__device__ void dev_su2_ti_su2(dev_su2 * r, dev_su2* a, dev_su2* b){

  (*r).a.x = (*a).a.x * (*b).a.x - (*a).a.y * (*b).a.y
             - (*a).b.x * (*b).b.x - (*a).b.y * (*b).b.y;

  (*r).a.y = (*a).a.x * (*b).a.y + (*a).a.y * (*b).a.x
             - (*a).b.x * (*b).b.y + (*a).b.y * (*b).b.x;

  (*r).b.x = (*a).a.x * (*b).b.x + (*a).b.x * (*b).a.x
             - (*a).b.y * (*b).a.y + (*a).a.y * (*b).b.y;

  (*r).b.y = (*a).a.x * (*b).b.y + (*a).b.y * (*b).a.x
             - (*a).a.y * (*b).b.x + (*a).b.x * (*b).a.y;

}





__device__ void dev_su3copy( dev_su3 * to, dev_su3 * from){
  int i,j;
  for(i=0; i<3; i++){
    for(j=0; j<3; j++){
      (*to)[i][j] = (*from)[i][j];
    }
  }
return;
}




__device__ void dev_su3_ti_su3(dev_su3* u, dev_su3 * v, dev_su3 * w){
  dev_complex help1, help2;
  dev_complex zero = dev_initcomplex(0.0,0.0);
  int i,j,k;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){

      help2 = zero;
      for(k=0; k<3; k++){
          help1 = dev_cmult((*v)[i][k],(*w)[k][j]);
          help2 = dev_cadd(help1, help2);
        }
        (*u)[i][j] = help2;
    }
  }
}






__device__ void dev_add_su3_ti_su3(dev_su3* u, dev_su3 * v, dev_su3 * w){
  dev_complex help1, help2;
  dev_complex zero = dev_initcomplex(0.0,0.0);
  int i,j,k;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){

      help2 = zero;
      for(k=0; k<3; k++){
          help1 = dev_cmult((*v)[i][k],(*w)[k][j]);
          help2 = dev_cadd(help1, help2);
        }
        (*u)[i][j].re += help2.re;
        (*u)[i][j].im += help2.im;
    }
  }
}




__device__ void dev_su3_ti_su3d(dev_su3* u, dev_su3 * v, dev_su3 * w){
  dev_complex help1, help2;
  dev_complex zero = dev_initcomplex(0.0,0.0);
  int i,j,k;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      help2 = zero;
      for(k=0; k<3; k++){
          help1 = dev_cmult((*v)[i][k],dev_cconj( (*w)[j][k] ) );
          help2 = dev_cadd(help1, help2);
        }
        (*u)[i][j] = help2;
    }
  }
}



__device__ void dev_su3_sub(dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*a)[i][j] = dev_csub((*a)[i][j], (*b)[i][j]);
    }
  }
}






__device__ void dev_su3_sub_assign(dev_su3* c,dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*c)[i][j] = dev_csub((*a)[i][j], (*b)[i][j]);
    }
  }
}






__device__ void dev_su3_add(dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*a)[i][j] = dev_cadd((*a)[i][j], (*b)[i][j]);
    }
  }
}



__device__ void dev_su3_add_assign(dev_su3* c, dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*c)[i][j] = dev_cadd((*a)[i][j], (*b)[i][j]);
    }
  }
}




__device__ void dev_su3_real_mult(dev_su3* a, double R){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*a)[i][j].re = (*a)[i][j].re*R;
      (*a)[i][j].im = (*a)[i][j].im*R;
    }
  }
}





__device__ void dev_su3_real_mult_assign(dev_su3* erg, dev_su3* a, double R){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*erg)[i][j].re = (*a)[i][j].re*R;
      (*erg)[i][j].im = (*a)[i][j].im*R;
    }
  }
}





__device__ void dev_su3_assign(dev_su3* a, dev_su3* b){
  int i,j;
  for(i=0; i<3;i++){
    for(j=0; j<3; j++){
      (*a)[i][j] = (*b)[i][j];
    }
  }
}



__device__ void dev_su3_normalize(dev_su3* u){
  int i;
  double len;
  dev_complex proj, help1, help2;

  len = ((*u)[0][0].re*(*u)[0][0].re + (*u)[0][0].im*(*u)[0][0].im) +
        ((*u)[0][1].re*(*u)[0][1].re + (*u)[0][1].im*(*u)[0][1].im) +
        ((*u)[0][2].re*(*u)[0][2].re + (*u)[0][2].im*(*u)[0][2].im) ;


  len = rsqrt(len);

#pragma unroll 3
  for(i=0; i<3; i++){
    (*u)[0][i].re = (*u)[0][i].re*len;
    (*u)[0][i].im = (*u)[0][i].im*len;
  }


  proj = dev_initcomplex(0.0,0.0);
#pragma unroll 3
  for(i=0; i<3; i++){
    proj = dev_cadd( proj , dev_cmult( (*u)[1][i] , dev_cconj( (*u)[0][i]) ));
  }



#pragma unroll 3
  for(i=0; i<3; i++){
    (*u)[1][i] = dev_csub( (*u)[1][i] , dev_cmult(proj, (*u)[0][i] ) );
  }




  len = ((*u)[1][0].re*(*u)[1][0].re + (*u)[1][0].im*(*u)[1][0].im) +
        ((*u)[1][1].re*(*u)[1][1].re + (*u)[1][1].im*(*u)[1][1].im) +
        ((*u)[1][2].re*(*u)[1][2].re + (*u)[1][2].im*(*u)[1][2].im) ;

  len = rsqrt(len);

#pragma unroll 3
  for(i=0; i<3; i++){
    (*u)[1][i].re = (*u)[1][i].re*len;
    (*u)[1][i].im = (*u)[1][i].im*len;
  }



  help1 = dev_cmult((*u)[0][1],(*u)[1][2]);
  help2 = dev_cmult((*u)[0][2],(*u)[1][1]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*u)[2][0] = help1;


  help1 = dev_cmult((*u)[0][2],(*u)[1][0]);
  help2 = dev_cmult((*u)[0][0],(*u)[1][2]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*u)[2][1] = help1;

  help1 = dev_cmult((*u)[0][0],(*u)[1][1]);
  help2 = dev_cmult((*u)[0][1],(*u)[1][0]);
  help1 = dev_cconj(dev_csub(help1,help2));
  (*u)[2][2] = help1;

}
# 1602 "dev_su3.cu"
extern "C" int bind_texture_gf(dev_su3_2v * gfield){





 size_t size = sizeof(double2)*6*VOLUME*4;


 cudaGetTextureReference(&gf_texRefPtr, "gf_tex");
 gf_channelDesc = cudaCreateChannelDesc<int4>();
 cudaBindTexture(0, gf_texRefPtr, (int4 *) gfield, &gf_channelDesc, size);

 return(0);
}


extern "C" int unbind_texture_gf(){

 cudaUnbindTexture(gf_texRefPtr);

 return(0);
}




extern "C" int bind_texture_trafo(dev_su3_2v * trafofield){





 size_t size = sizeof(double2)*6*VOLUME;


 cudaGetTextureReference(&trafo_texRefPtr, "trafo_tex");
 trafo_channelDesc = cudaCreateChannelDesc<int4>();
 cudaBindTexture(0, trafo_texRefPtr, (int4 *) trafofield, &trafo_channelDesc, size);

 return(0);
}


extern "C" int unbind_texture_trafo(){

 cudaUnbindTexture(trafo_texRefPtr);

 return(0);
}
# 50 "cudagaugefix.cu" 2
# 1 "overrelax.cu" 1



__device__ double * dev_redfield_F;
__device__ double * dev_redfield_dAdA;
__device__ double * dev_redfield_maxdAdA;
__device__ double * dev_redfield_plaq;




__global__ void dev_gfix_init (int* grid){
  dev_LX = grid[0];
  dev_LY = grid[1];
  dev_LZ = grid[2];
  dev_T = grid[3];
  dev_VOLUME = grid[4];
}
# 29 "overrelax.cu"
__global__ void dev_mean_plaq(double* reductionfield_plaq, int * dev_nn, dev_su3_2v * gf){
  double mplaq = 0.0;
  int x0pos, x1pos, x2pos ;
  int iz,x,y,z,t,mu,nu;
  dev_su3 su3matrix,su3matrix2, M1,M2,M3,M4;
  dev_complex chelp;




  __shared__ double output[64];
  t = blockIdx.x;
  z = threadIdx.x;


      for(y=0; y<dev_LY; y++){
        for(x=0; x<dev_LX; x++){
          for(nu=0;nu <3; nu++){
            for(mu =nu+1; mu < 4; mu++){
              x0pos = x + dev_LX*(y + dev_LY*(z + dev_LZ*t));
              x1pos = dev_nn[8*x0pos + mu];
              x2pos = dev_nn[8*x0pos + nu];





              dev_reconstructgf_2vtexref(gf, (4*x0pos+mu),&M1);





              dev_reconstructgf_2vtexref(gf, (4*x1pos+nu),&M2);






              dev_reconstructgf_2vtexref_dagger(gf, (4*x2pos+mu),&M3);





              dev_reconstructgf_2vtexref_dagger(gf, (4*x0pos+nu),&M4);



              dev_su3_ti_su3(&su3matrix, &M3,&M4);
              dev_su3_ti_su3(&su3matrix2, &M2,&su3matrix);
              dev_su3_ti_su3(&su3matrix, &M1,&su3matrix2);

              chelp = dev_su3trace(&su3matrix);
              mplaq += chelp.re/3.0;
            }
          }

        }
      }
    output[z] = mplaq;

  __syncthreads();

  if(threadIdx.x == 0){


    double accum = 0.0;
    for(iz=0; iz < dev_LZ; iz++){
      accum += output[iz];
    }
    accum = accum*(1.0/(6.0*dev_VOLUME));
    reductionfield_plaq[t] = accum;
  }
  __syncthreads();

}



double calc_plaquette(dev_su3_2v * U){
   double erg=0.0;
   int j;
   dev_mean_plaq <<< T , LZ >>> (dev_redfield_plaq, dev_nn, U) ;
   cudaMemcpy(redfield_plaq, dev_redfield_plaq, (size_t)(T*sizeof(double)), cudaMemcpyDeviceToHost);
   for(j=0; j<T; j++){
     erg+=redfield_plaq[j];

   }
   printf("PLAQ = %.16f\n",erg);
   return(erg);
}
# 132 "overrelax.cu"
__device__ void overrelax ( dev_su3 * g, dev_su3 * gn, double w, int N){

  int i;
  dev_su3 one, R, a, Rw, help;

  dev_unitsu3(&(one));

  dev_su3_ti_su3d (&(R), gn, g );
  dev_su3_sub(&(R), &(one));

  dev_su3_assign(&(Rw), &(one));
  dev_su3_assign(&(a), &(one));

  for(i=1; i<N; i++){

    dev_su3_ti_su3(&(help), &(a), &(R));
    dev_su3_assign(&(a), &(help));

    dev_su3_real_mult(&(a), (1.0 + w - i)/i );
    dev_su3_add(&(Rw), &(a));

  }
  dev_su3_normalize(&(Rw));


  dev_su3_ti_su3(&(help), &(Rw), g);
  dev_su3_assign(g, &(help));

}
# 171 "overrelax.cu"
__device__ void relax_su2(dev_su2 * out, dev_su2 * in){
  double det = (*in).a.x*(*in).a.x + (*in).a.y*(*in).a.y + (*in).b.x*(*in).b.x + (*in).b.y*(*in).b.y;
  det = rsqrt(det);


  (*out).a.x = (*in).a.x*det;
  (*out).a.y = (*in).a.y*det;
  (*out).b.x = (*in).b.x*det;
  (*out).b.y = (*in).b.y*det;

}




__device__ void cabibbo_marinari_relax(dev_su3 * g, dev_su3 * star){




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
# 219 "overrelax.cu"
      relax_su2(&(alpha), &(w));


      for(c=0; c<3; c++){





       dummy = dev_cmult(dev_initcomplex(alpha.a.x,alpha.b.y),(*g)[a][c]);
       dummy2 = dev_cmult(dev_initcomplex(alpha.b.x,alpha.a.y),(*g)[b][c]);
       dummy = dev_cadd(dummy, dummy2);




       dummy2 = dev_cmult(dev_initcomplex(-alpha.b.x,alpha.a.y),(*g)[a][c]);
       dummy3 = dev_cmult(dev_initcomplex(alpha.a.x,-alpha.b.y),(*g)[b][c]);
       (*g)[b][c] = dev_cadd(dummy2, dummy3);



       (*g)[a][c] = dummy;

      }

    }
  }
}



__global__ void dev_apply_trafo(dev_su3_2v * gf_new, dev_su3_2v * gf, dev_su3_2v * trafo, int* dev_nn){
int pos,hoppos,mu;



     __shared__ dev_su3 gfsmem[128];
     __shared__ dev_su3 trafosmem[128];
     dev_su3 help;


  pos = threadIdx.x + blockDim.x*blockIdx.x;
  int ix = threadIdx.x;
  if(pos < dev_VOLUME){


    for(mu=0;mu<4;mu++){

      hoppos = dev_nn[8*pos+mu];




        dev_reconstructgf_2vtexref(gf, (4*pos+mu),&(gfsmem[ix]));
# 282 "overrelax.cu"
        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));



      dev_su3_ti_su3(&(help), &(gfsmem[ix]), &(trafosmem[ix]) );






        dev_reconstructtrafo_2vtexref(trafo, pos,&(trafosmem[ix]));



      dev_su3_ti_su3(&(gfsmem[ix]), &(trafosmem[ix]), &(help) );






          dev_storegf_2v((4*pos+mu), gf_new ,&(gfsmem[ix]) );


    }
  }
}



__global__ void dev_overrelax_step(dev_su3_2v * trafo_new, dev_su3_2v * gf, dev_su3_2v * trafo, int * dev_indeo_thissite, int * dev_indeo_nextside, int * dev_nn){
    int eofieldpos, pos,hoppos,mu;



     __shared__ dev_su3 gfsmem[128];
     __shared__ dev_su3 trafosmem[128];

    dev_su3 help, star;

  eofieldpos = threadIdx.x + blockDim.x*blockIdx.x;
  int ix = threadIdx.x;
  if(eofieldpos < dev_VOLUME/2){

  pos = dev_indeo_thissite[eofieldpos];
  dev_su3zero( &(star) );


    for(mu=0;mu<4;mu++){

      hoppos = dev_nn[8*pos+mu];




        dev_reconstructgf_2vtexref(gf, (4*pos+mu),&(gfsmem[ix]));





        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));





      dev_add_su3_ti_su3(&(star) , &(gfsmem[ix]), &(trafosmem[ix]) );


      hoppos = dev_nn[8*pos+4+mu];




       dev_reconstructgf_2vtexref_dagger(gf, 4*hoppos+mu,&(gfsmem[ix]));






        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));



      dev_add_su3_ti_su3( &(star), &(gfsmem[ix]), &(trafosmem[ix]) );

  }





        dev_reconstructtrafo_2vtexref(trafo, pos,&(trafosmem[ix]));
# 386 "overrelax.cu"
   dev_su3copy( &(help) , &(trafosmem[ix]) );

   cabibbo_marinari_relax( &(help), &(star) );

   dev_su3_normalize(&(help));

   overrelax(&(trafosmem[ix]), &(help), 1.68, 3);
   dev_su3_normalize( &(trafosmem[ix]) );




     dev_storetrafo_2v(pos, trafo_new ,&(trafosmem[ix]) );
# 420 "overrelax.cu"
  }
}




__device__ void dev_vectorpotential(dev_su3* U){

 dev_su3 temp;
 dev_complex i_half = dev_initcomplex(0.0, 0.5);
 dev_complex trace;

 dev_su3dagger(&(temp), U);
 dev_su3_sub( &(temp), U);
 dev_su3skalarmult(U, i_half, &(temp));




 trace = dev_su3trace(U);

 trace.re = trace.re/3.0;
 trace.im = trace.im/3.0;

 (*U)[0][0] = dev_csub((*U)[0][0], trace);
 (*U)[1][1] = dev_csub((*U)[1][1], trace);
 (*U)[2][2] = dev_csub((*U)[2][2], trace);

}
# 457 "overrelax.cu"
__global__ void dev_functional(dev_su3_2v * gf, dev_su3_2v * trafo, int * dev_nn, double * reduction_field_F, double * reduction_field_dAdA, double * reduction_field_maxdAdA){

  int pos, mu, hoppos, i;

  __shared__ dev_su3 gfsmem[128];
  __shared__ dev_su3 trafosmem[128];
  __shared__ double Flocal[128];
  __shared__ double dAdAlocal[128];

  dev_su3 gather, help, fw, bw;

  pos= threadIdx.x + blockDim.x*blockIdx.x;

  int ix = threadIdx.x;


  if(pos < dev_VOLUME){

   dev_su3zero(&(gather));

    Flocal[ix] = 0.0;
    dAdAlocal[ix] = 0.0;

    for(mu=0;mu<4;mu++){


      hoppos = dev_nn[8*pos+mu];





        dev_reconstructgf_2vtexref(gf, (4*pos+mu),&(gfsmem[ix]));







        dev_reconstructtrafo_2vtexref(trafo, pos,&(trafosmem[ix]));



      dev_su3_ti_su3(&(help), &(trafosmem[ix]), &(gfsmem[ix]) );





        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));



      dev_su3_ti_su3(&(fw), &(help), &(trafosmem[ix]));
      Flocal[ix] += dev_su3Retrace(&(fw));



    hoppos = dev_nn[8*pos+4+mu];





        dev_reconstructgf_2vtexref(gf, (4*hoppos+mu),&(gfsmem[ix]));







        dev_reconstructtrafo_2vtexref(trafo, hoppos,&(trafosmem[ix]));



      dev_su3_ti_su3(&(help), &(trafosmem[ix]) , &(gfsmem[ix]));





        dev_reconstructtrafo_2vtexref_dagger(trafo, pos,&(trafosmem[ix]));




   dev_su3_ti_su3( &(bw), &(help), &(trafosmem[ix]) );

   dev_vectorpotential(&(fw));
   dev_vectorpotential(&(bw));
   dev_su3_sub(&(bw), &(fw));



  dev_su3_add(&(gather), &(bw));

   }



   dev_su3_ti_su3d( &(help),&(gather), &(gather));
   dAdAlocal[ix] += dev_su3Retrace( &(help) );

  }


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
  if(VOLUME%128 != 0){
   printf("Error: VOLUME is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(128,1,1);
  if( VOLUME >= 128){
   gridsize =VOLUME/128;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1);


  int redfieldsize = VOLUME/128;




     dev_functional<<< griddim, blockdim >>> (gf, trafo, dev_nn, dev_redfield_F, dev_redfield_dAdA, dev_redfield_maxdAdA);



   printf("%s\n", cudaGetErrorString(cudaGetLastError()));


   { cudaError err = cudaMemcpy(redfield_F, dev_redfield_F, (size_t)(redfieldsize*sizeof(double)), cudaMemcpyDeviceToHost); if( cudaSuccess != err) { fprintf(stderr, "Cuda error : %s.\n", cudaGetErrorString( err) ); exit(1); } };
   { cudaError err = cudaMemcpy(redfield_dAdA, dev_redfield_dAdA, (size_t)(redfieldsize*sizeof(double)), cudaMemcpyDeviceToHost); if( cudaSuccess != err) { fprintf(stderr, "Cuda error : %s.\n", cudaGetErrorString( err) ); exit(1); } };
   { cudaError err = cudaMemcpy(redfield_maxdAdA, dev_redfield_maxdAdA, (size_t)(redfieldsize*sizeof(double)), cudaMemcpyDeviceToHost); if( cudaSuccess != err) { fprintf(stderr, "Cuda error : %s.\n", cudaGetErrorString( err) ); exit(1); } };

   for(i=0;i<redfieldsize;i++){

     F += redfield_F[i];
     dada += redfield_dAdA[i];

     if(redfield_maxdAdA[i] > maxdada){
       maxdada = redfield_maxdAdA[i];
     }






   }

   F=F/(4.0*VOLUME);
   dada=dada/(VOLUME);


   FUNC=F;
   DADA=dada;
   maxDADA=maxdada;


   return(maxdada);
}





int overrelax_gauge(int maxit, double eps, int checkinterval){

  int gridsize;
  double maxdada = 0.0;
  int i;
  clock_t start, stop;
  double timeelapsed = 0.0;


  if((VOLUME/2)%128 != 0){
   printf("Error: VOLUME/2 is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(128,1,1);
  if( (VOLUME/2) >= 128){
   gridsize =VOLUME/128;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1);




  (((start = clock())!=-1) ? (void) (0) : __assert_fail ("(start = clock())!=-1", "overrelax.cu", 677, __PRETTY_FUNCTION__));






  for(i=0; i<maxit; i++){
# 702 "overrelax.cu"
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn);


     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_odd, dev_eoidx_even, dev_nn);



    if((i%checkinterval) == 0){




      maxdada = calc_functional(dev_gf, dev_trafo1);
      printf("iter %6d:\t FUNC = %.16e \t dAdA = %.16e\t max(dAdA) = %.16e\n",i, FUNC, DADA, maxdada);



    }

    if(maxdada < eps){
      printf("CONVERGENCE!\nFinal values: F = %.16e dAdA = %.16e, maxdAdA = %.16e\n", FUNC, DADA, maxDADA);
     (((stop = clock())!=-1) ? (void) (0) : __assert_fail ("(stop = clock())!=-1", "overrelax.cu", 723, __PRETTY_FUNCTION__));
     timeelapsed = (double) (stop-start)/1000000l;
     printf("Overrelaxation finished after %f sec\n", timeelapsed);



     return(i);
    }

  }





  (((stop = clock())!=-1) ? (void) (0) : __assert_fail ("(stop = clock())!=-1", "overrelax.cu", 738, __PRETTY_FUNCTION__));
  timeelapsed = (double) (stop-start)/1000000l;
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


  if((VOLUME/2)%128 != 0){
   printf("Error: VOLUME/2 is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(128,1,1);
  if( (VOLUME/2) >= 128){
   gridsize =VOLUME/128;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1);




  (((start = clock())!=-1) ? (void) (0) : __assert_fail ("(start = clock())!=-1", "overrelax.cu", 781, __PRETTY_FUNCTION__));




  printf("Doing small benchmark...");

for(i=0; i<100; i++){
# 804 "overrelax.cu"
     cudaFuncSetCacheConfig(dev_overrelax_step, cudaFuncCachePreferShared);
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn);


     cudaFuncSetCacheConfig(dev_overrelax_step, cudaFuncCachePreferShared);
     dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_odd, dev_eoidx_even, dev_nn);


}





  printf("Done\n");

  (((stop = clock())!=-1) ? (void) (0) : __assert_fail ("(stop = clock())!=-1", "overrelax.cu", 820, __PRETTY_FUNCTION__));
  timeelapsed = (double) (stop-start)/1000000l;


  double benchres = 4766.0*2*(VOLUME/2)* 100 / timeelapsed / 1.0e9;
  printf("Benchmark: %f Gflops\n", benchres);




}




void calc_star(){

  int gridsize;
  double F = 0.0;


  if((VOLUME/2)%128 != 0){
   printf("Error: VOLUME/2 is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(128,1,1);
  if( (VOLUME/2) >= 128){
   gridsize =VOLUME/128;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1);
# 875 "overrelax.cu"
   F = calc_functional(dev_gf,dev_trafo1);







      dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn);







   F = calc_functional(dev_gf, dev_trafo1);





      dev_overrelax_step<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_odd, dev_eoidx_even, dev_nn);
# 910 "overrelax.cu"
}
# 51 "cudagaugefix.cu" 2
# 1 "simulated_annealing.cu" 1


__constant__ __device__ double sa_beta;




__device__ int dev_get_a0(double *a0, double kb, int ind){

  float a,b,y,help;

  a = abs(dev_rndgauss_field[ind]);
  b = -log(1.0f - dev_rndunif_field[4*ind]);

  y = a*a + b;
  y = y/kb;

  help = dev_rndunif_field[4*ind+1];
  if((2.0f * (help*help)) <= (2.0f -y)){
    *a0 = (double)(1.0f - y);
    return(1);
  }
  else{
   return(0);
  }
}





__device__ void dev_heatbath_su2(dev_su2* alpha, dev_su2* w, double beta, int ind){

  dev_su2 v, a;
  double k, rdet, cos_theta, sin_theta, phi, norm;
  int ret;

  k = (*w).a.x*(*w).a.x + (*w).a.y*(*w).a.y + (*w).b.x*(*w).b.x + (*w).b.y*(*w).b.y ;
  rdet = rsqrt(k);

  v.a.x = (*w).a.x*rdet;
  v.a.y = (*w).a.y*rdet;
  v.b.x = (*w).b.x*rdet;
  v.b.y = (*w).b.y*rdet;


  ret = dev_get_a0(&(a.a.x), k*beta, ind);

    norm = sqrt(1.0 - a.a.x*a.a.x);
    cos_theta = 2.0 * dev_rndunif_field[4*ind+2] - 1.0;
    sin_theta = sqrt( 1.0 - cos_theta*cos_theta );
    phi = 6.2831853071795862 * dev_rndunif_field[4*ind+3];

    a.a.y = norm * sin_theta * cos(phi);
    a.b.x = norm * sin_theta * sin(phi);
    a.b.y = norm * cos_theta;

   if(ret == 1){

     dev_su2_ti_su2(alpha,&a,&v);
   }
   else{

     (*alpha).a.x = (*w).a.x;
     (*alpha).a.y = (*w).a.y;
     (*alpha).b.x = (*w).b.x;
     (*alpha).b.y = (*w).b.y;
   }

}







__device__ void cabibbo_marinari_heatbath(dev_su3 * g, dev_su3 * star, double beta, int ind){




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
# 111 "simulated_annealing.cu"
      dev_heatbath_su2(&(alpha), &(w), beta, ind);


      for(c=0; c<3; c++){





       dummy = dev_cmult(dev_initcomplex(alpha.a.x,alpha.b.y),(*g)[a][c]);
       dummy2 = dev_cmult(dev_initcomplex(alpha.b.x,alpha.a.y),(*g)[b][c]);
       dummy = dev_cadd(dummy, dummy2);




       dummy2 = dev_cmult(dev_initcomplex(-alpha.b.x,alpha.a.y),(*g)[a][c]);
       dummy3 = dev_cmult(dev_initcomplex(alpha.a.x,-alpha.b.y),(*g)[b][c]);
       (*g)[b][c] = dev_cadd(dummy2, dummy3);



       (*g)[a][c] = dummy;

      }

    }
  }
}
# 150 "simulated_annealing.cu"
__global__ void dev_heatbath_sweep(dev_su3_2v * trafo_new, dev_su3_2v * gf, dev_su3_2v * trafo, int * dev_indeo_thissite, int * dev_indeo_nextside, int * dev_nn){

    int eofieldpos, pos,hoppos,mu;



     __shared__ dev_su3 gfsmem[128];
     __shared__ dev_su3 trafosmem[128];

    dev_su3 help, star;

  eofieldpos = threadIdx.x + blockDim.x*blockIdx.x;
  int ix = threadIdx.x;
  if(eofieldpos < dev_VOLUME/2){

  pos = dev_indeo_thissite[eofieldpos];
  dev_su3zero( &(star) );




    for(mu=0;mu<4;mu++){

      hoppos = dev_nn[8*pos+mu];




        dev_reconstructgf_2vtexref(gf, (4*pos+mu),&(gfsmem[ix]));





        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));





      dev_add_su3_ti_su3(&(star) , &(gfsmem[ix]), &(trafosmem[ix]) );


      hoppos = dev_nn[8*pos+4+mu];




       dev_reconstructgf_2vtexref_dagger(gf, 4*hoppos+mu,&(gfsmem[ix]));






        dev_reconstructtrafo_2vtexref_dagger(trafo, hoppos,&(trafosmem[ix]));



      dev_add_su3_ti_su3( &(star), &(gfsmem[ix]), &(trafosmem[ix]) );

   }





        dev_reconstructtrafo_2vtexref(trafo, pos,&(trafosmem[ix]));



   dev_su3copy( &(help) , &(trafosmem[ix]) );
   cabibbo_marinari_heatbath( &(help), &(star) , sa_beta, pos);



   dev_su3_normalize(&(help));




     dev_storetrafo_2v(pos, trafo_new ,&(trafosmem[ix]) );
# 253 "simulated_annealing.cu"
  }
}







void set_sa_temperature(int i){



    double a, temperature;
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
          temperature = pow( (a*i + pow(saparam.Tmax,-saparam.expo)) , (-1.0/saparam.expo) );
       }
    }
   temperature = 1.0/temperature;

   { cudaError err = cudaMemcpyToSymbol("sa_beta", &temperature, sizeof(double)); if( cudaSuccess != err) { fprintf(stderr, "Cuda error : %s.\n", cudaGetErrorString( err) ); exit(1); } } ;
}
# 298 "simulated_annealing.cu"
void simannealing_gauge(){

  int gridsize;
  double maxdada = 0.0;
  int i;
  clock_t start, stop;
  double timeelapsed = 0.0;


  if((VOLUME/2)%128 != 0){
   printf("Error: VOLUME/2 is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(128,1,1);
  if( (VOLUME/2) >= 128){
   gridsize =VOLUME/128;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1);




  (((start = clock())!=-1) ? (void) (0) : __assert_fail ("(start = clock())!=-1", "simulated_annealing.cu", 323, __PRETTY_FUNCTION__));






 for(i=0; i<saparam.N; i++){

   set_sa_temperature(i);
   printf("%s\n", cudaGetErrorString(cudaGetLastError()));
# 350 "simulated_annealing.cu"
     dev_heatbath_sweep<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_even, dev_eoidx_odd, dev_nn);




     dev_heatbath_sweep<<< griddim, blockdim >>> (dev_trafo1, dev_gf, dev_trafo1, dev_eoidx_odd, dev_eoidx_even, dev_nn);




    printf("%s\n", cudaGetErrorString(cudaGetLastError()));


    printf("Updating the random numbers...\n");
    update_MT();
    printf("%s\n", cudaGetErrorString(cudaGetLastError()));

    if((i%saparam.checkint) == 0){




      maxdada = calc_functional(dev_gf, dev_trafo1);
      printf("iter %6d:\t FUNC = %.16e \t dAdA = %.16e\t max(dAdA) = %.16e\n",i, FUNC, DADA, maxdada);



    }


  }





  (((stop = clock())!=-1) ? (void) (0) : __assert_fail ("(stop = clock())!=-1", "simulated_annealing.cu", 386, __PRETTY_FUNCTION__));
  timeelapsed = (double) (stop-start)/1000000l;
  printf("SA finished after %f sec\n", timeelapsed);

}
# 52 "cudagaugefix.cu" 2




extern int read_gf_ildg(su3 gf[], char* filename);



void initnn(){
  int t,x,y,z,pos, count;
  count=0;
  for(t=0;t<T;t++){
    for(z=0; z<LZ; z++){
      for(y=0; y<LY; y++){
        for(x=0; x<LX; x++){
          pos= x + LX*(y + LY*(z + LZ*t));
          ind[count] = pos;

          nn[8*pos+3] = x + LX*(y + LY*(z + LZ*((t+1)%T)));
          nn[8*pos+2] = x + LX*(y + LY*((z+1)%LZ + LZ*t));
          nn[8*pos+1] = x + LX*((y+1)%LY + LY*(z + LZ*t));
          nn[8*pos+0] = (x+1)%LX + LX*(y + LY*(z + LZ*t));

          if(t==0){
            nn[8*pos+7] = x + LX*(y + LY*(z + LZ*((T-1))));
          }
          else{
            nn[8*pos+7] = x + LX*(y + LY*(z + LZ*((t-1))));
          }
          if(z==0){
            nn[8*pos+6] = x + LX*(y + LY*((LZ-1) + LZ*t));
          }
          else{
            nn[8*pos+6] = x + LX*(y + LY*((z-1) + LZ*t));
          }
          if(y==0){
            nn[8*pos+5] = x + LX*((LY-1) + LY*(z + LZ*t));
          }
          else{
            nn[8*pos+5] = x + LX*((y-1) + LY*(z + LZ*t));
          }
          if(x==0){
            nn[8*pos+4] = (LX-1) + LX*(y + LY*(z + LZ*t));
          }
          else{
            nn[8*pos+4] = (x-1) + LX*(y + LY*(z + LZ*t));
          }


        count++;
        }
      }
    }
  }
}
# 117 "cudagaugefix.cu"
void initnn_eo(){
  int x,y,z,t,index,nnpos,j, count;
  int evenpos=0;
  int oddpos=0;


  evenpos=0;
  oddpos=0;
  count=0;
  for(t=0;t<T;t++){
    for(z=0;z<LZ;z++){
      for(y=0;y<LY;y++){
        for(x=0;x<LX;x++){
          if( ((x+y+z+t) %2)==0){
            lexic2eo[count] = evenpos;
            evenpos++;
          }
          else{
            lexic2eo[count] = oddpos;
            oddpos++;
          }
          count++;
        }
      }
    }
  }




  evenpos=0;
  oddpos=0;
  count=0;
  for(t=0;t<T;t++){
   for(z=0;z<LZ;z++){
    for(y=0;y<LY;y++){
     for(x=0;x<LX;x++){
          index = ind[count];

          if(((t+x+y+z)%2 == 0)){
            nnpos = lexic2eo[index];
            for(j=0;j<4;j++){
              nn_eo[8*nnpos+j] = lexic2eo[ nn[8*index+j] ];
            }
            for(j=0;j<4;j++){
              nn_eo[8*nnpos+4+j] = lexic2eo[ nn[8*index+4+j] ];
            }
            eoidx_even[evenpos] = index;
            evenpos++;
          }
          else{
            nnpos = lexic2eo[index];
            for(j=0;j<4;j++){
              nn_oe[8*nnpos+j] = lexic2eo[ nn[8*index+j] ];
            }
            for(j=0;j<4;j++){
              nn_oe[8*nnpos+4+j] = lexic2eo[ nn[8*index+4+j] ];
            }
            eoidx_odd[oddpos] = index;
            oddpos++;
          }

        count++;
        }
      }
    }
  }
}







void init_gaugefixing(su3* gf, su3* trafo){
cudaError_t cudaerr;







  size_t dev_gfsize = 6*4*VOLUME * sizeof(dev_su3_2v);


  if((cudaerr=cudaMalloc((void **) &dev_gf, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of gauge field failed. Aborting...\n");
    exit(200);
  }
  else{
    printf("Allocated gauge field on device\n");
  }
# 228 "cudagaugefix.cu"
  h2d_gf = (dev_su3_2v *)malloc(dev_gfsize);
  su3to2v(gf,h2d_gf);

  cudaMemcpy(dev_gf, h2d_gf, dev_gfsize, cudaMemcpyHostToDevice);
# 242 "cudagaugefix.cu"
  dev_gfsize = 6*VOLUME * sizeof(dev_su3_2v);


  if((cudaerr=cudaMalloc((void **) &dev_trafo1, dev_gfsize)) != cudaSuccess){
    printf("Error in init_mixedsolve(): Memory allocation of trafo field failed. Aborting...\n");
    exit(200);
  }
  else{
    printf("Allocated trafo field 1 on device\n");
  }
# 267 "cudagaugefix.cu"
  h2d_trafo = (dev_su3_2v *)malloc(dev_gfsize);
  su3to2v_trafo(trafo,h2d_trafo);

  cudaMemcpy(dev_trafo1, h2d_trafo, dev_gfsize, cudaMemcpyHostToDevice);







  size_t nnsize = 8*VOLUME*sizeof(int);
  nn = (int *) malloc(nnsize);
  cudaMalloc((void **) &dev_nn, nnsize);

  size_t indsize = VOLUME*sizeof(int);
  ind = (int *) malloc(indsize);

  lexic2eo = (int *) malloc(indsize);



  size_t nnsize_evenodd = (size_t)8*VOLUME/2*sizeof(int);
  nn_oe = (int *) malloc(nnsize_evenodd);
  cudaMalloc((void **) &dev_nn_oe, nnsize_evenodd);
  nn_eo = (int *) malloc(nnsize_evenodd);
  cudaMalloc((void **) &dev_nn_eo, nnsize_evenodd);


  size_t indsize_evenodd = (size_t)VOLUME/2*sizeof(int);
  eoidx_even = (int *) malloc(indsize_evenodd);
  cudaMalloc((void **) &dev_eoidx_even, indsize_evenodd);
  eoidx_odd = (int *) malloc(indsize_evenodd);
  cudaMalloc((void **) &dev_eoidx_odd, indsize_evenodd);


  initnn();
  initnn_eo();





  cudaMemcpy(dev_nn, nn, nnsize, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_nn_eo, nn_eo, nnsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_nn_oe, nn_oe, nnsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_eoidx_even, eoidx_even, indsize_evenodd, cudaMemcpyHostToDevice);
  cudaMemcpy(dev_eoidx_odd, eoidx_odd, indsize_evenodd, cudaMemcpyHostToDevice);


  output_size = LZ*T*sizeof(double);
  cudaMalloc((void **) &dev_output, output_size);
  double * host_output = (double*) malloc(output_size);

  int grid[5];
  grid[0]=LX; grid[1]=LY; grid[2]=LZ; grid[3]=T; grid[4]=VOLUME;

  cudaMalloc((void **) &dev_grid, (size_t)(5*sizeof(int)));
  cudaMemcpy(dev_grid, &(grid[0]), (size_t)(5*sizeof(int)), cudaMemcpyHostToDevice);


    dev_gfix_init<<< 1, 1 >>> (dev_grid);



  if(VOLUME%128 != 0){
   printf("Error: VOLUME is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }


  int redfieldsize = VOLUME/128;
  printf("VOLUME/BLOCK = %d\n", VOLUME/128);
  cudaMalloc((void **) &dev_redfield_F, redfieldsize*sizeof(double));
  if((redfield_F = (double*)malloc(redfieldsize*sizeof(double)))==(void*)((void *)0)){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(F)\n");
  }
  cudaMalloc((void **) &dev_redfield_dAdA, redfieldsize*sizeof(double));
  if((redfield_dAdA = (double*)malloc(redfieldsize*sizeof(double)))==(void*)((void *)0)){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(dAdA)\n");
  }

  cudaMalloc((void **) &dev_redfield_maxdAdA, redfieldsize*sizeof(double));
  if((redfield_maxdAdA = (double*)malloc(redfieldsize*sizeof(double)))==(void*)((void *)0)){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(maxdAdA)\n");
  }

  cudaMalloc((void **) &dev_redfield_plaq, T*sizeof(double));
  if((redfield_plaq = (double*)malloc(T*sizeof(double)))==(void*)((void *)0)){
    fprintf(stderr,"Error in init_gaugefixing: malloc error(plaq)\n");
  }


printf("%s\n", cudaGetErrorString(cudaGetLastError()));

}






void finalize_gaugefixing(){

  cudaFree(dev_gf);
  cudaFree(dev_trafo1);





  cudaFree(dev_grid);
  cudaFree(dev_output);
  cudaFree(dev_nn);
  cudaFree(dev_redfield_F);
  cudaFree(dev_redfield_dAdA);
  cudaFree(dev_redfield_maxdAdA);
  cudaFree(dev_redfield_plaq);
  cudaFree(dev_nn_eo);
  cudaFree(dev_nn_oe);
  cudaFree(dev_eoidx_even);
  cudaFree(dev_eoidx_odd);
  free(h2d_gf);
  free(h2d_trafo);
  free(redfield_F);
  free(redfield_dAdA);
  free(redfield_maxdAdA);
  free(redfield_plaq);
  free(nn);
  free(nn_eo);
  free(nn_oe);
  free(eoidx_even);
  free(eoidx_odd);
  free(lexic2eo);
  free(ind);
}



void usage() {
  fprintf(stdout, "Code to compute Landau gauge on gauge field\n");
  fprintf(stdout, "Usage:   cudagaugefix -i [inputfile] [gaugefile]\n");
  exit(0);
}


int main(int argc, char *argv[]){

  int ret;
  double F,dada;
  double plaq;
  int c;

  int gridsize;
  if(VOLUME%128 != 0){
   printf("Error: VOLUME is not a multiple of BLOCK. Aborting...\n");
   exit(100);
  }
  dim3 blockdim(128,1,1);
  if( VOLUME >= 128){
   gridsize =VOLUME/128;
  }
  else{
   gridsize=1;
  }
  dim3 griddim(gridsize,1,1);


  char inputfilename[100];
  char gaugefilename[100];
  char fixedgaugename[100];

if (argc != 4){
  usage();
}

while ((c = getopt(argc, argv, "h?:i:")) != -1) {
      switch (c) {
          case 'i':
              strcpy ( &(inputfilename[0]) , optarg );
              printf("The input file is: %s\n", &(inputfilename[0]));
              break;
          case 'h':
          case '?':
          default:
              usage();
              break;
      }
  }

   strcpy ( &(gaugefilename[0]) , argv[3] );
   strcpy ( &(fixedgaugename[0]) , argv[3] );
   strcat ( &(fixedgaugename[0]) , "_landau" );

   printf("The gaugefield file is: %s\n", &(gaugefilename[0]));


  read_input(&(inputfilename[0]));
  printf("LX = %d, LY = %d, LZ = %d, T = %d\n", LX, LY, LZ, T);

  gf = (su3*) malloc(4*VOLUME*sizeof(su3));
  trafo1 = (su3*) malloc(VOLUME*sizeof(su3));
  trafo2 = (su3*) malloc(VOLUME*sizeof(su3));

  read_gf_ildg(gf, &(gaugefilename[0]));

  printf("Setting random seed to %d\n", randseed);
  PlantSeeds(randseed);


  random_init_trafo(trafo1);
  init_gaugefixing(gf, trafo1);
  init_MT(VOLUME, 4*VOLUME);






   plaq = calc_plaquette(dev_gf);





  printf("%s\n", cudaGetErrorString(cudaGetLastError()));

  F = gauge_functional(gf);
  dada = dAdA(gf);
  printf("HOST FUNC = %.16e\tHOST dAdA = %.16e\n", F, dada);
# 505 "cudagaugefix.cu"
 if(saflag==1){
   printf("Starting simulated annealing...\n");
   simannealing_gauge();
 }



 if(orxflag==1){
   printf("Starting overrelaxation...\n");
   ret = overrelax_gauge(orxmaxit, orxeps, orxcheckinterval);
    if(ret < 0){
     printf("Gauge condition not reached. Aborting...\n");
     finalize_gaugefixing();
     free(trafo1);
     free(trafo2);
     free(gf);
     exit(300);
   }
 }
# 546 "cudagaugefix.cu"
     plaq = calc_plaquette(dev_gf);




  printf("%s\n", cudaGetErrorString(cudaGetLastError()));



  printf("Transferring back to host...\n");

  printf("Applying trafo on host...\n");






    size_t dev_gfsize = 6*VOLUME * sizeof(dev_su3_2v);
    cudaMemcpy(h2d_trafo, dev_trafo1, dev_gfsize, cudaMemcpyDeviceToHost);
    from2vtosu3_trafo(trafo1, h2d_trafo);

  g_trafo(gf, trafo1);
  plaq = mean_plaq(gf);
  PLAQ = plaq;
  dada = dAdA(gf);
  DADA = dada;
  F = gauge_functional(gf);
  FUNC = F;
  printf("Final HOST values:\n");
  printf("PLAQ = %.16f\n", PLAQ);
  printf("F = %.16e \t dAdA = %.16e\t max(dAdA) = %.16e\n", FUNC, DADA, maxDADA);


  printf("Writing out the gauge fixed field ...");
  ret = write_gf_ildg(gf, &(fixedgaugename[0]), 64);
  if(ret!=0){
    fprintf(stderr, "Error writing gauge field. Aborting...\n");
    exit(400);
  }
  printf("done.\n");







  finalize_gaugefixing();
  free(trafo1);
  free(trafo2);
  free(gf);
}
