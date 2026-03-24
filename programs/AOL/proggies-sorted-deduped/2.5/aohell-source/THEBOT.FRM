VERSION 2.00
Begin Form AOLBOT 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "AOHell v3.0 Scrolling Bot"
   ClientHeight    =   5910
   ClientLeft      =   1560
   ClientTop       =   840
   ClientWidth     =   5355
   ForeColor       =   &H00808080&
   Height          =   6600
   Icon            =   THEBOT.FRX:0000
   Left            =   1500
   LinkTopic       =   "Form6"
   MaxButton       =   0   'False
   ScaleHeight     =   5910
   ScaleWidth      =   5355
   Top             =   210
   Width           =   5475
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   4560
      MessageCount    =   THEBOT.FRX:0302
      MessageList     =   THEBOT.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   5400
      Width           =   420
   End
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   2400
      Parameter       =   ""
      Top             =   5400
      Value           =   ""
      Width           =   420
   End
   Begin CommonDialog CMDialog1 
      Filter          =   "AOHell Bot Files (*BOT)|*.BOT"
      Left            =   120
      Top             =   5280
   End
   Begin TextBox Text5 
      Height          =   285
      Left            =   4200
      TabIndex        =   6
      Text            =   "2"
      Top             =   2760
      Width           =   495
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "&Start"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   960
      TabIndex        =   7
      Top             =   5400
      Width           =   1215
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&Warning"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6000
      TabIndex        =   18
      Top             =   3480
      Visible         =   0   'False
      Width           =   1095
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
      Height          =   375
      Left            =   3120
      TabIndex        =   8
      Top             =   5400
      Width           =   1215
   End
   Begin CommandButton Command1 
      Caption         =   "&Warning"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   7320
      TabIndex        =   19
      Top             =   2880
      Visible         =   0   'False
      Width           =   1575
   End
   Begin TextBox Text6 
      Height          =   285
      Left            =   480
      TabIndex        =   5
      Text            =   " "
      Top             =   2160
      Width           =   4575
   End
   Begin TextBox Text4 
      Height          =   285
      Left            =   480
      TabIndex        =   4
      Text            =   " "
      Top             =   1680
      Width           =   4575
   End
   Begin TextBox Text3 
      Height          =   285
      Left            =   480
      TabIndex        =   3
      Text            =   " "
      Top             =   1200
      Width           =   4575
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   480
      TabIndex        =   2
      Text            =   " "
      Top             =   720
      Width           =   4575
   End
   Begin TextBox Text1 
      Height          =   285
      Left            =   480
      TabIndex        =   0
      Text            =   " "
      Top             =   240
      Width           =   4575
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Re-Enter Room Options"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1935
      Left            =   240
      TabIndex        =   20
      Top             =   3240
      Width           =   4935
      Begin TextBox Text8 
         Height          =   285
         Left            =   4200
         TabIndex        =   10
         Top             =   960
         Width           =   495
      End
      Begin SSCommand Command3D1 
         BevelWidth      =   3
         Caption         =   "&Help!"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   375
         HelpContextID   =   18
         Left            =   4200
         TabIndex        =   26
         Top             =   360
         Width           =   615
      End
      Begin SSCheck Check3d1 
         Caption         =   "&Enable the Re-Enter room option"
         Height          =   255
         Left            =   1080
         TabIndex        =   24
         Top             =   1560
         Width           =   3255
      End
      Begin SSOption Option3d1 
         Caption         =   "&Member Room"
         Height          =   255
         Left            =   360
         TabIndex        =   23
         Top             =   1200
         Value           =   -1  'True
         Width           =   2175
      End
      Begin SSOption Option3d2 
         Caption         =   "&Private Room"
         Height          =   255
         Left            =   360
         TabIndex        =   22
         TabStop         =   0   'False
         Top             =   840
         Width           =   1575
      End
      Begin TextBox Text7 
         Height          =   285
         Left            =   1680
         TabIndex        =   9
         Top             =   360
         Width           =   2055
      End
      Begin Label Label11 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Seconds to wait before Re-Entering room:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   375
         Left            =   2280
         TabIndex        =   25
         Top             =   840
         Width           =   1815
         WordWrap        =   -1  'True
      End
      Begin Label Label10 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Name of room:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   240
         TabIndex        =   21
         Top             =   360
         Width           =   1335
      End
   End
   Begin CommandButton Command3 
      Caption         =   "&Cancel"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6000
      TabIndex        =   14
      Top             =   1080
      Visible         =   0   'False
      Width           =   1575
   End
   Begin HScrollBar HScroll1 
      Height          =   255
      Left            =   7200
      Max             =   100
      Min             =   1
      TabIndex        =   11
      Top             =   3240
      Value           =   1
      Visible         =   0   'False
      Width           =   975
   End
   Begin CommandButton Command2 
      Caption         =   "&Start"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6120
      TabIndex        =   1
      Top             =   2040
      Visible         =   0   'False
      Width           =   1455
   End
   Begin Timer Timer1 
      Left            =   6000
      Top             =   2760
   End
   Begin Label Label14 
      BackColor       =   &H00C0C0C0&
      Caption         =   "5."
      Height          =   255
      Left            =   240
      TabIndex        =   12
      Top             =   2160
      Width           =   255
   End
   Begin Label Label13 
      BackColor       =   &H00C0C0C0&
      Caption         =   "4."
      Height          =   255
      Left            =   240
      TabIndex        =   13
      Top             =   1680
      Width           =   255
   End
   Begin Label Label12 
      BackColor       =   &H00C0C0C0&
      Caption         =   "3."
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   1200
      Width           =   255
   End
   Begin Label Label6 
      BackColor       =   &H00C0C0C0&
      Caption         =   "2."
      Height          =   255
      Left            =   240
      TabIndex        =   16
      Top             =   720
      Width           =   255
   End
   Begin Label Label5 
      BackColor       =   &H00C0C0C0&
      Caption         =   "1."
      Height          =   255
      Left            =   240
      TabIndex        =   27
      Top             =   240
      Width           =   255
   End
   Begin Label Label2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Number of seconds to pause between each line:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   17
      Top             =   2760
      Width           =   3855
   End
   Begin Menu MnuFile 
      Caption         =   "File"
      Begin Menu mnuopen 
         Caption         =   "Open"
      End
      Begin Menu MnuSaveAs 
         Caption         =   "Save As"
      End
      Begin Menu mnudsfkjl 
         Caption         =   "-"
      End
      Begin Menu mnuexitbot 
         Caption         =   "Exit Bot"
      End
   End
End
Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2


Dim sTARTIT
 Dim junky
 Dim formloading As Integer
Dim Public

Sub Check1_Click ()
ReEnter = 1000
End Sub

Sub Check3D1_Click (Value As Integer)
ReEnter = 1000

End Sub

Sub Command1_Click ()
MsgBox "Do NOT hit the backspace key in the ""Seconds to wait before Re-Entering the room:"" box.  If you do, you will get a Type Mismatch error."

End Sub

Sub Command2_Click ()
If check3d1.Value = True And Text8.Text = "" Then
MsgBox "Please enter in the amount of seconds to pause before reentering the room."
Exit Sub
End If
GoTo begin3

titfuck3:
Exit Sub

begin3:
On Error GoTo titfuck3

 Tex1 = Text1
 TEX2 = Text2
 TEX3 = Text3
 TEX4 = Text4
 TEX6 = Text6
 Fuckthat = Text5


'Randomizing shit
 ROD = 0

If Text8 <> "" Then
Roomenter = Text8
End If

If Text1 <> "" Then
ROD = ROD + 1
End If

If Text2 <> "" Then
ROD = ROD + 1
End If

If Text3 <> "" Then
ROD = ROD + 1
End If

If Text4 <> "" Then
ROD = ROD + 1
End If

If Text6 <> "" Then
ROD = ROD + 1
End If
'end of randomizing shit


'Start of error checking
If Text5 = "" Then
MsgBox "Please enter the amount of seconds you wish to pause the bot for."
Exit Sub
End If
'If Text7 <> "" Or Text8 <> "" And ReEnter < 90 Then
'MsgBox "You must check the Re-Enter box to use the Re-Enter feature."
'Exit Sub
'End If

If option3d1.Value = False And option3d2.Value = False And ReEnter = 1000 Then
MsgBox "You must say whether your room is public or private"
Exit Sub
End If



NotQuitit = 1


sTARTIT = 100
AOLBOT.Hide
status.Timer1.Enabled = True
status.Show



'If check3d1.Value = True Then
'Response = MsgBox("Look at the Member Room list on AOL (wait for cursor to come back), is the more button enabled?", 36, "More button?")
'Possible Response values: 6--YES, 7--NO.
'If Response = 6 Then
'morebutton = 1
MsgBox "You should turn off your IMs by sending an IM to ""$im_off"".  Then close all Windows on AOL except for the chat room window. (before you hit the OK button to this message)"

'ElseIf Response = 7 Then
'morebutton = 0
'MsgBox "OK.  Now you should turn off your IMs by sending an IM to ""$im_off"".  Then close all Windows on AOL except for the chat room window. (before you hit the OK button to this message)"

 'End If
'End If




End Sub

Sub Command3_Click ()
NotQuitit = 1001
Unload Me



End Sub

Sub Command3D1_Click ()
SendKeys "{F1}"
DoEvents

End Sub

Sub Command3D2_Click ()
Call Command3_Click

End Sub

Sub Command3D3_Click ()
Call Command1_Click

End Sub

Sub Command3D4_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If



THEROOM = Text7
 If option3d1.Value = True Then Public = 100
 If option3d2.Value = True Then Public = 100
  If check3d1.Value = True Then ReEnter = 1000
Call Command2_Click
End Sub

Sub Command4_Click ()

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(AOLBOT.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

GoTo begin4

titfuck4:
MsgBox "The default bot file was not in the specified PATH.  Hit the options button on the Main menu and enter the correct PATH."
Exit Sub

begin4:
On Error GoTo titfuck4


a11 = "w"
b11 = "a"
c11 = "r"
d11 = "g"
e11 = "a"
f11 = "m"
g11 = "e"
h11 = "z"
i11 = "1"
Rem Formloading = true
Rem Call MnuOPen_click

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "DefBot"
Dab = init1.Value

formloading = False

If Dab = "yes" Then

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "BotSet"
Dab1 = init1.Value

Open Dab1 For Input As #1
 Input #1, phr1, phr2, phr3, phr4, phr5, secon, roomm, roomsec, privat, membe, renter1
 Text1.Text = phr1
 Text2.Text = phr2
 Text3.Text = phr3
 Text4.Text = phr4
 Text6.Text = phr5
 Text5.Text = secon
 Text7.Text = roomm
 If privat = "True" Then
    option3d2.Value = True
 Else
    option3d2.Value = False
 End If
    If membe = "True" Then
        option3d1.Value = True
    Else
        option3d1.Value = False
    End If

 If renter1 = "True" Then
        check3d1.Value = True
 Else
        check3d1.Value = False
 End If

 Text8.Text = roomsec
 Close #1

Else Text8.Enabled = True

End If

End Sub

Sub Form_Paint ()

Text1.SetFocus

End Sub

Sub HScroll1_Change ()
Text5 = hSCROLL1

End Sub

Sub mnuexitbot_Click ()
Unload Me

End Sub

Sub mnuopen_Click ()
GoTo begin1

titfuck1:
Exit Sub

begin1:
 On Error GoTo titfuck1

cmdialog1.Filename = "*.Bot"
If formloading = False Then
cmdialog1.Action = 1
xx$ = cmdialog1.Filename
Else
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "BotSet"
DoEvents
xx$ = init1.Value
End If
Open xx$ For Input As #1
 Input #1, phr1, phr2, phr3, phr4, phr5, secon, roomm, roomsec, privat, membe, renter1
 Text1.Text = phr1
 Text2.Text = phr2
 Text3.Text = phr3
 Text4.Text = phr4
 Text6.Text = phr5
 Text5.Text = secon
 Text7.Text = roomm
 If privat = "True" Then
    option3d2.Value = True
 Else
    option3d2.Value = False
 End If
    If membe = "True" Then
        option3d1.Value = True
    Else
        option3d1.Value = False
      End If

 If renter1 = "True" Then
        check3d1.Value = True
 Else
        check3d1.Value = False
 End If

 Text8.Text = roomsec
 Close #1


      
End Sub

Sub MnuSaveAs_Click ()
 GoTo begin2

titfuck2:
Exit Sub

begin2:
 On Error GoTo titfuck2

 If option3d1.Value = True Then
 valopt1 = "True"
 Else
 valopt1 = "False"
 End If
 If option3d2.Value = True Then
 valopt2 = "True"
 Else
 valopt2 = "False"
 End If
 If check3d1.Value = True Then
 valcheck1 = "True"
 Else
 valcheck1 = "False"
 End If

 cmdialog1.Action = 2
 Open cmdialog1.Filename For Output As #1
 Write #1, Text1.Text, Text2.Text, Text3.Text, Text4.Text, Text6.Text, Text5.Text, Text7.Text, Text8.Text, valopt2, valopt1, valcheck1
 Close #1

End Sub

Sub Option1_Click ()
Public = 100

End Sub

Sub Option2_Click ()
PrivRoom = 100


End Sub

Sub Option3_Click ()
ReEnter = 1000

End Sub

Sub Text10_Change ()
Roomenter = Text8

End Sub

Sub Text4_Change ()
'Tex4 = text4

End Sub

Sub Text5_Change ()
'hSCROLL1 = Text5


End Sub

Sub Text9_Change ()
THEROOM = Text7

End Sub

Sub Timer1_Timer ()
'status.Show

'Rod = 0
'If NotQuitit < 20 Then


'If sTARTIT = 100 Then
'Randomize
'If Text1 <> "" Then
'Rod = Rod + 1
'End If

''If Text2 <> "" Then
'Rod = Rod + 1
'End If

'If Text3 <> "" Then
'Rod = Rod + 1
'End If

'If text4 <> "" Then
'Rod = Rod + 1
'End If
'
'If Text6 <> "" Then
'Rod = Rod + 1
'End If
'
'
'
'junks = Rnd * Rod
'AppActivate "America  Online"
'
'
'If junks > 1 And junks < 2 Then
'fuckit = 2
'SendKeys Text2 + "{ENTER}"
'
'End If
'If junks < 1 Then
'fuckit = 1
'
'SendKeys Text1 + "{ENTER}"
'
'End If
'If junks > 2 And junks < 3 Then
'fuckit = 3
'
'SendKeys Text3 + "{ENTER}"
'End If
'If junks > 3 Then
'fuckit = 4
'
'SendKeys text4 + "{ENTER}"
 '
'End If
'If junks > 4 Then
'SendKeys Text6 + "{Enter}"
'fuckit = 5
'End If
'
'End If
'Else
'
'status.Hide
'
'MsgBox " Thank You For Using The AOL-BOT By The Rizzer/Chr" + Chr$(13) + "Look For more Features SOON!"
'End
'
'End If
'





End Sub

