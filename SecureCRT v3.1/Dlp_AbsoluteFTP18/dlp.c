/*	Finding discrete logarithms using Pollard's rho method.
	Made for finding private x in equation y = g^x (mod p)
	with given y, g and p.

    Note:
	Program has been made for solving the DLP which appears
	in ElGamal keycheck scheme of AbsoluteFTP v1.8 and can't
	be used for solving DLPs in *general* without modifications.
	If youdon't understand the maths or number theory, reading of
	'Handbook of Applied Cryptography' is highly recommended.

	Base sourcecode was 'index.c' which comes bundled with
	the miracl library (freelip suxx).

	Numbers directly taken from 'AbsoluteFTP.EXE':

    F2A53E6CE5F365F1 -> p (prime)
	00509DB816146DA0 -> g (generator) -> order=p-1 here! so it's generator of main group
	A1CC1714B0411C67 -> y

    Factorization of F2A53E6CE5F365F0 (p-1):
    2^4 * 5 * 29 * 368F * 58DC9F43F5

	tHE EGOiSTE // TMG
 */

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <miracl.h>

static big p,p1,order,lim1,lim2;

void iterate(big x,big q,big r,big a,big b)
{ /* apply Pollards random mapping */
    if (compare(x,lim1)<0)
    {
        mad(x,q,q,p,p,x);
        incr(a,1,a);
        if (compare(a,order)==0) zero(a);
        return;
    }
    if (compare(x,lim2)<0)
    {
        mad(x,x,x,p,p,x);
        premult(a,2,a);
        if (compare(a,order)>=0) subtract(a,order,a);
        premult(b,2,b);
        if (compare(b,order)>=0) subtract(b,order,b);
        return;
    }
    mad(x,r,r,p,p,x);
    incr(b,1,b);
    if (compare(b,order)==0) zero(b);
}

long rho(big q,big r,big m,big n)
{ /* find q^m = r^n */
    long iter,rr,i;
    big ax,bx,ay,by,x,y;
    ax=mirvar(0);
    bx=mirvar(0);
    ay=mirvar(0);
    by=mirvar(0);
    x=mirvar(1);
    y=mirvar(1);
    iter=0L;
    rr=1L;
    do
    { /* Brent's Cycle finder */
        copy(y,x);
        copy(ay,ax);
        copy(by,bx);
        rr*=2;
        for (i=1;i<=rr;i++)
        {
            iter++;
            iterate(y,q,r,ay,by);
            if (compare(x,y)==0) break;
        }
    } while (compare(x,y)!=0);

    subtract(ax,ay,m);
    if (size(m)<0) add(m,order,m);
    subtract(by,bx,n);
    if (size(n)<0) add(n,order,n);
    mirkill(y);
    mirkill(x);
    mirkill(by);
    mirkill(ay);
    mirkill(bx);
    mirkill(ax);
    return iter;
}

int main()
{
    int i,np=8;

    long iter;
	unsigned long tme,tsec,tmin;
    big pp[8],rem[8];
    big m,n,Q,R,q,w,x,g;
    big_chinese bc;
    miracl *mip=mirsys(50,0);
    for (i=0;i<8;i++) {
        pp[i]=mirvar(0);
        rem[i]=mirvar(0);
    }
	g=mirvar(0);
    q=mirvar(0);
    Q=mirvar(0);
    R=mirvar(0);
    w=mirvar(0);
    m=mirvar(0);
    n=mirvar(0);
    x=mirvar(0);
    p=mirvar(0);
    p1=mirvar(1);
    order=mirvar(0);
    lim1=mirvar(0);
    lim2=mirvar(0);

	/* Set Numberbase to Hex. */
	mip->IOBASE=16;
	/* Input prime p */
	cinstr(p, "F2A53E6CE5F365F1");
	/* Input order of generator s. top of source for sourcecode!*/
	cinstr(p1,"F2A53E6CE5F365F0");
	/* Input Element of subgroup */
	cinstr(q, "A1CC1714B0411C67");
	/* Input generator of subgroup */
	cinstr(g, "00509DB816146DA0");

	/* Input prime factors of p1 ; 'factor.exe' from miracl used for factorization */
    /* Please note that the order of the input *DOES* matter. */

	cinstr(pp[0], "5");
	cinstr(pp[1], "2");
	cinstr(pp[2], "2");
	cinstr(pp[3], "2");
	cinstr(pp[4], "2");
	cinstr(pp[5], "29");
	cinstr(pp[6], "368F");
	cinstr(pp[7], "58DC9F43F5");

	
	/* Determine limits */
	subdiv(p,3,lim1);
    premult(lim1,2,lim2);

	/* Output some unimportant crap :-) */
	printf("Approach to solve a discrete logarithm problem in Z*(p) - the finite\n");
	printf("multiplicative Group of positive integers modulo a prime 'p'.\n");
	printf("Problem: Find valid x in y=g^x (mod p), where y, g and p are known and\n");
	printf("g is a generator of a subgroup of Z*(p). Used Algorithm: Pollard rho.\n\n");
	printf("Prime modulus p = \t\t");
	cotnum(p, stdout);
	printf("Group element y = \t\t");
	cotnum(q, stdout);
	printf("Generator of group = \t\t");
	cotnum(g, stdout);
	printf("Order of generator in Z*(p) = \t");
	cotnum(p1, stdout);
	printf("Factorization of Order = \t5*2*2*2*2*29*368F*58DC9F43F5\n");
	printf("Working...Approximate running time on a PII 300: 9 sec. \n\n");

	tme=GetTickCount();

    crt_init(&bc,np,pp);		// init Chinese remainder thereom
    for (i=0;i<np;i++) { 
        copy(p1,w);
        divide(w,pp[i],w);		// (p-1) / primefactor(i) of p-1
        powmod(q,w,p,Q);		// Q=y^w (mod p)
		powmod(g,w,p,R);		// R=alpha^w (mod p)

		copy(pp[i],order);		// order = primefactor(i) of p-1
        iter=rho(Q,R,m,n);
        xgcd(m,order,w,w,w);
        mad(w,n,n,order,order,rem[i]);
        printf("%lu iterations needed processing prime factor %lu \n",iter,(i+1) );
    }

	crt(&bc,rem,x);				// apply Chinese remainder thereom

	tsec=(GetTickCount()-tme)/1000;
	tmin=tsec/60;
	tsec%=60;
    printf("\nFound discrete log = \t");
    cotnum(x,stdout);
	powmod(g,x,p,w);
    crt_end(&bc);
    printf("Verification = \t\t");
    cotnum(w,stdout);
	printf("\n\nTime needed: %lu minutes, %lu seconds.",tmin,tsec);
	printf("\n\nHave a nice day.");
	/* Clean Up */
	mirkill(g);
   	mirkill(q);
	mirkill(Q);
	mirkill(R);
	mirkill(w);
	mirkill(m);
 	mirkill(n);
	mirkill(x);
	mirkill(p);
	mirkill(p1);
	mirkill(order);
	mirkill(lim1);
	mirkill(lim2);
    return 0;
}

