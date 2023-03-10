/* 
 *   MIRACL compiler/hardware definitions - mirdef.h
 *   This version suitable for use with most 32-bit computers
 *   e.g. 80386+ PC, VAX, Archimedes. Assembly language versions of muldiv,
 *   muldvm and muldvd will be necessary. See mrmuldv.any 
 *
 *   Also suitable for DJGPP GNU C Compiler
 *   Copyright (c) 1988-1997 Shamus Software Ltd.
 */

#define MIRACL 32
#define MR_LITTLE_ENDIAN    /* This may need to be changed        */
#define mr_utype int
                            /* the underlying type is usually int *
                             * but see mrmuldv.any                */
#define mr_unsign32 unsigned int
                            /* 32 bit unsigned type               */
#define MR_IOBSIZ     1024
                            /* I/O buffer size        */
#define MR_FLASH      52      
                            /* delete this definition if integer  *
                             * only version of MIRACL required    */
                            /* Number of bits per double mantissa */


