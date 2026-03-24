VERSION 2.00
Begin Form IsChron 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Is it Chronic?"
   ClientHeight    =   4560
   ClientLeft      =   2610
   ClientTop       =   1200
   ClientWidth     =   4500
   Height          =   4965
   Icon            =   ISCHRON.FRX:0000
   Left            =   2550
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4560
   ScaleWidth      =   4500
   Top             =   855
   Width           =   4620
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Instructions"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   960
      TabIndex        =   1
      Top             =   4080
      Width           =   2895
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Is it the real Chronic?"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   960
      TabIndex        =   5
      Top             =   3600
      Width           =   2895
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1320
      TabIndex        =   3
      Top             =   3120
      Width           =   3015
   End
   Begin Label Label4 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "Paste the string they gave you here"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   225
      Left            =   1320
      TabIndex        =   0
      Top             =   2760
      Width           =   2850
   End
   Begin Label Label3 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "Proof String:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   120
      TabIndex        =   4
      Top             =   3120
      Width           =   1095
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      Caption         =   "Nowa days there are so many people posing as me it's getting tough for me to prove to people that I am who I say I am.  So I have devised this way to be able to prove to people that it's me.  When someone comes online claiming to be me, tell them to prove it by sending you the ""Proof"" string.  You will then copy that string they send you to the clipboard, then paste it in the box below by pressing CTRL-V.  Then hit the ""Is it Chronic?"" button.  If it's the real Chronic AOHell will tell you so, if it's not, it will tell you that too."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   2535
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   4215
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

'// I have removed this code for personal reasons
'// This is the only code that I have removed from
'// the original source code.
'//                   -DC

End Sub

Sub Command3D2_Click ()
MsgBox "If someone comes online and claims to be me (Da Chronic), make them prove it.  If they don't know how, then they are not me.  If they send you a string of weird characters, highlight the string of characters with the mouse (make sure you get all of the characters, and don't copy their screen name, just what they said), and go to the menu ""Edit"" and choose ""Copy"".  Then on AOHell, paste that string in the edit box by hitting CTRL+V.  After that, just hit the ""Is it Chronic?"" button and AOHell will tell you if that's really me or not.", 64, "Instructions"

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(IsChron.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

