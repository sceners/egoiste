;------------------------------------------------------------------------
; Powerstrip Keygen * 160 Bit RSA (!) 2000 by tHE EGOiSTE // TMG
; Assemble:
; tasm32 /mx /m4 /z keygen.asm
; tlink32 -x -V4.0 -Tpe -aa -c keygen.obj,keygen,,,keygen.def,keygen.res
;------------------------------------------------------------------------

.386
.MODEL FLAT, STDCALL
LOCALS
UNICODE	= 0

; Adjust paths
INCLUDELIB G:\KTA\BIN\LIBGEN\imp32i.lib
INCLUDE E:\UNZIPPED\KTA\BIN\w32.inc

ICON_BIG		=	1
BT_CLIP                 =	200
BT_EXIT                 =	201
KEYGEN_ICON             =	101
IDD_MAIN                =	103
PTR_EMAIL               =	104
EDIT_NAME               =	1001
EDIT_KEY                =	1002
IDC_ABOUT		=	1003
GHND 			=	GMEM_MOVEABLE OR GMEM_ZEROINIT
;
extrn	OpenClipboard		:	PROC
extrn	CloseClipboard		:	PROC
extrn	GetClipboardData	:	PROC
extrn	EmptyClipboard		:	PROC
extrn	SetClipboardData	:	PROC
extrn	IsClipboardFormatAvailable :	PROC
extrn	wsprintfA		: 	PROC
extrn	CharUpperA		: 	PROC
extrn	GetCursor		: 	PROC
extrn	DrawMenuBar		: 	PROC
extrn	DeleteMenu 		: 	PROC
extrn	GetSystemMenu 		: 	PROC
extrn	SetCursor 		: 	PROC
extrn	ChildWindowFromPoint 	: 	PROC
extrn	GetTickCount		: 	PROC
extrn	GetCursorPos		: PROC
extrn	ScreenToClient		: PROC

MINCHARS	=	4
MAXCHARS	=	31

.DATA
wtext		db "Powerstrip v2.70.05 - Keygen by tE!",0
defname		db "tHE EGOiSTE [TMG]",0
infocap		db "Info",0
aboutcap	db "About",0
err_cap  	db "Error",0
clipflag	db 0
clipmsg		db "* TMG - Cream of the Scene *",0
  align 4
fmat		db "%.8lX",0
  align 4
pnt		POINT <>
  align 4
rec		RECT <>
;---------------------------------------------------------------------------------------------
nameerr		db "Username 4 to 31 Chars. No leading/trailing spaces.",0
abouttxt	db "Another fine TMG Keygenerator",13,10
		db "     made by tHE EGOiSTE",13,10,13,10
		db "Program:",9,"Powerstrip v2.70.05",13,10
		db "OS:",9,"Win9xNT",13,10
		db "Date:",9,"07-23-2000",13,10
		db "Notes:",9,"n/a",0

RSA_d:	dw	10	; 160 Bit/16
	db	09h,010h,09Ah,0BBh,0BAh,008h,050h,0D5h,04Ah,0B8h,07Fh,024h,012h,0A7h,01Ch,0B3h,027h,0AAh,0DCh,00Dh,0,0

RSA_n:	dw	10	; 160 Bit/16
	db	04Eh,072h,096h,0FBh,031h,01Eh,07Ch,0A8h,031h,0F5h,0C5h,099h,023h,0E0h,069h,017h,0FAh,08Bh,023h,0Dh,0,0

.DATA?
hAbout		dd ?
save_esp	dd ?
bbtn		dd ?
cursor_e	dd ?
hdlg		dd ?
_hInst          dd ?
nlen		dd ?

userinput	db 60 dup(?)
tempname	db 60 dup(?)
userkey		db 60 dup(?)
.CODE

Start:	pushad
	call	GetModuleHandle, 0
	test	eax,eax
	je	ExitKeyGen
        mov	_hinst,eax
	call	DialogBoxParamA, _hinst, IDD_MAIN, 0, offset DlgProc, 0
ExitKeyGen:
	popad
	call	ExitProcess, 0
	RET

;---------------------------------------------------------------------------------------------
DlgProc proc __hwnd:HWND, wmsg:UINT, _wparam:WPARAM, _lparam:LPARAM
   uses  ebx, edi, esi
	mov 	eax, wmsg

	cmp	eax, WM_CTLCOLORSTATIC
	jz	_statcol
	cmp	eax, WM_LBUTTONUP
	jnz	_nlbu
	call	GetCursor
	cmp	eax, cursor_e
	jnz	_nM
	call	MessageBoxA, hdlg, offset abouttxt, offset aboutcap, MB_ICONINFORMATION OR MB_OK OR MB_APPLMODAL
	jmp	_nM
_nlbu:	cmp	eax, WM_SETCURSOR
	jz	_setcursor
_ncu:	cmp	eax,WM_CLOSE
	jz	_wmdestroy
	cmp	eax,WM_COMMAND
	jz	_wmcommand
	cmp	eax,WM_INITDIALOG
	jz	_initdlg
_nM:	xor	eax, eax
	RET
;---------------------------------------------------------------------------------------------

_setcursor:
	call	GetCursorPos, offset pnt
	call	ScreenToClient, hAbout, offset pnt
	mov	eax, pnt.pt_x
	test	eax, eax
	js	rrroud
	mov	ebx, pnt.pt_y
	test	ebx, ebx
	js	rrroud
	cmp	eax, rec.rc_right
	ja	rrroud
	cmp	ebx, rec.rc_bottom
	ja	rrroud
	call	SetCursor, cursor_e
	push	1
	pop	eax
	RET
rrroud:	jmp	_nM

_statcol:
	mov	eax, _lparam
	cmp	eax, hAbout
	jne	noco
	call	SetBkMode, _wparam, OPAQUE
	call	SetBkColor, _wparam, 0
	call	SetTextColor, _wparam, 000c0c0c0H
	mov	eax, bbtn			; return brushhandle
	RET
noco:	jmp	_nM
;---------------------------------------------------------------------------------------------
_wmdestroy:
	call	DeleteObject, bbtn
	call	EndDialog, hdlg, 0
	RET
_wmcommand:
	mov	eax, _wParam
	cmp	ax, EDIT_NAME
	jnz	nogen
	shr	eax, 16
	cmp	ax, EN_CHANGE
	jnz	nogen
	call	Generate
	xor	eax, eax
	RET
nogen:	cmp	ax, BT_CLIP
	jnz	noclip
	call	KeytoClip
	jmp	_cout	
noclip:	cmp	ax, BT_EXIT
	jz	_wmdestroy
_cout:	xor	eax, eax
	RET
;---------------------------------------------------------------------------------------------


_initdlg:
	mov	eax, __hwnd
	mov	hdlg, eax

	call	GetDlgItem, __hwnd, IDC_ABOUT
	mov	hAbout, eax
	call	GetClientRect, eax, offset rec

	call	GetDlgItem, __hwnd, EDIT_NAME
	call	SendMessageA, eax, EM_SETLIMITTEXT, MAXCHARS, 0

	call	LoadIcon, _hinst, KEYGEN_ICON
	test	eax,eax
	je	@iconerr
	call	SendMessage, __hwnd, WM_SETICON, ICON_BIG, eax
@iconerr:
	call	SetWindowTextA, __hwnd, offset wtext
	call	SetDlgItemTextA, __hwnd, EDIT_NAME, offset defname

	call	GetSystemMenu, __hwnd, FALSE
	mov	esi, eax
	mov	edi, offset DeleteMenu
	call	edi, esi, SC_RESTORE, MF_BYCOMMAND
	call	edi, esi, SC_MAXIMIZE, MF_BYCOMMAND
	call	edi, esi, SC_SIZE, MF_BYCOMMAND
	call	DrawMenuBar, __hwnd

	call	CreateSolidBrush, 0	; black
	mov	bbtn, eax

	call	LoadCursorA, _hInst, PTR_EMAIL
	mov	cursor_e, eax

	push	1
	pop	eax
	RET
DlgProc ENDP
;---------------------------------------------------------------------------------------------
KeytoClip proc
	LOCAL len:DWORD, hmemtemp:DWORD, lpb:DWORD
	xor	eax, eax
	lea	ecx, [eax-1]
	lea	edi, userkey
	cmp	clipflag, 0
	jnz	@@ok
	lea	edi, clipmsg
@@ok:	mov	lpb, edi
	repnz	scasb
	not	ecx
	mov	eax, ecx
	mov	len, eax
	call	GlobalAlloc, GHND, eax  		; OR GMEM_SHARE removed
	mov	hmemtemp, eax
	test	eax, eax
	jz	@@out
	call	GlobalLock, hmemtemp
  ;; Copy text to allocated mem-block
	mov	ecx, len
	mov	esi, lpb
	mov	edi, eax
	mov	eax, ecx
	and	eax, 3
	shr	ecx, 2
	cld
	repz	movsd
	mov	ecx, eax
	repz	movsb
	call	GlobalUnlock, hmemtemp	
	call	OpenClipboard, hdlg
	call	EmptyClipboard				; free clipboard
	call	SetClipboardData, CF_TEXT, hmemtemp	; hmemtemp -> (newowner)Windows
	call	CloseClipboard
@@out:	RET
KeytoClip endp

;------------------------------------------------------------------------------
;############################ GENERATE KEY ####################################
;------------------------------------------------------------------------------

Generate PROC
	call	GetDlgItemTextA, hdlg, EDIT_NAME, offset userinput, MAXCHARS+1
	cmp	eax, MINCHARS
	mov	clipflag, 0
	jl	@@err
	mov	nlen, eax	
;------------------------------------------------------------------------------
	lea	esi, userinput
	mov	edi, esi
	mov	ecx, nlen
@@n1:	lodsb
	dec	ecx	
	jz	@@err
	cmp	al, 20h
	jz	@@n1
@@n2:	stosb
	lodsb
	test	al, al
	jnz	@@n2
	stosb
	dec	edi
@@wow:	and	byte ptr[edi], al
	cmp	byte ptr[edi-1], 20h
	jnz	@@nok
	dec	edi
	jmp	@@wow	
@@nok:	lea	edi, userinput
	xor	eax, eax
	lea	ecx, [eax-1]
	repnz	scasb
	not	ecx
	dec	ecx
	mov	eax, ecx
	mov	nlen, eax
	cmp	eax, MINCHARS
	mov	clipflag, 0
	jl	@@err

	lea	edi, tempname
	lea	esi, userinput
; Create temp. copy of username and clear rest of buffer
	push	40
	pop	edx
	sub	edx, eax
	mov	ecx, eax
	rep	movsb
	mov	ecx, edx
	sub	eax, eax
	rep	stosb
; Powerstrip uses standard RSA scheme: Serial = Username ^ d mod n
	call	RSA_PRIVATE_ENCRYPT, offset RSA_d, offset RSA_n, offset tempname, offset tempname, nlen
; Convert result to ASCII
	lea	edi, userkey
	lea	esi, tempname
	movzx	ecx, word ptr[esi]
	add	ecx, ecx
	inc	esi
	inc	esi
@@l1:	xor	eax, eax
	lodsb	
	mov	bl, al
	and	ebx, 15
	shr	eax, 4
	mov	al, cctab[eax]
	mov	ah, cctab[ebx]
	stosw
	dec	ecx
	jg	@@l1
	and	byte ptr[edi], 0
;------------------------------------------------------------------------------
	call	SetDlgItemTextA, hDlg, EDIT_KEY, offset userkey
	mov	clipflag, 1
fzk:	xor	eax, eax
	RET
@@err:	call	SetDlgItemTextA, hDlg, EDIT_KEY, offset nameerr
	jmp	fzk
cctab	db	"0123456789ABCDEF"
Generate ENDP

;*--------------------------------------------------------------------------*
; Function:    int RSA_PRIVATE_ENCRYPT (P1,P2,P3,P4,P5);
;
; Description: Calculates C=M ^ D MOD N
;
; Parameters:  P1) pointer to private exponent D
;              P2) pointer to modulus N
;              P3) pointer to message M   (source buffer/plaintext)
;              P4) pointer to ciphertext  (destination buffer)
;              P5) length of M [Bytes]
; Returns:      0 = OK
;              -1 = ERROR
; Notes:       D and N have to be in Bignum format used by the
;              math routines. I.e. that the first WORD represents
;              the SIZE of the following number in BITS divided by 16 !
;              M will be converted to Bignum format automatically.
;              Ciphertext is in Bignum format with corrected byte order. 
;              Base for Big numbers is 16
;*--------------------------------------------------------------------------*
RSA_PRIVATE_ENCRYPT proc lpD:DWORD, lpN:DWORD, lpM:DWORD, lpC:DWORD, ml:DWORD

LOCAL	mem_D:DWORD, mem_N:DWORD, mem_M:DWORD, mem_Temp:DWORD,\
	mem_Temp2:DWORD, mem_Result:DWORD, Bitpos:DWORD, cnt:DWORD,\
	expbits:DWORD, isodd:DWORD
USES	ebx,esi,edi

	and	isodd, 0
	mov	esi, lpD
	cmp	word ptr[esi], 0
	jle	@@err
	mov	eax, ml
	shr	eax, 1
	jnc	@@ncs
	inc	eax
	inc	isodd
@@ncs:	mov	esi, lpN
	cmp	word ptr[esi], 0
	jle	@@err
	test	ax, ax
	jz	@@err
;;	cmp	[esi], ax
;;	jl	@@err				; Powerstrip keycheck sucks ... allows M > N :(

	call	VirtualAlloc, 0, 4160, MEM_COMMIT, PAGE_READWRITE
	test	eax, eax
	jz	@@err
	mov	mem_D, eax
	add	eax, 520
	mov	mem_N, eax
	add	eax, 520
	mov	mem_M, eax
	mov	edi, eax
	add	eax, 520
	mov	mem_Temp, eax
	add	eax, 1040
	mov	mem_Temp2, eax
	add	eax, 520
	mov	mem_Result, eax
	and	word ptr[eax], 0		; virtualalloc set this 0 already, but i'm running in paranoia mode :P

	mov	ebx, ml
	shr	ebx, 1
	adc	ebx, 0
	mov	[edi], bx
	inc	edi
	inc	edi
	mov	ecx, ebx
	mov	esi, lpM
	cld
	rep	movsw

	mov	edi, mem_N
	mov	esi, lpN
	movzx	ecx, word ptr[esi]
	inc	ecx
	rep	movsw

	mov	edi, mem_D
	mov	esi, lpD
	movzx	ecx, word ptr[esi]
	mov	eax, ecx
	shl	eax, 4
	mov	expbits, eax
	inc	ecx
	rep	movsw

	call	REV_BIGNUM, mem_N, 0		; byte order reversing needed in order to get math. correct results
	call	REV_BIGNUM, mem_M, isodd	; ''
	call	REV_BIGNUM, mem_D, 0		; ''

	mov	esi, mem_M
	mov	edi, mem_Temp
	movzx	ecx, word ptr[esi]
	inc	ecx
	rep	movsw

	xor	edi, edi
	mov	Bitpos, edi			; initialize bitcounter
	jmp	@@l2
@@l1:	
;
;	mem_Temp = mem_Temp ^ 2 
;
	call	BiG_SQR, mem_Temp, mem_Temp
;
;	mem_Temp = mem_Temp MOD mem_N */* mem_Temp2 used as Dummy to hold quotient (which is of no use here)
;
	call	BiG_DIV, mem_Temp, mem_N, mem_Temp2, mem_Temp

	dec	cnt
	jg	@@l1
	mov	esi, mem_Temp
	mov	edi, mem_Result
	cmp	word ptr[edi], 0
	jnz	@@nff
	movzx	ecx, word ptr[esi]
	inc	ecx
	cld
	rep	movsw
	jmp	@@tal
@@nff:
	call	BiG_MUL, mem_Result, mem_Temp, mem_Result
	call	BiG_DIV, mem_Result, mem_N, mem_Temp2, mem_Result

@@tal:	mov	edi, bitpos
@@l2:	inc	Bitpos
	mov	eax, expbits
	cmp	bitpos, eax
	jge	@@exit

	mov	eax, bitpos
	xor	edx, edx
	push	8
	pop	ebx
	div	ebx
	mov	esi, mem_D
	mov	bl, [esi+eax+2]
	push	1
	pop	eax
	mov	ecx, edx
	shl	eax, cl
	test	bl, al				; bit set ?
	jz	@@l2				; no -> test next
	mov	eax, bitpos
	sub	eax, edi			; calc. delta
	mov	cnt, eax			; init square counter
	jmp	@@l1	
@@exit:
;
; Test if final mul. is needed - thus when D is odd
;
	mov	esi, mem_D
	test	byte ptr[esi+2], 1
	jz	@@done
	call	BiG_MUL, mem_Result, mem_M, mem_Result
	call	BiG_DIV, mem_Result, mem_N, mem_Temp2, mem_Result
@@done:	call	REV_BIGNUM, mem_Result, 0
	mov	esi, mem_Result
	mov	edi, lpC
	movzx	ecx, word ptr[esi]
	inc	ecx
	rep	movsw	
	call	VirtualFree, mem_D, 4160, MEM_DECOMMIT
	RET
@@err:	mov	esi, lpC
	and	word ptr[esi], 0	
	or 	eax, -1
	RET
RSA_PRIVATE_ENCRYPT endp


;*---------------------------------------------------*
; Function:    void REV_BIGNUM(P1,P2);
;
; Description: Reverses byteorder of a Bignum
;
; Parameters:  P1) pointer to Bignumber
;              P2) Message Odd/Even signal 
; Notes:       P2 added for this keygen only!
; Returns:     Always 0
;              Stack Restored on Exit
;*---------------------------------------------------*
REV_BIGNUM proc
	push	ebp		
	mov	ebp, esp
	sub	esp, 520
	mov	edi, esp
	push	ebx
	push	edi
	push	esi
	mov	esi, [ebp+8]
	movzx	ecx, word ptr[esi]
	cmp	ecx, 256
	jg	@@out
	inc	esi
	inc	esi
	push	esi
	lea	edx, [ecx*2]
	cld
	rep	movsw
	lea	esi, [edi-1]
	pop	edi
	mov	ecx, edx
	sub	esi, [ebp+12]
	sub	ecx, [ebp+12]
	std
@@l1:	lodsb
	mov	[edi], al
	inc	edi
	dec	ecx
	jg	@@l1
	cld	
@@out:	pop	esi
	pop	edi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	xor	eax, eax
	RET	8
REV_BIGNUM endp


;*-------------------------------------------------------*
; Function:    int BiG_DIV(P1,P2,P3,P4);
; Description: 
; Parameters:  P1) pointer to Bignum to divide
;              P2) pointer to Divisor
;              P3) pointer to Quotient  (dest. Buffer 1)
;              P4) pointer to Remainder (dest. Buffer 2)
; Returns:   0 = OK 
;           -1 = Error (e.g. Div. by Zero)
;              Stack Restored on Exit
;*-------------------------------------------------------*
BiG_DIV proc
	push	ebp		
	mov	ebp, esp
	sub	esp, 2600			; free some space on stack..badly needed for local copies :)
	mov	eax, esp
	push	ebx
	push	edi
	push	esi
	mov	ebx, eax			; save start address

	mov	esi, [ebp+8]	
	mov	edi, [ebp+12]	
	mov	ax, [esi]	
	mov	dx, [edi]	
	test	dx, dx
	jz	@@dbzerr			; division by zero error

	push	edi		
	mov	edi, ebx	
	xor	ecx, ecx
	mov	cx, ax		
	shr	cx, 1
	adc	cx, 0
	cld
	rep	movsd			
	movsw			
	mov	cx, ax
	add	cx, cx
	lea	edi, [ebx+ecx+2]
	and	word ptr [edi], 0

	pop	esi		
	lea	edi, [ebx+1030]
	xor	ecx, ecx
	mov	cx, dx		
	shr	cx, 1
	adc	cx, 0
	cld
	rep	movsd			
	movsw			
	mov	cx, dx
	add	cx, cx
	lea	edi, [ebx+ecx+1032]
	and	word ptr [edi], 0

	push	ebp		
	mov	ebp, ebx		

	xor	eax, eax
	xor	ecx, ecx
	mov	ax, [ebp]	
	test	ax, ax
	jz	@@goon
	add	eax, eax
;
; Remove leading zeros		
;
	mov	esi, eax
@@l1:	cmp	word ptr [ebp+esi], 0
	jnz	@@inzo1
	sub	esi, 2		
	jnz	@@l1
@@inzo1:
	shr	esi, 1		
	mov	eax, esi		
	mov	word ptr [ebp], ax
@@goon:
	mov	ax, [ebp+1030]	
	test	ax, ax
	jz	@@isdo
	add	eax, eax
				
	mov	esi, eax
@@l2:	cmp	word ptr [ebp+esi+1030], 0
	jnz	@@inzo2
	sub	esi, 2		
	jnz	@@l2	
@@inzo2:
	shr	esi, 1		
	mov	eax, esi		
	mov	[ebp+1030], ax	

@@isdo:	test	ax, ax
	jnz	@@w4
	pop	ebp
	jmp	@@dbzerr
@@w4:	cmp	word ptr [ebp], 0
	jnz	@@w5
	pop	ebp
	jmp	@@zerdiv

@@w5:	xor	ecx, ecx
	mov	cx, [ebp]
	cmp	cx, [ebp+1030]	
	jc	@@dab
	jnz	@@dchs		
	mov	eax, ecx		
	add	eax, eax
	lea	esi, [ebp]
	lea	edi, [ebp+1030]
	add	esi, eax		
	add	edi, eax		
	std
	repz	cmpsw
	cld
	jc	@@dab		
@@dchs:
	mov	ax, [ebp+1030]
	shr	ax, 1
	adc	ax, 0
	cmp	ax, 1		
	jz	@@shdiv		
;
; Start division
;
	xor	eax, eax
	mov	ax, [ebp+1030]
	shr	ax, 1
	adc	ax, 0
	mov	esi, eax
	shl	esi, 2
	sub	esi, 2		
	cmp	esi, 10		
	jb	@@dm1a		

	mov	ebx, [ebp+esi+1030]	
	mov	eax, [ebp+esi+1026]
	mov	edx, [ebp+esi+1022]

	xor	ecx, ecx
@@l3:	cmp	ebx, 80000000h			; check for 2^31 overflow
	jae	@@dm2
	inc	cx
	clc
	rcl	edx, 1
	rcl	eax, 1
	rcl	ebx, 1		
	jmp	@@l3

@@dm1a:	mov	ebx, [ebp+esi+1030]	
	mov	eax, [ebp+esi+1026]

	xor	ecx, ecx			; init cnt
@@l4:	cmp	ebx, 80000000h	
	jae	@@dm2		
	inc	cx
	clc
	rcl	eax, 1
	rcl	ebx, 1		
	jmp	@@l4

@@dm2:	mov	[ebp+2578], cx			; save exp.
	mov	[ebp+2570], ebx	
	mov	[ebp+2574], eax	

@@dm3:	inc	word ptr [ebp]	
	inc	word ptr [ebp]
	xor	eax, eax
	mov	ax, [ebp]
	shr	ax, 1
	adc	ax, 0
	mov	esi, eax
	shl	esi, 2
	sub	esi, 2
	mov	dword ptr [ebp+esi], 0

	xor	eax, eax
	mov	ax, [ebp+1030]
	shr	ax, 1
	adc	ax, 0
	mov	esi, eax
	shl	esi, 2
	sub	esi, 2		

	xor	ecx, ecx
	mov	cx, [ebp]
	shr	cx, 1
	adc	cx, 0
	mov	edi, ecx
	shl	edi, 2
	sub	edi, 2		
	push	edi
	sub	edi, esi	
	inc	edi		
	mov	ecx, edi
	shr	ecx, 2		
	pop	esi		
	sub	edi, 3		
	push	edi		
;
; Division loop
;
@@sdm:	cmp	esi, 14
	jb	@@dib
	push	edi
	mov	edx, [ebp+esi]	
	mov	eax, [ebp+esi-4]
	mov	ebx, [ebp+esi-8]
	mov	edi, [ebp+esi-12]
	push	ecx
	mov	cx, [ebp+2578]
@@l5:	test	cx, cx
	jz	@@w6
	rcl	edi, 1
	rcl	ebx, 1
	rcl	eax, 1
	rcl	edx, 1
	dec	cx
	jmp	@@l5
@@w6:	pop	ecx
	pop	edi
	jmp	@@cqd

@@dib:	mov	edx, [ebp+esi]	
	mov	eax, [ebp+esi-4]
	mov	ebx, [ebp+esi-8]
	push	ecx
	mov	cx, [ebp+2578]
@@l6:	cmp	cx, 0
	jz	@@w7
	rcl	ebx, 1
	rcl	eax, 1
	rcl	edx, 1
	dec	cx
	jmp	@@l6
@@w7:	pop	ecx

@@cqd:	mov	[ebp+2582], eax
	mov	[ebp+2586], ebx
	mov	ebx, [ebp+2570]
	cmp	ebx, edx
	jz	@@bm1

	div	ebx			; eax => mv

	mov	[ebp+2566], eax
	test	eax, eax
	jnz	@@w8
	jmp	@@dml
@@bm1:	xor	eax, eax
	dec	eax
	mov	[ebp+2566], eax
	mov	edx, [ebp+2582]
	add	edx, [ebp+2570]
	jc	@@sdo
@@w8:	mov	ebx, edx
	mul	dword ptr [ebp+2574]
	cmp	edx, ebx
	jb	@@sdo
	ja	@@w9	
	cmp	eax, [ebp+2586] 
	jbe	@@sdo

@@w9:	dec	dword ptr [ebp+2566]	; correct mv
	add	ebx, [ebp+2570]
	jc	@@sdo	
	sub	eax, [ebp+2574]
	sbb	edx, 0
	cmp	edx, ebx
	jb	@@sdo
	ja	@@w9
	cmp	eax, [ebp+2586]
	ja	@@w9

@@sdo:	push	ecx		
	push	esi		
	push	edi		
	mov	cx,  [ebp+1030]	
	shr	cx, 1
	adc	cx, 0
	mov	ebx, [ebp+2566]	
; MulSub()
	push	2
	pop	esi
	xor	edx, edx			; rem. dummy
@@msl:	push	edx
	mov	eax, ebx		
	mul	dword ptr [ebp+esi+1030]
	sub	[ebp+edi], eax
	adc	edx, 0		
	pop	eax
	sub	[ebp+edi], eax
	adc	edx, 0		
	add	edi, 4
	add	esi, 4
	loop	@@msl
	sub	[ebp+edi], edx
	jnc	@@dnc		
; Correct on cs
	pop	edi
	push	edi
	xor	ecx, ecx
	mov	cx, [ebp+1030]	
	shr	cx, 1
	adc	cx, 0
	push	2
	pop	esi
	clc
@@sdw:	mov	eax, [ebp+esi+1030]	
	adc	[ebp+edi], eax	
	add	edi, 4
	add	esi, 4
	loop	@@sdw		
	jnc	@@sdx
	inc	dword ptr [ebp+edi]
@@sdx:	dec	dword ptr [ebp+2566]

@@dnc:	pop	edi		
	pop	esi
	pop	ecx
@@dml:	mov	eax, [ebp+2566]	
	mov	[ebp+edi+1546], eax	
	sub	edi, 4
	sub	esi, 4
	dec	ecx		
	jz	@@sdz
	jmp	@@sdm

@@sdz:	pop	edi		
	add	edi, 2		
	xor	eax, eax
@@l7:	cmp	ax, [ebp+edi+1546]	
	jnz	@@sdr
	sub	edi, 2
	jnz	@@l7
@@sdr:	mov	edx, edi
	shr	edx, 1		
	mov	[ebp+1546], dx	
; Check for rem. len
	xor	eax, eax
	mov	ax, [ebp+1030]
	mov	ecx, eax
	add	ax, ax
	mov	edi, eax
	xor	ebx, ebx
	add	edi, 2
@@sdu:	sub	edi, 2
	cmp	[ebp+edi], bx
	loopz	@@sdu
	jz	@@sdv		
	inc	cx		
@@sdv:	mov	[ebp], cx	

; Save results
@@savd:	mov	esi, ebp
	mov	ebx, ebp
	pop	ebp
	push	esi
	add	esi, 1546
	mov	edi, [ebp+16]	
	xor	ecx, ecx
	mov	cx, [esi]
	shr	cx, 1
	adc	cx, 0
	cld
	test	cx, cx
	jz	@@quot0
	rep	movsd
@@quot0:
	movsw
	pop	esi
@@drs:
	mov	edi, [ebp+20]
	xor	ecx, ecx
	mov	cx, [esi]
	shr	cx, 1
	adc	cx, 0
	cld
	test	ecx, ecx
	jz	@@rem0
	rep	movsd
@@rem0:
	movsw
	xor	eax, eax
@@rfdiv:
	pop	esi
	pop	edi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	RET	16				; restore stack / get rid of parameters

@@zerdiv:
	xor	eax, eax
	mov	edi, [ebp+20]	
	mov	esi, [ebp+16]	
	mov	[edi], ax	
	mov	[esi], ax	
	jmp	@@rfdiv

@@dbzerr:
	or	eax, -1				; return error
	jmp	@@rfdiv	

@@dab:	mov	esi, ebp
	mov	ebx, ebp
	pop	ebp
	mov	edi, [ebp+16]
	mov	word ptr [edi], 0
	jmp	@@drs	

@@shdiv:
	xor	ecx, ecx
	mov	cx, [ebp]
	shr	cx, 1
	adc	cx, 0
	mov	edi, ecx
	shl	edi, 2
	sub	edi, 2
	xor	edx, edx
	mov	ebx, [ebp+1032]
@@dsh1:	mov	eax, [ebp+edi]
	div	ebx
	mov	[ebp+edi+1546], eax
	sub	edi, 4
	loop	@@dsh1
@@dsh2:	xor	ecx, ecx
	mov	cx, [ebp]
	mov	esi, ecx
	add	esi, esi
@@l8:	mov	bx, [ebp+esi+1546]
	test	bx, bx
	jnz	@@dsh3
	dec	esi
	dec	esi
	dec	ecx
	test	cx, cx
	jnz	@@l8
@@dsh3:	mov	[ebp+1546], cx
	mov	[ebp+2], edx
	mov	word ptr [ebp], 2
	cmp	word ptr [ebp+4], 0
	jnz	@@dst
	mov	word ptr [ebp], 1
	cmp	word ptr [ebp+2], 0
	jnz	@@dst
	and	word ptr [ebp], 0
@@dst:	jmp	@@savd
BiG_DIV  endp

;*-------------------------------------------------------*
; Function:    void BiG_SQR(P1,P2);
;
; Description: Calculates Square of a given X => X*X 
;              (Faster than BiG_MUL !)
; Parameters:  P1) pointer to Bignum to square
;              P2) pointer to (result)buffer
; Returns:     Always 0
;              Stack Restored on Exit
;*-------------------------------------------------------*
BiG_SQR proc
	push	ebp		
	mov	ebp, esp
	sub	esp, 1560
	mov	eax, esp
	push	ebx
	push	edi
	push	esi
	mov	ebx, eax		

	mov	esi, [ebp+8]		
	mov	dx, [esi]	
	test	dx, dx
	jz	@@pow0

	lea	edi, [ebx]	
	xor	ecx, ecx
	mov	cx, dx		
	cld
	rep	movsw			
	movsw			
	and	word ptr [edi], 0

	push	ebp		
	mov	ebp, ebx		
; Kill leading 0s
	xor	eax, eax
	mov	ax, [ebp]	
	test	ax, ax
	jz	@@goon
	add	eax, eax
	mov	esi, eax			; obase
@@l1:	cmp	word ptr [ebp+esi], 0
	jnz	@@inzo1		
	sub	esi, 2		
	jnz	@@l1		
@@inzo1:
	shr	esi, 1		
	mov	eax, esi		
	mov	[ebp], ax	

@@goon:	test	ax, ax
	jnz	@@mpow2
	pop	ebp
	jmp	@@pow0
@@mpow2:
	xor	ecx, ecx
	mov	cx, [ebp]	
	shr	cx, 1
	adc	cx, 0
	cmp	cx, 1
	jz	@@regpow

	xor	eax, eax
	push	2
	pop	esi
@@lsqrW:
	mov	[ebp+esi+520], eax
	add	esi, 4
	loop	@@lsqrW

	push	2
	pop	esi
	xor	ecx, ecx
	mov	cx, [ebp]	
	shr	cx, 1
	jc	@@lsqrV
	dec	cx		
@@lsqrV:
	push	ecx		

	mov	edi, esi		
	add	edi, 4			
	xor	ecx, ecx
	mov	cx, [ebp]	
	shr	cx, 1			
	adc	cx, 0
	push	esi
	add	esi, 2			
	shr	esi, 2			
	sub	ecx, esi
	pop	esi		
	xor	edx, edx
	mov	ebx, [ebp+esi]	
	add	esi, edi		
@@lsqrU:
	push	ecx		
	mov	ecx, edx		
	mov	eax, ebx			
	mul	dword ptr [ebp+edi]
	add	eax, ecx		
	adc	edx, 0
	add	[ebp+esi+518], eax
	adc	edx, 0		
	add	edi, 4		
	add	esi, 4		
	pop	ecx		
	loop	@@lsqrU

	mov	[ebp+esi+518], edx
	sub	esi, edi		
	add	esi, 4		
	pop	ecx		
	loop	@@lsqrV

	add	esi, edi
	and	dword ptr [ebp+esi+518], 0 
	and	dword ptr [ebp+esi+522], 0 
; tempres = tempres * 2
	push	6				; skip 0 part
	pop	esi
	xor	ecx, ecx
	mov	cx, [ebp]
@@tr2l:
	rcl	dword ptr[ebp+esi+520], 1
	inc	esi				; inc doesn't affest c flag. so better don't change it to add  ,4 ;)
	inc	esi
	inc	esi
	inc	esi
	loop	@@tr2l
; Add squares
	mov	cx, [ebp]
	add	cx, cx
	mov	[ebp+520], cx
	push	2
	pop	esi
	mov	edi, esi
	mov	cx, [ebp]	
	shr	cx, 1			
	adc	cx, 0
	xor	eax, eax
	pushf				; dummy
@@lsqr2:
	mov	eax, [ebp+esi]
	mul	eax		
	popf
	adc	[ebp+edi+520], eax
	adc	[ebp+edi+524], edx
	pushf
	add	esi, 4
	add	edi, 8
	loop	@@lsqr2
	popf				; stack corr. only
	jmp	@@lsqrX

@@regpow:
	mov	eax, [ebp+2]
	mul	eax
	mov	[ebp+522], eax 
	mov	[ebp+526], edx 
	mov	word ptr [ebp+520], 4
@@lsqrX:
	xor	eax, eax
	mov	ax, [ebp+520]
	mov	edi, eax
	add	edi, edi
	cmp	word ptr [ebp+edi+520], 0
	jnz	@@lsqrY
	dec	word ptr [ebp+520]
	jmp	@@lsqrX
@@lsqrY:
	lea	esi, [ebp+520]
	mov	ebx, ebp
	pop	ebp
	mov	edi, [ebp+12]
	xor	ecx, ecx
	mov	cx, [esi]
	shr	cx, 1
	adc	cx, 0
	jz	@@w5
	cld
	rep	movsd
@@w5:	movsw

@@rfsq:						; return from square :P
	pop	esi
	pop	edi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	xor	eax, eax
	RET	8				; restore stack / get rid of parameters
@@pow0:
	mov	esi, [ebp+12]
	and	word ptr [esi],	0		; set bignum 0
	jmp	@@rfsq
BiG_SQR  endp


;*-------------------------------------------------------*
; Function:    void BiG_MUL(P1,P2,P3);
; Description: 
; Parameters:  P1) pointer to Bignum factor 1
;              P2) pointer to Bignum factor 2
;              P2) pointer to (result)buffer
; Returns:     Always 0
;              Stack Restored on Exit
;*-------------------------------------------------------*
BiG_MUL	proc
	push	ebp		
	mov	ebp, esp
	sub	esp, 2200	
	cld
	mov	eax, esp		
	push	edi
	push	esi
	push	ebx
	mov	ebx, eax

	xor	eax, eax
	xor	edx, edx
	mov	esi, [ebp+8]		
	mov	edi, [ebp+12]		
	mov	ax, [esi]
	mov	dx, [edi]

	test	ax, ax
	jz	@@mul0
	test	dx, dx
	jz	@@mul0

	push	edi		
	lea	edi, [ebx+520]	
	xor	ecx, ecx
	mov	cx, ax		
	rep	movsw			
	movsw			
	and	word ptr [edi], 0

	pop	esi		
	lea	edi, [ebx]	
	mov	cx, dx		
	rep	movsw		
	movsw			
	and	word ptr [edi], 0

	push	ebp		
	mov	ebp, ebx		

	xor	eax, eax
	mov	ax, [ebp+520]	
	test	ax, ax
	jz	@@goon
	add	eax, eax
	mov	esi, eax
@@l1:	cmp	word ptr [ebp+esi+520], 0
	jnz	@@inzo1
	sub	esi, 2		
	jnz	@@l1
@@inzo1:
	shr	esi, 1		
	mov	eax, esi		
	mov	520[ebp], ax	
@@goon:
	mov	ax, [ebp]	
	test	ax, ax
	jz	@@iszer
	add	eax, eax
	mov	esi, eax
@@l2:	cmp	word ptr [ebp+esi], 0
	jnz	@@inzo2
	sub	esi, 2		
	jnz	@@l2		
@@inzo2:
	shr	esi, 1		
	mov	eax, esi		
	mov	[ebp], ax	

@@iszer:
	test	ax, ax
	jnz	@@w1
	pop	ebp
	jmp	@@mul0
@@w1:	cmp	word ptr [ebp+520], 0
	jnz	@@w2
	pop	ebp
	jmp	@@mul0
; start
@@w2:	push	2
	pop	esi
	mov	cx, dx		
	shr	cx, 1
	adc	cx, 0
	xor	eax, eax
@@mxx:
	mov	[ebp+esi+1040], eax
	add	esi, 4
	loop	@@mxx
	mov	esi, 2		
	xor	ecx, ecx
	mov	cx, [ebp+520]	
	shr	cx, 1
	adc	cx, 0
; outter loop
@@mxw:	push	ecx		
	mov	edi, 2		
	mov	cx, [ebp]	
	shr	cx, 1
	adc	cx, 0

	xor	edx, edx			; dummy 
	mov	ebx, [ebp+esi+520]	
	add	esi, edi
; inner loop
@@mxy:	push	ecx		
	mov	ecx, edx		
	mov	eax, ebx
	mul	dword ptr [ebp+edi]
	add	eax, ecx		
	adc	edx, 0
	add	[ebp+esi+1038], eax
	adc	edx, 0		
	add	edi, 4		
	add	esi, 4		
	pop	ecx		
	loop	@@mxy

	mov	[ebp+esi+1038], edx
	sub	esi, edi		
	add	esi, 4		
	pop	ecx		
	loop	@@mxw

	add	esi, edi
	sub	esi, 4
@@mxz:
	cmp	word ptr [ebp+esi+1040], 0
	jnz	@@mxv
	sub	esi, 2
	jmp	@@mxz
@@mxv:
	mov	ecx, esi
	shr	ecx, 1
	mov	[ebp+1040], cx
;Save result
	lea	esi, [ebp+1040]
	mov	ebx, ebp
	pop	ebp
	mov	edi, [ebp+16]
	test	cx, cx
	jz	@@w3
	cld
	rep	movsw
@@w3:	movsw

@@rfmul:
	pop	ebx
	pop	esi		
	pop	edi
	mov	esp, ebp
	pop	ebp
	xor	eax,  eax
	RET	12				; restore stack / get rid of parameters
@@mul0:
	mov	esi, [ebp+16]
	and	word ptr [esi], 0		; clear bignum
	jmp	@@rfmul
BiG_MUL  endp

END Start
;;
