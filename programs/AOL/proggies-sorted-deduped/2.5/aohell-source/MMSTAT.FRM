VERSION 2.00
Begin Form MMStat 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Fixing Mailbox"
   ClientHeight    =   990
   ClientLeft      =   2715
   ClientTop       =   3180
   ClientWidth     =   4575
   ControlBox      =   0   'False
   Height          =   1395
   Icon            =   MMSTAT.FRX:0000
   Left            =   2655
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   990
   ScaleWidth      =   4575
   Top             =   2835
   Width           =   4695
   Begin SSPanel Panel3D1 
      BevelInner      =   2  'Raised
      Caption         =   "Mass Deleting..."
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   600
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
      Left            =   1320
      TabIndex        =   0
      Top             =   120
      Width           =   1815
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
AppActivate "America  Online"
quit3 = 100


End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(mmstat.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2


End Sub

