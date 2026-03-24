  VERSION 2.00
  Begin Form IManager
    BackColor       =   &H00C0C0C0&
    BorderStyle     =   3   'Fixed Double
    Caption         =   "Instant Message Manager"
    ClientHeight    =   3135
    ClientLeft      =   480
    ClientTop       =   2220
    ClientWidth     =   8880
    Height          =   3540
    Icon            =   IMANAGER.FRX:0000
    Left            =   420
    LinkTopic       =   "Form6"
    MaxButton       =   0   'False
    MinButton       =   0   'False
    ScaleHeight     =   3135
    ScaleWidth      =   8880
    Top             =   1875
    Width           =   9000
    Begin SSFrame Frame3D1
      FontBold        =   -1    'True
      FontItalic      =   0 'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0 'False
      FontUnderline   =   0 'False
      Height          =   3975
      Left            =   -120
      TabIndex        =   1
      Top             =   -120
      Width           =   9135
      Begin Timer Timer2
        Enabled         =   0   'False
        Interval        =   300
        Left            =   4800
        Top             =   2400
      End
      Begin VBMsg VBMsg2
        Height          =   420
        Left            =   6840
        MessageCount    =   IMANAGER.FRX:0302
        MessageList     =   IMANAGER.FRX:0304
        MessageTypes    =   0   'Selected Messages
        PostDefault     =   0   'False
        Top             =   2400
        Width           =   420
      End
      Begin VBMsg VBMsg1
        Height          =   420
        Left            =   6360
        MessageCount    =   IMANAGER.FRX:0502
        MessageList     =   IMANAGER.FRX:0504
        MessageTypes    =   0   'Selected Messages
        PostDefault     =   0   'False
        Top             =   2400
        Width           =   420
      End
      Begin Timer Timer1
        Enabled         =   0   'False
        Interval        =   150
        Left            =   5280
        Top             =   2400
      End
      Begin CommonDialog CMDialog1
        Filter          =   "IM Mnger Settings(*.IMS)|*.IMS"
        Left            =   5760
        Top             =   2400
      End
      Begin SSCommand Command3D9
        BevelWidth      =   3
        Caption         =   "&Help"
        Font3D          =   3   'Inset w/light shading
        FontBold        =   -1  'True
        FontItalic      =   0   'False
        FontName        =   "Times New Roman"
        FontSize        =   9.75
        FontStrikethru  =   0   'False
        FontUnderline   =   0   'False
        Height          =   375
        HelpContextID   =   21
        Left            =   8160
        TabIndex        =   0
        Top             =   2760
        Width           =   735
      End
      Begin SSCommand Command3D8
        BevelWidth      =   3
        Caption         =   "&Load Settings"
        Font3D          =   3   'Inset w/light shading
        FontBold        =   -1  'True
        FontItalic      =   0   'False
        FontName        =   "Times New Roman"
        FontSize        =   8.25
        FontStrikethru  =   0   'False
        FontUnderline   =   0   'False
        Height          =   375
        Left            =   6720
        TabIndex        =   4
        Top             =   2760
        Width           =   1215
      End
      Begin SSCommand Command3D7
        BevelWidth      =   3
        Caption         =   "&Save Settings"
        Font3D          =   3   'Inset w/light shading
        FontBold        =   -1  'True
        FontItalic      =   0   'False
        FontName        =   "Times New Roman"
        FontSize        =   8.25
        FontStrikethru  =   0   'False
        FontUnderline   =   0   'False
        Height          =   375
        Left            =   5400
        TabIndex        =   17
        Top             =   2760
        Width           =   1215
      End
      Begin SSCommand Command3D6
        BevelWidth      =   3
        Caption         =   "&OK"
        Font3D          =   3   'Inset w/light shading
        FontBold        =   -1  'True
        FontItalic      =   0   'False
        FontName        =   "Times New Roman"
        FontSize        =   9.75
        FontStrikethru  =   0   'False
        FontUnderline   =   0   'False
        Height          =   375
        Left            =   4560
        TabIndex        =   16
        Top             =   2760
        Width           =   735
      End
      Begin SSFrame Frame3D3
        Caption         =   "Ignore Options"
        FontBold        =   -1  'True
        FontItalic      =   0   'False
        FontName        =   "Times New Roman"
        FontSize        =   9.75
        FontStrikethru  =   0   'False
        FontUnderline   =   0   'False
        ForeColor       =   &H00000000&
        Height          =   2295
        Left            =   4560
        TabIndex        =   10
        Top             =   240
        Width           =   4335
        Begin SSCheck Check3D2
          Caption         =   "Ignore &Just these SNs:"
          Height          =   255
          Left            =   240
          TabIndex        =   19
          Top             =   720
          Width           =   2295
        End
        Begin SSCheck Check3D1
          Caption         =   "Ignore &All IMs except from these People:"
          Height          =   255
          Left            =   240
          TabIndex        =   18
          Top             =   360
          Width           =   3855
        End
        Begin SSCommand Command3D5
          BevelWidth      =   1
          Caption         =   "Clear List"
          FontBold        =   0 'False
          FontItalic      =   0 'False
          FontName        =   "MS Sans Serif"
          FontSize        =   8.25
          FontStrikethru  =   0 'False
          FontUnderline   =   0 'False
          Height          =   255
          Left            =   1560
          Outline         =   0 'False
          TabIndex        =   15
          Top             =   1920
          Width           =   975
        End
        Begin SSCommand Command3D4
          BevelWidth      =   1
          Caption         =   "Add to List"
          FontBold        =   0 'False
          FontItalic      =   0 'False
          FontName        =   "MS Sans Serif"
          FontSize        =   8.25
          FontStrikethru  =   0 'False
          FontUnderline   =   0 'False
          Height          =   255
          Left            =   480
          Outline         =   0 'False
          TabIndex        =   14
          Top             =   1920
          Width           =   975
        End
        Begin TextBox Text2
          FontBold        =   0 'False
          FontItalic      =   0 'False
          FontName        =   "Arial"
          FontSize        =   9.75
          FontStrikethru  =   0 'False
          FontUnderline   =   0 'False
          Height          =   360
          Left            =   960
          TabIndex        =   13
          Top             =   1440
          Width           =   1215
        End
        Begin ListBox List2
          FontBold        =   0 'False
          FontItalic      =   0 'False
          FontName        =   "Arial"
          FontSize        =   9.75
          FontStrikethru  =   0 'False
          FontUnderline   =   0 'False
          Height          =   1230
          Left            =   2640
          TabIndex        =   11
          Top             =   840
          Width           =   1455
        End
        Begin Line Line8
          BorderWidth     =   3
          X1              =   1440
          X2              =   1440
          Y1              =   1920
          Y2              =   2160
        End
        Begin Line Line7
          BorderWidth     =   2
          X1              =   480
          X2              =   480
          Y1              =   1920
          Y2              =   2160
        End
        Begin Line Line6
          BorderWidth     =   2
          X1              =   480
          X2              =   1440
          Y1              =   1920
          Y2              =   1920
        End
        Begin Line Line5
          BorderWidth     =   3
          X1              =   480
          X2              =   1440
          Y1              =   2160
          Y2              =   2160
        End
        Begin Label Label1
          AutoSize        =   -1    'True
          BackColor       =   &H8000000F&
          Caption         =   "Enter Name for List"
          FontBold        =   -1    'True
          FontItalic      =   0 'False
          FontName        =   "Times New Roman"
          FontSize        =   9.75
          FontStrikethru  =   0 'False
          FontUnderline   =   -1    'True
          Height          =   225
          Left            =   720
          TabIndex        =   12
          Top             =   1080
          Width           =   1620
        End
      End
      Begin SSCommand Command3D1
        BevelWidth      =   1
        Caption         =   "Add to List"
        FontBold        =   0   'False
        FontItalic      =   0   'False
        FontName        =   "MS Sans Serif"
        FontSize        =   8.25
        FontStrikethru  =   0   'False
        FontUnderline   =   0   'False
        Height          =   255
        Left            =   600
        Outline         =   0   'False
        TabIndex        =   3
        Top             =   2160
        Width           =   975
      End
      Begin SSCommand Command3D2
        BevelWidth      =   1
        Caption         =   "Clear List"
        FontBold        =   0   'False
        FontItalic      =   0   'False
        FontName        =   "MS Sans Serif"
        FontSize        =   8.25
        FontStrikethru  =   0   'False
        FontUnderline   =   0   'False
        Height          =   255
        Left            =   1680
        Outline         =   0   'False
        TabIndex        =   2
        Top             =   2160
        Width           =   975
      End
      Begin SSFrame Frame3D2
        Caption         =   "Auto-Answer Options"
        FontBold        =   -1  'True
        FontItalic      =   0   'False
        FontName        =   "Times New Roman"
        FontSize        =   9.75
        FontStrikethru  =   0   'False
        FontUnderline   =   0   'False
        ForeColor       =   &H00000000&
        Height          =   2895
        Left            =   240
        TabIndex        =   5
        Top             =   240
        Width           =   4215
        Begin SSCheck Check3D4
          Caption         =   "Auto-Answer All &Except:"
          Height          =   255
          Left            =   240
          TabIndex        =   21
          Top             =   720
          Width           =   2295
        End
        Begin SSCheck Check3D3
          Caption         =   "Auto-Answer &All IMs"
          Height          =   255
          Left            =   240
          TabIndex        =   20
          Top             =   360
          Width           =   2295
        End
        Begin SSCommand Command3D3
          BevelWidth      =   3
          Caption         =   "&Select Auto-Answer Message"
          Font3D          =   3 'Inset w/light shading
          FontBold        =   -1    'True
          FontItalic      =   0 'False
          FontName        =   "Times New Roman"
          FontSize        =   9.75
          FontStrikethru  =   0 'False
          FontUnderline   =   0 'False
          Height          =   375
          Left            =   600
          TabIndex        =   9
          Top             =   2280
          Width           =   3015
        End
        Begin ListBox List1
          FontBold        =   0 'False
          FontItalic      =   0 'False
          FontName        =   "Arial"
          FontSize        =   9.75
          FontStrikethru  =   0 'False
          FontUnderline   =   0 'False
          Height          =   1230
          Left            =   2640
          TabIndex        =   7
          Top             =   840
          Width           =   1335
        End
        Begin TextBox Text1
          FontBold        =   0 'False
          FontItalic      =   0 'False
          FontName        =   "Arial"
          FontSize        =   9.75
          FontStrikethru  =   0 'False
          FontUnderline   =   0 'False
          Height          =   360
          Left            =   960
          TabIndex        =   6
          Top             =   1440
          Width           =   1215
        End
        Begin Line Line4
          BorderWidth     =   3
          X1              =   360
          X2              =   1320
          Y1              =   2160
          Y2              =   2160
        End
        Begin Line Line3
          BorderWidth     =   2
          X1              =   360
          X2              =   360
          Y1              =   1920
          Y2              =   2160
        End
        Begin Line Line2
          BorderWidth     =   3
          X1              =   1320
          X2              =   1320
          Y1              =   1920
          Y2              =   2160
        End
        Begin Line Line1
          BorderWidth     =   2
          X1              =   360
          X2              =   1320
          Y1              =   1920
          Y2              =   1920
        End
        Begin Label Label2
          AutoSize        =   -1    'True
          BackColor       =   &H8000000F&
          Caption         =   "Enter Name for List"
          FontBold        =   -1    'True
          FontItalic      =   0 'False
          FontName        =   "Times New Roman"
          FontSize        =   9.75
          FontStrikethru  =   0 'False
          FontUnderline   =   -1    'True
          Height          =   225
          Left            =   720
          TabIndex        =   8
          Top             =   1080
          Width           =   1620
        End
      End
    End
  End
  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

  Sub Check3D1_Click (Value As Integer)
    If Check3D1.Value = True Then Check3D2.Value = False

  End Sub

  Sub Check3D2_Click (Value As Integer)
    If Check3D2.Value = True Then Check3D1.Value = False

  End Sub

  Sub Check3D3_Click (Value As Integer)
    If Check3D3.Value = True Then Check3D4.Value = False

  End Sub

  Sub Check3D4_Click (Value As Integer)
    If Check3D4.Value = True Then Check3D3.Value = False

  End Sub

  Sub Command3D1_Click ()
    GoTo Start1

    Listerr1:
    Exit Sub

    Start1:
    On Error GoTo Listerr1
    If Text1.Text = "" Then
      Exit Sub
    Else
      List1.AddItem Text1.Text
      Text1.Text = ""
      Text1.SetFocus
    End If


  End Sub

  Sub Command3D1_GotFocus ()
    Command3D1.FontBold = True

  End Sub

  Sub Command3D1_LostFocus ()
    Command3D1.FontBold = False


  End Sub

  Sub Command3D10_Click ()
  End Sub

  Sub Command3D2_Click ()
    List1.Clear

  End Sub

  Sub Command3D2_GotFocus ()
    Command3D2.FontBold = True


  End Sub

  Sub Command3D2_LostFocus ()
    Command3D2.FontBold = False


  End Sub

  Sub Command3D3_Click ()
    IMessage1.Show

  End Sub

  Sub Command3D4_Click ()
    GoTo Start2

    Listerr2:
    Exit Sub

    Start2:
    On Error GoTo Listerr2
    If Text2.Text = "" Then
      Exit Sub
    Else
      List2.AddItem Text2.Text
      Text2.Text = ""
      Text2.SetFocus
    End If


  End Sub

  Sub Command3D4_GotFocus ()
    Command3D4.FontBold = True


  End Sub

  Sub Command3D4_LostFocus ()
    Command3D4.FontBold = False


  End Sub

  Sub Command3D5_Click ()
    List2.Clear

  End Sub

  Sub Command3D5_GotFocus ()
    Command3D5.FontBold = True

  End Sub

  Sub Command3D5_LostFocus ()
    Command3D5.FontBold = False


  End Sub

  Sub Command3D6_Click ()
    GoTo ignbeg

    ingerr:
    Resume Next3

    ignerr:
    Resume Next4

    Lasterr:

    Exit Sub

    ignbeg:
    On Error GoTo ingerr

    If Check3D1.Value = True Or Check3D2.Value = True Or Check3D3.Value = True Or Check3D4.Value = True Then

      Timer1.Enabled = True
      Timer2.Enabled = True

    End If


    If Check3D3.Value = True Or Check3D4.Value = True Then
      If IMessage = "" Then
        MsgBox "You must enter an Auto-Answer reply message first.", 16, "No Reply Message Specified!"
        Exit Sub
      End If
    End If


    List2.ListIndex = 0
    juju = List2.ListCount

    For X = 1 To juju


      jacko1 = List2.List(List2.ListIndex)
      If Ignore1 = "" Then
        Ignore1 = jacko1
        GoTo kewl
      End If
      If Ignore2 = "" Then
        Ignore2 = jacko1
        GoTo kewl
      End If
      If Ignore3 = "" Then
        Ignore3 = jacko1
        GoTo kewl
      End If
      If Ignore4 = "" Then
        Ignore4 = jacko1
        GoTo kewl
      End If
      If Ignore5 = "" Then
        Ignore5 = jacko1
        GoTo kewl
      End If
      If Ignore6 = "" Then
        Ignore6 = jacko1
        GoTo kewl
      End If
      If Ignore7 = "" Then
        Ignore7 = jacko1
        GoTo kewl
      End If
      If Ignore8 = "" Then
        Ignore8 = jacko1
        GoTo kewl
      End If
      If Ignore9 = "" Then
        Ignore9 = jacko1
        GoTo kewl
      End If
      If Ignore10 = "" Then
        Ignore10 = jacko1
        GoTo kewl
      End If
      If Ignore11 = "" Then
        Ignore11 = jacko1
        GoTo kewl
      End If
      If Ignore12 = "" Then
        Ignore12 = jacko1
        GoTo kewl
      End If
      If Ignore13 = "" Then
        Ignore13 = jacko1
        GoTo kewl
      End If
      If Ignore14 = "" Then
        Ignore14 = jacko1
        GoTo kewl
      End If
      If Ignore15 = "" Then
        Ignore15 = jacko1
        GoTo kewl
      End If
      If Ignore16 = "" Then
        Ignore16 = jacko1
        GoTo kewl
      End If
      If Ignore17 = "" Then
        Ignore18 = jacko1
        GoTo kewl
      End If
      If Ignore18 = "" Then
        Ignore18 = jacko1
        GoTo kewl
      End If
      If Ignore19 = "" Then
        Ignore19 = jacko1
        GoTo kewl
      End If
      If Ignore20 = "" Then
        Ignore20 = jacko1
        GoTo kewl
      End If


      kewl:


      List2.ListIndex = List2.ListIndex + 1
    Next X


    Next3:
    On Error GoTo ignerr

    List1.ListIndex = 0
    juju1 = List1.ListCount

    For Y = 1 To juju1


      jacko2 = List1.List(List1.ListIndex)
      If IM1 = "" Then
        IM1 = jacko2
        GoTo kewl1
      End If
      If IM2 = "" Then
        IM2 = jacko2
        GoTo kewl1
      End If
      If IM3 = "" Then
        IM3 = jacko2
        GoTo kewl1
      End If
      If IM4 = "" Then
        IM4 = jacko2
        GoTo kewl1
      End If
      If IM5 = "" Then
        IM5 = jacko2
        GoTo kewl1
      End If
      If IM6 = "" Then
        IM6 = jacko2
        GoTo kewl1
      End If
      If IM7 = "" Then
        IM7 = jacko2
        GoTo kewl1
      End If
      If IM8 = "" Then
        IM8 = jacko2
        GoTo kewl1
      End If
      If IM9 = "" Then
        IM9 = jacko2
        GoTo kewl1
      End If
      If IM10 = "" Then
        IM10 = jacko2
        GoTo kewl1
      End If
      If IM11 = "" Then
        IM11 = jacko2
        GoTo kewl1
      End If
      If IM12 = "" Then
        IM12 = jacko2
        GoTo kewl1
      End If
      If IM13 = "" Then
        IM13 = jacko2
        GoTo kewl1
      End If
      If IM14 = "" Then
        IM14 = jacko2
        GoTo kewl1
      End If
      If IM15 = "" Then
        IM15 = jacko2
        GoTo kewl1
      End If
      If IM16 = "" Then
        IM16 = jacko2
        GoTo kewl1
      End If
      If IM17 = "" Then
        IM17 = jacko2
        GoTo kewl1
      End If
      If IM18 = "" Then
        IM18 = jacko2
        GoTo kewl1
      End If
      If IM19 = "" Then
        IM19 = jacko2
        GoTo kewl1
      End If
      If IM20 = "" Then
        IM20 = jacko2
        GoTo kewl1
      End If



      kewl1:
      List1.ListIndex = List1.ListIndex + 1
    Next Y

    Next4:
    On Error GoTo Lasterr

    IManager.Hide
    IM1 = UCase$(IM1)
    IM2 = UCase$(IM2)
    IM3 = UCase$(IM3)
    IM4 = UCase$(IM4)
    IM5 = UCase$(IM5)
    IM6 = UCase$(IM6)
    IM7 = UCase$(IM7)
    IM8 = UCase$(IM8)
    IM9 = UCase$(IM9)
    IM10 = UCase$(IM10)
    IM11 = UCase$(IM11)
    IM12 = UCase$(IM12)
    IM13 = UCase$(IM13)
    IM14 = UCase$(IM14)
    IM15 = UCase$(IM15)
    IM16 = UCase$(IM16)
    IM17 = UCase$(IM17)
    IM18 = UCase$(IM18)
    IM19 = UCase$(IM19)
    IM20 = UCase$(IM20)

    Ignore1 = UCase$(Ignore1)
    Ignore2 = UCase$(Ignore2)
    Ignore3 = UCase$(Ignore3)
    Ignore4 = UCase$(Ignore4)
    Ignore5 = UCase$(Ignore5)
    Ignore6 = UCase$(Ignore6)
    Ignore7 = UCase$(Ignore7)
    Ignore8 = UCase$(Ignore8)
    Ignore9 = UCase$(Ignore9)
    Ignore10 = UCase$(Ignore10)
    Ignore11 = UCase$(Ignore11)
    Ignore12 = UCase$(Ignore12)
    Ignore13 = UCase$(Ignore13)
    Ignore14 = UCase$(Ignore14)
    Ignore15 = UCase$(Ignore15)
    Ignore16 = UCase$(Ignore16)
    Ignore17 = UCase$(Ignore17)
    Ignore18 = UCase$(Ignore18)
    Ignore19 = UCase$(Ignore19)
    Ignore20 = UCase$(Ignore20)



  End Sub

  Sub Command3D7_Click ()
    GoTo begin1

    titfuck1:
    Resume Next1

    titfuck2:

    Close #1
    Close #2
    Exit Sub

    begin1:
    On Error GoTo titfuck1


    CMDialog1.DialogTitle = "Save IM Manager Settings File"
    CMDialog1.Action = 2

    xfilnam$ = CMDialog1.Filename

    Open xfilnam$ For Output As #1


    numims1 = List1.ListCount
    numims2 = List2.ListCount

    Write #1, IMessage

    If Check3D1.Value = True Then option1 = "1" Else option1 = "0"
    If Check3D2.Value = True Then option2 = "1" Else option2 = "0"
    If Check3D3.Value = True Then option3 = "1" Else option3 = "0"
    If Check3D4.Value = True Then option4 = "1" Else option4 = "0"

    Write #1, option1, option2, option3, option4

    Write #1, numims1


    num = 0
    List1.ListIndex = 0

    If numims1 > 0 Then

      For X = 1 To numims1

        jacko1 = List1.List(List1.ListIndex)
        Write #1, jacko1
        List1.ListIndex = List1.ListIndex + 1

      Next X

      Next1:
      On Error GoTo titfuck2

    End If

    Close #1

    file2 = Len(xfilnam$) - 3
    file3 = Mid$(xfilnam$, 1, file2)
    file4 = file3 + "aoh"

    Open file4 For Output As #2

    Write #2, numims2


    num = 0
    List2.ListIndex = 0

    If numims2 > 0 Then

      For Y = 1 To numims2

        jacko2 = List2.List(List2.ListIndex)
        Write #2, jacko2
        List2.ListIndex = List2.ListIndex + 1

      Next Y
    End If

    Close #2


  End Sub

  Sub Command3D8_Click ()
    GoTo begin3:

    titfuck3:
    Resume next2

    listerr4:
    Close #1
    Close #2
    Exit Sub

    begin3:
    On Error GoTo titfuck3

    For xy = 1 To 60
      IMList1(xy) = ""
    Next xy

    CMDialog1.DialogTitle = "Open IM Manager Settings File"
    CMDialog1.Action = 1

    xfilnam$ = CMDialog1.Filename

    Open xfilnam$ For Input As #1

    Input #1, IMessage, option1, option2, option3, option4, numberims1

    If option1 = "1" Then Check3D1.Value = True Else Check3D1.Value = False
    If option2 = "1" Then Check3D2.Value = True Else Check3D2.Value = False
    If option3 = "1" Then Check3D3.Value = True Else Check3D3.Value = False
    If option4 = "1" Then Check3D4.Value = True Else Check3D4.Value = False

    For Y = 1 To numberims1
      Input #1, IMList1(Y)
      List1.AddItem IMList1(Y)
    Next Y
    next2:
    On Error GoTo listerr4

    Close #1

    file2 = Len(xfilnam$) - 3
    file3 = Mid$(xfilnam$, 1, file2)
    file4 = file3 + "aoh"

    For xy1 = 1 To 60
      IMList2(xy1) = ""
    Next xy1

    Open file4 For Input As #2

    Input #2, numberims2

    For z = 1 To numberims2
      Input #2, IMList2(z)
      List2.AddItem IMList2(z)
    Next z
    Close #2




  End Sub

  Sub Command3D9_Click ()
    SendKeys "{F1}"
    DoEvents

  End Sub

  Sub Form_Load ()
    Dim Success As Integer

    Success% = SetWindowPos%(IManager.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

    Timer1.Enabled = False
    Timer2.Enabled = False

    thiswin% = FindWindow(0, "America  Online")
    thiswin22 = FindWindow(0, "America  Online")
    MDIClient = FindChildByClass(thiswin%, "MDIClient")
    VBMsg2.SubClasshWnd = MDIClient

  End Sub

  Sub Form_Resize ()
    Dim Success As Integer

    Success% = SetWindowPos%(IManager.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

  End Sub

  Sub Text1_KeyDown (KeyCode As Integer, Shift As Integer)
    If KeyCode = KEY_RETURN Then
      Call Command3D1_Click
    End If

  End Sub

  Sub Text2_KeyDown (KeyCode As Integer, Shift As Integer)
    If KeyCode = KEY_RETURN Then
      Call Command3D4_Click
    End If

  End Sub

  Sub Timer1_Timer ()
    GoTo Time1Start

    Time1Err:
    Exit Sub

    Time1Start:
    On Error GoTo Time1Err

    If Check3D1.Value = True Or Check3D2.Value = True Then

      Dim trimed As String, Sender As String

      find13% = FindChildByTitle(thiswin22, ">Instant")
      While find13% > 0
        VBMsg2.SubClasshWnd = find13%
        lint = 70   '7500
        lpstring = Space(70)
        X = SendMessagebyString(find13%, WM_GETTEXT, lint, lpstring)    ',lint
        trimed = Trim$(lpstring)
        Sender = Mid$(trimed, 23)
        Sender1 = UCase$(Sender)
      ' MsgBox Sender1
        If Not Ignore1 = "" Then a1 = InStr(Sender1, Ignore1)
        If Not Ignore2 = "" Then b1 = InStr(Sender1, Ignore2)
        If Not Ignore3 = "" Then c1 = InStr(Sender1, Ignore3)
        If Not Ignore4 = "" Then d1 = InStr(Sender1, Ignore4)
        If Not Ignore5 = "" Then e1 = InStr(Sender1, Ignore5)
        If Not Ignore6 = "" Then f1 = InStr(Sender1, Ignore6)
        If Not Ignore7 = "" Then g1 = InStr(Sender1, Ignore7)
        If Not Ignore8 = "" Then h1 = InStr(Sender1, Ignore8)
        If Not Ignore9 = "" Then i1 = InStr(Sender1, Ignore9)
        If Not Ignore10 = "" Then j1 = InStr(Sender1, Ignore10)
        If Not Ignore11 = "" Then k1 = InStr(Sender1, Ignore11)
        If Not Ignore12 = "" Then l1 = InStr(Sender1, Ignore12)
        If Not Ignore13 = "" Then m1 = InStr(Sender1, Ignore13)
        If Not Ignore14 = "" Then n1 = InStr(Sender1, Ignore14)
        If Not Ignore15 = "" Then o1 = InStr(Sender1, Ignore15)
        If Not Ignore16 = "" Then p1 = InStr(Sender1, Ignore16)
        If Not Ignore17 = "" Then q1 = InStr(Sender1, Ignore17)
        If Not Ignore18 = "" Then r1 = InStr(Sender1, Ignore18)
        If Not Ignore19 = "" Then s1 = InStr(Sender1, Ignore19)
        If Not Ignore20 = "" Then t1 = InStr(Sender1, Ignore20)
        If Check3D2.Value = True Then

          If a1 > 0 Or b1 > 0 Or c1 > 0 Or d1 > 0 Or e1 > 0 Or f1 > 0 Or g1 > 0 Or h1 > 0 Or i1 > 0 Or j1 > 0 Or k1 > 0 Or l1 > 0 Or m1 > 0 Or n1 > 0 Or o1 > 0 Or p1 > 0 Or q1 > 0 Or r1 > 0 Or s1 > 0 Or t1 > 0 Then

            VBMsg2.SendMessage = WM_CLOSE
          End If
        End If
        If Check3D1.Value = True Then

          If a1 > 0 Or b1 > 0 Or c1 > 0 Or d1 > 0 Or e1 > 0 Or f1 > 0 Or g1 > 0 Or h1 > 0 Or i1 > 0 Or j1 > 0 Or k1 > 0 Or l1 > 0 Or m1 > 0 Or n1 > 0 Or o1 > 0 Or p1 > 0 Or q1 > 0 Or r1 > 0 Or s1 > 0 Or t1 > 0 Then
            xr = 7
          Else
            VBMsg2.SendMessage = WM_CLOSE
          End If
        End If


        find13% = FindChildByTitle(thiswin%, ">Instant")
      Wend
    End If

  End Sub

  Sub Timer2_Timer ()
    GoTo Time2Start

    Time2Err:
    Exit Sub

    Time2Start:
    On Error GoTo Time2Err

  'Static IMSender1
    If Check3D3.Value = True And Not IMessage = "" Or Check3D4.Value = True And Not IMessage = "" Then

      thiswin1% = FindWindow(0, "America  Online")
      newwin = FindChildByTitle(thiswin1%, ">Instant")

      If newwin <> 0 Then
        c = SendMessage(newwin, WM_GETTEXTLENGTH, 0, 0)
        c = c + 1

        lint = c    '7500
        lpstring = Space(c)

        X = SendMessagebyString(newwin, WM_GETTEXT, lint, lpstring) ',lint
      '  MsgBox Str(c)

        IMTitle = Trim$(lpstring)
      '     MsgBox IMTitle

        IMSen = InStr(IMTitle, ": ")
        IMSen = IMSen + 1

        IMSender = Mid$(IMTitle, IMSen)

        IMSender = CStr(IMSender)
        boma = Len(IMSender)
        boma = boma - 1
        IMSender = Mid$(IMSender, 1, boma)

        IMSendCheck = UCase$(IMSender)

        If IMTitle = IMSender1 Then
          Exit Sub
        Else
          IMSender1 = IMTitle

          If Check3D4.Value = True Then
            If Not IM1 = "" Then chrontest1 = InStr(IMSendCheck, IM1)
            If Not IM2 = "" Then chrontest2 = InStr(IMSendCheck, IM2)
            If Not IM3 = "" Then chrontest3 = InStr(IMSendCheck, IM3)
            If Not IM4 = "" Then chrontest4 = InStr(IMSendCheck, IM4)
            If Not IM5 = "" Then chrontest5 = InStr(IMSendCheck, IM5)
            If Not IM6 = "" Then chrontest6 = InStr(IMSendCheck, IM6)
            If Not IM7 = "" Then chrontest7 = InStr(IMSendCheck, IM7)
            If Not IM8 = "" Then chrontest8 = InStr(IMSendCheck, IM8)
            If Not IM9 = "" Then chrontest9 = InStr(IMSendCheck, IM9)
            If Not IM10 = "" Then chrontest10 = InStr(IMSendCheck, IM10)
            If Not IM11 = "" Then chrontest11 = InStr(IMSendCheck, IM11)
            If Not IM12 = "" Then chrontest12 = InStr(IMSendCheck, IM12)
            If Not IM13 = "" Then chrontest13 = InStr(IMSendCheck, IM13)
            If Not IM14 = "" Then chrontest14 = InStr(IMSendCheck, IM14)
            If Not IM15 = "" Then chrontest15 = InStr(IMSendCheck, IM15)
            If Not IM16 = "" Then chrontest16 = InStr(IMSendCheck, IM16)
            If Not IM17 = "" Then chrontest17 = InStr(IMSendCheck, IM17)
            If Not IM18 = "" Then chrontest18 = InStr(IMSendCheck, IM18)
            If Not IM19 = "" Then chrontest19 = InStr(IMSendCheck, IM19)
            If Not IM20 = "" Then chrontest20 = InStr(IMSendCheck, IM20)


            If chrontest1 > 0 Or chrontest2 > 0 Or chrontest4 > 0 Or chrontest5 > 0 Or chrontest6 > 0 Or chrontest7 > 0 Or chrontest8 > 0 Or chrontest9 > 0 Or chrontest10 > 0 Or chrontest11 > 0 Or chrontest12 > 0 Or chrontest13 > 0 Or chrontest14 > 0 Or chrontest15 > 0 Or chrontest16 > 0 Or chrontest17 > 0 Or chrontest18 > 0 Or chrontest19 > 0 Or chrontest20 > 0 Or chrontest3 > 0 Then Exit Sub
            If IMSendCheck = IM1 Or IMSendCheck = IM2 Or IMSendCheck = IM3 Or IMSendCheck = IM4 Or IMSendCheck = IM5 Or IMSendCheck = IM6 Or IMSendCheck = IM7 Or IMSendCheck = IM8 Or IMSendCheck = IM9 Or IMSendCheck = IM10 Or IMSendCheck = IM11 Or IMSendCheck = IM12 Or IMSendCheck = IM13 Or IMSendCheck = IM14 Or IMSendCheck = IM15 Or IMSendCheck = IM16 Or IMSendCheck = IM17 Or IMSendCheck = IM18 Or IMSendCheck = IM19 Or IMSendCheck = IM20 Then
              Exit Sub
            End If
          End If

          EditHand = VBEnumChildWindows(newwin, 4)  'i%

          SendHand = VBEnumChildWindows(newwin, 5)  'i%

          Name1 = InStr(1, IMessage, "{SN}")

          If Name1 > 0 Then
            If Name1 > 1 Then
              Name3 = Name1 - 1
            Else Name3 = 1
            End If

            Part1 = Mid$(IMessage, 1, Name3)
            Name2 = Name1 + 4
            Part2 = Mid$(IMessage, Name2)
          End If




          lint = 2000   '7500

          If Name1 > 0 Then

            lpstring = Part1 + IMSender + Part2
          '  MsgBox Len(IMSender)

          Else

            lpstring = IMessage
          End If



          X = SendMessagebyString(EditHand, WM_SETTEXT, lint, lpstring) ',lint
          DoEvents

          VBMsg1.SubClasshWnd = SendHand
          VBMsg1.SendMessage = WM_LBUTTONDOWN
          DoEvents
          VBMsg1.SendMessage = WM_LBUTTONUP


        End If
      End If

    End If

  End Sub

