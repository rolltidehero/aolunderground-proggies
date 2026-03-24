VERSION 2.00
Begin Form ListStatus 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Mass Mail List Status"
   ClientHeight    =   2250
   ClientLeft      =   2355
   ClientTop       =   900
   ClientWidth     =   4395
   ControlBox      =   0   'False
   Height          =   2655
   Icon            =   LISTSTAT.FRX:0000
   Left            =   2295
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2250
   ScaleWidth      =   4395
   Top             =   555
   Width           =   4515
   Begin VBMsg VBMsg4 
      Height          =   420
      Left            =   4320
      MessageCount    =   LISTSTAT.FRX:0302
      MessageList     =   LISTSTAT.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   1440
      Width           =   420
   End
   Begin SSCommand Command3D5 
      BevelWidth      =   3
      Caption         =   "Start MM Now!"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2280
      TabIndex        =   1
      Top             =   1440
      Width           =   1575
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "Adjust Time"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   3120
      TabIndex        =   8
      Top             =   360
      Width           =   1215
   End
   Begin Timer Timer4 
      Interval        =   60000
      Left            =   4320
      Top             =   1680
   End
   Begin Timer Timer3 
      Interval        =   60000
      Left            =   4320
      Top             =   1920
   End
   Begin Timer Timer2 
      Interval        =   100
      Left            =   4080
      Top             =   2280
   End
   Begin VBMsg VBMsg3 
      Height          =   420
      Left            =   3240
      MessageCount    =   LISTSTAT.FRX:0502
      MessageList     =   LISTSTAT.FRX:0504
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2280
      Width           =   420
   End
   Begin VBMsg VBMsg2 
      Height          =   420
      Left            =   2760
      MessageCount    =   LISTSTAT.FRX:0702
      MessageList     =   LISTSTAT.FRX:0704
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2280
      Width           =   420
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   2280
      MessageCount    =   LISTSTAT.FRX:0902
      MessageList     =   LISTSTAT.FRX:0904
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2280
      Width           =   420
   End
   Begin Timer Timer1 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   3600
      Top             =   2280
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "Add Person"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1800
      TabIndex        =   4
      Top             =   360
      Width           =   1215
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "Cancel MM"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   3120
      TabIndex        =   6
      Top             =   840
      Width           =   1215
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "Rem. Person"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1800
      TabIndex        =   5
      Top             =   840
      Width           =   1215
   End
   Begin ListBox List1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1950
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1455
   End
   Begin Label Label4 
      BackColor       =   &H8000000F&
      Caption         =   "mins."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   3720
      TabIndex        =   7
      Top             =   1920
      Width           =   615
   End
   Begin Label Label3 
      BackColor       =   &H8000000F&
      Caption         =   "0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   10.5
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3480
      TabIndex        =   3
      Top             =   1920
      Width           =   255
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      Caption         =   "Time remaining:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   2040
      TabIndex        =   2
      Top             =   1920
      Width           =   1455
   End
End
  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

  Sub Command3D1_Click ()
    GoTo begin4

titfuck4:
    Exit Sub

begin4:
    On Error GoTo titfuck4

    List1.RemoveItem List1.ListIndex

  End Sub

  Sub Command3D2_Click ()
    Response = MsgBox("Are you sure you want cancel the Mass Mail?", 292, "Cancel Mass Mail")
  'Possible Response values: 6--YES, 7--NO.
    If Response = 6 Then
      main.Timer1.Enabled = True
      main.Timer2.Enabled = True

      Unload WarezBot
      Unload Me
    End If

    If Response = 7 Then Exit Sub

  End Sub

  Sub Command3D3_Click ()
    Word2 = InputBox$("Enter screen name", "Add Name to List")
    List1.AddItem Word2

  End Sub

  Sub Command3D4_Click ()
    GoTo NewT

NErr:
    MsgBox "You must enter a number!  Keeping old Time Limit..."
    Exit Sub

NewT:
    On Error GoTo NErr

    NewTime = InputBox$("Enter the new Time Limit (in minutes).", "Adjust Time Limit")

    If NewTime = "" Then Exit Sub

    TimeLimit = NewTime
  Label3.Caption = TimeLimit

  End Sub

  Sub Command3D5_Click ()
    If DoMM = 2 Then

      Numppl = List1.ListCount

      List1.ListIndex = 0

      For x = 1 To Numppl

      'List1.ListIndex = List1.ListIndex + 1

        jacko1 = List1.List(List1.ListIndex)
        MMList = MMList + jacko1 + ", "
        On Error GoTo fab1
        GoTo lars1

fab1:
        Resume fa1

lars1:


        List1.ListIndex = List1.ListIndex + 1
fa1:

        MMCt = Len(MMList)
        MMCt1 = MMCt - 2

      Next x

      MMList = Mid$(MMList, 1, MMCt1)
      Clipboard.SetText MMList

      MsgBox "The people on your Mass Mail list has been copied to the clipboard.  To mass mail these people, just paste (CTRL+V) into the ""To:"" box on your mass mailer."
      Unload Me
    End If

    If DoMM = 1 Then

      Numppl = List1.ListCount

      GoTo ber1

berr1:
      main.Timer1.Enabled = True
      main.Timer2.Enabled = True
      main.Timer3.Enabled = True

      Exit Sub

ber1:
      On Error GoTo berr1

      List1.ListIndex = 0

      For x = 1 To Numppl

      'List1.ListIndex = List1.ListIndex + 1

        jacko1 = List1.List(List1.ListIndex)
        MMList = MMList + jacko1 + ", "
        On Error GoTo fab3
        GoTo lars3

fab3:
        Resume fa3

lars3:


        List1.ListIndex = List1.ListIndex + 1
fa3:

        MMCt = Len(MMList)
        MMCt1 = MMCt - 2

      Next x

      MMList = Mid$(MMList, 1, MMCt1)


      WNote.Show
      ListStatus.Hide
      DoEvents
      Call Pause(10)
      DoEvents
      Unload WNote
      DoEvents
      MM2.Show
      MM2.Text3.Text = NWarez
      MM2.Text1.Text = MMList
      If MMComment = "" Then
      MM2.Text2.Text = "-==AOHell==- Free Mass Mail courtesy of " + ScreenName
      Else MM2.Text2.Text = MMComment
      End If

      DoEvents
      Call Pause(1)
      SendKeys "%S "

      Unload Me
    End If


  End Sub

  Sub Form_Load ()
    If AIStatus = 1 Then
      MsgBox "The AI Bot is still active.  You cannot use the Warez Bot with the AI Bot still running.  Please bring up the AI Bot window and choose ""Unload AI Bot"", then try again.", 16, "AI Bot Still Active"
      Unload Me
      Exit Sub
    End If
    If AIStatus = 11 Then
      MsgBox "The Multi-Task Chat Room is still active.  You cannot use the Warez Bot with the Multi-Task Chat Room still running.  Please close the MT Chat Room and try again.", 16, "MT Chat Room Still Active"
      Unload Me
      Exit Sub
    End If


    GoTo listbeg

errlist:
    MsgBox "An error has occured while trying to start the bot.  Please close that Chat Room window, then re-enter the room you are in.  You may then try again.    NOTE: If you have the AI Bot or Multi-Task Chat Room running, it will cause this error.", 48, "Can't Get Window Lock"
    Unload Me
    Exit Sub

listbeg:
    On Error GoTo errlist


    AIStatus = 12


    main.Timer1.Enabled = False
    main.Timer2.Enabled = False

    Dim Success As Integer

    Success% = SetWindowPos%(ListStatus.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
    GoTo AIBeg

AIErr:
    MsgBox "An error has occured while trying to start the bot.  Please close that Chat Room window, then re-enter the room you are in.  You may then try again.", 48, "Can't Get Window Lock"
    Unload Me
    Exit Sub


AIBeg:
    On Error GoTo AIErr

    Label3.Caption = TimeLimit

  'MsgBox "AOHell needs to get a lock on the chat room window now.  Please click the chat room with the mouse, so it is the top AOL window.  Then hit the OK button to this message.", 64, "Chat Window Lock"
    bac = Chr$(13)
    jojo4 = "List" + bac + "Rooms"
    thiswin% = FindWindow(0, "America  Online")
    RoomIcon = FindChildByTitle(thiswin%, jojo4)
    DaRoom = GetParent(RoomIcon)
    If DaRoom = 0 Then
      MsgBox "You must be in a room before you can use this!", 16, "Not In a Room"
      Unload Me
      Exit Sub
    End If

  'thiswin% = FindWindow(0, "America  Online")

    find% = FindChildByClass(DaRoom, "_AOL_View")
    find1% = FindChildByClass(DaRoom, "_AOL_Edit")
    find2% = FindChildByTitle(DaRoom, "Send")


    AOLViewHandle = find%
    AOLSendHandle = find2%
    AOLEditHandle = find1%


    VBMsg2.SubClasshWnd = find1%
    VBMsg1.SubClasshWnd = find2%
    VBMsg4.SubClasshWnd = find%

  End Sub

  Sub Form_Unload (Cancel As Integer)
    main.Timer1.Enabled = True
    main.Timer2.Enabled = True
    VBMsg1.SubClasshWnd = 0
    VBMsg2.SubClasshWnd = 0
    VBMsg3.SubClasshWnd = 0
    If AIStatus = 12 Then AIStatus = 0

  End Sub

  Sub Timer2_Timer ()
   If DidGo1 = 1 Then GoTo Beg1


Err1:
    Exit Sub


Beg1:
    On Error GoTo Err1
   DidGo1 = 0

    thiswin% = FindWindow(0, "America  Online")


    Destroy1 = FindChildByClass(thiswin%, "_AOL_Listbox")
   DoEvents

    If Destroy1 = 0 Then
      MsgBox "AOHell has detected that the AOL chat window has been closed.  ..Stopping MM List", 64, "Room Closed"
      Destroyed = 0
      Unload ListStatus
      Exit Sub
    End If
    chat6 = ChatLine

    colon = ":"

    l% = InStr(1, chat6, colon)
    If l% > 0 Then

      l% = l% - 1
    Else l% = 1
    End If

    SN = Mid$(chat6, 1, l%)
  ' text2.Text = SN
    ChatName = SN
    ChatNameSp = SN

      DoEvents


    ChatLine = UCase$(ChatLine)
    TriggerWord = UCase$(TriggerWord)
    DidTrigger = InStr(1, ChatLine, TriggerWord)
    DidOwn = InStr(1, ChatNameSp, ScreenName)
    DidHostSay = InStr(1, ChatNameSp, "OnlineHost")
    DoEvents
    If DidOwn > 0 Or DidHostSay > 0 Then Exit Sub
    If ChatNameSp = LastPr Then Exit Sub

    If DidTrigger > 0 And DidTrigger < 104 Then
      List1.AddItem ChatNameSp
      LastPr = ChatNameSp
    End If
    DoEvents
    

  End Sub

  Sub Timer3_Timer ()

    TimeLimit = TimeLimit - 1

    Label3.Caption = TimeLimit

    If TimeLimit = 0 Then

      If DoMM = 2 Then

        Numppl = List1.ListCount
     DoEvents
     List1.ListIndex = 0

        For x = 1 To Numppl

        'List1.ListIndex = List1.ListIndex + 1

          jacko1 = List1.List(List1.ListIndex)
          MMList = MMList + jacko1 + ", "
          On Error GoTo fab
          GoTo lars

fab:
          Resume fa

lars:

       DoEvents

          List1.ListIndex = List1.ListIndex + 1
fa:

          MMCt = Len(MMList)
          MMCt1 = MMCt - 2

        Next x

        MMList = Mid$(MMList, 1, MMCt1)
        Clipboard.SetText MMList
        DoEvents

        MsgBox "Timer expired.  The people on your Mass Mail list have been copied to the clipboard.  To mass mail these people, just paste (CTRL+V) into the ""To:"" box on your mass mailer."
        Unload Me

      End If




      If DoMM = 1 Then

        Numppl = List1.ListCount

        GoTo ber

berr:
        Exit Sub

ber:
        On Error GoTo berr

        List1.ListIndex = 0

        For x = 1 To Numppl

        'List1.ListIndex = List1.ListIndex + 1

          jacko1 = List1.List(List1.ListIndex)
          MMList = MMList + jacko1 + ", "
          On Error GoTo fab2
          GoTo lars2

fab2:
          Resume fa2

lars2:


          List1.ListIndex = List1.ListIndex + 1
fa2:

          MMCt = Len(MMList)
          MMCt1 = MMCt - 2

        Next x

        MMList = Mid$(MMList, 1, MMCt1)
         DoEvents
         
        WNote.Show
        ListStatus.Hide
        DoEvents
        Call Pause(10)
        DoEvents
        Unload WNote
        DoEvents
        MM2.Show
        MM2.Text3.Text = NWarez
        MM2.Text1.Text = MMList
        MM2.Text2.Text = "-==AOHell==- Free Mass Mail courtesy of " + ScreenName
        DoEvents
        Call Pause(1)
        SendKeys "%S "

        Unload Me
      End If

    End If

  End Sub

  Sub Timer4_Timer ()
    DoEvents
    If NotifyRoom = 1 Then GoTo LStart
    If NotifyRoom = 2 Then
      NotifyRoom = NotifyRoom - 1
      Exit Sub
    End If
    If NotifyRoom = 3 Then
      NotifyRoom = NotifyRoom - 1
      Exit Sub
    End If
    If NotifyRoom = 4 Then
      NotifyRoom = NotifyRoom - 1
      Exit Sub
    End If
    If NotifyRoom = 5 Then
      NotifyRoom = NotifyRoom - 1
      Exit Sub
    End If
    DoEvents
    
LStart:

    lint = 1000
    If Label3.Caption = "1" Then Min1 = " minute." Else Min1 = " minutes."

    lpstring = "-==AOHell==- Mass Mail going out in " + Label3.Caption + Min1 + "  Type " + TriggerWordSp + " to get on MM list."
    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP
    NotifyRoom = NotifyRoom2
    DoEvents
    
  End Sub

  Sub VBMsg4_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    ChatLine = ptGetStringFromAddress(lParam, 106)
    ChatLine = Trim$(ChatLine)
    ChatLine = Mid$(ChatLine, 3)
    DidGo1 = 1

  End Sub

