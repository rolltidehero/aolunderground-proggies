VERSION 2.00
Begin Form mmwait 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Mass Mailing..."
   ClientHeight    =   1920
   ClientLeft      =   2445
   ClientTop       =   3225
   ClientWidth     =   4560
   ControlBox      =   0   'False
   Height          =   2325
   Left            =   2385
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1920
   ScaleWidth      =   4560
   Top             =   2880
   Width           =   4680
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Complete"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   1680
      TabIndex        =   1
      Top             =   1200
      Width           =   1215
   End
   Begin Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H8000000F&
      Caption         =   "                                                               "
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   195
      Left            =   600
      TabIndex        =   2
      Top             =   1560
      Width           =   3375
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "Mass Mailing...  Be patient, sometimes the mass mailing will pause for a few seconds, this does not mean it's stuck.  You may stop this process anytime you wish.    PRESS THE <F3> KEY TO STOP IT"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   975
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4335
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

'GoTo begin

'titfuck:
' GoTo titfuck1
'
'titfuck2:
' MsgBox "An error has occurred -- cannot stop WhaleEx script.  Please click on an AOL window then hit the ""F3"" button."
' Unload mm2
' Unload mmwait
' Exit Sub

'titfuck1:
 'On Error GoTo titfuck2
 'AppActivate "Whale Express - read.wex"
 'DoEvents
 'SendKeys "%{F4}"
 'Resume Ending
 
'begin:
'On Error GoTo titfuck
'AppActivate "Whale Express - MFWD.WEX"
'DoEvents
'SendKeys "%{F4}"

'Ending:

mm2.Show
Unload mmwait

End Sub

Sub Form_GotFocus ()
'label2.Caption = "Creating WhaleEx scripts -- PLEASE WAIT."
'DoEvents
'Call Pause(20)
'DoEvents
'label2.Caption = "(Click here when complete, or to stop it)"

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(mmwait.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

AppActivate "America  Online"

Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2

End Sub

Sub Label1_Click ()
AppActivate "America  Online"

End Sub

