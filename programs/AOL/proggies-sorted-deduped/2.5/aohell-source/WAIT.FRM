VERSION 2.00
Begin Form wait 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Please Wait"
   ClientHeight    =   1665
   ClientLeft      =   2550
   ClientTop       =   1740
   ClientWidth     =   4530
   ControlBox      =   0   'False
   Height          =   2070
   Icon            =   WAIT.FRX:0000
   Left            =   2490
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1665
   ScaleWidth      =   4530
   Top             =   1395
   Width           =   4650
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Skip Pause"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   1440
      TabIndex        =   1
      Top             =   1200
      Width           =   1695
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Pausing for 60 seconds to let all the mail come up.  If the mail is finished coming up hit the Skip Pause button.  (Move the cursor over AOL and wait for hourglass to go away.)"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   975
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   4095
      WordWrap        =   -1  'True
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
SkipPause = 1

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(wait.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
'Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2


End Sub

