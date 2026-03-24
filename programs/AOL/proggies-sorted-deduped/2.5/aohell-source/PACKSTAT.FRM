VERSION 2.00
Begin Form PackStatus 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Pack Offering Status"
   ClientHeight    =   2775
   ClientLeft      =   1080
   ClientTop       =   585
   ClientWidth     =   7440
   ControlBox      =   0   'False
   Height          =   3180
   Icon            =   PACKSTAT.FRX:0000
   Left            =   1020
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2775
   ScaleWidth      =   7440
   Top             =   240
   Width           =   7560
   Begin VBMsg VBMsg5 
      Height          =   420
      Left            =   7080
      MessageCount    =   PACKSTAT.FRX:0302
      MessageList     =   PACKSTAT.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2400
      Width           =   420
   End
   Begin SSCommand Command3D5 
      BevelWidth      =   1
      Caption         =   "Small"
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   6000
      TabIndex        =   13
      Top             =   2400
      Width           =   855
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "&Ignore Someone"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   3840
      TabIndex        =   12
      Top             =   1920
      Width           =   1575
   End
   Begin VBMsg VBMsg4 
      Height          =   420
      Left            =   7320
      MessageCount    =   PACKSTAT.FRX:0502
      MessageList     =   PACKSTAT.FRX:0504
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2040
      Width           =   420
   End
   Begin VBMsg VBMsg3 
      Height          =   420
      Left            =   7320
      MessageCount    =   PACKSTAT.FRX:0702
      MessageList     =   PACKSTAT.FRX:0704
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2040
      Width           =   420
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "Send &Notice Now"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2040
      TabIndex        =   10
      Top             =   1920
      Width           =   1575
   End
   Begin Timer Timer4 
      Interval        =   60000
      Left            =   840
      Top             =   2640
   End
   Begin Timer Timer3 
      Interval        =   60000
      Left            =   600
      Top             =   2640
   End
   Begin VBMsg VBMsg2 
      Height          =   420
      Left            =   7320
      MessageCount    =   PACKSTAT.FRX:0902
      MessageList     =   PACKSTAT.FRX:0904
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2640
      Width           =   420
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   7320
      MessageCount    =   PACKSTAT.FRX:0B02
      MessageList     =   PACKSTAT.FRX:0B04
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2160
      Width           =   420
   End
   Begin Timer Timer2 
      Interval        =   100
      Left            =   240
      Top             =   2640
   End
   Begin Timer Timer1 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   0
      Top             =   2640
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Cancel Packs"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   5640
      TabIndex        =   9
      Top             =   1920
      Width           =   1575
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Send Packs Now"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   240
      TabIndex        =   8
      Top             =   1920
      Width           =   1575
   End
   Begin ListBox List5 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1230
      Left            =   6000
      TabIndex        =   4
      Top             =   480
      Width           =   1215
   End
   Begin ListBox List4 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1230
      Left            =   4560
      TabIndex        =   3
      Top             =   480
      Width           =   1215
   End
   Begin ListBox List3 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1230
      Left            =   3120
      TabIndex        =   2
      Top             =   480
      Width           =   1215
   End
   Begin ListBox List2 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1230
      Left            =   1680
      TabIndex        =   1
      Top             =   480
      Width           =   1215
   End
   Begin ListBox List1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1230
      Left            =   240
      TabIndex        =   0
      Top             =   480
      Width           =   1215
   End
   Begin Label Label4 
      BackColor       =   &H8000000F&
      Caption         =   "minutes"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   4680
      TabIndex        =   11
      Top             =   2400
      Width           =   735
   End
   Begin Label Label3 
      BackColor       =   &H8000000F&
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   13.5
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   4320
      TabIndex        =   7
      Top             =   2400
      Width           =   495
   End
   Begin Label Label2 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "Requested Packs will be sent in:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   1560
      TabIndex        =   6
      Top             =   2400
      Width           =   2625
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "   Pack 1 List           Pack 2 List           Pack 3 List          Pack 4 List           Pack 5 List"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   120
      Width           =   6975
   End
End
  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

  Sub Command3D1_Click ()
    thiswin% = FindWindow(0, "America  Online")

    If Pk1 = 1 And pk2 = 0 And pk3 = 0 And pk4 = 0 And pk5 = 0 Then
      Num = List1.ListCount
      If Num = 0 Then
        PTime = PTime1
        Label3.Caption = PTime
        Exit Sub
      End If
    End If
    Num1 = List1.ListCount
    Num2 = List2.ListCount
    Num3 = List3.ListCount
    Num4 = List4.ListCount
    Num5 = List5.ListCount
    If Num1 = 0 And Num2 = 0 And Num3 = 0 And Num4 = 0 And Num5 = 0 Then
      PTime = PTime1
      Label3.Caption = PTime
      Exit Sub
    End If

    Unload SmallPack

    PTime = 50
    PackNotify = 50
    main.Timer1.Enabled = False
    main.Timer2.Enabled = False
    main.Timer3.Enabled = False
    Timer1.Enabled = False
    Timer2.Enabled = False

    PackStatus.Hide
    WNote.Show
    WNote.Label1.Caption = "Preparing to send out Requested packs.  Stop anything you are doing now, while AOHell starts sending out requested packs.  ..Starting in 10 seconds."
    Packing1 = 1
    DoEvents
    Call Pause(12)
    Unload WNote
    If Packing1 = 2 Then
      Packing1 = 0
      Exit Sub
    End If

    AppActivate "America  Online"
    DoEvents
    SendKeys Chr$(20)
    DoEvents
    Call Pause(2)
    PeopleList = FindChildByClass(thiswin%, "_AOL_Tree")
    Next1 = 0
    Next2 = 0
    next3 = 0
    next4 = 0
    next5 = 0

    DaNum = P1F

    Numppl = List1.ListCount

    If Numppl = 0 Then
      Next1 = 1
      GoTo nex1
    End If

    List1.ListIndex = 0

    For b = 1 To Numppl

    'List1.ListIndex = List1.ListIndex + 1

      jacko1 = List1.List(List1.ListIndex)
      MMList1 = MMList1 + jacko1 + ", "
      On Error GoTo fab1
      GoTo lars1

fab1:
      Resume fa1

lars1:


      List1.ListIndex = List1.ListIndex + 1
fa1:

      MMCt = Len(MMList1)
      MMCt1 = MMCt - 2

    Next b

    SendTo = Mid$(MMList1, 1, MMCt1)

    Call MassMail(SendTo, DaNum)

nex1:

    If pk2 = 1 Then

      DaNum = P2F

      Numppl = List2.ListCount
      If Numppl = 0 Then
        Next2 = 1
        GoTo nex2
      End If

      List2.ListIndex = 0


      For c = 1 To Numppl

      'List1.ListIndex = List1.ListIndex + 1

        jacko2 = List2.List(List2.ListIndex)
        MMList2 = MMList2 + jacko2 + ", "
        On Error GoTo fab2
        GoTo lars2

fab2:
        Resume fa2

lars2:


        List2.ListIndex = List2.ListIndex + 1
fa2:

        MMCt = Len(MMList2)
        MMCt1 = MMCt - 2

      Next c

      SendTo = Mid$(MMList2, 1, MMCt1)

      Cur = P1F

      SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)


      Call MassMail(SendTo, DaNum)
    End If

nex2:

    If pk3 = 1 Then

      DaNum = P3F

      Numppl = List3.ListCount
      If Numppl = 0 Then
        next3 = 1
        GoTo nex3
      End If

      List3.ListIndex = 0

      For d = 1 To Numppl

      'List1.ListIndex = List1.ListIndex + 1

        jacko3 = List3.List(List3.ListIndex)
        MMList3 = MMList3 + jacko3 + ", "
        On Error GoTo fab3
        GoTo lars3

fab3:
        Resume fa3

lars3:


        List3.ListIndex = List3.ListIndex + 1
fa3:

        MMCt = Len(MMList3)
        MMCt1 = MMCt - 2

      Next d

      SendTo = Mid$(MMList3, 1, MMCt1)

      Cur = P1F + P2F

      SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)


      Call MassMail(SendTo, DaNum)
    End If

nex3:

    If pk4 = 1 Then

      DaNum = P4F

      Numppl = List4.ListCount
      If Numppl = 0 Then
        next4 = 1
        GoTo nex4
      End If

      List4.ListIndex = 0

      For e = 1 To Numppl

      'List1.ListIndex = List1.ListIndex + 1

        jacko4 = List4.List(List4.ListIndex)
        MMList4 = MMList4 + jacko4 + ", "
        On Error GoTo fab4
        GoTo lars4

fab4:
        Resume fa4

lars4:


        List4.ListIndex = List4.ListIndex + 1
fa4:

        MMCt = Len(MMList4)
        MMCt1 = MMCt - 2

      Next e

      SendTo = Mid$(MMList4, 1, MMCt1)

      Cur = P1F + P2F + P3F

      SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)


      Call MassMail(SendTo, DaNum)
    End If

nex4:

    If pk5 = 1 Then

      DaNum = P5F

      Numppl = List5.ListCount
      If Numppl = 0 Then
        next5 = 1
        GoTo nex5
      End If

      List5.ListIndex = 0

      For f = 1 To Numppl

      'List1.ListIndex = List1.ListIndex + 1

        jacko5 = List5.List(List5.ListIndex)
        MMList5 = MMList5 + jacko5 + ", "
        On Error GoTo fab5
        GoTo lars5

fab5:
        Resume fa5

lars5:


        List5.ListIndex = List5.ListIndex + 1
fa5:

        MMCt = Len(MMList5)
        MMCt1 = MMCt - 2

      Next f

      SendTo = Mid$(MMList5, 1, MMCt1)

      Cur = P1F + P2F + P3F + P4F

      SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)


      Call MassMail(SendTo, DaNum)
    End If

nex5:

    thiswin% = FindWindow(0, "America  Online")
    MailHand1 = FindChildByTitle(thiswin%, "Download Manager")
    VBMsg4.SubClasshWnd = MailHand1
    VBMsg4.SendMessage = WM_CLOSE

    PTime = PTime1
    PackNotify = PackNotify1
    Label3.Caption = PTime
    SmallPack.Caption = "Pack Status -" + Str(PTime)
    PackStatus.Show
    List1.Clear
    List2.Clear
    List3.Clear
    List4.Clear
    List5.Clear
    ListS1 = ""
    ListS2 = ""
    ListS3 = ""
    ListS4 = ""
    ListS5 = ""
    Timer1.Enabled = True
    Timer2.Enabled = True
    Timer3.Enabled = True

  End Sub

  Sub Command3D2_Click ()
    Response = MsgBox("Are you sure you want stop offering Packs?", 292, "Cancel Pack Offers")
  'Possible Response values: 6--YES, 7--NO.
    If Response = 6 Then

      Timer1.Enabled = False
      Timer2.Enabled = False
      Timer3.Enabled = False
      Timer4.Enabled = False
      main.Timer1.Enabled = True
      main.Timer2.Enabled = True

    ' Unload WarezBot

      Unload Me
    End If

    If Response = 7 Then Exit Sub


  '  Unload Me

  End Sub

  Sub Command3D3_Click ()

    lint = 1000 '74
    lpstring = "-==AOHell==-      Offered Packs      -==AOHell==-   Leech Limit:" + Str(LeechLimit)

    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(.4)

    If PTime = 1 Then IsMin = " minute." Else IsMin = " minutes."   '91
    lpstring = "Type:  " + ScreenName + " XDCC SEND #N  to request pack.  Where N is the pack number."'  Requests sent in: " + PTime + IsMin

    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(1.5)
    If P1F = 1 Then Filt1 = " file )" Else Filt1 = " files )"
    If P2F = 1 Then Filt2 = " file )" Else Filt2 = " files )"
    If P3F = 1 Then Filt3 = " file )" Else Filt3 = " files )"
    If P4F = 1 Then Filt4 = " file )" Else Filt4 = " files )"
    If P5F = 1 Then Filt5 = " file )" Else Filt5 = " files )"

    lpstring = "Pack 1:  " + P1D + "  (" + Str(P1F) + Filt1

    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(.5)

    If pk2 = 1 Then
      lpstring = "Pack 2:  " + P2D + "  (" + Str(P2F) + Filt2
      x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
      DoEvents
      Call Pause(.3)
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.5)
    End If
    If pk3 = 1 Then
      lpstring = "Pack 3:  " + P3D + "  (" + Str(P3F) + Filt3
      x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
      DoEvents
      Call Pause(.3)
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(2)
    End If
    If pk4 = 1 Then
      lpstring = "Pack 4:  " + P4D + "  (" + Str(P4F) + Filt4
      x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
      DoEvents
      Call Pause(.3)
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.5)
    End If
    If pk5 = 1 Then
      lpstring = "Pack 5:  " + P5D + "  (" + Str(P5F) + Filt5
      x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
      DoEvents
      Call Pause(.3)
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.5)
    End If

    DoEvents
    Call Pause(.5)

    If PTime1 = 1 Then IsMin1 = " minute." Else IsMin1 = " minutes."
    lpstring = "Requested packs will be sent out every" + Str(PTime1) + IsMin1 + "  Next send time will be in" + Str(PTime) + IsMin
    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP


  End Sub

  Sub Command3D4_Click ()
    Ignored = InputBox$("Enter the person's Screen Name.  Any requests from this person will be ignored.", "Ignore Someone")

    Ignored = UCase$(Ignored)

    If IgnorePer1 = "XXX1" Then
      IgnorePer1 = Ignored
      Exit Sub
    End If
    If IgnorePer2 = "XXX2" Then
      IgnorePer2 = Ignored
      Exit Sub
    End If
    If IgnorePer3 = "XXX3" Then
      IgnorePer3 = Ignored
      Exit Sub
    End If
    If IgnorePer4 = "XXX4" Then
      IgnorePer4 = Ignored
      Exit Sub
    End If
    If IgnorePer5 = "XXX5" Then
      IgnorePer5 = Ignored
      Exit Sub
    End If
    If IgnorePer6 = "XXX6" Then
      IgnorePer6 = Ignored
      Exit Sub
    End If
    If IgnorePer7 = "XXX7" Then
      IgnorePer7 = Ignored
      Exit Sub
    End If
    If IgnorePer8 = "XXX8" Then
      IgnorePer8 = Ignored
      Exit Sub
    End If
    If IgnorePer9 = "XXX9" Then
      IgnorePer9 = Ignored
      Exit Sub
    End If
    If IgnorePer10 = "XXX10" Then
      IgnorePer10 = Ignored
      Exit Sub
    End If


  End Sub

  Sub Command3D5_Click ()
    PackStatus.Hide
    SmallPack.Show

  End Sub

  Sub Form_Load ()
    If AIStatus = 11 Then
      MsgBox "The Multi-Task Chat Room is still active.  You cannot use the Warez Bot with the Multi-Task Chat Room still running.  Please close the MT Chat Room and try again.", 16, "MT Chat Room Still Active"
      Unload Me
      Exit Sub
    End If
    If AIStatus = 1 Then
      MsgBox "The AI Bot is still active.  You cannot use the Warez Bot with the AI Bot still running.  Please bring up the AI Bot window and choose ""Unload AI Bot"", then try again.", 16, "AI Bot Still Active"
      Unload Me
      Exit Sub
    End If

    AIStatus = 12


    Dim Success As Integer

    Success% = SetWindowPos%(PackStatus.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
    GoTo AIBeg

AIErr:
    MsgBox "An error has occured while trying to start the bot.  Please close that Chat Room window, then re-enter the room you are in.  You may then try again.", 48, "Can't Get Window Lock"
    Unload Me
    Exit Sub


AIBeg:
    On Error GoTo AIErr

    ListS1 = ""
    ListS2 = ""
    ListS3 = ""
    ListS4 = ""
    ListS5 = ""

    IgnorePer1 = "XXX1"
    IgnorePer2 = "XXX2"
    IgnorePer3 = "XXX3"
    IgnorePer4 = "XXX4"
    IgnorePer5 = "XXX5"
    IgnorePer6 = "XXX6"
    IgnorePer7 = "XXX7"
    IgnorePer8 = "XXX8"
    IgnorePer9 = "XXX9"
    IgnorePer10 = "XXX10"


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

  ' DaRoom = thiswin%
    Label3.Caption = PTime
    PNotify = 5

  'thiswin% = FindWindow(0, "America  Online")

    find% = FindChildByClass(DaRoom, "_AOL_View")
    find1% = FindChildByClass(DaRoom, "_AOL_Edit")
    find2% = FindChildByTitle(DaRoom, "Send")


    AOLViewHandle = find%
    AOLSendHandle = find2%
    AOLEditHandle = find1%


    VBMsg2.SubClasshWnd = find1%
    VBMsg1.SubClasshWnd = find2%
    VBMsg5.SubClasshWnd = find%


  End Sub

  Sub Form_Unload (Cancel As Integer)
    VBMsg1.SubClasshWnd = 0
    VBMsg2.SubClasshWnd = 0
    VBMsg3.SubClasshWnd = 0
    VBMsg4.SubClasshWnd = 0
    If AIStatus = 12 Then AIStatus = 0

  End Sub

  Sub Timer2_Timer ()
    GoTo Beg1


Err1:
    Exit Sub


Beg1:
  'On Error GoTo Err1

    thiswin% = FindWindow(0, "America  Online")


    Destroy1 = FindChildByClass(thiswin%, "_AOL_Listbox")
    DoEvents

    If Destroy1 = 0 Then
      MsgBox "AOHell has detected that the AOL chat window has been closed.  ..Stopping Pack Offers", 64, "Room Closed"
      Destroyed = 0
      Unload PackStatus
      Exit Sub
    End If
    chat6 = ChatLine

    colon = ":"

    l% = InStr(1, chat6, colon)
    If l% > 0 Then

      l% = l% - 1
    Else l% = 1
    End If
    DoEvents

    SN = Mid$(chat6, 1, l%)
  ' text2.Text = SN
    ChatName = SN
    ChatNameSp = SN

    TempChat = ChatNameSp
    ChatLine = UCase$(ChatLine)
    Trig = "XDCC"
    DidTrigger = InStr(1, ChatLine, Trig)
    If DidTrigger = 0 Then Exit Sub
    DoEvents
    If DidTrigger > 0 And DidTrigger < 104 Then
      ScreenName1 = UCase$(ScreenName)

      If ChatLine = PLast Then Exit Sub
      DidOwnSay = InStr(1, TempChat, ScreenName)
      DidHostSay = InStr(1, TempChat, "OnlineHost")
      If DidOwnSay > 0 Or DidHostSay > 0 Then Exit Sub
    DoEvents

      ig1 = InStr(1, ChatLine, IgnorePer1)
      ig2 = InStr(1, ChatLine, IgnorePer2)
      ig3 = InStr(1, ChatLine, IgnorePer3)
      ig4 = InStr(1, ChatLine, IgnorePer4)
      ig5 = InStr(1, ChatLine, IgnorePer5)
      ig6 = InStr(1, ChatLine, IgnorePer6)
      ig7 = InStr(1, ChatLine, IgnorePer7)
      ig8 = InStr(1, ChatLine, IgnorePer8)
      ig9 = InStr(1, ChatLine, IgnorePer9)
      ig10 = InStr(1, ChatLine, IgnorePer10)
    DoEvents

      If ig1 > 0 Or ig2 > 0 Or ig3 > 0 Or ig4 > 0 Or ig5 > 0 Or ig6 > 0 Or ig7 > 0 Or ig8 > 0 Or ig9 > 0 Or ig10 > 0 Then Exit Sub


      DidName = InStr(1, ChatLine, ScreenName1)
      If DidName > 0 Then

        ListB1 = 0
        ListB2 = 0
        ListB3 = 0
        ListB4 = 0
        ListB5 = 0

        InLis1 = InStr(1, ListS1, TempChat)
        If InLis1 > 0 Then ListB1 = 1
        InLis2 = InStr(1, ListS2, TempChat)
        If InLis2 > 0 Then ListB2 = 1
        InLis3 = InStr(1, ListS3, TempChat)
        If InLis3 > 0 Then ListB3 = 1
        InLis4 = InStr(1, ListS4, TempChat)
        If InLis4 > 0 Then ListB4 = 1
        InLis5 = InStr(1, ListS5, TempChat)
        If InLis5 > 0 Then ListB5 = 1
    DoEvents


        DidLeech = ListB1 + ListB2 + ListB3 + ListB4 + ListB5
      '   MsgBox Str(DidLeech)
        If DidLeech >= LeechLimit Then Exit Sub


        WhichNum = Mid$(ChatLine, DidTrigger, 12)
        WhichNum2 = Mid$(WhichNum, 12)
        PackNum = WhichNum2
        PLast = ChatLine
      'MsgBox PackNum

        If PackNum = "1" Then
          List1.AddItem TempChat
          ListS1 = ListS1 + TempChat
        'MsgBox ListS1
        End If
        If PackNum = "2" Then
          List2.AddItem TempChat
          ListS2 = ListS2 + TempChat
        'MsgBox ListS2
        End If
        If PackNum = "3" Then
          List3.AddItem TempChat
          ListS3 = ListS3 + TempChat
        'MsgBox ListS3
        End If
        If PackNum = "4" Then
          List4.AddItem TempChat
          ListS4 = ListS4 + TempChat
        'MsgBox ListS4
        End If
        If PackNum = "5" Then
          List5.AddItem TempChat
          ListS5 = ListS5 + TempChat
        'MsgBox ListS5
        End If
        DoEvents

      End If
    End If


  End Sub

  Sub Timer3_Timer ()

    If PTime = 1 Then
      GoTo StartTim
    Else
      PTime = PTime - 1
      Label3.Caption = PTime
      SmallPack.Command3D1.Caption = "Pack Status -" + Str(PTime)
      Exit Sub

    End If


StartTim:

    Call Command3D1_Click

  End Sub

  Sub Timer4_Timer ()

    If PackNotify = 1 Then
      GoTo StartNot
    Else
      PackNotify = PackNotify - 1
      Exit Sub
    End If


StartNot:

    PackNotify = PackNotify1

    lint = 1000 '74
    lpstring = "-==AOHell==-      Offered Packs      -==AOHell==-   Leech Limit:" + Str(LeechLimit)
    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(.4)

    If PTime = 1 Then IsMin = " minute." Else IsMin = " minutes."   '91
    lpstring = "Type:  " + ScreenName + " XDCC SEND #N  to request pack.  Where N is the pack number."'  Requests sent in: " + PTime + IsMin

    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(1.5)
    If P1F = 1 Then Filt1 = " file )" Else Filt1 = " files )"
    If P2F = 1 Then Filt2 = " file )" Else Filt2 = " files )"
    If P3F = 1 Then Filt3 = " file )" Else Filt3 = " files )"
    If P4F = 1 Then Filt4 = " file )" Else Filt4 = " files )"
    If P5F = 1 Then Filt5 = " file )" Else Filt5 = " files )"

    lpstring = "Pack 1:  " + P1D + "  (" + Str(P1F) + Filt1

    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(.5)

    If pk2 = 1 Then
      lpstring = "Pack 2:  " + P2D + "  (" + Str(P2F) + Filt2
      x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
      DoEvents
      Call Pause(.3)
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.5)
    End If
    If pk3 = 1 Then
      lpstring = "Pack 3:  " + P3D + "  (" + Str(P3F) + Filt3
      x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
      DoEvents
      Call Pause(.3)
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(2)
    End If
    If pk4 = 1 Then
      lpstring = "Pack 4:  " + P4D + "  (" + Str(P4F) + Filt4
      x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
      DoEvents
      Call Pause(.3)
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.5)
    End If
    If pk5 = 1 Then
      lpstring = "Pack 5:  " + P5D + "  (" + Str(P5F) + Filt5
      x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
      DoEvents
      Call Pause(.3)
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.5)
    End If

    DoEvents
    Call Pause(.5)

    If PTime1 = 1 Then IsMin1 = " minute." Else IsMin1 = " minutes."
    lpstring = "Requested packs will be sent out every" + Str(PTime1) + IsMin1 + "  Next send time will be in" + Str(PTime) + IsMin
    x = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.3)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP

  End Sub

  Sub VBMsg3_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    CursorChanged = 1

  End Sub

  Sub VBMsg5_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    ChatLine = ptGetStringFromAddress(lParam, 1000)
    ChatLine = Trim$(ChatLine)
    ChatLine = Mid$(ChatLine, 3)

  End Sub

