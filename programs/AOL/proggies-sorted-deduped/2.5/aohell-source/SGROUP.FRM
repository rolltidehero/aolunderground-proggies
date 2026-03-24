VERSION 2.00
Begin Form Setupgroup 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "-=AOHell=-  Member Search Groups  -=AOHell=-"
   ClientHeight    =   3600
   ClientLeft      =   675
   ClientTop       =   1125
   ClientWidth     =   5565
   ForeColor       =   &H00C0C0C0&
   Height          =   4005
   Left            =   615
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3600
   ScaleWidth      =   5565
   Top             =   780
   Width           =   5685
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
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   3360
      TabIndex        =   7
      Top             =   3120
      Width           =   975
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
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   1320
      TabIndex        =   6
      Top             =   3120
      Width           =   975
   End
   Begin CommandButton Cancel_btn 
      Caption         =   "Cancel"
      Height          =   372
      Left            =   5760
      TabIndex        =   2
      Top             =   3120
      Visible         =   0   'False
      Width           =   972
   End
   Begin CommandButton OK_Btn 
      Caption         =   "OK"
      Height          =   372
      Left            =   5760
      TabIndex        =   3
      Top             =   3360
      Visible         =   0   'False
      Width           =   972
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   285
      Left            =   360
      TabIndex        =   0
      Top             =   480
      Width           =   4815
   End
   Begin TextBox Text2 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1812
      Left            =   360
      MaxLength       =   1000
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   1200
      Width           =   4932
   End
   Begin Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Type In Group Name:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   225
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   1935
      WordWrap        =   -1  'True
   End
   Begin Label Label2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Type In Screen Names (with commas between names):"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   240
      Left            =   120
      TabIndex        =   5
      Top             =   840
      Width           =   4935
   End
End
'Option Explicit

Sub Cancel_btn_Click ()
gv0234 = 0
Unload Setupgroup

End Sub

Sub Command3D1_Click ()
Call OK_Btn_Click

End Sub

Sub Command3D2_Click ()
Call Cancel_btn_Click

End Sub

Sub Form_Load ()
Me.Top = (Screen.Height - Me.Height) / 2
Me.Left = (Screen.Width - Me.Width) / 2

End Sub

Sub OK_Btn_Click ()
Dim l0038 As Variant
Dim l003C As Variant
If Text1.Text = "" Or Text2.Text = "" Then MsgBox "Form Not Completely Filled", 48, "Sweetalk": Exit Sub
If gv0234 = 1 Then
Setupwho.List2.AddItem Trim(Text1.Text)
Setupwho.List3.AddItem Trim(Text2.Text)
gv0234 = 0
Else
Setupwho.List2.List(Setupwho.List2.ListIndex) = Text1.Text
Setupwho.List3.List(Setupwho.List2.ListIndex) = Text2.Text
End If
l0038 = App.Path & "\aohell.who"
Open l0038 For Output As #1
For l003C = 0 To Setupwho.List2.ListCount - 1
Write #1, Setupwho.List2.List(l003C) + Chr(170) + Setupwho.List3.List(l003C)
Next l003C
Close #1
Unload Setupgroup

End Sub

