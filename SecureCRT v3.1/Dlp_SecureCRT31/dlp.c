/*	Finding discrete logarithms using Pollard's rho method.
	Made for finding private x in equation y = g^x (mod p)
	with given y, g and p.

    Note:
	Program has been made for solving the DLP which appears
	in ElGamal keycheck scheme of SecureCRT v3.1 and can't
	be used for solving DLPs in *general* without modifications.
	If youdon't understand the maths or number theory, reading of
	'Handbook of Applied Cryptography' is highly recommended.

	Base sourcecode was 'index.c' which comes bundled with
	the miracl library (freelip suxx).

	Numbers directly taken from 'securecrt.exe':

	09E9350F141FFAC5 -> p (prime)
	095CC918618D6ED4 -> g (generator)
	07E61ED4B9ACFD2E -> y 

    Sounds easy, but it is not. Many hours of work were needed
	to find/trace/understand the ElGamal system used there.
	Finding those numbers only, helps/means *nothing* - because
	they're only ... numbers. :-)

	First it's a good idea to check if the generator used is a
	generator of the maingroup and so, if the DLP must be solved
	in that maingroup or can be reduced to a smaller (subgroup).

	To find the order of g in the Group Z*(p), the following
	piece of code was used (created according to the info in
	'Handbook of Applied Cryptography', Chapter 4, page 162):

  int main()
{
    big pp[4];
    big p,n,t,a,a1;
    miracl *mip=mirsys(50,0);
 	long ee[]={2,3,1};		// exponents - (factorization of p-1: 2^2 * 3^3 * 177E1EF455A123^1)

    cp=mirvar(1);
	p =mirvar(0);
	n =mirvar(0);
	t =mirvar(0);
	a =mirvar(0);
	a1=mirvar(0);

	mip->IOBASE=16;
	
	// Unique prime factors of p-1
	cinstr(pp[0], "2");		//2^2
	cinstr(pp[1], "3");		//3^3
	cinstr(pp[2], "177E1EF455A123");

	cinstr(p, "09E9350F141FFAC5"); // prime modulus p
    cinstr(t, "09E9350F141FFAC4"); // t <- order of Group Z*(p) = p-1
	cinstr(a, "095CC918618D6ED4"); // group-element to check

	for (i=0;i<3;i++){
		power(pp[i],ee[i],n,n);		// n=p(i)^e(i)
        divide(t,n,t);				// t<-t/p(i)^e(i)
        powmod(a,t,p,a1);			// a1=a^t (mod p)
		while ( compare(a1,cp) !=0 ){
        powmod(a1,pp[i],p,a1);		// a1=a1^p(i)(mod p)
		multiply(t,pp[i],t);		// t<-t*p(i)
		}
	}
	printf("In Group ");
	cotnum(p, stdout);
	printf("Order of element ");
	cotnum(a, stdout);
	printf("Is: ");
	cotnum(t, stdout);	
    return 0;
}
	
	Result of the above code was order of g in Z*(p) = 1A6DE2D2E055476
	This means g is no generator of the group Z*(p), because its order is
	!= p-1. We know that p is prime (can be easily checked using the
	probabilistic primality test function isprime() of miracl. So, it's
	clear that the group p in Z is a multiplicative finite group of order
	p-1 (according to Euler's phi function). The order of a group is defined
	to be the number of elements in	the group. The order of an element 'A' in
	a group Z(p) is defined to be the least positive integer 't' that satisfies:
	1 = A^t (mod p). If 'A' is an element of group Z(p), then A is called a
	generator of that group if 1=A^(p-1). If a group has a generator then that
	group is called cyclic.
    
	Check: 95CC918618D6ED4^1A6DE2D2E055476 (mod 9E9350F141FFAC5) = 1

	Conclusion: the given generator is a generator of a subgroup of Z*(p), and
	so we can reduce our computations to this subgroup. Using Pollard's rho
	algorithm was a good choice for this approach...

        Fucks to all you guys out there who think you're too leet to help others.

	tHE EGOiSTE! / TMG
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
    int i,np=4;
    long iter;
	unsigned long tme,tsec,tmin;
    big pp[5],rem[5];
    big m,n,Q,R,q,w,x,g;
    big_chinese bc;
    miracl *mip=mirsys(50,0);
    for (i=0;i<5;i++) {
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
	cinstr(p, "09E9350F141FFAC5");
	/* Input order of generator s. top of source for sourcecode!*/
	cinstr(p1,"1A6DE2D2E055476");
	/* Input Element of subgroup */
	cinstr(q, "7E61ED4B9ACFD2E");
	/* Input generator of subgroup */
	cinstr(g, "95CC918618D6ED4");

	/* Input prime factors of p1 ; 'factor.exe' from miracl used for factorization */
	/* Please note that the order of that input *DOES* matter ! */
	cinstr(pp[0], "2");
	cinstr(pp[1], "3");
	cinstr(pp[2], "3");
	cinstr(pp[3], "177E1EF455A123");

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
	printf("Generator of subgroup = \t");
	cotnum(g, stdout);
	printf("Order of generator in Z*(p) = \t");
	cotnum(p1, stdout);
	printf("Factorization of Order = \t2 * 3^2 * 177E1EF455A123\n");
	printf("Working...Approx. running time: about 13 min. on a PII 300 CPU.\n\n");

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
        printf("%ld iterations needed processing prime factor %ld\n",iter,(i+1) );
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

