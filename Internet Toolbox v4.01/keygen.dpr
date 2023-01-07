program keygen;
{
 Internet ToolBox v4.01  Keygen by tE! // TMG
 Protection: (Useless implementation of) ElGamal
}

uses Windows, Messages, SysUtils, FGIntElGamal, FGInt;

{$R *.RES}

var
x,y,w,h	:integer;
wrec	:TRect;
wClass	:TWndClass;
hFont, hInst, Handle, hGenerate, hAbout, hRegcode,
hLabel, hLabel2, hLabel3, hUsername, hDesktop	:HWND;
Msg	:TMSG;

procedure ExitKeygen;
begin
  DeleteObject(hFont);
  UnRegisterClass('tE KeygenClass',hInst);
  ExitProcess(0);
end;

procedure Generate;
var
   i,j : integer;
   s : Longword;
   kstr,regstr,tmpstr : String;
   instr: PChar;
   p, g, x, y, k : TFGInt;
begin
   // Prime modulus
   Base10StringToFGInt('144138568175333', p);
   // Generator
   Base10StringToFGInt('2', g);
   // Private x ('Internet ToolBox v4.0') - crap
   Base10StringToFGInt('107320204233669375722430952347435434190593533947440', x);
   // y = g^x mod p
   FGIntModExp(g, x, p, y);
   GetMem(instr,100);
   i:=GetWindowText(hUsername, instr, 61);
   if (i<1) then
        begin
        SetWindowText(hRegcode,'Invalid Username.');
        FreeMem(instr);
        FGIntDestroy(p);
        FGIntDestroy(g);
        FGIntDestroy(x);
        Exit;
        end;
   // Shit. I love asm - not Pascal :-)
   asm
   mov  esi, instr
   mov  edi, esi
   mov  ecx, i
   cmp  ecx, 11
   jbe  @o
   push 10
   pop  ecx
@o:inc  ecx
   xor  edx, edx
@n:lodsb
   cmp  al, 20h
   jz   @n
   stosb
   inc  edx
   dec  ecx
   jg   @n
@d:mov  j, edx
   and  byte ptr[edi],0
   end;
   if (j<1) then
        begin
        SetWindowText(hRegcode,'Invalid Username.');
        FreeMem(instr);
        FGIntDestroy(p);
        FGIntDestroy(g);
        FGIntDestroy(x);
        Exit;
        end;
   regstr:=instr;
   s:=$A93175CB;
   for i:=1 to j do
   begin
   s:=s*Longword(regstr[i]);
   asm
   rol s, 3
   end;
   end;
   s:=(s MOD 99999) OR $4001;
   kstr:=inttostr(s);
   regstr:=kstr+regstr;

   Base10StringToFGInt(kstr, k);
   ElGamalEncrypt(regstr, g, y, k, p, regstr);

   ConvertBase256to64(regstr,tmpstr);
   SetWindowText(hRegcode, PChar(tmpstr) );
   FreeMem(instr);
   FGIntDestroy(p);
   FGIntDestroy(g);
   FGIntDestroy(x);
   FGIntDestroy(y);
   FGIntDestroy(k);
end;

function WindowProc(hWnd,Msg,wParam,lParam:Longint):Longint; stdcall;
begin
  Result:=DefWindowProc(hWnd,Msg,wParam,lParam);
  case Msg of
  WM_COMMAND: if      lParam=Longint(hGenerate) then Generate
              else if lParam=Longint(hAbout) then MessageBox(hWnd,
                                                            'Keygenerator by tHE EGOiSTE/TMG'#13#10#13#10'Greets to Ousir/TNO'#13#10#13#10'Have a nice day.','About',MB_ICONINFORMATION OR MB_OK OR MB_APPLMODAL);
  WM_DESTROY: ExitKeygen;
  end;
end;

begin
  hInst:=GetModuleHandle(nil);

  with wClass do
  begin
    Style:=         CS_HREDRAW or CS_VREDRAW;
    hIcon:=         LoadIcon(hInst,'MAINICON');
    lpfnWndProc:=   @WindowProc;
    hInstance:=     hInst;
    hbrBackground:= COLOR_BTNFACE+1;
    lpszClassName:= 'tE KeygenClass';
    hCursor:=       LoadCursor(0,IDC_ARROW);
  end;

  RegisterClass(wClass);
  h:=GetSystemMetrics(SM_CYSIZE);
  h:=(h-18)+180;
  w:=365;
  hDesktop:=GetDesktopWindow();
  GetWindowRect(hDesktop,wrec);
  x:=wrec.right;
  y:=wrec.bottom;
  x:=(x-365) div 2;
  y:=(y-h) div 2;

  Handle:=CreateWindowEx(WS_EX_DLGMODALFRAME, 'tE KeygenClass',
    'Internet ToolBox v4.01 - Keygen by tE! / TMG',
    WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX or WS_VISIBLE,
    x, y, w, h, 0, 0, hInst, nil);

  hGenerate:=CreateWindowEx(0, 'Button', 'Generate', WS_VISIBLE or WS_CHILD,
    4,120,65,24,Handle,0,hInst,nil);

  hAbout:=CreateWindowEx(0, 'Button', 'About', WS_VISIBLE or WS_CHILD,
    80,120,65,24,Handle,0,hInst,nil);

  hRegcode:=CreateWindowEx(
    WS_EX_CLIENTEDGE,
    'Edit',
    'Enter your name and press Generate.',
    WS_VISIBLE or WS_CHILD or ES_LEFT or ES_AUTOHSCROLL or ES_READONLY,
    5,82,350,20,Handle,0,hInst,nil);

  hUsername:=CreateWindowEx(WS_EX_CLIENTEDGE, 'Edit','', WS_VISIBLE or WS_CHILD or ES_LEFT or ES_AUTOHSCROLL,
    4,28,350,20,Handle,0,hInst,nil);

  hLabel:=CreateWindowEx(0, 'Static', 'Username:', WS_VISIBLE or WS_CHILD or SS_LEFT,
    4,10,50,18,Handle,0,hInst,nil);

  hLabel2:=CreateWindowEx(0, 'Static', 'Registration code:', WS_VISIBLE or WS_CHILD or SS_LEFT,
    4,64,100,18,Handle,0,hInst,nil);

  hLabel3:=CreateWindowEx(0, 'Static', 'tHE EGOiSTE/TMG', WS_VISIBLE or WS_CHILD or SS_LEFT or WS_DISABLED,
    270,141,90,18,Handle,0,hInst,nil);

  hFont:=CreateFont(-11, 0, 0, 0, 0, 0, 0, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
    DEFAULT_QUALITY, DEFAULT_PITCH or FF_DONTCARE, 'Arial');

  SendMessage(hGenerate,WM_SETFONT,hFont,0);
  SendMessage(hAbout,WM_SETFONT,hFont,0);
  SendMessage(hRegcode,WM_SETFONT,hFont,0);
  SendMessage(hUsername,WM_SETFONT,hFont,0);
  SendMessage(hLabel,WM_SETFONT,hFont,0);
  SendMessage(hLabel2,WM_SETFONT,hFont,0);
  SendMessage(hLabel3,WM_SETFONT,hFont,0);
  SendMessage(hUsername,EM_SETLIMITTEXT,60,0);

  SetFocus(hUsername);

  while(GetMessage(Msg,Handle,0,0))do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end.
