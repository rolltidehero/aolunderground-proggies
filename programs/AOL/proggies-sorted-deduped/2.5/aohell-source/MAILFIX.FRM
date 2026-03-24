VERSION 2.00
Begin Form Mailfix 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Email Bomb Recovery"
   ClientHeight    =   1695
   ClientLeft      =   2910
   ClientTop       =   1980
   ClientWidth     =   3495
   Height          =   2100
   Icon            =   MAILFIX.FRX:0000
   Left            =   2850
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1695
   ScaleWidth      =   3495
   Top             =   1635
   Width           =   3615
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
      HelpContextID   =   30
      Left            =   1320
      TabIndex        =   0
      Top             =   1200
      Width           =   855
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   3480
      MessageCount    =   MAILFIX.FRX:0302
      MessageList     =   MAILFIX.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   600
      Width           =   420
   End
   Begin Timer Timer1 
      Left            =   3000
      Top             =   3720
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   1800
      TabIndex        =   1
      Top             =   480
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
      Left            =   2400
      TabIndex        =   3
      Top             =   1200
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
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   1200
      Width           =   855
   End
   Begin Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "AOL 2.5 or higher required"
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   720
      TabIndex        =   6
      Top             =   120
      Width           =   2130
   End
   Begin Label Label7 
      BackColor       =   &H00C0C0C0&
      Caption         =   "(estimate number)"
      FontBold        =   -1  'True
      FontItalic      =   -1  'True
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   1440
      TabIndex        =   4
      Top             =   840
      Width           =   1335
   End
   Begin Label Label6 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Number of mails:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   120
      TabIndex        =   5
      Top             =   480
      Width           =   1410
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
zzag2 = Text2.Text

a$ = "b"
i$ = "w"
b$ = "i"
c$ = "z"
d$ = "a"
e$ = "t"
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
f$ = "c"
J$ = "a"
g$ = "h"
z$ = "b"
k$ = "r"
p1$ = "c"
v$ = "f"
l$ = "g"
h1$ = "t"
h2$ = "k"
m$ = "a"
b1$ = "y"
b2$ = "g"
n$ = "m"
g1$ = "a"
g2$ = "s"
o$ = "e"
o1$ = "h"
o2$ = "f"
o3$ = "gg"
o5$ = "lb"
o6$ = "o"
p$ = "z"
p3$ = "d"
p4$ = "s"
p5$ = "d"
p6$ = "b"
p7$ = "n"
ag = "y"




valid:

MsgBox "Open your New Mail and wait for hourglass to go away.  Then hit the OK button to this message box."
'Possible Response values: 1--IDOK, 2--CANCEL.
'If Response = 1 GoTo mfix1
'If Response = 2 GoTo endall


mfix1:



mailfix.Hide

'wait.Show
mailfix.Hide

    AppActivate "America  Online"
    DoEvents

MMStat.Show
       thiswin% = FindWindow(0, "America  Online")
       NewMail = FindChildByTitle(thiswin%, "New Mail")
       DeleteButton = FindChildByTitle(NewMail, "Delete")
       VBMsg1.SubClasshWnd = DeleteButton
       
              AppActivate "America  Online"
              DoEvents
              Call Pause(2)


For X = 1 To Text2
If quit3 = 100 Then GoTo quit3
          DoEvents

     VBMsg1.SendMessage = WM_LBUTTONDOWN
     VBMsg1.SendMessage = WM_LBUTTONUP
    DoEvents
    
Next X

mailfix.Show
MMStat.Hide

GoTo endall


quit3:
MMStat.Hide
mailfix.Show
GoTo endall

endall:
quit3 = 0

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

Success% = SetWindowPos%(mailfix.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
  

End Sub

Sub Form_Paint ()
 Text2.SetFocus
 
End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(mailfix.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

