VERSION 2.00
Begin Form Form3 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Scroll"
   ClientHeight    =   2235
   ClientLeft      =   1800
   ClientTop       =   2205
   ClientWidth     =   5985
   ControlBox      =   0   'False
   ForeColor       =   &H00FFFF80&
   Height          =   2640
   Icon            =   SCROLL.FRX:0000
   Left            =   1740
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2235
   ScaleWidth      =   5985
   Top             =   1860
   Width           =   6105
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   5520
      MessageCount    =   SCROLL.FRX:0302
      MessageList     =   SCROLL.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   1800
      Width           =   420
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
      Left            =   4320
      TabIndex        =   9
      Top             =   1800
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
      Left            =   3000
      TabIndex        =   8
      Top             =   1800
      Width           =   975
   End
   Begin TextBox Text4 
      Height          =   285
      Left            =   1680
      TabIndex        =   7
      Top             =   1800
      Width           =   615
   End
   Begin TextBox Text3 
      Height          =   285
      Left            =   1080
      TabIndex        =   6
      Top             =   1200
      Width           =   4695
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   1080
      TabIndex        =   5
      Top             =   720
      Width           =   4695
   End
   Begin TextBox Text1 
      Height          =   285
      Left            =   1080
      TabIndex        =   4
      Top             =   240
      Width           =   4695
   End
   Begin Label Label5 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Line 3:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   1200
      Width           =   615
   End
   Begin Label Label4 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Line 2:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   720
      Width           =   615
   End
   Begin Label Label3 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Line 1:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   735
   End
   Begin Label Label2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Times to repeat:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   1800
      Width           =   1455
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


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
If Text1.Text = "" Then
MsgBox "You must enter what you want to scroll."
Exit Sub
End If
 GoTo scrollbeg

scrollerr:
MsgBox "An error has occured.  Cannot continue.", 16, "Error!"
Exit Sub
next4:
Resume tryagain

scrollbeg:
On Error GoTo next4


ok1:
AppActivate "America  Online"

If Text4.Text = "" Then GoTo endall

tryagain:
On Error GoTo scrollerr
     Zapp = 0

For X = 1 To Text4
    
DoEvents
Call Pause(1.7)
DoEvents


start1:

SendKeys Text1.Text

 SendKeys "{ENTER}"


DoEvents

text22:

If Text2.Text = "" Then
GoTo text33
Else

SendKeys Text2.Text
DoEvents

SendKeys "{ENTER}"
End If



text33:
If Text3.Text = "" Then
GoTo zaza1
Else

SendKeys Text3.Text

SendKeys "{ENTER}"
End If

zaza1:

Next X


endall:

End Sub

Sub Command3D2_Click ()
Unload Me

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(form3.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)


End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(form3.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

