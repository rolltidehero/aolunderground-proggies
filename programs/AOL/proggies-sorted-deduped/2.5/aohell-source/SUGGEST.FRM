VERSION 2.00
Begin Form suggestion 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Suggestions/Questions"
   ClientHeight    =   4080
   ClientLeft      =   1695
   ClientTop       =   1635
   ClientWidth     =   6345
   Height          =   4485
   Icon            =   SUGGEST.FRX:0000
   Left            =   1635
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   ScaleHeight     =   4080
   ScaleWidth      =   6345
   Top             =   1290
   Width           =   6465
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   0
      MessageCount    =   SUGGEST.FRX:0302
      MessageList     =   SUGGEST.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   3600
      Width           =   420
   End
   Begin OptionButton Option2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "&Question"
      Height          =   255
      Left            =   2280
      TabIndex        =   0
      Top             =   3600
      Width           =   1095
   End
   Begin OptionButton Option1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "&Suggestion"
      Height          =   255
      Left            =   720
      TabIndex        =   6
      Top             =   3600
      Value           =   -1  'True
      Width           =   1335
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Cancel"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   5040
      TabIndex        =   4
      Top             =   3600
      Width           =   1095
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Send"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   3720
      TabIndex        =   3
      Top             =   3600
      Width           =   1095
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Suggestion/Question"
      Height          =   2055
      Left            =   240
      TabIndex        =   1
      Top             =   1440
      Width           =   5895
      Begin TextBox Text1 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "Arial"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   1455
         Left            =   240
         MaxLength       =   7900
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   2
         Top             =   360
         Width           =   5415
      End
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "If you have any suggestions on how to make AOHell better, I'd like to hear them.  I'm especially interested in suggestions for the Warez Bot.  If you have a question, there is a chance I will answer it.  But if I do, it'll be at least 1-3 weeks after you've sent it, so make sure you use an account that won't be dead by the time I reply."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1215
      Left            =   360
      TabIndex        =   5
      Top             =   120
      Width           =   5655
      WordWrap        =   -1  'True
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub CenterForm (f As Form)
f.Left = (Screen.Width - f.Width) / 2
f.Top = (Screen.Height - f.Height) / 2
End Sub

Sub Command3D1_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
If Text1.Text = "" Then
MsgBox "Please enter your suggestion or question before you send"
Exit Sub
End If
GoTo SugBeg

SugErr:
 MsgBox "An error has occured while trying to send.", 48, "Suggestion Send Error"
 Exit Sub

SugBeg:
On Error GoTo SugErr
      ret = Chr$(13) + Chr$(10)

AppActivate "America  Online"
DoEvents
SendKeys "%MC"
DoEvents
Call Pause(1)

     thiswin% = FindWindow(0, "America  Online")
     ComposeHand = FindChildByTitle(thiswin%, "Compose")
     SendButton = VBEnumChildWindows(ComposeHand, 2)
     ToField = VBEnumChildWindows(ComposeHand, 10)
     SubField = VBEnumChildWindows(ComposeHand, 14)
     MsgField = VBEnumChildWindows(ComposeHand, 17)
     VBMsg1.SubClasshWnd = SendButton

lint = 8000

lpstring = "password@anon.penet.fi"
ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)
 DoEvents
lpstring = "Password"
SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring)
 DoEvents
lpstring = "aohell"
MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring)
 DoEvents
 DoEvents
Call Pause(1)
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP
Snap = FindWindow(0, "America Online")
While Snap = 0
DoEvents
Snap = FindWindow(0, "America Online")
DoEvents
Wend
SendKeys "{ENTER}"
DoEvents
Call Pause(1)

DoEvents
SendKeys "%MC"
DoEvents
Call Pause(1)

     thiswin% = FindWindow(0, "America  Online")
     ComposeHand = FindChildByTitle(thiswin%, "Compose")
     SendButton = VBEnumChildWindows(ComposeHand, 2)
     ToField = VBEnumChildWindows(ComposeHand, 10)
     SubField = VBEnumChildWindows(ComposeHand, 14)
     MsgField = VBEnumChildWindows(ComposeHand, 17)
     VBMsg1.SubClasshWnd = SendButton

lpstring = "anon@anon.penet.fi"
ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)
 DoEvents
If Option1.Value = True Then
lpstring = "Suggestion"
Else
lpstring = "Question"
End If
SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring)
 DoEvents
lpstring = "X-Anon-Password: aohell" + ret + "X-Anon-To: an211669" + ret + ret + "Screen Name:    " + ScreenName + ret + ret + Text1.Text + ret + ret + "             *** 95-b5 " + cryptname + "***"

MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring)
 DoEvents
Call Pause(1)
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP


DoEvents
 Unload Me

End Sub

Sub Command3D2_Click ()
Unload Me

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(suggestion.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(suggestion.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

