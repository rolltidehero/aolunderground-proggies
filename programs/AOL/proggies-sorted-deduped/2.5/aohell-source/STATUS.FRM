VERSION 2.00
Begin Form Status 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Bot Status"
   ClientHeight    =   3540
   ClientLeft      =   2745
   ClientTop       =   1935
   ClientWidth     =   3525
   FontBold        =   -1  'True
   FontItalic      =   0   'False
   FontName        =   "MS Sans Serif"
   FontSize        =   16.5
   FontStrikethru  =   0   'False
   FontUnderline   =   0   'False
   Height          =   3945
   Icon            =   STATUS.FRX:0000
   Left            =   2685
   LinkTopic       =   "Form1"
   ScaleHeight     =   3540
   ScaleWidth      =   3525
   Top             =   1590
   Width           =   3645
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   240
      MessageCount    =   STATUS.FRX:0302
      MessageList     =   STATUS.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2760
      Width           =   420
   End
   Begin SSCheck Check3D1 
      Caption         =   "&Click to Pause"
      Height          =   255
      Left            =   1080
      TabIndex        =   8
      Top             =   2760
      Width           =   2175
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Quit"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   120
      TabIndex        =   7
      Top             =   3120
      Width           =   1455
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Continue Later"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1680
      TabIndex        =   6
      Top             =   3120
      Width           =   1695
   End
   Begin Timer Timer2 
      Left            =   1200
      Top             =   0
   End
   Begin Timer Timer1 
      Interval        =   1000
      Left            =   720
      Top             =   0
   End
   Begin Label Label6 
      BackColor       =   &H00C0C0C0&
      Caption         =   "0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   29.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   735
      Left            =   2520
      TabIndex        =   5
      Top             =   1920
      Width           =   975
   End
   Begin Label Label5 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Seconds Until you automatically Re-enter the room"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   735
      Left            =   120
      TabIndex        =   4
      Top             =   1920
      Width           =   2175
   End
   Begin Label Label4 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Line Number of the Phrase that was last said"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   735
      Left            =   120
      TabIndex        =   3
      Top             =   1080
      Width           =   2175
   End
   Begin Label Label3 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Seconds until the next phrase will be said"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   735
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   2175
   End
   Begin Label Label2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   29.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   735
      Left            =   2520
      TabIndex        =   1
      Top             =   1080
      Width           =   975
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   29.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   735
      Left            =   2520
      TabIndex        =   0
      Top             =   240
      Width           =   975
   End
End
Dim junk
Dim Shitt

Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal x%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Check3D1_Click (Value As Integer)
If Check3d1.Value = True Then
timer1.Enabled = False
Check3d1.Caption = "Click to UnPause"
End If
If Check3d1.Value = False Then
timer1.Enabled = True
Check3d1.Caption = "Click to Pause"
End If

End Sub

Sub Command3D1_Click ()
NotQuitit = 1002
aolbot.Show


timer1.Enabled = False


Unload Me

aolbot.Show


End Sub

Sub Command3D2_Click ()
NotQuitit = 1002
aolbot.Hide
rod = 0

timer1.Enabled = False


Unload Me

Unload aolbot

'aohell.Show

End Sub

Sub Form_Load ()
Dim Success As Integer

junk = Roomenter
Label6.Caption = Roomenter
Shitt = FUCKTHAT


Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2


Success% = SetWindowPos%(status.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

'crapola = 1
'junky = Fuckthat

'Label1.Caption = Fuckthat

'fuckyou = Timer

'While NotQuitit < 20
    'DoEvents

    'Fuckyou2 = Timer
    'If Fuckyou2 - fuckyou > crapola Then
	'DoEvents
       ' crapola = crapola + 1
	
	'junky = junky - 1
	'Label1.Caption = junky
	'DoEvents
	'If junky = 0 Then
	    'junky = Fuckthat
	'End If
   'End If

   'DoEvents
    label2.Caption = fuckit
    DoEvents
    'Wend




End Sub

Sub Timer1_Timer ()
GoTo BotBeg

BotErr:
MsgBox "An error has occured with the bot.  You can only use the bot if you're in a Member room, or private room."
Exit Sub


BotBeg:
On Error GoTo BotErr

If NotQuitit = 1002 Then
Exit Sub
End If
If REENTER <> 1000 Then
Label6.Caption = "N/A"
GoTo NoTROoM

End If

junk = junk - 1
Label6.Caption = junk


If junk = 0 Then
AppActivate "America  Online"
       thiswin% = FindWindow(0, "America  Online")
       ChatHand = FindChildByClass(thiswin%, "MDIClient")
       RoomButton = VBEnumChildWindows(ChatHand, 3)
VBMsg1.SubClasshWnd = RoomButton
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP

'SendKeys "{tab}"
'SendKeys "{tab}"
'SendKeys " "
shitnat:
    DoEvents
    Call Pause(2)
    SendKeys "{ESC}"
    SendKeys "{ESC}"
    SendKeys "{ESC}"
    DoEvents
    For g1 = 1 To 6
    DoEvents
    Call Pause(1)
    DoEvents
    Next g1


If aolbot.Option3d2.Value = True Then GoTo dodo
If aolbot.Option3d1.Value = True Then GoTo popo

dodo:
' If morebutton = 1 Then SendKeys "{TAB 6}"
' If morebutton = 0 Then SendKeys "{TAB 5}"
    thiswin% = FindWindow(0, "America  Online")
    MemberHand = FindChildByTitle(thiswin%, "Member Rooms")
    MemberButton = FindChildByTitle(MemberHand, "Private Room")
    While MemberButton = 0
    DoEvents
    MemberButton = FindChildByTitle(MemberHand, "Private Room")
    Wend

    VBMsg1.SubClasshWnd = MemberButton
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP

DoEvents

Call Pause(3)

SendKeys THERooM
SendKeys "{ENTER}"
Call Pause(3)
GoTo contin

popo:
 'If morebutton = 1 Then SendKeys "{TAB 5}"
 'If morebutton = 0 Then SendKeys "{TAB 4}"
    thiswin% = FindWindow(0, "America  Online")
    MemberHand = FindChildByTitle(thiswin%, "Member Rooms")
    MemberButton = FindChildByTitle(MemberHand, "Create Room")
    While MemberButton = 0
    DoEvents
    MemberButton = FindChildByTitle(MemberHand, "Create Room")
    Wend

    VBMsg1.SubClasshWnd = MemberButton
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP

DoEvents
Call Pause(3)
DoEvents
SendKeys THERooM
SendKeys "{ENTER}"
Call Pause(3)

contin:

junk = Roomenter
End If

'Sending the Text
NoTROoM:

Shitt = Shitt - 1
Label1.Caption = Shitt



If Shitt = 0 Then
Shitt = FUCKTHAT

If NotQuitit < 20 Then



'Randomizing shit
Randomize
Junks = Rnd * rod
'End of Randomizing
AppActivate "America  Online"
'SendKeys "%{TAB}"


If Junks > 1 And Junks < 2 Then

thiswin% = FindWindow(0, "America  Online")
EditBox = FindChildByClass(thiswin%, "_AOL_Edit")
lint = 1000
lpstring = Tex2
Sendlp = SendMessageByString(EditBox, WM_SETTEXT, lint, lpstring) ',lint
DoEvents
SendButton3 = FindChildByTitle(thiswin%, "Send")
VBMsg1.SubClasshWnd = SendButton3
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP
DoEvents
fuckit = 2

End If

If Junks < 1 Then
thiswin% = FindWindow(0, "America  Online")
EditBox = FindChildByClass(thiswin%, "_AOL_Edit")
lint = 1000
lpstring = Tex1
Sendlp = SendMessageByString(EditBox, WM_SETTEXT, lint, lpstring) ',lint
DoEvents
SendButton3 = FindChildByTitle(thiswin%, "Send")
VBMsg1.SubClasshWnd = SendButton3
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP
DoEvents

fuckit = 1

End If

If Junks > 2 And Junks < 3 Then
thiswin% = FindWindow(0, "America  Online")
EditBox = FindChildByClass(thiswin%, "_AOL_Edit")
lint = 1000
lpstring = Tex3
Sendlp = SendMessageByString(EditBox, WM_SETTEXT, lint, lpstring) ',lint
DoEvents
SendButton3 = FindChildByTitle(thiswin%, "Send")
VBMsg1.SubClasshWnd = SendButton3
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP
DoEvents

fuckit = 3

End If
If Junks > 2.1 And junk < 2.2 Then
DoEvents
DoEvents

End If


If Junks > 3 And Junks < 4 Then
thiswin% = FindWindow(0, "America  Online")
EditBox = FindChildByClass(thiswin%, "_AOL_Edit")
lint = 1000
lpstring = Tex4
Sendlp = SendMessageByString(EditBox, WM_SETTEXT, lint, lpstring) ',lint
DoEvents
SendButton3 = FindChildByTitle(thiswin%, "Send")
VBMsg1.SubClasshWnd = SendButton3
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP
DoEvents

fuckit = 4

End If

If Junks > 4 Then

thiswin% = FindWindow(0, "America  Online")
EditBox = FindChildByClass(thiswin%, "_AOL_Edit")
lint = 1000
lpstring = Tex6
Sendlp = SendMessageByString(EditBox, WM_SETTEXT, lint, lpstring) ',lint
DoEvents
SendButton3 = FindChildByTitle(thiswin%, "Send")
VBMsg1.SubClasshWnd = SendButton3
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP
DoEvents


fuckit = 5

End If

label2.Caption = fuckit

Else
Unload Me

End If

End If 'Shitt

End Sub

