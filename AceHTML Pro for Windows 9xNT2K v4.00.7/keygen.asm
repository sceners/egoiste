;-------------------------------------------------------------
; AceHTML Pro for Windows 9x/NT4 and 2000
; Version 4 (4.00.7) - 09.07.00
; Protection: Blowfish
; KEYGENERATOR by tHE EGOiSTE // TMG
;
; Assemble:
; tasm32 /mx /m4 /z keygen.asm
; tlink32 -x -V4.0 -Tpe -aa -c keygen.obj,keygen,,,keygen.def,keygen.res
;-------------------------------------------------------------

.386
.MODEL FLAT, STDCALL
LOCALS
UNICODE	= 0

; Adjust paths before assembling...
INCLUDELIB G:\KTA\BIN\LIBGEN\imp32i.lib
INCLUDE E:\UNZIPPED\KTA\BIN\w32.inc
;
ICON_BIG		=     1
BT_CLIP                 =     200
BT_EXIT                 =     201
KEYGEN_ICON             =     101
IDD_MAIN                =     103
PTR_EMAIL               =     104
EDIT_NAME               =     1001
EDIT_KEY                =     1002
IDC_ABOUT		=     1003
GHND 			=     GMEM_MOVEABLE OR GMEM_ZEROINIT
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
extrn	GetCursorPos		:	PROC
extrn	ScreenToClient		:	PROC
;
MINCHARS	=	4
MAXCHARS	=	31
;
.DATA
INCLUDE		piboxes.asm			; Hexdigits of PI - w/o leading '3.'
Data_BoxIni	dd	0,0			; Init-value: Used for later p/sBox-encryption	

wtext		db "AceHTML Pro v4.00.7 - Keygen by tE!",0
defname		db "tHE EGOiSTE [TMG]",0
infocap		db "Info",0
aboutcap	db "About",0
err_cap  	db "Error",0
clipflag	db 0
clipmsg		db "* TMG - Cream of the Scene *",0
BlowfishKey	db "ABCZGRTEHJTDF6545YTREWKERTY58963540"
BF_Keylen	= ($-BlowfishKey)
conversiontab	db "CVRU23456789ABCDEFGHHJKLMNNPQRSTUVWXYZABCDEFGHIJKLMNPPQRSTUVWXYZ",0
xortab		db 5Bh,31h,2Ah,79h,7Ch,0Ah,1Ch,07h

  align 4
fmat		db "%.8lX",0
  align 4
pnt		POINT <>
  align 4
rec		RECT <>
;---------------------------------------------------------------------------------------------
nameerr		db "Supported name length: 4 to 31 Chars.",0
abouttxt	db "Keygenerator made by tHE EGOiSTE [TMG]",13,10,13,10
		db "Program:",9,"AceHTML Pro v4.00.7",13,10
		db "OS:",9,"Win9xNT",13,10
		db "Date:",9,"07-10-2000",13,10
		db "Notes:",9,"Version 4 (4.00.7) - 09.07.00",13,10,13,10
		db "The Millenium Group 2000",0

.DATA?
hAbout		dd ?
save_esp	dd ?
bbtn		dd ?
cursor_e	dd ?
hdlg		dd ?
_hInst          dd ?
nlen		dd ?

userinput	db 260 dup(?)
userkey		db 60 dup(?)
.CODE

Start:	pushad
	call	GetModuleHandle, 0
	test	eax,eax
	je	ExitKeyGen
        mov	_hinst,eax
	call	BF_InitBoxes, offset BlowfishKey
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
	call	SetWindowTextA, __hwnd, offset wtext	; Fenstertitel
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
	LOCAL len:DWORD
	LOCAL hmemtemp:DWORD
	LOCAL lpb:DWORD
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
	local	cnt:DWORD, cnt2:DWORD

	call	GetDlgItemTextA, hdlg, EDIT_NAME, offset userinput, MAXCHARS+1
	cmp	eax, MINCHARS
	mov	clipflag, 0
	jl	@@err
	mov	nlen, eax
;------------------------------------------------------------------------------

	mov	ecx, eax
	lea	esi, userinput
	mov	edi, esi
@@lp1:	lodsb
	cmp	al, 61h
	jb	@@cok
	cmp	al, 7Ah
	ja	@@cok
	sub	al, 20h
@@cok:	stosb
	dec	ecx
	jg	@@lp1

	mov	eax, nlen
	xor	edx, edx
	push	8
	pop	ecx
	div	ecx
	inc	eax

	mov	ecx, eax
	mov	edx, eax
	shl	ecx, 3
	mov	cnt2, ecx
	sub	ecx, nlen
	jz	@@nopad
	mov	eax, ecx
	rep	stosb		
@@nopad:and	dword ptr[edi], 0
	lea	edi, userinput
	lea	esi, xortab
	xor	ecx, ecx
@@lp2:	lodsb
	xor	[edi+ecx], al
	inc	ecx
	cmp	ecx, 8
	jl	@@lp2

	mov	cnt, edx
	lea	esi, userinput
@@mec:	call	EndianRev, esi, 8 
; [] BF encrypt 1 block
	call	BF_Encrypt, esi, offset pBox, 1
	call	EndianRev, esi, 8
	dec	cnt
	jz	@@eout
	lea	edi, [esi+8]
	xor	ecx, ecx
@@nec:	lodsb
	xor	[edi+ecx], al
	inc	ecx
	cmp	ecx, 8
	jl	@@nec
	jmp	@@mec
@@eout:
; [] Character conversion
	lea	edi, userkey
	mov	al, "Z"
	push	20
	pop	ecx
	rep	stosb

	mov	ebx, cnt2
	inc	ebx
	mov	cnt, ebx
	push	4
	pop	ebx
	lea	esi, userinput
	lea	edi, userkey
@@conl:	lodsb
	mov	ecx, eax
	and	eax, 255
	shr	eax, 2
	mov	al, conversiontab[eax]
	stosb			
	dec	cnt
	lodsb
	mov	edx, eax
	and	ecx, 3	
	and	edx, 0Fh
	shl	ecx, 4
	and	eax, 0F0h
	shr	eax, 4
	or	cl, al
	mov	al, conversiontab[ecx]
	stosb
	dec	cnt
	lodsb
	shl	edx, 2
	mov	ecx, eax
	and	ecx, 3Fh
	and	eax, 0C0h
	shr	eax, 6
	or	dl, al
	mov	al, conversiontab[edx]
	stosb
	dec	cnt
	jz	@@fout
	mov	al, conversiontab[ecx]
	stosb
	mov	byte ptr[edi], "-"
	inc	edi
	dec	ebx
	jg	@@conl	
	and	byte ptr [edi-1], 0
	jmp	@@done
@@fout:	mov	byte ptr[edi+1],"-"
	and	byte ptr[edi+6], 0
@@done:
;------------------------------------------------------------------------------
	call	SetDlgItemTextA, hDlg, EDIT_KEY, offset userkey
	mov	clipflag, 1
fzk:	xor	eax, eax
	RET
@@err:	call	SetDlgItemTextA, hDlg, EDIT_KEY, offset nameerr
	jmp	fzk
Generate ENDP

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

BF_InitBoxes PROC lpBFKey:DWORD
	lea	esi, pbox
	xor	ecx, ecx
	lea	edi, Blowfishkey
	xor	edx, edx
@@l_1:	push	4
	pop	eax
@@l1:	shl	ebx, 8
	mov	bl, [edi+edx]
	inc	edx
	cmp	edx, BF_keylen
	jnz	@@ok
	xor	edx, edx
@@ok:	dec	eax
	jg	@@l1
	xor	[esi+ecx], ebx
	add	ecx, 4
	cmp	ecx, 18*4
	jl	@@l_1	
				
; Encrypt all Boxes now
	xor	eax, eax			; Data_high = 0x00000000 (High DWORD of 64-Bit (init-)value)
	xor	ebx, ebx			; Data_low  = 0x00000000 (Low  DWORD of 64-Bit (init-)value)
	mov	edi, offset Data_BoxIni		; edi = lp -> 64-Bit Initialization value
	lea	esi, pbox

	mov	[edi], eax
	mov	[edi+4], ebx

	mov	ecx, 9+512			; Encrypt pBox (9*64 Bit) & sBoxes (4*128*64 Bit)
@@l_3:	call	BF_Encrypt, edi, offset pBox, 1
	mov	eax, [edi]
	mov	ebx, [edi+4]
	mov	[esi], eax
	mov	[esi+4], ebx
	add	esi, 8
	dec	ecx
	jg	@@l_3
	RET
BF_InitBoxes ENDP

BF_Encrypt PROC lpBFData:DWORD, lpBFpBox:DWORD, noblocks:DWORD
	USES	ebx, edi, esi
	LOCAL	BF_cnt:DWORD	
	pushad
	mov	eax, noblocks
	mov	BF_cnt, eax
	mov	esi, lpBFData			; lp to 64Bit data-block to encrypt
	mov	edi, lpBFpBox			; lp to pBox
@@main:	xor	ecx, ecx
@@l_1:	mov	eax, [esi]			; D_High
	xor	eax, [ecx*4+edi]		; D_High XOR pBox[ecx]
	mov	[esi], eax			; save D_High

	push	ecx				; save counter
	xor	edx, edx
	mov	dl, al				; D
	mov	edx, [edx*4+offset sbox_1+3*1024]; sBox_4, D
	shr	eax, 8
	xor	ebx, ebx
	mov	bl, al				; C
	mov	ebx, [ebx*4+offset sbox_1+2*1024]; sBox_3, C
	shr	eax, 8
	xor	ecx, ecx
	mov	cl, al				; B
	mov	ecx, [ecx*4+offset sbox_1+1*1024]; sBox_2, B
	shr	eax, 8				; A
	mov	eax, [eax*4+offset sBox_1]	; sBox_1, A
	add	eax, ecx
	xor	eax, ebx
	add	eax, edx	
	pop	ecx				; restore counter
	xor	eax, [esi+4]			; fB(D_High) XOR D_Low
	mov	ebx, [esi]
	mov	[esi], eax
	mov	[esi+4], ebx
	inc	ecx
	cmp	ecx, 16				; do 16 rounds
	jne	@@l_1
	mov	eax, [esi]
	mov	ebx, [esi+4]
	mov	[esi], ebx
	mov	[esi+4], eax
	mov	eax, [ecx*4+edi]
	inc	ecx
	mov	ebx, [ecx*4+edi]
	xor	[esi], ebx			; D_High = pBox[17] XOR D_Low
	xor	[esi+4], eax			; D_Low = pBox[16] XOR D_High
	add	esi, 8
	dec	BF_cnt
	jnz	@@main
	popad
	RET
BF_Encrypt ENDP

END Start
;;
