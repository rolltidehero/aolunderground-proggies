VERSION 2.00
Begin Form Form1 
   BackColor       =   &H8000000F&
   BorderStyle     =   0  'None
   Caption         =   "Guide DC"
   ClientHeight    =   735
   ClientLeft      =   2340
   ClientTop       =   2865
   ClientWidth     =   5295
   ControlBox      =   0   'False
   Height          =   1140
   Left            =   2280
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   735
   ScaleWidth      =   5295
   Top             =   2520
   Width           =   5415
   Begin SSCommand Command3D1 
      Caption         =   "C   H  R  O  N  I  C"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   24
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   735
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5295
   End
End
Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
C1 = "D"

thiswin% = FindWindow(0, "America  Online")
  find14% = FindChildByTitle(thiswin%, "Welcome,")
    DoEvents

lint = 50 '7500
C2 = "C"

lpstring = "Welcome, Guide " + C1 + C2 + "!"

X = SendMessagebyString(find14%, WM_SETTEXT, lint, lpstring) ',lint
        DoEvents

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(Form1.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

