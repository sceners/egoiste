;*----------------------------------------------------------------------------*
; FTP Voyager v7.2.0.0 Keygenerator - Protection: RSA 256
; (!) by tHE EGOiSTE // TMG
;
; Greets to egis/CORE ;)
;
; Assembler: TASM 5
; tasm32.exe /mx /m4 /z keygen.asm
; tlink32.exe -x -V4.0 -Tpe -aa -c keygen.obj,keygen,,,keygen.def,keygen.res
;
;*----------------------------------------------------------------------------*
.386
.model flat, stdcall
locals
unicode	= 0
;Adjust paths for includes please..
includelib G:\KTA\BIN\LIBGEN\imp32i.lib
include E:\UNZIPPED\KTA\BIN\w32.inc
;
DLG_MAIN	=	111
BT_GENERATE	=	1008
EDIT_NAME	=	1009
EDIT_KEY	=	1010
EDIT_EMAIL	=	1011
;
MINCHARS	=	1
MAXCHARS	=	60
;
extrn	lstrcmpA	:	PROC
extrn	wsprintfA	: 	PROC
extrn	_mbsrev		:	PROC
extrn	gmtime		:	PROC
extrn	strftime	:	PROC
extrn	CharLowerA	: 	PROC
;extrn	GetTickCount	: 	PROC
;
.DATA
szWinTitle	db "FTP Voyager v7.2.0.0 - Keygen by tE! / TMG",0
szError		db "Name and email address must contain at least 1 character.",0
szInit		db "Enter your name and email address and press Generate.",0
szNameError	db "The entered Username is blacklisted.",0
szEmailError	db "The entered email address is blacklisted.",0
szCapture	db "Error",0
; v7.2.0.0 Blacklist
blacknames	db 0,"death brain",0,"bs2000",0,"norberta de leon",0,"blastsoft",0,"alt cracks",0,"thebrabo",0,"the user by c.c.",0
		db "high voltage",0,"ajay khandelwal",0,"the master",0,"driver8zolexn dub",0,"the cracking scene !",0,"mega warrior",0
		db "fully licensed user",0,"greco",0,"super xe",0,"khaled aziz",0,"cracked",0,"durk",0,"the stardogg champion [pc]",0
		db "the stardogg champion",0,"marquis",0,"fx22",0,"high voltage tech",0,"enip/cod",0,"nasri salah eddine",0
		db "cynthia micheletti",0,"sam hog",0,"majaved",0,"binichirre",0,"hilary",0,"ticker",0,"higher volt",0,"maxim rudnev",0
		db "louis vaughn",0,"stephen austin",0,"frank rennhak",0,"jerry rushing",0,"dn",0,"john barron",0,"roan distributors",0
		db "smptad",0,"mark montgomery",0,"alan long",0,"hv",0,0
blackmails	db 0,"mbiersmith@exhibitor.net",0,"slazcano@geocities.com",0,"djean4@csi.com",0,"codinf@aol.com",0,"none@pressanykey.com",0
		db "anga03@one.net.au",0,"flodhi@pakistanmail.com",0,"guidedeaw@gmx.de",0,"banana@123india.com",0,"ticker@choifm.org",0
		db "hvoltage@us.navy.org",0,"louisv9@bellsouth.net",0,"chrisy2dope@beer.com",0,"reeno@online.de",0,"bourrin@saintly.com",0
		db "jerryr@navellier.com",0,"bombayzone4@homail.cim",0,"j23barron@excite.com",0,"death_brain",0,"rmroan@prodigy.net",0
		db "adoffice@ni.net",0,"markm@network-solution.com",0,"secs@nettaxi.com",0,"oscargarcia@topmail.com.ar",0,"roncho@compuserve.com",0
		db "mail.ru",0,"projekt-98",0,".crack",0,"apcutie123@aol.com",0,"mota8x@aol.com",0,0

  align 4
fdatetime	db "%m/%d/%Y - %H:%M:%S",0
  align 4
formatmagic	db "%02x%02X%02x%02X%02x%02X%02x%02X",0
;
; e for v7.2.0.0 = 65537
RSA_n:	dw	16	; 256 Bit/16
	db	01Eh,02Bh,0D7h,0C2h,038h,0A8h,008h,0DDh,0DFh,020h,0FCh,03Eh,0E1h,026h,003h,056h,01Ah
	db	052h,02Eh,0B5h,055h,06Fh,068h,0ACh,050h,083h,0CCh,051h,0BAh,0AAh,0B4h,05Dh,0,0

RSA_d:	dw	16	; 256 Bit/16
	db	005h,037h,069h,057h,070h,03Ah,045h,046h,012h,02Dh,08Fh,084h,0E5h,040h,0B7h,03Ah,051h
	db	0A9h,082h,0FDh,0C2h,0F7h,01Fh,02Ch,02Fh,01Fh,026h,0F2h,0E8h,02Fh,0A6h,0C1h,0,0
bflag		db 0
.DATA?
hdlg		dd ?
hWndName	dd ?
hWndEmail	dd ?
hWndKey		dd ?
hWndGenerate	dd ?
hWndExit	dd ?
userinput	db MAXCHARS+2 dup(?)
useremail	db MAXCHARS+2 dup(?)
userkey		db 80 dup(?)
magic		db 8 dup(?)
check1string	db MAXCHARS*4 dup(?)
check2string	db MAXCHARS*4 dup(?)
RSATemp		db 80 dup(?)
;
.CODE
Start:	pushad
	call	GetModuleHandle, 0
	test	eax, eax
	jz	ExitKG
	xor	ebx, ebx
	call	DialogBoxParamA, eax, DLG_MAIN, ebx, offset DlgProc, ebx
ExitKG:	popad
	call	ExitProcess, 0
	RET
;
DlgProc proc __hwnd:HWND, wmsg:UINT, _wparam:WPARAM, _lparam:LPARAM
	uses	ebx, edi, esi
	mov 	eax, wmsg

	cmp	eax, WM_SETCURSOR
	jz	_setcursor
	cmp	eax, WM_CLOSE
	jz	_wmdestroy
	cmp	eax, WM_COMMAND
	jz	_wmcommand
	cmp	eax, WM_INITDIALOG
	jz	_initdlg
_nM:	xor	eax, eax
	RET
_setcursor:
	mov	eax, _wparam
	mov	edi, offset SendMessageA
	mov	esi, BM_SETSTYLE
	cmp	eax, hWndGenerate
	jz	_isbt1
	cmp	eax, hWndExit
	jz	_isbt2
	cmp	bflag, 0
	jz	_nM
	cmp	bflag, 2
	mov	bflag, 0
	jz	_iseb
	call	edi, hWndGenerate, esi, BS_PUSHBUTTON, 1
	jmp	_nM
_iseb:	call	edi, hWndExit, esi, BS_PUSHBUTTON, 1
	jmp	_nM
_isbt1:	test	bflag, 1
	jnz	_nM
	call	edi, hWndGenerate, esi, BS_DEFPUSHBUTTON, 1
	or	bflag, 1
	test	bflag, 2
	jz	_nM
	call	edi, hWndExit, esi, BS_PUSHBUTTON, 1
	and	bflag, 0FDh
	jmp	_nM
_isbt2:	test	bflag, 2
	jnz	_nM
	call	edi, hWndExit, esi, BS_DEFPUSHBUTTON, 1
	or	bflag, 2
	test	bflag, 1
	jz	_nM
	call	edi, hWndGenerate, esi, BS_PUSHBUTTON, 1
	and	bflag, 0FEh
	jmp	_nM
_wmdestroy:
	call	EndDialog, hdlg, 0
	RET
_wmcommand:
	mov	eax, _wParam
	cmp	ax, IDCANCEL
	jz	_wmdestroy
	cmp	ax, BT_GENERATE
	jnz	_nM
	call	Generate
	jmp	_nM
_initdlg:
	mov	eax, __hwnd
	mov	hdlg, eax

	call	GetDlgItem, __hwnd, BT_GENERATE
	mov	hWndGenerate, eax
	call	GetDlgItem, __hwnd, IDCANCEL
	mov	hWndExit, eax

	call	GetDlgItem, __hwnd, EDIT_KEY
	mov	hWndKey, eax
	call	SendMessageA, eax, WM_SETTEXT, 0, offset szInit
	call	GetDlgItem, __hwnd, EDIT_NAME
	mov	hWndName, eax
	call	SendMessageA, eax, EM_SETLIMITTEXT, MAXCHARS, 0
	call	GetDlgItem, __hwnd, EDIT_EMAIL
	mov	hWndEmail, eax
	call	SendMessageA, eax, EM_SETLIMITTEXT, MAXCHARS, 0

	call	SetWindowTextA, __hwnd, offset szWinTitle
	push	1
	pop	eax
	RET
DlgProc ENDP
;
Generate proc
	LOCAL	nlen:DWORD,elen:DWORD,tim:DWORD,cslen:DWORD
	call	SendMessageA, hWndName, WM_GETTEXT, MAXCHARS+1, offset userinput
	cmp	eax, MINCHARS
	jl	@@err
	mov	nlen, eax	
	call	SendMessageA, hWndEmail, WM_GETTEXT, MAXCHARS+1, offset useremail
	cmp	eax, MINCHARS
	jl	@@err
	mov	elen, eax	
;--------------------------------------------------------------
	lea	edi, magic
	xor	eax, eax
	stosd
	stosd
; [] Clear Temp Buffer
	lea	edi, RSATemp
	push	8
	pop	ecx
	rep	stosd
	sub	edi, 13				; edi -> checked data
; [] Checksum Name/Email
	push	offset userinput
	push	offset useremail
	call	CheckSum
	mov	[edi+9], al
	mov	al, ah
	shl	ah, 4
	shr	al, 4
	or	al, ah
	mov	[edi+7], al
; [] Control word
	mov	byte ptr[edi+5], 255		; upper byte (!FFh == 00h)
	mov	byte ptr[edi+11], 254		; lower byte !FEh must at least be < C8h. other values than 1 suck, tho ;)
; [] Get some valid dateval
	finit
	push	eax eax
	push	81000
	fild	dword ptr[esp]
	push	100000
	fild	dword ptr[esp]
	fdiv	st(1),st(0)
	fstp	real8 ptr[esp]
	add	esp, 8
	mov	dword ptr[esp], 36507		; 36507.81 produces '12/13/1999 - 18:45:00' That's ok. - fuck MFC :/
	fild	dword ptr[esp]
	faddp	st(1),st(0)
	fstp	real8 ptr[esp]
	pop	eax eax				; eax=timestamp
	mov	tim, eax
	lea	ebx, tim
	mov	[ebx], eax
	push	ebx
	call	gmtime
	pop	esi
; [] Change tm struc that it meets our needs
	mov	dword ptr[eax], 0		; sec
	mov	dword ptr[eax+4], 45		; min
	mov	dword ptr[eax+8], 18		; hour
	mov	dword ptr[eax+12], 13		; day
	mov	dword ptr[eax+16], 11		; month (0-11)
	mov	dword ptr[eax+20], 99		; year-1900
; [] Date/time to string
	push	eax				; -> tm
	push	offset fdatetime		; control string
	push	24				; max len
	push	offset check1string		; dest buffer
	call	strftime
	add	esp, 16
	add	eax, offset check1string
	mov	esi, eax
;
	mov	ebx, tim
	lea	ecx, magic
	mov	[edi+6], bh
	mov	[ecx+1], bh
	mov	[edi+2], bl
	mov	[ecx+5], bl
	shr	ebx, 16
	mov	[edi+4], bh
	mov	[ecx], bh
	mov	[edi+10], bl
	mov	[ecx+6], bl
; [] Copy name/email
	push	edi
	mov	edi, esi
	lea	esi, userinput
	mov	ecx, nlen
	rep	movsb
	lea	esi, useremail
	mov	ecx, elen
	rep	movsb
;
	lea	esi, magic
	xor	eax, eax
	push	8
	pop	ecx
	add	esi, ecx
	std
	dec	esi
@@lpu:	lodsb
	push	eax
	dec	ecx
	jg	@@lpu
	cld
	push	offset formatmagic
	push	edi
	call	wsprintfA
	add	esp, 40
	lea	esi, check2string
	mov	dword ptr[esi], " - 1"		; 1 -> !FEh from "control word" (s.above)
	add	esi, 4
; [] Reverse string1
	lea	edi, check1string
	xor	eax, eax
	lea	ecx, [eax-1]
	repnz	scasb
	neg	ecx
	dec	ecx
	dec	edi
@@lcs:	dec	edi
	mov	al, [edi]
	mov	[esi], al
	inc	esi
	dec	ecx
	jg	@@lcs
; [] Append "LITE " extension
;;	mov	dword ptr[esi-1], "ITE "
;;	mov	word ptr[esi+3], "L"
; [] Register w/o extension
	and	byte ptr[esi], 0
;
	pop	edi
; [] Checksum checkstrings
	push	offset check1string
	push	offset check2string
	call	CheckSum
; [] Store sum-word / swap nibbles of hbyte
	mov	[edi], al
	mov	al, ah
	shl	ah, 4
	shr	al, 4
	or	al, ah
	mov	[edi+3], al
; [] RSA Encrypt
	call	RSA_PRIVATE_ENCRYPT, offset RSA_d, offset RSA_n, offset RSATemp, offset RSATemp, 32
; [] Convert result to ASCII
	lea	edi, userkey
	lea	esi, RSATemp
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
; [] Blacklist check
	lea	esi, userinput
	lea	edi, blacknames
	call	CharLowerA, esi
@@bl1:	xor	eax, eax
	lea	ecx, [eax-1]
	repnz	scasb
	cmp	byte ptr[edi], 0
	jz	done1
	call	lstrcmpA, esi, edi
	test	eax, eax
	jz	blst
	jmp	@@bl1
done1:	lea	esi, useremail
	lea	edi, blackmails
	call	CharLowerA, esi
@@bl2:	xor	eax, eax
	lea	ecx, [eax-1]
	repnz	scasb
	cmp	byte ptr[edi], 0
	jz	done2
	call	lstrcmpA, esi, edi
	test	eax, eax
	jz	blst2
	jmp	@@bl2
blst:	call	MessageboxA, hdlg, offset szNameError, offset szCapture, MB_OK OR MB_APPLMODAL
	jmp	@@out
blst2:	call	MessageboxA, hdlg, offset szEmailError, offset szCapture, MB_OK OR MB_APPLMODAL
	jmp	@@out
done2:	
;--------------------------------------------------------------
	call	SendMessageA, hWndKey, WM_SETTEXT, 0, offset userkey
@@out:	RET
@@err:	call	SendMessageA, hWndKey, WM_SETTEXT, 0, offset szError
	jmp	@@out
cctab	db	"0123456789abcdef",0
Generate endp

; [] Ripped from ftpvoyager.exe
CheckSum:
	push	ebx esi edi ebp
	mov	ebp, [esp+8+16]
	xor	eax, eax
	movzx	ecx, byte ptr[ebp+0]
	xor	edx, edx
	xor	edi, edi
	push	1
	pop	esi
	test	cl, cl
	jz	@@ok1
@@l1:	mov	ebx, ecx
	add	edx, ecx
	imul	ebx, esi
	xor	ebx, edi
	mov	esi, ecx
	movzx	ecx, byte ptr[ebp+edi+1]
	add	ebx, edx
	xor	eax, ebx
	inc	edi
	test	cl, cl
	jnz	@@l1	
@@ok1:	mov	ebp, [esp+4+16]
	xor	edi, edi
	movzx	ecx, byte ptr[ebp+0]
	test	cl, cl
	jz	@@done
@@l2:	mov	ebx, ecx
	add	edx, ecx
	imul	ebx, esi
	xor	ebx, edi
	mov	esi, ecx
	movzx	ecx, byte ptr[ebp+edi+1]
	add	ebx, edx
	xor	eax, ebx
	inc	edi
	test	cl, cl
	jnz	@@l2
@@done:	and	eax, 00FFFFFFh		
	pop	ebp edi esi ebx
	RET

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
; Notes:       D and N have to be in my Bignum format used by the
;              math routines. I.e. that the first WORD represents
;              the SIZE of the following number in BITS divided by 16.
;              M will be converted to Bignum format automatically.
;              Ciphertext is in Bignum format with corrected byte order. 
;              Base for Big numbers is 16. Function handles Numbers up
;              to 4096 Bits but isn't optimized (math.) in any way.
;              Thus, most RSA C/CPP packages are faster. Who cares ? ;P
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
; Notes:       P2 used in Powerstrip keygen..
; Returns:     Always 0
;              Stack Restored on Exit
;*---------------------------------------------------*
REV_BIGNUM proc
	push	ebp		
	mov	ebp, esp
	sub	esp, 520
	mov	edi, esp
	push	ebx edi esi
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
@@out:	pop	esi edi ebx
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
	push	ebx edi esi
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
	pop	esi edi ebx
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
;              (Faster than BiG_MUL)
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
	db	"   Keygenerator made by tHE EGOiSTE / TMG   "
END Start
;;
