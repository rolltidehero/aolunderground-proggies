VERSION 2.00
Begin Form SmallPack 
   BackColor       =   &H8000000F&
   BorderStyle     =   0  'None
   ClientHeight    =   240
   ClientLeft      =   1710
   ClientTop       =   15
   ClientWidth     =   1575
   ControlBox      =   0   'False
   Height          =   645
   Left            =   1650
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   240
   ScaleWidth      =   1575
   Top             =   -330
   Width           =   1695
   Begin SSCommand Command3D1 
      Caption         =   "Pack Status -"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1575
   End
End
Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
PackStatus.Show
Unload Me

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(SmallPack.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

