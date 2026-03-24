VERSION 2.00
Begin Form punt2stat 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Punt"
   ClientHeight    =   1065
   ClientLeft      =   4980
   ClientTop       =   330
   ClientWidth     =   4545
   ControlBox      =   0   'False
   Height          =   1470
   Icon            =   PUNTSTAT.FRX:0000
   Left            =   4920
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1065
   ScaleWidth      =   4545
   Top             =   -15
   Width           =   4665
   Begin SSPanel Panel3D1 
      BevelInner      =   2  'Raised
      Caption         =   "Punting..."
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   720
      Width           =   4575
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Stop this thing!"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   1440
      TabIndex        =   0
      Top             =   240
      Width           =   1695
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub command3d1_click ()
GoTo dfd1

booyaka:
Unload punt2stat
Exit Sub


dfd1:
On Error GoTo booyaka

quit6 = 1000
quit7 = 1000
AppActivate "America  Online"
Panel3d1.Caption = "Cancel request acknowledged.. Please wait.."


End Sub

Sub Form_Click ()
AppActivate "America  Online"

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(punt2stat.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)


End Sub

