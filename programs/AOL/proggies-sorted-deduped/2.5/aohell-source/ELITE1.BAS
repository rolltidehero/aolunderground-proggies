Declare Function SetWindowPos Lib "user" (ByVal h%, ByVal hb%, ByVal x%, ByVal y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer

Global Const SWP_NOMOVE = 2
Global Const SWP_NOSIZE = 1
Global Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Global Const HWND_TOPMOST = -1
Global Const HWND_NOTOPMOST = -2

 Declare Function sndPlaySound Lib "MMSYSTEM.DLL" (ByVal lpszSoundName$, ByVal wFlags%) As Integer

  ' Global Const SND_SYNC = &H0
   Global Const SND_ASYN = &H1
  ' Global Const SND_NODEFAULT = &H2
  ' Global Const SND_LOOP = &H8
  ' Global Const SND_NOSTOP = &H10

'Add the following line of code to the appropriate function or subroutine
'in your application:

