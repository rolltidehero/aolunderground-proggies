VERSION 2.00
Begin Form MultiChat 
   BackColor       =   &H8000000F&
   Caption         =   "AOHell v3.0  Multi-Task Chat"
   ClientHeight    =   2775
   ClientLeft      =   435
   ClientTop       =   2295
   ClientWidth     =   8685
   Height          =   3465
   HelpContextID   =   20
   Icon            =   MULTICHA.FRX:0000
   Left            =   375
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2775
   ScaleWidth      =   8685
   Top             =   1665
   Width           =   8805
   Begin VBMsg VBMsg4 
      Height          =   420
      Left            =   1560
      MessageCount    =   MULTICHA.FRX:0302
      MessageList     =   MULTICHA.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2760
      Width           =   420
   End
   Begin Timer Timer2 
      Interval        =   100
      Left            =   2400
      Top             =   2640
   End
   Begin VBMsg VBMsg3 
      Height          =   420
      Left            =   6480
      MessageCount    =   MULTICHA.FRX:0502
      MessageList     =   MULTICHA.FRX:0504
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2640
      Width           =   420
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   2055
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Top             =   120
      Width           =   8415
   End
   Begin VBMsg VBMsg2 
      Height          =   420
      Left            =   5160
      MessageCount    =   MULTICHA.FRX:0702
      MessageList     =   MULTICHA.FRX:0704
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2640
      Width           =   420
   End
   Begin CommandButton Command1 
      Caption         =   "Send"
      Default         =   -1  'True
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   7800
      TabIndex        =   1
      Top             =   2280
      Width           =   735
   End
   Begin TextBox Text2 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   360
      Left            =   120
      MaxLength       =   93
      TabIndex        =   0
      Top             =   2280
      Width           =   7575
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   3960
      MessageCount    =   MULTICHA.FRX:0902
      MessageList     =   MULTICHA.FRX:0904
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   2640
      Width           =   420
   End
   Begin Timer Timer1 
      Interval        =   2000
      Left            =   3360
      Top             =   2640
   End
   Begin Menu mnuOptions 
      Caption         =   "&Options"
      Begin Menu mnuRoom 
         Caption         =   "&Change Rooms"
         Begin Menu mnuPrivate 
            Caption         =   "&Private Room"
         End
         Begin Menu mnuMember 
            Caption         =   "&Member Room"
         End
      End
      Begin Menu mnuPause 
         Caption         =   "&Pause Room"
      End
      Begin Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin Menu mnuIgnore 
      Caption         =   "I&gnore"
      Begin Menu mnuISome 
         Caption         =   "Ignore &Someone"
      End
      Begin Menu mnuDice 
         Caption         =   "Ignore &Dice"
      End
      Begin Menu mnuSounds 
         Caption         =   "Ignore &Sounds"
      End
      Begin Menu mnuClear 
         Caption         =   "&Clear Ignores"
      End
   End
End
'Option Explicit
  Dim Ctrl() As ScaleStruct
  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

  Sub Command1_Click ()
    GoTo SendBeg

SendErr:
    MsgBox "An error has occured, could not send line.", 48, "Chat Room Error"
    Exit Sub

SendBeg:
    On Error GoTo SendErr
    Dim Tex2 As String
    If Text2.Text = "" Then
      Exit Sub
    End If

    Tex2 = Text2.Text
    Text2.Text = ""

    lint = 100  '7500
    lpstring = Tex2

    X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)  ',lint
    DoEvents
    DoEvents
    DoEvents
    Call Pause(.5)
    DoEvents
    VBMsg1.PostMessage = WM_LBUTTONDOWN
    DoEvents
    VBMsg1.PostMessage = WM_LBUTTONUP

    Text2.SetFocus

  End Sub

  Sub Command3D1_Click ()
    mnuPause.Checked = True

  End Sub

  Sub Form_Load ()

    If AIStatus = 1 Then
      MsgBox "The AI Bot is still active.  You cannot use the MultiTask chatroom with the AI Bot still running.  Please bring up the AI Bot window and choose ""Unload AI Bot"", then try again.", 16, "AI Bot Still Active"
      Unload Me
      Exit Sub
    End If
    If AIStatus = 12 Then
      MsgBox "The Warez Bot is still active.  You cannot use the Multi-Task Chat Room with the Warez Bot still running.  Please stop the Warez Bot and try again.", 16, "Warez Bot Still Active"
      Unload Me
      Exit Sub
    End If


    AIStatus = 11

    GoTo MBeg1

MErr1:
    MsgBox "An error has occured while trying to start the Chat Room.  Please close that Chat Room window, then re-enter the room you are in.  You may then try again.    NOTE: If you have the Warez Bot or AI Bot running, it will cause this error.", 48, "Can't Get Window Lock"
    Unload Me
    Exit Sub

MBeg1:
    On Error GoTo MErr1:


  '1) add this code to your forms form_load for EACH form you want to resize
  '   also add the code in Form_Resize.
  '2) add the code in form_resize to the form_resize sub of your form
  '3) add the dim statement for CTRL in declarations to form_declarations
  '4) add the type definition in the .BAS file to your project.
  'Note - if you have no controls on the form, it will not work
    Dim i As Integer

    ReDim Ctrl(0 To controls.Count - 1) 'an array called "Ctrl" will hold
  'the Left, Top, Width, Height, and
    On Error Resume Next    'TextSize (if any) of each control
  'on the Form, as well as, the Form's
  'Width and Height the control is on.
    For i = 0 To controls.Count - 1
      Ctrl(i).Top = controls(i).Top
      Ctrl(i).Left = controls(i).Left
      Ctrl(i).Width = controls(i).Width
      Ctrl(i).Height = controls(i).Height
      Ctrl(i).ParentHeight = controls(i).Parent.ScaleHeight
      Ctrl(i).ParentWidth = controls(i).Parent.ScaleWidth
      Ctrl(i).FontSize = controls(i).FontSize
    Next

  'If a control does not have one of the above properties then
  'the "On Error Resume Next" statement will simply skips it.


    Dim Success As Integer

    Success% = SetWindowPos%(MultiChat.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

  'MsgBox "AOHell needs to get a lock on the chat room window now.  Please click the chat room with the mouse, so it is the top AOL window.  Then hit the OK button to this message.", 64, "Chat Window Lock"

  'thiswin% = FindWindow(0, "America  Online")

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
    c = SendMessage(DaRoom, WM_GETTEXTLENGTH, 0, 0)
    c = c + 1

    lint = c    '7500
    lpstring = Space(c)

    X = SendMessageByString(DaRoom, WM_GETTEXT, lint, lpstring) ',lint
    lpstring = Trim$(lpstring)
    lpstring = CStr(lpstring)

    MultiChat.Caption = "-==AOHell v3.0  Multi-Task Chat Room==-  You are in:  " + lpstring


    ChatCount = 0

    find% = FindChildByClass(DaRoom, "_AOL_View")
    find1% = FindChildByClass(DaRoom, "_AOL_Edit")
    find2% = FindChildByTitle(DaRoom, "Send")


    AOLViewHandle = find%
    AOLSendHandle = find2%
    AOLEditHandle = find1%


    VBMsg1.SubClasshWnd = find2%
  'VBMsg2.SubClasshWnd = find%
    VBMsg3.SubClasshWnd = find%

  End Sub

  Sub Form_Resize ()
    Dim i As Integer
    Dim ParentSH As Integer, ParentSW As Integer

    On Error Resume Next

    ParentSH = controls(i).Parent.ScaleHeight
    ParentSW = controls(i).Parent.ScaleWidth

    For i = 0 To controls.Count - 1
      controls(i).Visible = False
      controls(i).Top = Ctrl(i).Top * (ParentSH / Ctrl(i).ParentHeight)
      controls(i).Left = Ctrl(i).Left * (ParentSW / Ctrl(i).ParentWidth)
      controls(i).Width = Ctrl(i).Width * (ParentSW / Ctrl(i).ParentWidth)
      controls(i).Height = Ctrl(i).Height * (ParentSH / Ctrl(i).ParentHeight)

    '  controls(i).FontSize = Ctrl(i).FontSize * (ParentSH / Ctrl(i).ParentHeight)
    '  If controls(i).FontSize < 6 Then controls(i).FontSize = 6
    'controls(i).FontName = "Arial"
      controls(i).Visible = True
    Next i


    Dim Success As Integer

    Success% = SetWindowPos%(MultiChat.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

  End Sub

  Sub Form_Unload (Cancel As Integer)
    VBMsg1.SubClasshWnd = 0
    VBMsg2.SubClasshWnd = 0
    If AIStatus = 11 Then AIStatus = 0
  End Sub

  Sub mnuClear_Click ()
    mnuDice.Checked = False
    mnuSounds.Checked = False
    IgDice = 0
    IgSounds = 0
    MTR1 = ""
    MTR2 = ""
    MTR3 = ""
    MTR4 = ""
    MTR5 = ""
    MTR6 = ""
    MTR7 = ""
    MTR8 = ""
    MTR9 = ""
    MTR10 = ""

  End Sub

  Sub mnuDice_Click ()
    If mnuDice.Checked = False Then
      mnuDice.Checked = True
      IgDice = 1

    Else

      If mnuDice.Checked = True Then
        mnuDice.Checked = False
        IgDice = 0

      End If
    End If

  End Sub

  Sub mnuExit_Click ()
    Unload Me

  End Sub

  Sub mnuISome_Click ()
    GoTo JackBeg

ErrJack:
    Exit Sub

JackBeg:
    On Error GoTo ErrJack

    jacko1 = InputBox$("Please enter the persons Screen Name you want to ignore.", "Screen Name to Ignore")

  ' jacko1 = jacko1 + ":"
    jacko1 = UCase$(jacko1)

    If MTR1 = "" Then
      MTR1 = jacko1
      GoTo kewl
    End If
    If MTR2 = "" Then
      MTR2 = jacko1
      GoTo kewl
    End If
    If MTR3 = "" Then
      MTR3 = jacko1
      GoTo kewl
    End If
    If MTR4 = "" Then
      MTR4 = jacko1
      GoTo kewl
    End If
    If MTR5 = "" Then
      MTR5 = jacko1
      GoTo kewl
    End If
    If MTR6 = "" Then
      MTR6 = jacko1
      GoTo kewl
    End If
    If MTR7 = "" Then
      MTR7 = jacko1
      GoTo kewl
    End If
    If MTR8 = "" Then
      MTR8 = jacko1
      GoTo kewl
    End If
    If MTR9 = "" Then
      MTR9 = jacko1
      GoTo kewl
    End If
    If MTR10 = "" Then
      MTR10 = jacko1
      GoTo kewl
    End If

kewl:

  End Sub

  Sub mnuMember_Click ()
    GoTo MemBeg

ErrMem:
    Timer2.Enabled = True
    Exit Sub

MemBeg:
  'On Error GoTo ErrMem
    Timer2.Enabled = False

    LeRoom = InputBox$("Enter the Member Room name.", "Enter a Member Room")
    thiswin% = FindWindow(0, "America  Online")
    IsMem = FindChildByTitle(thiswin%, "Member Rooms")
    If IsMem <> 0 Then GoTo nex1



    bac = Chr$(13)
    jojo4 = "List" + bac + "Rooms"

    RoomIcon = FindChildByTitle(thiswin%, jojo4)
  'MsgBox Str(RoomIcon)
    RoomIcon = RoomIcon + 4


    VBMsg4.SubClasshWnd = RoomIcon
    VBMsg4.SendMessage = WM_LBUTTONDOWN
    VBMsg4.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(1)
  'SendKeys "{ESC 3}"
    DoEvents
    Call Pause(3)
    DoEvents

nex1:

    CreateBut = FindChildByTitle(thiswin%, "Create Room")
    VBMsg4.SubClasshWnd = CreateBut
    VBMsg4.SendMessage = WM_LBUTTONDOWN
    VBMsg4.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(1)
    MemWin = FindChildByTitle(thiswin%, "Create a Member Room")
    While MemWin = 0
      DoEvents
      VBMsg4.SendMessage = WM_LBUTTONDOWN
      VBMsg4.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.5)
      MemWin = FindChildByTitle(thiswin%, "Create a Member Room")
    Wend

    MemEdit = FindChildByClass(MemWin, "_AOL_Edit")
    lint = 3000
    lpstring = LeRoom
    SendIM = SendMessageByString(MemEdit, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(1)
    GoWin = FindChildByTitle(MemWin, "Create")
    VBMsg4.SubClasshWnd = GoWin
    VBMsg4.SendMessage = WM_LBUTTONDOWN
    VBMsg4.SendMessage = WM_LBUTTONUP
    DoEvents
    Timer2.Enabled = True
    DoEvents
    Call Pause(2)

    bac = Chr$(13)
    jojo4 = "List" + bac + "Rooms"
    thiswin% = FindWindow(0, "America  Online")
    RoomIcon = FindChildByTitle(thiswin%, jojo4)
    DaRoom = GetParent(RoomIcon)
    c = SendMessage(DaRoom, WM_GETTEXTLENGTH, 0, 0)
    c = c + 1

    lint = c    '7500
    lpstring = Space(c)

    X = SendMessageByString(DaRoom, WM_GETTEXT, lint, lpstring) ',lint
    lpstring = Trim$(lpstring)
    lpstring = CStr(lpstring)

    MultiChat.Caption = "-==AOHell v3.0  Multi-Task Chat Room==-  You are in:  " + lpstring


  End Sub

  Sub mnuPause_Click ()
    If mnuPause.Checked = False Then
      mnuPause.Checked = True
      Timer2.Enabled = False

    Else

      If mnuPause.Checked = True Then
        mnuPause.Checked = False
        Timer2.Enabled = True

      End If
    End If

  End Sub

Sub mnuPrivate_Click ()
    GoTo MemBeg1

ErrMem1:
    Timer2.Enabled = True
    Exit Sub

MemBeg1:
  On Error GoTo ErrMem1
    Timer2.Enabled = False

    LeRoom = InputBox$("Enter the Private Room name.", "Enter a Private Room")
    thiswin% = FindWindow(0, "America  Online")
    IsMem = FindChildByTitle(thiswin%, "Member Rooms")
    If IsMem <> 0 Then GoTo nex2



    bac = Chr$(13)
    jojo4 = "List" + bac + "Rooms"

    RoomIcon = FindChildByTitle(thiswin%, jojo4)
  'MsgBox Str(RoomIcon)
    RoomIcon = RoomIcon + 4


    VBMsg4.SubClasshWnd = RoomIcon
    VBMsg4.SendMessage = WM_LBUTTONDOWN
    VBMsg4.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(1)
  'SendKeys "{ESC 3}"
    DoEvents
    Call Pause(3)
    DoEvents

nex2:

    CreateBut = FindChildByTitle(thiswin%, "Private Room")
    VBMsg4.SubClasshWnd = CreateBut
    VBMsg4.SendMessage = WM_LBUTTONDOWN
    VBMsg4.SendMessage = WM_LBUTTONUP
    DoEvents
    Call Pause(1)
    MemWin = FindChildByTitle(thiswin%, "Enter a Private Room")
    While MemWin = 0
      DoEvents
      VBMsg4.SendMessage = WM_LBUTTONDOWN
      VBMsg4.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.5)
      MemWin = FindChildByTitle(thiswin%, "Enter a Private Room")
    Wend

    MemEdit = FindChildByClass(MemWin, "_AOL_Edit")
    lint = 3000
    lpstring = LeRoom
    SendIM = SendMessageByString(MemEdit, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(1)
    GoWin = FindChildByTitle(MemWin, "Go")
    VBMsg4.SubClasshWnd = GoWin
    VBMsg4.SendMessage = WM_LBUTTONDOWN
    VBMsg4.SendMessage = WM_LBUTTONUP
    DoEvents
    Timer2.Enabled = True
    DoEvents
    Call Pause(2)

    bac = Chr$(13)
    jojo4 = "List" + bac + "Rooms"
    thiswin% = FindWindow(0, "America  Online")
    RoomIcon = FindChildByTitle(thiswin%, jojo4)
    DaRoom = GetParent(RoomIcon)
    c = SendMessage(DaRoom, WM_GETTEXTLENGTH, 0, 0)
    c = c + 1

    lint = c    '7500
    lpstring = Space(c)

    X = SendMessageByString(DaRoom, WM_GETTEXT, lint, lpstring) ',lint
    lpstring = Trim$(lpstring)
    lpstring = CStr(lpstring)

    MultiChat.Caption = "-==AOHell v3.0  Multi-Task Chat Room==-  You are in:  " + lpstring

End Sub

  Sub mnuSounds_Click ()
    If mnuSounds.Checked = False Then
      mnuSounds.Checked = True
      IgSounds = 1

    Else

      If mnuSounds.Checked = True Then
        mnuSounds.Checked = False
        IgSounds = 0

      End If
    End If

  End Sub

  Sub Timer1_Timer ()
    GoTo MultiBeg

MultiErr:
    Exit Sub

MultiBeg:
    On Error GoTo MultiErr

    thiswin% = FindWindow(0, "America  Online")


    Destroy1 = FindChildByClass(thiswin%, "_AOL_Listbox")

    If Destroy1 = 0 Then
      MsgBox "AOHell has detected that the AOL chat window has been closed.  ...Shutting down Multi-Task Chat Room", 64, "Room Closed"
      Destroyed = 0
      Unload MultiChat
      Exit Sub
    End If


  End Sub

  Sub Timer2_Timer ()
    
       

    If SaidChat = 1 Then
     
      DoEvents
      SaidChat = 0
      ChatLine = Trim$(ChatLine)
    'ret = Chr$(13) + Chr$(10)
      DoEvents
      IsDice = InStr(ChatLine, "sided dice:")
      IsSounds = InStr(ChatLine, "{S ")
      DoEvents
      If IgSounds = 1 And IsSounds > 0 And IsSounds < 106 Then Exit Sub
      If IgDice = 1 And IsDice > 0 And IsDice < 106 Then Exit Sub
      If Not MTR1 = "" Then
        NewChat = UCase$(ChatLine)
        DidM1 = InStr(NewChat, MTR1)
      If Not MTR2 = "" Then DidM2 = InStr(NewChat, MTR2)
      If Not MTR3 = "" Then DidM3 = InStr(NewChat, MTR3)
      If Not MTR4 = "" Then DidM4 = InStr(NewChat, MTR4)
      If Not MTR5 = "" Then DidM5 = InStr(NewChat, MTR5)
      If Not MTR6 = "" Then DidM6 = InStr(NewChat, MTR6)
      If Not MTR7 = "" Then DidM7 = InStr(NewChat, MTR7)
      If Not MTR8 = "" Then DidM8 = InStr(NewChat, MTR8)
      If Not MTR9 = "" Then DidM9 = InStr(NewChat, MTR9)
      If Not MTR10 = "" Then DidM10 = InStr(NewChat, MTR10)
    '    MsgBox Str(DidM1) + Str(DidM2) + Str(DidM3) + Str(DidM4) + Str(DidM5) + Str(DidM6) + Str(DidM7) + Str(DidM8) + Str(DidM9) + Str(DidM10)
        If DidM1 > 106 Or DidM2 > 106 Or DidM3 > 106 Or DidM4 > 106 Or DidM5 > 106 Or DidM6 > 106 Or DidM7 > 106 Or DidM8 > 106 Or DidM9 > 106 Or DidM10 > 106 Then GoTo Neb1
        If DidM1 > 0 Or DidM2 > 0 Or DidM3 > 0 Or DidM4 > 0 Or DidM5 > 0 Or DidM6 > 0 Or DidM7 > 0 Or DidM8 > 0 Or DidM9 > 0 Or DidM10 > 0 Then Exit Sub
        
Neb1:
     End If
      DoEvents
      Text1.Text = Text1.Text + ChatLine    '+ ret
      Leng = Len(Text1.Text)
      Text1.SelStart = Leng
      DoEvents

    End If

  End Sub

  Sub VBMsg1_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    MsgBox "AOHell needs to get a lock on the chat room window now.  Please click the chat room with the mouse, so it is the top AOL window.  Then hit the OK button to this message.", 64, "Chat Window Lock"

    thiswin% = FindWindow(0, "America  Online")

    find% = FindChildByClass(thiswin%, "_AOL_View")
    find1% = FindChildByClass(thiswin%, "_AOL_Edit")
    find2% = FindChildByTitle(thiswin%, "Send")


    AOLViewHandle = find%
    AOLSendHandle = find2%
    AOLEditHandle = find1%


    VBMsg2.SubClasshWnd = find%
    VBMsg1.SubClasshWnd = find2%

  End Sub

  Sub VBMsg2_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    Destroyed = 1

  End Sub

  Sub VBMsg3_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
   ChatLine = ptGetStringFromAddress(lParam, 106)
  SaidChat = 1
  End Sub

