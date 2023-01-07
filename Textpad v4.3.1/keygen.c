/* Keygenerator for Textpad v4.3.1 - Protection: Twofish
   Don't forget to include twofish.c in your project.
   Made by tE!/TMG */

#include <windows.h>
#include "resource.h"
#include "aes.h"

HINSTANCE	hInst;
BOOL		sflag=FALSE;
POINT		opnt;

static char szAboutText[]=	"TextPad v4.3.1 Keygenerator\n\n"
							"Made by tHE EGOiSTE [TMG]\n\n"
							"Greetings fly over to:\n"
							"* Ousir / TNO *\n\n"
							"Have a nice day.";

void GenerateCode(HWND hDlg){
	static char hextab[]="0123456789abcdef";
	/* Only ucase, alphanumeric, nodigits, no "O" chars allowed */
	static char keychars[]="QPALYMXNCKSIWJEUDHFZGTRAXCQEFGTSHIWJGKDLMNDSPABREQCSTUVCWMXNYP";
	static char licBegin[]="BEGIN LICENSE\r\n";
	static char licEnd[]="END LICENSE\r\n";
	/* "66" mark must consist of digits */
	/* "????" -> number of licenses, "9999" -> unlimited users */
	static char noLic[]="66 9999";
	static char LicString[]="669999";
	static char kfmat[]="%.8lx";
	static char extKey[]="TMG\r\n";
	char		TF_key[40]={0x00};
	char		szName[100]={0x00};
	char		szCompany[100];
	char		Regcode[400]={0x00};
	char		Ciphertext[96]={0x00};
	int			i,j,k,l,m,nLen,cLen;
	BYTE		t, u;
	keyInstance    ki;
	cipherInstance ci;

	nLen=GetDlgItemTextA(hDlg, EDIT_NAME, szName, 46);
	cLen=GetDlgItemTextA(hDlg, EDIT_COMPANY, szCompany, 46);
	if	( (nLen < 1) || (cLen < 1) ) {
		SetDlgItemTextA(hDlg, EDIT_CODE, "Name and company must both contain at least 1 char.");
		return;
	}
	for (i=0; i<15; i++) Regcode[i]=licBegin[i];
	for (i=0; i<nLen; i++) Regcode[i+15]=szName[i];
	m=15+i;
	Regcode[m]=0x0D;
	Regcode[m+1]=0x0A;
	m+=2;
	for (i=0; i<cLen; i++) Regcode[m+i]=szCompany[i];
	m+=i;
	Regcode[m]=0x0D;
	Regcode[m+1]=0x0A;
	m+=2;
	
	for (i=0; i<7; i++) Regcode[m+i]=noLic[i];
	m+=i;

	for (i=0,j=0,l=0,k=GetTickCount(); i<16; i++,j++){ 
		if (j<nLen) k*=(int) ((int)szName[i]*0x7931563F);
		else k*=0x3973517B;
		__asm ror k, 9;
		u=t=keychars[((unsigned int)k%62)];
		Regcode[m+i]=u;
		TF_key[l]=hextab[((t & 0xF0) >> 4)];
		TF_key[l+1]=hextab[(u & 0x0F)];
		l+=2;
	}
	m+=i;
	for (i=0; i<5; i++) Regcode[m+i]=extKey[i];
	m+=i;

	for (i=0; i<6; i++) szName[i+90]=LicString[i];

	for (i=0; i<cLen; i++) szName[45+i]=szCompany[i];

	cipherInit(&ci, MODE_ECB, 0);
	makeKey(&ki, DIR_ENCRYPT, 128, TF_key);
	blockEncrypt(&ci, &ki,szName, (BLOCK_SIZE*6),Ciphertext);

    // Oh my god. The ASM lamer strikes back again...haha
	k=4;
	__asm {
			lea esi, Ciphertext
			lea edi, Regcode
			add edi, m
bloop:		mov	ebx, 6
cloop:		lodsb
			shl eax, 8
			lodsb
			shl eax, 8
			lodsb
			shl eax, 8
			lodsb
			push eax
			push offset kfmat
			push edi
			call dword ptr[wsprintfA]
			add	esp, 12
			add	edi, eax
			mov byte ptr[edi], 0x20
			inc edi
			dec	ebx
			jg cloop
			dec edi
			mov ax, 0x0A0D
			stosw
			dec k
			jg bloop
			lea	esi, licEnd
			mov ecx, 13
			rep movsb
	}

	/* Show Regcode */
	SetDlgItemTextA(hDlg, EDIT_CODE, Regcode);
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
			SendDlgItemMessageA(hDlg, EDIT_NAME, EM_SETLIMITTEXT, (WPARAM) 45, 0);
			SendDlgItemMessageA(hDlg, EDIT_COMPANY, EM_SETLIMITTEXT, (WPARAM) 45, 0);
			SetWindowTextA(hDlg, "TextPad 4.3.1 - Keygen by tE!/TMG");
			SetDlgItemTextA(hDlg, EDIT_CODE, "Enter your name and press Generate.");
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
