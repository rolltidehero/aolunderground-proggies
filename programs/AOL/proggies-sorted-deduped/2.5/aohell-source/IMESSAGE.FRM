VERSION 2.00
Begin Form IMessage1 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Auto-Answer Message"
   ClientHeight    =   2040
   ClientLeft      =   2115
   ClientTop       =   2265
   ClientWidth     =   5535
   ControlBox      =   0   'False
   Height          =   2445
   Icon            =   IMESSAGE.FRX:0000
   Left            =   2055
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2040
   ScaleWidth      =   5535
   Top             =   1920
   Width           =   5655
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&Help"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      HelpContextID   =   21
      Left            =   4320
      TabIndex        =   4
      Top             =   1560
      Width           =   1095
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Cancel"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   4320
      TabIndex        =   3
      Top             =   960
      Width           =   1095
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&OK"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   4320
      TabIndex        =   2
      Top             =   480
      Width           =   1095
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1455
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   480
      Width           =   3975
   End
   Begin Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "Enter the Message you want AOHell to use when Auto-Answering"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   225
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   5325
   End
End
Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
IMessage = Text1.Text
Unload Me

End Sub

Sub Command3D2_Click ()
Unload Me

End Sub

Sub Command3D3_Click ()
SendKeys "{F1}"
DoEvents

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(IMessage1.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

If IMessage = "" Then
Text1.Text = "Fuck off {SN}, I do NOT want to trade warez."
Else
Text1.Text = IMessage
End If

End Sub

