VERSION 2.00
Begin Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   1080
   ClientLeft      =   3630
   ClientTop       =   675
   ClientWidth     =   4095
   Height          =   1485
   Left            =   3570
   LinkTopic       =   "Form1"
   ScaleHeight     =   1080
   ScaleWidth      =   4095
   Top             =   330
   Width           =   4215
   Begin CommandButton Command1 
      Caption         =   "Command1"
      Height          =   1095
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4095
   End
End
  Declare Function SetWindowPos Lib "User" (ByVal H%, ByVal hb%, ByVal X%, ByVal Y%, ByVal CX%, ByVal CY%, ByVal F%) As Integer


  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

Sub Command1_Click ()

    Randomize
    upperb = 999999
    lowerb = 111111

    Transit = Int((upperb - lowerb + 1) * Rnd + lowerb)
         Clipboard.SetText "aol://4344:1.a." + Trim$(Transit)
         AppActivate "America  Online"
         DoEvents
         SendKeys Chr$(22) + "{ENTER}"


End Sub

Sub Form_Load ()
    Dim Success As Integer

    Success% = SetWindowPos%(Form1.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

