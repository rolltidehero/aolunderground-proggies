' Module1
'Option Explicit
Declare Function enablemenuitem Lib "User" (ByVal p1%, ByVal p2%, ByVal p3%) As Integer
Declare Function extfn608 Lib "VBWFIND.dll" Alias "findchildbyclass" () As Integer
Declare Function extfn5D0 Lib "VBWFIND.dll" Alias "findchildbytitle" (ByVal p1%, ByVal p2$) As Integer
Declare Function getactivewindow Lib "User" () As Integer
Declare Function GetClassName Lib "User" (ByVal p1%, ByVal p2$, ByVal p3%) As Integer
Declare Sub GETCURSORPOS Lib "User" (p1 As Any)
Declare Function GetDeviceCaps Lib "GDI" () As Integer
Declare Function getfocus Lib "User" () As Integer
Declare Function GetMenu Lib "User" (ByVal p1%) As Integer
Declare Function getmenuitemcount Lib "User" (ByVal p1%) As Integer
Declare Function getmenuitemid Lib "User" (ByVal p1%, ByVal p2%) As Integer
Declare Function getmenustate Lib "User" (ByVal p1%, ByVal p2%, ByVal p3%) As Integer
Declare Function getmenustring Lib "User" (ByVal p1%, ByVal p2%, ByVal p3$, ByVal p4%, ByVal p5%) As Integer
Declare Function GetParent Lib "User" (ByVal p1%) As Integer
Declare Function GetSubMenu Lib "User" (ByVal p1%, ByVal p2%) As Integer
Declare Function GetSystemDirectory Lib "Kernel" (ByVal p1$, ByVal p2%) As Integer
Declare Function GetSystemMenu Lib "User" () As Integer
Declare Function GetVersion Lib "Kernel" () As Long
'Declare Function GetWindowsDirectory Lib "Kernel" () As Integer
Declare Function ismenu Lib "User" () As Integer
Declare Function sendmessage Lib "User" (ByVal p1%, ByVal p2%, ByVal p3%, p4 As Any) As Long
Declare Function SETACTIVEWINDOW Lib "User" (ByVal p1%) As Integer
'Declare Function SetFocus Lib "User" (ByVal p1%) As Integer
Declare Sub SetWindowText Lib "User" ()
'Declare Function sndPlaySound Lib "MMSystem" (ByVal p1$, ByVal p2%) As Integer
Declare Function TrackPopupMenu Lib "User" (ByVal p1%, ByVal p2%, ByVal p3%, ByVal p4%, ByVal p5%, ByVal p6%, p7 As Any) As Integer
Declare Function waveOutGetNumDevs Lib "MMSystem" () As Integer
'Declare Sub SetWindowPos Lib "User" ()
Declare Function GetWindowText Lib "User" () As Integer
Declare Function GetWindowTextLength Lib "User" () As Integer
Dim m00C2 As String

