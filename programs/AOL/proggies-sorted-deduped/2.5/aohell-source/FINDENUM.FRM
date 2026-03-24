VERSION 2.00
Begin Form Form2 
   BackColor       =   &H8000000F&
   Caption         =   "Form2"
   ClientHeight    =   4020
   ClientLeft      =   1095
   ClientTop       =   1485
   ClientWidth     =   7365
   Height          =   4425
   Left            =   1035
   LinkTopic       =   "Form2"
   ScaleHeight     =   4020
   ScaleWidth      =   7365
   Top             =   1140
   Width           =   7485
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "Command3D2"
      Font3D          =   3  'Inset w/light shading
      Height          =   375
      Left            =   2520
      TabIndex        =   2
      Top             =   2280
      Width           =   1815
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "Command3D1"
      Font3D          =   3  'Inset w/light shading
      Height          =   495
      Left            =   2520
      TabIndex        =   1
      Top             =   1680
      Width           =   1815
   End
   Begin ListBox List1 
      Height          =   3150
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   1815
   End
End
Declare Function FindWindow Lib "User" (ByVal lpClassName As Any, ByVal lpWindowName As Any) As Integer
Declare Function SetWindowPos Lib "User" (ByVal H%, ByVal hb%, ByVal X%, ByVal Y%, ByVal CX%, ByVal CY%, ByVal F%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
Cert5 = FindWindow("_AOL_Modal", "")
CardNumber = VBEnumChildWindows(Cert5, -1)
  For i = 1 To CardNumber
   ca = VBEnumChildWindows(Cert5, i)
   List1.AddItem ca
  Next i


End Sub

Sub Command3D2_Click ()
List1.Clear

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(Form2.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

