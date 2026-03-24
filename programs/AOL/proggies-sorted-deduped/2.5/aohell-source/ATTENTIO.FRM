VERSION 2.00
Begin Form Attention 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Attention"
   ClientHeight    =   1695
   ClientLeft      =   2070
   ClientTop       =   2775
   ClientWidth     =   5265
   ControlBox      =   0   'False
   Height          =   2100
   Left            =   2010
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1695
   ScaleWidth      =   5265
   Top             =   2430
   Width           =   5385
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "Label1"
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   4935
   End
End
Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(Attention.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

