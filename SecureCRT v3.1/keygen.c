/* 	 SecureCRT v3.1 Keygenerator - by tE!/TMG
     Protection: ElGamal 64 / Messed up Ripe-MD 160 Hashes
     Note: You need the MIRACL bignum library to compile this.
	 Include mirlib.lib in your project.

     Oh, yes. Before I forget it: Please don't blame me for my
	 C code style. I never liked high-level languages. So, if
	 you think I suck - fuck you :-)
  */

#include <windows.h>
#include <stdio.h>
#include "resource.h"
#include "miracl.h"


HINSTANCE hInst;
BOOL		sflag=FALSE;
POINT		opnt;
static char szAboutText[]=	"SecureCRT v3.1 Keygenerator\n\n"
							"Made by tHE EGOiSTE [TMG]\n\n"
							"Greetings fly over to:\n"
							"* Ousir / TNO *\n\n"
							"Have a nice day.";

static char hextab[]=		"0123456789ABCDEF";

static unsigned char Fill[]={
		0x7F,0x08,0xAC,0x57,0x4D,0xD2,0x31,0x52,0x48,0x9C,0x90,0x37,0x43,0xFC,0xA2,0x74,
		0x2E,0x6E,0x90,0x03,0x63,0xBF,0x59,0x62,0xF2,0x39,0x05,0x00,0x70,0x3E,0x02,0x76,
		0xC3,0x4A,0x70,0x72,0x23,0x35,0xA4,0x25,0x57,0x3B,0xEF,0x6C,0x7D,0x05,0x90,0x00,
		0xC2,0x68,0x4A,0x14,0x8D,0x40,0xF0,0x21,0x68,0x41,0xA5,0x7B,0xEA,0x0E,0xD4,0x6F,
		0x03,0x8A,0x36,0x68,0x10,0x24,0x67,0x07,0x58,0x48,0xB9,0x2F,0x07,0x46,0x2B,0x5E,
		0x33,0x33,0x3F,0x70,0x65,0x04,0xDC,0x01,0x9C,0x91,0x4D,0x58,0x21,0x98,0x61,0x11,
		0xE3,0x13,0xB0,0x74,0xF0,0x39,0x16,0x20,0x49,0x71,0x54,0x46,0xDE,0x50,0x00,0x67,
		0x90,0x2F,0x77,0x59,0xAF,0x1D,0x9B,0x3D,0xFA,0x2E,0xA2,0x27,0x9F,0x3D,0x01,0x08};

void InitRipe(char *lpI){
	__asm {
	mov edi, lpI
	mov	dword ptr[edi+00h], 067452301h
	mov	dword ptr[edi+04h], 0EFCDAB89h
	mov	dword ptr[edi+08h], 098BADCFEh
	mov	dword ptr[edi+0Ch], 010325476h
	mov	dword ptr[edi+10h], 0C3D2E1F0h
	}
}

void EConvert(char *lpB){
	__asm {
	mov	esi, lpB
	mov	edi, esi
	push 16
	pop ecx
eco1:
	lodsd
	mov	ebx, eax
	rol	ebx, 8
	and	ebx, 000FF00FFh
	ror	eax, 8
	and	eax, 0FF00FF00h
	or	eax, ebx
	stosd
	dec	ecx
	jg	eco1
	}
}

void Ripe_X86(char *lpInit, char *lpData){ 
	__asm { 
	push	lpData
	push	lpInit
#include "rmd-586.asm" 
	} 
}

void PrepareBuffer(char *Dest, char *Source, int bLen, int pLen){
	int i,j,k;
	for (i=0; i<bLen; i++) Dest[i+pLen]=Source[i];
	j=64-(i+pLen);
	for (k=0; k<j; k++, i++) Dest[i+pLen]=Fill[k];
}

void FinalizeBuffer(char *Dest, char *Source, int bLen, int pLen){
	int i,j,k;
	for (i=0; i<bLen; i++) Dest[i+pLen]=Source[i];
	Dest[i+pLen]=(char)0x80;
	i++;
	j=64-(i+pLen);
	for (k=0; k<j; k++, i++) Dest[i+pLen]=0x00;
}

void GenerateCode(HWND hDlg){
	static char EG_g[]		=	"095CC918618D6ED4";
	static char EG_p[]		=	"09E9350F141FFAC5";
	static char EG_x[]		=	"096BD96A271C5CCD";
	static char fpDATE[]	=	"%.2lu-%.2lu-%.4lu";
	static char fhDATE[]	=	"%.2lu%.2lu%.2lu";
	static char fpSERIAL[]	=	"03-31-%.6lu";
	static char fhSERIAL[]	=	"0331%.6lu";

	SYSTEMTIME		lTime;
	char			szName[40];
	char			szCompany[40];
	char			szRegcode[40]={0x00};
	char			szR1[20]={0x00};
	char			szR2[20]={0x00};
	char			szDate[16];
	char			szSerial[16];
	char			szTName[40];
	char			szTCompany[40];
	char			szTDate[16];
	char			szTSerial[16];
	char			szHash[42];
	char			RipeMD[64]={0x00};
	char			HashMe[64];
	int				*lpCheck=(int*)&HashMe[60];
	int				i,j,t, nLen, cLen, sLen, dLen;
	unsigned int 	Serial, tS;
	miracl			*mip;
	big				k,p,g,x,m,a,b,y;

	nLen=GetDlgItemTextA(hDlg, EDIT_NAME, szName, 31);
	if	( (nLen < 1) || (nLen > 30) ){
		SetDlgItemTextA(hDlg, EDIT_CODE, "Invalid Username.");
		return;
	}
	cLen=GetDlgItemTextA(hDlg, EDIT_COMPANY, szCompany, 31);
	if	( (cLen < 1) || (cLen > 30) ){
		SetDlgItemTextA(hDlg, EDIT_CODE, "Invalid Company.");
		return;
	}

	if	( (cLen + nLen > 37) ){
		SetDlgItemTextA(hDlg, EDIT_CODE, "Both names must not exceed 37 chars.");
		return;
	}

	GetLocalTime(&lTime);
	wsprintfA(szDate, fpDATE, lTime.wMonth, lTime.wDay, lTime.wYear);
	dLen=wsprintfA(szTDate, fhDATE, lTime.wMonth, lTime.wDay, lTime.wYear);
	SetDlgItemTextA(hDlg, EDIT_DATE, szDate);

	Serial=lTime.wMilliseconds+13;
	for (i=0,j=0; i < nLen; i++){
		if ( (szName[i]>=0x61) && (szName[i]<=0x7A) ) {
			szTName[j]=szName[i]-0x20;
			j++;
		}
		if ( (szName[i]>=0x41) && (szName[i]<=0x5A) ) {
			szTName[j]=szName[i];
			j++;
		}
		if ( (szName[i]>=0x30) && (szName[i]<=0x39) ) {
			szTName[j]=szName[i];
			j++;
		}
		Serial*=szName[i];
		Serial+=0xA1137331;
		__asm rol Serial, 11;
	}
	szTName[j]=0x00;
	nLen=j;

	for (i=0,j=0; i < cLen; i++){
		if ( (szCompany[i]>=0x61) && (szCompany[i]<=0x7A) ) {
			szTCompany[j]=szCompany[i]-0x20;
			j++;
		}
		if ( (szCompany[i]>=0x41) && (szCompany[i]<=0x5A) ) {
			szTCompany[j]=szCompany[i];
			j++;
		}
		if ( (szCompany[i]>=0x30) && (szCompany[i]<=0x39) ) {
			szTCompany[j]=szCompany[i];
			j++;
		}
		Serial*=szCompany[i];
		Serial^=(unsigned int) lTime.wSecond;
		__asm rol Serial, 5;
	}
	szTCompany[j]=0x00;
	cLen=j;

	/* 1) Reduce serial range. 1st digit of last serial part must be < "4"
	 * 2) Make k rel. prime */
	while (1) {
	tS=Serial%=389999;
	if	( ((tS%2)!=0) && ((tS%3)!=0) ) break;
	Serial++;
	}

	wsprintfA(szSerial, fpSERIAL, Serial);
	sLen=wsprintfA(szTSerial, fhSERIAL, Serial);
	SetDlgItemTextA(hDlg, EDIT_SERIAL, szSerial);

	InitRipe(RipeMD);

	PrepareBuffer(HashMe, szTName, nLen, 0);
	EConvert(HashMe);
	Ripe_X86(RipeMD, HashMe);
	j=64-nLen;
	for (i=0; i<64; i++) HashMe[i]=Fill[i+j];
	EConvert(HashMe);
	Ripe_X86(RipeMD, HashMe);

	t=0x80-nLen;
	for (i=0; i<nLen; i++) HashMe[i]=Fill[i+t];
	PrepareBuffer(HashMe, szTCompany, cLen, nLen);
	EConvert(HashMe);
	Ripe_X86(RipeMD, HashMe);

	t=0x40-(nLen+cLen);
	for (i=0; i<64; i++) HashMe[i]=Fill[i+t];
	EConvert(HashMe);
	Ripe_X86(RipeMD, HashMe);

	t=0x80-(nLen+cLen);
	for (i=0; i<(nLen+cLen); i++) HashMe[i]=Fill[i+t];
	PrepareBuffer(HashMe, szTSerial, sLen, (nLen+cLen) );
	EConvert(HashMe);
	Ripe_X86(RipeMD, HashMe);

	t=0x40-(nLen+cLen+sLen);
	for (i=0; i<64; i++) HashMe[i]=Fill[i+t];
	EConvert(HashMe);
	Ripe_X86(RipeMD, HashMe);

	t=0x80-(nLen+cLen+sLen);
	for (i=0; i<(nLen+cLen+sLen); i++) HashMe[i]=Fill[i+t];
	FinalizeBuffer(HashMe, szTDate, dLen, (nLen+cLen+sLen) );
	EConvert(HashMe);
	
	lpCheck[0]=(( (nLen+cLen+sLen+dLen) * 8 ) + 0xC00);
	Ripe_X86(RipeMD, HashMe);
	EConvert(RipeMD);

	for	(i=0, j=0; i<20; i++){
		szHash[j]=hextab[((0xF0 & RipeMD[i]) >> 4)];
		szHash[j+1]=hextab[(0x0F & RipeMD[i])];
		j+=2;
	}
	szHash[j]&=0x00;

	/* Initialize Miracl System */
	mip=mirsys(100,0);

	/* Initialize Bignum variables */
	k=mirvar(0);
	p=mirvar(0);
	g=mirvar(0);
	x=mirvar(0);
	m=mirvar(0);
	y=mirvar(0);
	a=mirvar(0);
	b=mirvar(0);

	/* Set IO-BASE = 16 */
	mip->IOBASE=16;

	/* Input Bignumbers */
	convert(Serial,k);
	cinstr(p,EG_p);
	cinstr(g,EG_g);
	cinstr(x,EG_x);
	cinstr(m,szHash);

	/* y=g^(big)k mod p 
	   -> Serial part 1 */

	powmod(g,k,p,y);

	decr(p,1,p);

	/* a=xy mod p-1 */
	multiply(x,y,a);
	divide(a,p,b);

	/* b=m-a mod p-1 */
	subtract(m,a,b);
	divide(b,p,a);

	/* m=b/k mod p-1 ( 1/k (mod p-1) first, then b*1/k (mod p-1) )
	   -> Serial part 2 */

	xgcd(k,p,k,k,k);
	multiply(b,k,a);
	divide(a,p,b);
	
	cotstr(y, szR1);
	cotstr(a, szR2);

	mirkill(k);
	mirkill(p);
	mirkill(g);
	mirkill(x);
	mirkill(m);
	mirkill(y);
	mirkill(a);
	mirkill(b);

	/* Apply leading zeros */
	j=lstrlenA(szR1);
	t=16-j;
	for (i=0; i<t; i++) szRegcode[i]=0x30;
	for (i=0; i<j; i++) szRegcode[i+t]=szR1[i];

	j=lstrlenA(szR2);
	t=16-j;
	for (i=0; i<t; i++) szRegcode[i+16]=0x30;
	for (i=0; i<j; i++) szRegcode[i+t+16]=szR2[i];

	/* Show Regcode */
	SetDlgItemTextA(hDlg, EDIT_CODE, szRegcode);
}

BOOL CALLBACK DlgPA (HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
	POINT	pnt;
	POINT	tpnt;
	RECT	wrc; 

	switch (message)
	{
		case WM_MOUSEMOVE :
			if ( sflag==FALSE ) break;
			GetCursorPos(&pnt);
			GetWindowRect(hDlg, &wrc);
			tpnt.x=pnt.x-opnt.x+wrc.left;
			tpnt.y=pnt.y-opnt.y+wrc.top;
			opnt.x=pnt.x;
			opnt.y=pnt.y;
			MoveWindow(hDlg,(int)tpnt.x,(int)tpnt.y,(int)(wrc.right-wrc.left),(int)(wrc.bottom-wrc.top),TRUE);
			break;
		case WM_LBUTTONUP :
			ReleaseCapture();
			sflag=FALSE;
			break;
		case WM_LBUTTONDOWN :
			GetCursorPos(&opnt);
			SetCapture(hDlg);
			sflag=TRUE;
			break;
		case WM_INITDIALOG :
			SendDlgItemMessageA(hDlg, STATIC_ABOUT, WM_SETTEXT, 0, (LPARAM) szAboutText);
			return TRUE;
		case WM_COMMAND :
			if ( LOWORD (wParam) == IDCANCEL) EndDialog (hDlg, 0);
			break;
     }
     return FALSE;
}

BOOL CALLBACK DlgP (HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch (message)
	{
		case WM_INITDIALOG :
			SendDlgItemMessageA(hDlg, EDIT_NAME, EM_SETLIMITTEXT, (WPARAM) 30, 0);
			SendDlgItemMessageA(hDlg, EDIT_COMPANY, EM_SETLIMITTEXT, (WPARAM) 30, 0);
			SetWindowTextA(hDlg, "SecureCRT v3.1 - Keygen by tE!/TMG");
			SetDlgItemTextA(hDlg, EDIT_CODE, "Enter name and company and press Generate.");
			return TRUE;
		case WM_COMMAND :
			switch (LOWORD (wParam))
			{
				case BT_ABOUT :
					DialogBoxA(hInst, MAKEINTRESOURCE(DLG_ABOUT), hDlg, DlgPA);
					break;
				case BT_GENERATE :
					GenerateCode(hDlg);			
					SetFocus(GetDlgItem(hDlg, EDIT_NAME));
					break;
				case IDCANCEL :
					EndDialog (hDlg, 0);
					break;
			}
			break;
     }
     return FALSE;
}

int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR szCmdLine, int iCmdShow)
{
	hInst=hInstance;
	DialogBoxA(hInstance, MAKEINTRESOURCE(DLG_MAIN), 0, DlgP);
	return 0;
}
