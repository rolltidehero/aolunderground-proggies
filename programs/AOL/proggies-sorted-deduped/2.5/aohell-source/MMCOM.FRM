VERSION 2.00
Begin Form MMCom 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Comments to include with Mass Mail"
   ClientHeight    =   1695
   ClientLeft      =   1965
   ClientTop       =   1590
   ClientWidth     =   4995
   ControlBox      =   0   'False
   Height          =   2100
   Left            =   1905
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1695
   ScaleWidth      =   4995
   Top             =   1245
   Width           =   5115
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
      Left            =   3960
      TabIndex        =   2
      Top             =   720
      Width           =   855
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
      Left            =   3960
      TabIndex        =   1
      Top             =   240
      Width           =   855
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1455
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Text            =   "-==AOHell==- Free Mass Mail courtesy of "
      Top             =   120
      Width           =   3615
   End
End
Sub Command3D1_Click ()
MMComment = Text1.Text
Unload Me
WarezBot.Show

End Sub

Sub Command3D2_Click ()
Unload Me
WarezBot.Show

End Sub

Sub Form_Load ()
Text1.Text = "-==AOHell==- Free Mass Mail courtesy of " + ScreenName

End Sub

