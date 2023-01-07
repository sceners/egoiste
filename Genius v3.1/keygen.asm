;*----------------------------------------------------------------------------*
; Genius v3.1 Keygen
; (!) by tHE EGOiSTE // TMG
; Stupid author...thinks hashing crap 100 times increases security... :-/
; Assembler: TASM 5
; tasm32.exe /mx /m4 /z keygen.asm
; tlink32.exe -x -V4.0 -Tpe -aa -c keygen.obj,keygen,,,keygen.def,keygen.res
;
;*----------------------------------------------------------------------------*
.386
.model flat, stdcall
locals
unicode	= 0
; Adjust include paths...
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
;extrn	GetTickCount	: 	PROC
;
.DATA
szWinTitle	db "Genius v3.1 - Keygen by tE! / TMG",0
szErrorN	db "Invalid name.",0
szErrorE	db "Invalid email.",0
szInit		db "Enter your name and email address and press Generate.",0
evendata
cctab		db "ABCDEF0123456789"
cstring0	db "BfUpNpdP3ApLaxIr0yto"
cstring1	db "MIjhBlDxcD7biA84iAR0"
cstring2	db "DJYdez6hAgiZkhOpsdML"
cstring3	db "I74d7OB6sMoM698tKFoY"
cstring4	db "TLzm4ueUoZ48kXs4QJKo"
cstring5	db "Shg1WL8EqwJPg4rofFkP"
cstring6	db "D53JUPEsrHrJ0t5yZl1x"
cstring7	db "MhU0o1xo7IN2laFLbgFY"
cpt		dd cstring0, cstring1, cstring2, cstring3, cstring4, cstring5, cstring6, cstring7
.DATA?
hdlg		dd ?
hWndName	dd ?
hWndEmail	dd ?
hWndKey		dd ?
hLen		dd ?

userinput	db MAXCHARS+2 dup(?)
useremail	db MAXCHARS+2 dup(?)
hashbuffer	db 256 dup(?)

userkey		db 40 dup(?)
SHA1Hash	dd 5 dup(?)

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

	cmp	eax, WM_CLOSE
	jz	_wmdestroy
	cmp	eax, WM_COMMAND
	jz	_wmcommand
	cmp	eax, WM_INITDIALOG
	jz	_initdlg
_nM:	xor	eax, eax
	RET
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
	LOCAL	nlen:DWORD,elen:DWORD,cnt:DWORD
	call	SendMessageA, hWndName, WM_GETTEXT, MAXCHARS+1, offset userinput
	cmp	eax, MINCHARS
	jl	@@err
	mov	nlen, eax	
	call	SendMessageA, hWndEmail, WM_GETTEXT, MAXCHARS+1, offset useremail
	cmp	eax, MINCHARS
	jl	@@err2
	mov	elen, eax	
;--------------------------------------------------------------

	add	eax, nlen
	mov	hLen, eax
; [] Concatenate username|email address
	lea	edi, hashbuffer
	lea	esi, userinput
	mov	ecx, nlen
	rep	movsb
	lea	esi, useremail
	mov	ecx, elen
	inc	ecx
	rep	movsb
;
	lea	ecx, SHA1Hash
	lea	edx, cpt
	mov	cnt, 64h			; 100 iterations
; [] Initial Hashing of concatenated username|email address
	call	SHAPadding
	call	SHA1	
	jmp	first

l1:	mov	hLen, 20
	lea	edi, hashbuffer
	lea	esi, SHA1Hash
	movsd
	movsd
	movsd
	movsd
	movsd
	call	SHAPadding
	call	SHA1	

first:	mov	hLen, 40
	movzx	eax, byte ptr[ecx]
	cmp	eax, 81h
	jge	k1
	sub	eax, 21h
	jb	k2
	sub	eax, 20h
	jb	k3
	sub	eax, 20h
	jb	k4
	sub	eax, 20h
	jb	k5
	jmp	break	
k1:	add	eax, 0FFFFFF7Fh
	sub	eax, 20h
	jb	k6
	sub	eax, 20h
	jb	k7
	sub	eax, 20h
	jb	k8
	sub	eax, 1Fh
	jb	k9
	jmp	break
k2:	mov	eax, [edx+(0*4)]
	call	PrepareAndHashBuffer
	jmp	break
k3:	mov	eax, [edx+(1*4)]
	call	PrepareAndHashBuffer
	jmp	break
k4:	mov	eax, [edx+(2*4)]
	call	PrepareAndHashBuffer
	jmp	break
k5:	mov	eax, [edx+(3*4)]
	call	PrepareAndHashBuffer
	jmp	break
k6:	mov	eax, [edx+(4*4)]
	call	PrepareAndHashBuffer
	jmp	break
k7:	mov	eax, [edx+(5*4)]
	call	PrepareAndHashBuffer
	jmp	break
k8:	mov	eax, [edx+(6*4)]
	call	PrepareAndHashBuffer
	jmp	break
k9:	mov	eax, [edx+(7*4)]
	call	PrepareAndHashBuffer
;
break:	dec	cnt
	jg	l1
;;int 3
; [] Conversion
	lea	edi, userkey
	lea	esi, SHA1Hash
	push	20
	pop	ecx
	mov	dx, 2D00h
_cl:	lodsb	
	and	eax, 15
	mov	al, cctab[eax]
	stosb
	inc	dl
	and	dl, 3
	jnz	ok1
	mov	al, dh
	stosb
ok1:	dec	ecx
	jg	_cl
	and	byte ptr[edi-1], 0

;--------------------------------------------------------------
	call	SendMessageA, hWndKey, WM_SETTEXT, 0, offset userkey
@@out:	RET
@@err:	call	SendMessageA, hWndKey, WM_SETTEXT, 0, offset szErrorN
	jmp	@@out
@@err2:	call	SendMessageA, hWndKey, WM_SETTEXT, 0, offset szErrorE
	jmp	@@out
Generate endp

PrepareAndHashBuffer:
	pushad
	lea	edi, hashbuffer
	lea	esi, SHA1Hash
	push	5
	push	5
	pop	ecx
	rep	movsd
	mov	esi, eax
	pop	ecx
	rep	movsd
	call	SHAPadding
	call	SHA1	
	popad
	RET
;*-------------------------------*
; void EndianRev(*buffer, len);
;*-------------------------------*
EndianRev proc lpD:DWORD, Len:DWORD
	uses	ebx, esi, edi
	mov	esi, lpD
	mov	edi, esi
	mov	ecx, Len
	shr	ecx, 2
@@l1:	lodsd
	mov	ebx, eax
	rol	ebx, 8
	and	ebx, 000FF00FFh
	ror	eax, 8
	and	eax, 0FF00FF00h
	or	eax, ebx
	stosd
	dec	ecx
	jg	@@l1
	RET
EndianRev endp

;;*-------------------------------------------------------------------*
;;- SHA-1 Hashing Algorithm -/- Win32ASM implementation by tE!        -
;;- FIPS PUB 180-1 Compatible                                         -
;;---------------------------------------------------------------------
;; - Processes 512Bit Data-Blocks
;; - 4 Rounds a 20 function calls
;; - Output is 160 Bit Hash Value
;; - Stronger than MD5
;; - 4 Constants / One for each round:
;;    K1 = 5A827999 = 2 ^ 32 *  2^½ / 4
;;    K2 = 6ED9EBA1 = 2 ^ 32 *  3^½ / 4
;;    K3 = 8F1BBCDC = 2 ^ 32 *  5^½ / 4
;;    K4 = CA62C1D6 = 2 ^ 32 * 10^½ / 4
;; - 4 Nonlinear functions / One for each round:
;;   f1(b,c,d) = (b AND c) OR ((NOT b) AND d)          for t = 00-19
;; ->f1(b,c,d) =  d XOR (b AND (c XOR d)) - optimized
;;   f2(b,c,d) =  b XOR c XOR d                        for t = 30-39
;;   f3(b,c,d) = (b AND c) OR (b AND d) OR (c AND d)   for t = 40-59
;; ->f3(b,c,d) = (b AND c) OR (d AND (b OR c)) - optimized
;;   f4(b,c,d) =  b XOR c XOR d                        for t = 60-79
;; - Speed: ~10 MB/s on a Intel PII 300
;;*--------------------------------------------------------------------*

SHA1 PROC
	LOCAL a:DWORD, b:DWORD, c:DWORD, d:DWORD, e:DWORD, BCNT:DWORD
	pushad
	mov	eax, hLen
	push	64
	pop	ebx
	xor	edx, edx
	div	ebx
	test	edx, edx
	jnz	@@out			; not padded!? -> exit
	mov	BCNT, eax
  ;; Initialize variables
	lea	edi, SHA1Hash
	mov	[edi+00], 067452301h	; A
	mov	[edi+04], 0EFCDAB89h	; B
	mov	[edi+08], 098BADCFEh	; C
	mov	[edi+12], 010325476h	; D
	mov	[edi+16], 0C3D2E1F0h	; E

	lea	edi, hashbuffer		; Buffer to hash

@@loop:	lea	esi, SHA1Hash
	mov	eax, [esi+00]
	mov	ebx, [esi+04]
	mov	ecx, [esi+08]
	mov	edx, [esi+12]
	mov	esi, [esi+16]
	mov	a, eax
	mov	b, ebx
	mov	c, ecx
	mov	d, edx
	mov	e, esi
;Round 1
	xor	esi, esi		; t
@@l1:	mov	eax, a
	rol	eax, 5			; a <<< 5
 ;; f1 {
	mov	ebx, d
	mov	edx, ebx
	xor	edx, c
	and	edx, b
	xor	ebx, edx
  ;;   }
	add	ebx, e			; e
	lea	ebx, [ebx+eax+5A827999h]; K1
	add	ebx, [edi+esi*4]	; W(t) ->( W(t) = M(t) for t=0 - 15 )

	mov	eax, d
	mov	e, eax			; e=d
	mov	eax, c
	mov	d, eax			; d=c
	mov	eax, b
	ror	eax, 2			; same as <<< 30 !
	mov	c, eax			; c=b <<< 30
	mov	eax, a
	mov	b, eax			; b=a
	mov	a, ebx			; a=f1(b,c,d)+W(t)+e+K1+(a <<< 5)
	inc	esi			; t++
	cmp	esi, 16
	jnz	@@l1	

@@l2:	mov	eax, a
	rol	eax, 5
 ;; f1 {
	mov	ebx, d
	mov	edx, ebx
	xor	edx, c
	and	edx, b
	xor	ebx, edx
 ;;    }	
	add	ebx, e
	lea	ebx, [ebx+eax+5A827999h]

	lea	edx, [esi]
	and	edx, 0Fh
	lea	ecx, [edi+edx*4]
	mov	eax, [ecx]
	lea	edx, [esi+2]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	lea	edx, [esi+8]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	lea	edx, [esi+13]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	rol	eax, 1
	mov	[ecx], eax

	add	ebx, eax
	mov	eax, d
	mov	e, eax
	mov	eax, c
	mov	d, eax
	mov	eax, b
	ror	eax, 2
	mov	c, eax
	mov	eax, a
	mov	b, eax
	mov	a, ebx
	inc	esi
	cmp	esi, 20
	jnz	@@l2

;Round 2
@@l3:	mov	eax, a
	rol	eax, 5
 ;; f2 {
	mov	ebx, b
	xor	ebx, c
	xor	ebx, d
 ;;    }
	add	ebx, e
	lea	ebx, [ebx+eax+6ED9EBA1h]

	lea	edx, [esi]
	and	edx, 0Fh
	lea	ecx, [edi+edx*4]
	mov	eax, [ecx]
	lea	edx, [esi+2]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	lea	edx, [esi+8]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	lea	edx, [esi+13]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	rol	eax, 1
	mov	[ecx], eax

	add	ebx, eax
	mov	eax, d
	mov	e, eax
	mov	eax, c
	mov	d, eax
	mov	eax, b
	ror	eax, 2
	mov	c, eax
	mov	eax, a
	mov	b, eax
	mov	a, ebx
	inc	esi
	cmp	esi, 40
	jnz	@@l3

; Round 3
@@l4:	mov	eax, a
	rol	eax, 5
 ;; f3 {
	mov	ebx, b
	mov	edx, ebx
	and	ebx, c
	or	edx, c
	and	edx, d
	or	ebx, edx
 ;;    }
	lea	ebx, [ebx+eax+8F1BBCDCh]
	add	ebx, e

	lea	edx, [esi]
	and	edx, 0Fh
	lea	ecx, [edi+edx*4]
	mov	eax, [ecx]
	lea	edx, [esi+2]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	lea	edx, [esi+8]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	lea	edx, [esi+13]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	rol	eax, 1
	mov	[ecx], eax

	add	ebx, eax
	mov	eax, d
	mov	e, eax
	mov	eax, c
	mov	d, eax
	mov	eax, b
	ror	eax, 2
	mov	c, eax
	mov	eax, a
	mov	b, eax
	mov	a, ebx
	inc	esi
	cmp	esi, 60
	jnz	@@l4

; Round 4
@@l5:	mov	eax, a
	rol	eax, 5
 ;; f4 {
	mov	ebx, b
	xor	ebx, c
	xor	ebx, d
 ;;    }
	add	ebx, e
	lea	ebx, [ebx+eax+0CA62C1D6h]

	lea	edx, [esi]
	and	edx, 0Fh
	lea	ecx, [edi+edx*4]
	mov	eax, [ecx]
	lea	edx, [esi+2]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	lea	edx, [esi+8]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	lea	edx, [esi+13]
	and	edx, 0Fh
	xor	eax, [edi+edx*4]
	rol	eax, 1
	mov	[ecx], eax

	add	ebx, eax
	mov	eax, d
	mov	e, eax
	mov	eax, c
	mov	d, eax
	mov	eax, b
	ror	eax, 2
	mov	c, eax
	mov	eax, a
	mov	b, eax
	mov	a, ebx
	inc	esi
	cmp	esi, 80
	jnz	@@l5

;--------------------------------------------------------
	mov	eax, a
	add	[SHA1Hash], eax
	mov	eax, b
	add	[SHA1Hash+4], eax
	mov	eax, c
	add	[SHA1Hash+8], eax
	mov	eax, d
	add	[SHA1Hash+12], eax
	mov	eax, e
	add	[SHA1Hash+16], eax
  ;; Check if any Blocks left
	add	edi, 64
 	dec	BCNT
 	jnz	@@loop
	call	EndianRev, offset SHA1Hash, 20
	xor	eax, eax
	mov	a, eax
	mov	b, eax
	mov	c, eax
	mov	d, eax
	mov	e, eax
@@out:	popad
	RET
SHA1 ENDP

SHAPadding PROC				; Pads M to 512Bits (64 Bytes) Border
	LOCAL len:DWORD
	pushad
	lea	edi, hashbuffer
	mov	eax, hLen
	mov	len, eax
	add	edi, eax
	mov	byte ptr[edi], 80h	; Append TRUE Bit to Message
	inc 	edi
	inc	eax
	mov	hLen, eax
	push	64
	pop	ebx
	xor	edx, edx
	div	ebx			; len/64
	mov	eax, 64
	sub	eax, edx
	cmp	eax, 8
	jge	@@ok1
	add	eax, 64
@@ok1:	mov	ecx, eax
	add	hLen, eax
	xor	eax, eax
	cld
	repz	stosb
	mov	eax, len
	shl	eax, 3
	push	eax
	push	edi	
	lea	edi, hashbuffer
	mov	ebx, hLen
	xor	ecx, ecx
@@lc:	mov	eax, [edi+ecx]
	mov	[edi+ecx+3],al
	mov	[edi+ecx+2],ah
	shr	eax, 16
	mov	[edi+ecx+1],al
	mov	[edi+ecx],ah
	add	ecx, 4
	cmp	ecx, ebx
	jl	@@lc
	pop	edi
	pop	eax
	mov	[edi-4], eax
	popad
	RET
SHAPadding ENDP

	db	"þþþþþþþþþþþþþþþþþþþþ Keygenerator made by tHE EGOiSTE / TMG þþþþþþþþþþþþþþþþþþþþ"
END Start
;;
