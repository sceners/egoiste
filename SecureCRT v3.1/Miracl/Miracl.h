#ifndef MIRACL_H
#define MIRACL_H

/*
 *   main MIRACL header - miracl.h.
 *
 *   Copyright (c) 1988-1997 Shamus Software Ltd.
 */

#include "mirdef.h"

               /* error returns */

#define MR_ERR_BASE_TOO_BIG    1
#define MR_ERR_DIV_BY_ZERO     2
#define MR_ERR_OVERFLOW        3
#define MR_ERR_NEG_RESULT      4
#define MR_ERR_BAD_FORMAT      5
#define MR_ERR_BAD_BASE        6
#define MR_ERR_BAD_PARAMETERS  7
#define MR_ERR_OUT_OF_MEMORY   8
#define MR_ERR_NEG_ROOT        9
#define MR_ERR_NEG_POWER       10
#define MR_ERR_BAD_ROOT        11
#define MR_ERR_INT_OP          12
#define MR_ERR_FLASH_OVERFLOW  13
#define MR_ERR_TOO_BIG         14
#define MR_ERR_NEG_LOG         15
#define MR_ERR_DOUBLE_FAIL     16
#define MR_ERR_IO_OVERFLOW     17
#define MR_ERR_NO_MIRSYS       18
#define MR_ERR_BAD_MONT_MOD    19
#define MR_ERR_NO_MONT_MOD     20
#define MR_ERR_EXP_TOO_BIG     21
#define MR_ERR_NOT_SUPPORTED   22
#define MR_ERR_NOT_DOUBLE_LEN  23

               /* some useful definitions */

#define forever for(;;)   
#define FALSE 0
#define TRUE 1
#define OFF 0
#define ON 1
#define PLUS 1
#define MINUS (-1)

#define MR_MAXDEPTH 24
                                  /* max routine stack depth */

#define MR_IBITS 8*sizeof(int)
                                  /* no of Bits in int   */
#ifdef  MR_FLASH
#define MR_EBITS (8*sizeof(double) - MR_FLASH)
                                  /* no of Bits per double exponent */
#endif

#define MR_HASH_BYTES     20


/* Marsaglia & Zaman Random number generator */
/*         constants      alternatives       */
#define NK   37           /* 21 */
#define NJ   24           /*  6 */
#define NV   14           /*  8 */

 
/* big and flash variables consist of an array of mr_smalls */

typedef int BOOL;
typedef unsigned mr_utype mr_small;
#ifdef mr_dltype
typedef unsigned mr_dltype mr_large;
#endif
typedef mr_small *big;
typedef mr_small *flash;


#ifdef MR_LITTLE_ENDIAN
#define MR_TOP(x) (*(((mr_small *)&(x))+1))
#define MR_BOT(x) (*(((mr_small *)&(x))))
#endif
#ifdef MR_BIG_ENDIAN
#define MR_TOP(x) (*(((mr_small *)&(x))))
#define MR_BOT(x) (*(((mr_small *)&(x))+1))
#endif

/* chinese remainder theorem structures */

typedef struct {
big *C;
big *V;
big *M;
int NP;
} big_chinese;

typedef struct {
mr_utype *C;
mr_utype *V;
mr_utype *M;
int NP;
} small_chinese;


/* secure hash Algorithm structure */

typedef struct {
mr_unsign32 length[2];
mr_unsign32 h[5];
mr_unsign32 w[80];
} sha;

/* advanced encryption algorithm structure */

typedef struct {
int Nk,Nr;
BOOL CBC;
mr_unsign32 *fkey;
mr_unsign32 *rkey;
mr_unsign32 chain[4];
} aes;


#define MR_PROJECTIVE 0
#define MR_AFFINE     1


/* Elliptic Curve epoint structure. Uses projective (X,Y,Z) co-ordinates */

typedef struct {
big X;
big Y;
big Z;
int marker;
} epoint;


/* Structure for Brickell method for finite *
   field exponentiation with precomputation */

typedef struct {
    big *table;
    big n;
    int base;
    int store;
} brick;

/* Structure for Brickell method for elliptic *
   curve  exponentiation with precomputation  */

typedef struct {
    epoint **table;
    big a,b,n;
    int base;
    int store;
} ebrick;

/* main MIRACL instance structure */

typedef struct {
mr_small MSBIT;         /* msb of mr_small    */
mr_small OBITS;         /* other bits      */

mr_small base;       /* number base     */
mr_small apbase;     /* apparent base   */
int   pack;          /* packing density */
int   lg2b;          /* bits in base    */
mr_small base2;      /* 2^mr_lg2b          */
int alignment;
BOOL (*user)(void);  /* pointer to user supplied function */


int   nib;           /* length of bigs  */
int   depth;                 /* error tracing ..*/
int   trace[MR_MAXDEPTH];    /* .. mechanism    */
BOOL  check;         /* overflow check  */
BOOL  fout;          /* Output to file   */
BOOL  fin;           /* Input from file  */
BOOL  active;

FILE  *infile;       /* Input file       */
FILE  *otfile;       /* Output file      */

mr_unsign32 ira[NK];  /* random number...   */
int         rndptr;   /* ...array & pointer */
mr_unsign32 borrow;

int pool_ptr;
char pool[MR_HASH_BYTES];

                       /* Montgomery constants */
mr_small ndash;
big modulus;
BOOL ACTIVE;
                       /* Elliptic Curve details */
big A,B;
int coord,Asize,Bsize;

int logN;           /* constants for fast fourier fft multiplication */
int nprimes,degree;
mr_utype *prime,*cr;
mr_utype *inverse,**roots;
small_chinese chin;
mr_utype const1,const2,const3;
mr_small msw,lsw;
mr_utype **s1,**s2;   /* pre-computed tables for polynomial reduction */
mr_utype **t;         /* workspace */
mr_utype *w;

big w0;            /* workspace bigs  */
big w1,w2,w3,w4;
big w5,w6,w7;
big w5d,w6d,w7d;
big w8,w9,w10,w11;
big w12,w13,w14,w15;

/* User modifiables */

char *IOBUFF; /* i/o buffer    */

BOOL ERCON;        /* error control   */
int  ERNUM;        /* last error code */
int  NTRY;         /* no. of tries for probablistic primality testing   */
int  TOOBIG;       /* bigger than int */
int  IOBASE;       /* base for input and output */
BOOL EXACT;        /* exact flag      */
BOOL RPOINT;       /* =ON for radix point, =OFF for fractions in output */
BOOL TRACER;       /* turns trace tracker on/off */
int  INPLEN;       /* input length               */
int *PRIMES;       /* small primes array         */

#ifdef MR_FLASH
int          BTS;   
unsigned int MSK;
int   workprec;
int   stprec;        /* start precision */

int RS,RD;
double D;

double db,n,p;
int a,b,c,d,r,q,oldn,ndig;

#ifdef mr_dltype
mr_large u,v,ku,kv;
#else
mr_small u,v,ku,kv;
#endif

BOOL last,carryon;
flash pi;

#endif
#ifdef MR_PENTIUM

double* dmodulus;
double* dw0;

#endif

#ifdef MR_KCM
big big_ndash;
big ws;
#endif

} miracl;

/* Preamble and exit code for MIRACL routines. *
 * Not used if MR_STRIPPED_DOWN is defined     */ 

#ifdef MR_STRIPPED_DOWN
#define MR_OUT
#define MR_IN(N)
#else
#define MR_OUT  mr_mip->depth--;        
#define MR_IN(N)                       \
    mr_mip->depth++;                   \
    if (mr_mip->depth<MR_MAXDEPTH)     \
    {                                  \
     mr_mip->trace[mr_mip->depth]=(N); \
     if (mr_mip->TRACER) mr_track();   \
    }
#endif

#ifndef MR_NOFULLWIDTH

#define MAXBASE ((mr_small)1<<(MIRACL-1))
                                  /* maximum number base size */
#else

#define MAXBASE ((mr_small)1<<(MIRACL-2))

#endif

/* Function definitions  */

/* Group 0 - Internal routines */

extern void  mr_berror(int);
extern void  mr_setbase(mr_small);
extern void  mr_track(void);
extern void  mr_lzero(big);
extern BOOL  mr_notint(flash);
extern int   mr_lent(flash);
extern void  mr_padd(big,big,big);
extern void  mr_psub(big,big,big);
extern void  mr_pmul(big,mr_small,big);
extern mr_small mr_sdiv(big,mr_small,big);
extern void  mr_shift(big,int,big); 
extern void  *mr_alloc(int,int);
extern void  mr_free(void *);  
extern void  mr_set_align(int);
extern void  set_user_function(BOOL (*)(void));
extern int   mr_testbit(big,int);
extern int   mr_fft_init(int,big,big,BOOL);
extern void  mr_dif_fft(int,int,mr_utype *);
extern void  mr_dit_fft(int,int,mr_utype *);
extern void  fft_reset(void);

extern int   mr_poly_mul(int,big*,int,big*,big*);
extern int   mr_poly_sqr(int,big*,big*);
extern void  mr_polymod_set(int,big*,big*);
extern int   mr_poly_rem(int,big *,big *);

extern int   mr_ps_big_mul(int,big *,big *,big *);
extern int   mr_ps_zzn_mul(int,big *,big *,big *);

extern mr_small muldiv(mr_small,mr_small,mr_small,mr_small,mr_small *);
extern mr_small muldvm(mr_small,mr_small,mr_small,mr_small *); 
extern mr_small muldvd(mr_small,mr_small,mr_small,mr_small *); 
extern void     muldvd2(mr_small,mr_small,mr_small *,mr_small *); 

/* Group 1 - General purpose, I/O and basic arithmetic routines  */

extern int   igcd(int,int); 
extern int   isqrt(int,int);
extern void  irand(mr_unsign32);
extern mr_small brand(void);       
extern void  zero(flash);
extern void  __cdecl convert(int,big);
extern void  lgconv(long,big);
extern flash __cdecl mirvar(int);//changed
extern void  __cdecl mirkill(big);
extern miracl *get_mip(void);
extern miracl *__cdecl mirsys(int,mr_small);//changed
extern void  __cdecl mirexit(void);
extern int   exsign(flash);
extern void  insign(int,flash);
extern int   getdig(big,int);  
extern int   numdig(big);        
extern void  putdig(int,big,int);
extern void  copy(flash,flash);  
extern void  negate(flash,flash);
extern void  absol(flash,flash); 
extern int   size(big);
extern int   compare(big,big);
extern void  add(big,big,big);
extern void  subtract(big,big,big);
extern void  incr(big,int,big);    
extern void  __cdecl decr(big,int,big);    
extern void  premult(big,int,big); 
extern int   subdiv(big,int,big);  
extern BOOL  subdivisible(big,int);
extern int   remain(big,int);   
extern mr_small normalise(big,big);
extern void  __cdecl multiply(big,big,big);
extern void  fft_mult(big,big,big);
extern void  __cdecl divide(big,big,big);  
extern BOOL  divisible(big,big);   
extern void  mad(big,big,big,big,big,big);
extern int   instr(flash,char *);
extern int   otstr(flash,char *);
extern int   __cdecl cinstr(flash,char *);
extern int   __cdecl cotstr(flash,char *);
extern int   innum(flash,FILE *);          
extern int   otnum(flash,FILE *);
extern int   cinnum(flash,FILE *);
extern int   cotnum(flash,FILE *);

/* Group 2 - Advanced arithmetic routines */

extern mr_utype smul(mr_utype,mr_utype,mr_utype);
extern mr_utype spmd(mr_utype,mr_utype,mr_utype); 
extern mr_utype invers(mr_utype,mr_utype);
extern mr_utype sqrmp(mr_utype,mr_utype);

extern void  gprime(int);
extern int   jack(big,big);
extern int   __cdecl egcd(big,big,big);
extern int   xgcd(big,big,big,big,big);
extern int   logb2(big);
extern void  expint(int,int,big);
extern void  sftbit(big,int,big);
extern void  power(big,long,big,big);
extern void  __cdecl powmod(big,big,big,big);
extern void  powmod2(big,big,big,big,big,big);
extern void  powmodn(int,big *,big *,big,big);
extern int   powltr(int,big,big,big);
extern void  lucas(big,big,big,big,big);
extern BOOL  nroot(big,int,big);
extern BOOL  sqroot(big,big,big);
extern void  bigrand(big,big);
extern void  bigdig(int,int,big);
extern int   trial_division(big,big);
extern BOOL  isprime(big);
extern BOOL  nxprime(big,big);
extern BOOL  nxsafeprime(int,int,big,big);
extern BOOL  crt_init(big_chinese *,int,big *);
extern void  crt(big_chinese *,big *,big);
extern void  crt_end(big_chinese *);
extern BOOL  scrt_init(small_chinese *,int,mr_utype *);    
extern void  scrt(small_chinese*,mr_utype *,big); 
extern void  scrt_end(small_chinese *);
extern BOOL  brick_init(brick *,big,big,int);
extern void  pow_brick(brick *,big,big);
extern void  brick_end(brick *);
extern BOOL  ebrick_init(ebrick *,big,big,big,big,big,int);
extern void  ebrick_end(ebrick *);
extern int   mul_brick(ebrick*,big,big,big);

/* Montgomery stuff */

extern mr_small __cdecl prepare_monty(big);
extern void  __cdecl nres(big,big);        
extern void  __cdecl redc(big,big);        

extern void  nres_negate(big,big);
extern void  nres_modadd(big,big,big);    
extern void  nres_modsub(big,big,big);    
extern void  nres_premult(big,int,big);
extern void  __cdecl nres_modmult(big,big,big);    
extern int   __cdecl nres_moddiv(big,big,big);     
extern void  nres_dotprod(int,big *,big *,big);
extern void  __cdecl nres_powmod(big,big,big);     
extern void  nres_powltr(int,big,big);     
extern void  nres_powmod2(big,big,big,big,big);     
extern void  nres_powmodn(int,big *,big *,big);
extern BOOL  nres_sqroot(big,big);
extern void  nres_lucas(big,big,big,big);
extern BOOL  nres_multi_inverse(int,big *,big *);

extern void  shs_init(sha *);
extern void  shs_process(sha *,int);
extern void  shs_hash(sha *,char *);

extern BOOL  aes_init(aes *,int,char *,char *);
extern void  aes_encrypt(aes *,char *);
extern void  aes_decrypt(aes *,char *);
extern void  aes_reset(aes *,char *);
extern void  aes_end(aes *);

extern void  strong_init(int,char *,mr_unsign32);   
extern void  strong_rng(int,char *);

/* special modular multipliers */

extern void  comba_mult(big,big,big);
extern void  comba_square(big,big);
extern void  comba_redc(big,big);
extern void  comba_add(big,big,big);
extern void  comba_sub(big,big,big);


extern void  fastmodmult(double*,double*,double*);
extern void  fastmodsquare(double*,double*);   

extern void  kcm_mul(big,big,big);
extern void  kcm_sqr(big,big); 
extern void  kcm_redc(big,big); 

extern void  kcm_multiply(int,big,big,big);
extern void  kcm_square(int,big,big);

/* elliptic curve stuff */

extern void ecurve_init(big,big,big,int);
extern void ecurve_add(epoint *,epoint *);
extern void ecurve_sub(epoint *,epoint *);
extern void ecurve_multi_add(int,epoint **,epoint **);
extern void ecurve_mult(big,epoint *,epoint *);
extern void ecurve_mult2(big,epoint *,big,epoint *,epoint *);
extern void ecurve_multn(int,big *,epoint**,epoint *);

extern epoint* epoint_init(void);
extern BOOL epoint_set(big,big,int,epoint*);
extern int  epoint_get(epoint*,big,big);
extern int  epoint_norm(epoint *);
extern void epoint_free(epoint *);
extern void epoint_copy(epoint *,epoint *);
extern BOOL epoint_comp(epoint *,epoint *);

/* Group 3 - Floating-slash routines      */

#ifdef MR_FLASH
extern void  fpack(big,big,flash);
extern void  numer(flash,big);    
extern void  denom(flash,big);    
extern BOOL  fit(big,big,int);    
extern void  build(flash,int (*)(big,int));
extern void  round(big,big,flash);         
extern void  flop(flash,flash,int *,flash);
extern void  fmul(flash,flash,flash);      
extern void  fdiv(flash,flash,flash);      
extern void  fadd(flash,flash,flash);      
extern void  fsub(flash,flash,flash);      
extern int   fcomp(flash,flash);           
extern void  fconv(int,int,flash);         
extern void  frecip(flash,flash);          
extern void  ftrunc(flash,big,flash);      
extern void  fmodulo(flash,flash,flash);
extern void  fpmul(flash,int,int,flash);   
extern void  fincr(flash,int,int,flash);   
extern void  dconv(double,flash);          
extern double fdsize(flash);
extern void  frand(flash);

/* Group 4 - Advanced Flash routines */ 

extern void  fpower(flash,int,flash);
extern BOOL  froot(flash,int,flash); 
extern void  fpi(flash);             
extern void  fexp(flash,flash);      
extern void  flog(flash,flash);      
extern void  fpowf(flash,flash,flash);
extern void  ftan(flash,flash); 
extern void  fatan(flash,flash);
extern void  fsin(flash,flash); 
extern void  fasin(flash,flash);
extern void  fcos(flash,flash);  
extern void  facos(flash,flash); 
extern void  ftanh(flash,flash); 
extern void  fatanh(flash,flash);
extern void  fsinh(flash,flash); 
extern void  fasinh(flash,flash);
extern void  fcosh(flash,flash); 
extern void  facosh(flash,flash);
#endif


/* Test predefined Macros to determine compiler type, and hopefully 
   selectively use fast in-line assembler (or other compiler specific
   optimisations. Note I am unsure of Microsoft version numbers. So I 
   suspect are Microsoft.

   Note: It seems to be impossible to get the 16-bit Microsoft compiler
   to allow inline 32-bit op-codes. So I suspect that INLINE_ASM == 2 will
   never work with it. Pity. 

#define INLINE_ASM 1    -> generates 8086 inline assembly
#define INLINE_ASM 2    -> generates mixed 8086 & 80386 inline assembly,
                           so you can get some benefit while running in a 
                           16-bit environment on 32-bit hardware (DOS, WIndows
                           3.1...)
#define INLINE_ASM 3    -> generate true 80386 inline assembly - (Using DOS 
                           extender, Windows '95/Windows NT)
                           Actually optimised for Pentium

#define INLINE_ASM 4    -> 80386 code in the GNU style (for (DJGPP)

Small, medium, compact and large memory models are supported for the
first two of the above.
                        
*/

#ifndef MR_NOASM
#ifndef MR_NOFULLWIDTH

/* Borland C/Turbo C */

    #ifdef __TURBOC__ 
    #ifndef __HUGE__
        #define ASM asm
        #if defined(__COMPACT__) || defined(__LARGE__)
            #define MR_LMM
        #endif

        #if MIRACL==16
            #define INLINE_ASM 1
        #endif

        #if __TURBOC__>=0x410
            #if MIRACL==32
#if defined(__SMALL__) || defined(__MEDIUM__) || defined(__LARGE__) || defined(__COMPACT__)
                    #define INLINE_ASM 2
                #else
                    #define INLINE_ASM 3
                #endif
            #endif
        #endif
    #endif
    #endif

/* Microsoft C */

    #ifdef _MSC_VER
    #ifndef M_I86HM
        #define ASM _asm
        #if defined(M_I86CM) || defined(M_I86LM)
            #define MR_LMM
        #endif
        #if _MSC_VER>=600
            #if MIRACL==16
                #define INLINE_ASM 1
            #endif
        #endif
        #if _MSC_VER>=1000
            #if MIRACL==32
                #define INLINE_ASM 3
            #endif
        #endif     
    #endif       
    #endif


/* DJGPP GNU C */

    #ifdef __GNUC__
    #ifdef i386
        #define ASM __asm__ __volatile__
        #if MIRACL==32
            #define INLINE_ASM 4
        #endif
    #endif
    #endif

#endif
#endif


/* 
   The following contribution is from Tielo Jongmans, Netherlands
   These inline assembler routines are suitable for Watcom 10.0 and up 

   Added into miracl.h.  Notice the override of the original declarations 
   of these routines, which should be removed.

   The following pragma is optional, it is dangerous, but it saves a 
   calling sequence
*/

/*

#pragma off (check_stack);

extern unsigned int muldiv(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int *);
#pragma aux muldiv=                 \
       "mul     edx"                \
       "add     eax,ebx"            \
       "adc     edx,0"              \
       "div     ecx"                \
       "mov     [esi],edx"          \
    parm [eax] [edx] [ebx] [ecx] [esi]   \
    value [eax]                     \
    modify [eax edx];

extern unsigned int muldvm(unsigned int, unsigned int, unsigned int, unsigned int *);
#pragma aux muldvm=                 \
        "div     ebx"               \
        "mov     [ecx],edx"         \
    parm [edx] [eax] [ebx] [ecx]    \
    value [eax]                     \
    modify [eax edx];

extern unsigned int muldvd(unsigned int, unsigned int, unsigned int, unsigned int *);
#pragma aux muldvd=                 \
        "mul     edx"               \
        "add     eax,ebx"           \
        "adc     edx,0"             \
        "mov     [ecx],eax"         \
        "mov     eax,edx"           \
    parm [eax] [edx] [ebx] [ecx]    \
    value [eax]                     \
    modify [eax edx];

*/


#endif









