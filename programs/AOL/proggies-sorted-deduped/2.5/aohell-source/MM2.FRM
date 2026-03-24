VERSION 2.00
Begin Form mm2 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "-==AOHell==-    Mass Mail   -==AOHell==-"
   ClientHeight    =   4635
   ClientLeft      =   1665
   ClientTop       =   1230
   ClientWidth     =   6090
   Height          =   5040
   HelpContextID   =   26
   Icon            =   MM2.FRX:0000
   Left            =   1605
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   ScaleHeight     =   4635
   ScaleWidth      =   6090
   Top             =   885
   Width           =   6210
   Begin SSCommand Command3D7 
      BevelWidth      =   3
      Caption         =   "Add &IMs"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   1320
      TabIndex        =   28
      Top             =   3000
      Width           =   1095
   End
   Begin SSCommand Command3D6 
      BevelWidth      =   3
      Caption         =   "&Count Mail"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2520
      TabIndex        =   27
      Top             =   3000
      Width           =   1095
   End
   Begin CommonDialog CMDialog1 
      DialogTitle     =   "Open Saved MM List"
      Filter          =   "Mass Mail Lists(*.MM)|*.MM"
      Left            =   2520
      Top             =   4560
   End
   Begin SSCommand Command3D5 
      BevelWidth      =   3
      Caption         =   "Open"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2640
      TabIndex        =   26
      Top             =   720
      Width           =   735
   End
   Begin Timer Timer1 
      Left            =   6720
      Top             =   120
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "&Add  Room"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   120
      TabIndex        =   25
      Top             =   3000
      Width           =   1095
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "Save "
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2640
      TabIndex        =   24
      Top             =   240
      Width           =   735
   End
   Begin VBMsg VBMsg2 
      Height          =   420
      Left            =   1680
      MessageCount    =   MM2.FRX:0302
      MessageList     =   MM2.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   4560
      Width           =   420
   End
   Begin SSFrame Frame3D3 
      Caption         =   "Number to Send"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   1455
      Left            =   3720
      TabIndex        =   14
      Top             =   1440
      Width           =   2175
      Begin TextBox Text4 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "Arial"
         FontSize        =   6.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   1680
         TabIndex        =   23
         Text            =   "1"
         Top             =   1080
         Width           =   375
      End
      Begin OptionButton Option3D5 
         Caption         =   "&Everything in box"
         Height          =   255
         Left            =   240
         TabIndex        =   19
         Top             =   360
         Value           =   -1  'True
         Width           =   1815
      End
      Begin TextBox Text3 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "Arial"
         FontSize        =   6.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   960
         TabIndex        =   2
         Text            =   "200"
         Top             =   720
         Width           =   375
      End
      Begin OptionButton Option3D6 
         BackColor       =   &H00C0C0C0&
         Caption         =   "&Send        warez"
         Height          =   255
         Left            =   240
         TabIndex        =   20
         Top             =   720
         Width           =   1815
      End
      Begin Label Label5 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000F&
         Caption         =   "Start at number:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   225
         Left            =   240
         TabIndex        =   22
         Top             =   1080
         Width           =   1350
      End
   End
   Begin Timer Timer2 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   3720
      Top             =   4560
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   4200
      MessageCount    =   MM2.FRX:0502
      MessageList     =   MM2.FRX:0504
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   4560
      Width           =   420
   End
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   7080
      Parameter       =   ""
      Top             =   120
      Value           =   ""
      Width           =   420
   End
   Begin TextBox Text2 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   615
      Left            =   240
      MaxLength       =   19000
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   3840
      Width           =   5655
   End
   Begin SSFrame Frame3D2 
      Caption         =   "Options"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   1455
      Left            =   120
      TabIndex        =   12
      Top             =   1440
      Width           =   3495
      Begin SSCheck Check3D3 
         Caption         =   "&Auto sign-off when complete"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   480
         TabIndex        =   13
         Top             =   1080
         Width           =   2775
      End
      Begin SSCheck Check3D2 
         Caption         =   "&Keep All Mail as New"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   480
         TabIndex        =   7
         Top             =   720
         Value           =   -1  'True
         Width           =   2415
      End
      Begin SSCheck Check3D1 
         Caption         =   "Include &Warez Disclaimer"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   480
         TabIndex        =   10
         Top             =   360
         Width           =   2535
      End
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Mail to Send"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   1215
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   2295
      Begin OptionButton Option3D4 
         Caption         =   "&Everything"
         Enabled         =   0   'False
         Height          =   255
         Left            =   2280
         TabIndex        =   18
         Top             =   1200
         Visible         =   0   'False
         Width           =   1455
      End
      Begin OptionButton Option3D3 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Send All &Read Mail"
         Height          =   195
         Left            =   240
         TabIndex        =   17
         Top             =   600
         Width           =   1935
      End
      Begin OptionButton Option3D2 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Send All &Sent Mail"
         Height          =   195
         Left            =   240
         TabIndex        =   16
         Top             =   840
         Width           =   1935
      End
      Begin OptionButton Option3D1 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Send All &New Mail"
         Height          =   195
         Left            =   240
         TabIndex        =   15
         Top             =   360
         Value           =   -1  'True
         Width           =   1935
      End
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "X"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   5400
      TabIndex        =   5
      Top             =   3360
      Width           =   495
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Start"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   4080
      TabIndex        =   4
      Top             =   3360
      Width           =   1215
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   855
      Left            =   3840
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   240
      Width           =   2055
   End
   Begin Label Label4 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "AOL 2.5 or higher required"
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   3840
      TabIndex        =   21
      Top             =   3000
      Width           =   2130
   End
   Begin Label Label3 
      BackColor       =   &H8000000F&
      Caption         =   "(Optional)"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   2880
      TabIndex        =   9
      Top             =   3480
      Width           =   975
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      Caption         =   "Comments to include with mail:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   255
      Left            =   120
      TabIndex        =   11
      Top             =   3480
      Width           =   2775
   End
   Begin Label Label9 
      BackColor       =   &H8000000F&
      Caption         =   "Seperate names with a comma "
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   3840
      TabIndex        =   8
      Top             =   1200
      Width           =   2175
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "To:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   3480
      TabIndex        =   1
      Top             =   240
      Width           =   255
   End
End
  Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

  Sub Check3D2_Click (Value As Integer)
    quit = 1000
  End Sub

  Sub Command3D1_Click ()


    If SignStatus = 0 Then
      MsgBox "You must be signed on to AOL before using this feature.", 16, "Not Signed On!"
      Exit Sub
    End If
    GoTo MMBegin

MMErr:
    MsgBox "An error has occured within AOHell.  Cannot continue.", 48, "Mass Mail Error"
    Exit Sub

MMBegin:
  'On Error GoTo MMErr

    If Text1.Text = "" Then
      MsgBox "Please enter the screen names you want to send to.", 16, "Screen Names"
      Exit Sub
    End If

    If Option3D6.Value = True Then
      If Text3.Text = "" Then
        MsgBox "You must specify the amount of ware  to send.", 16, "Number of Warez"
        Exit Sub
      End If
    End If


    AppActivate "America  Online"
    
    thiswin% = FindWindow(0, "America  Online")
    Cursr = FindChildByClass(thiswin%, "MDIClient")


    VBMsg2.SubClasshWnd = Cursr
  '  If Check3D4.Value = True Then
  '  ListHand = FindChildByClass(thiswin%, "_AOL_Listbox")
  '  ListCount1 = SendMessage(ListHand, LB_GETCOUNT, 0, 0)
  '  sztext = Space$(256)
  ' For b = 1 To ListCount1
  '  length = GETAOLLIST(b, sztext)
  '  sztext = Trim$(sztext)
  '  Text1.Text = Text1.Text + "," + sztext
  ' Next b
  ' End If
    mm2.Hide
    wait.Show
    AppActivate "America  Online"
    DoEvents
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
'    While find13% > 0
      VBMsg1.SubClasshWnd = find12%
      VBMsg1.SendMessage = WM_CLOSE
    
     DoEvents

NewMail:

    If Option3D1.Value = True Then
      SendKeys "%MN"
      DoEvents
    End If
    If Option3D2.Value = True Then
      SendKeys "%MS"
      DoEvents
    End If
    If Option3D3.Value = True Then
      SendKeys "%MR"
      DoEvents
    End If

    mm2.Hide
    wait.Show
    If Check3D3.Value = True Then Ebstat.Check3D1.Value = True

    AppActivate "America  Online"
    DoEvents
    Call Pause(1)


    For a = 1 To 60
      DoEvents
      If SkipPause = 1 Then
        SkipPause = 0
        GoTo ByPass1
      End If
      Call Pause(1)
      DoEvents

    ' If ByPass = 1 Then
    ' ByPass = 0
    ' GoTo ByPass1
    ' End If
    Next a


ByPass1:
    wait.Hide
    Ebstat.Show
    Ebstat.Caption = "Mass Mailing"
    Ebstat.Panel3D1.Caption = "Mass Mailing To: " + Text1.Text + "..."
If Option3D5.Value = True Then
    thiswin% = FindWindow(0, "America  Online")
    PeopleList = FindChildByClass(thiswin%, "_AOL_Tree")

    F1 = SendMessage(PeopleList, LB_GETCOUNT, 0, 0)
  Text3.Text = F1
End If
  tex3 = Text3.Text
     Ebstat.Label4.Caption = tex3
      
    
    DoEvents
    AppActivate "America  Online"
    DoEvents
    ZaNum = Text4.Text
    If ZaNum > 1 Then
      ZaNum = ZaNum - 1
      For w = 1 To ZaNum
        SendKeys "{DOWN}"
        DoEvents
      Next w
    End If
    DoEvents
    
    find13% = FindChildByTitle(thiswin%, "Fwd:")
    While find13% > 0
      VBMsg1.SubClasshWnd = find13%
      VBMsg1.SendMessage = WM_CLOSE
      find13% = FindChildByTitle(thiswin%, "Fwd:")
      DoEvents
    Wend


    For X = 1 To Text3.Text

      If qui1 = 1000 Then GoTo endit
    ' ForwardHand = VBEnumChildWindows(MDIClient1, 1)
      MDIClient1 = FindChildByClass(thiswin%, "MDIClient")

      SendKeys "{ENTER}"

      DoEvents
      Call Pause(4)
    ' SendKeys "{ESC}"
      DoEvents
      lars = 0

    '  ForwardHand = VBEnumChildWindows(MDIClient1, 1)
     ForwardHand = FindChildByTitle(thiswin%, "Fwd:")
      While ForwardHand = 0
        lars = lars + 1
        If lars = 25 Then GoTo jimbob
        DoEvents
        Call Pause(.5)
        ForwardHand = FindChildByTitle(thiswin%, "Fwd:")
        DoEvents
      Wend

    ' ForwardHand = VBEnumChildWindows(MDIClient1, 1)
    ' ForwardHand = FindChildByTitle(thiswin%, "Fwd:")
      ForwardButton = VBEnumChildWindows(ForwardHand, 4)
      DoEvents
    '    Exit Sub

      VBMsg1.SubClasshWnd = ForwardButton
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      Call Pause(.1)
     ' DoEvents

    ' MailHand = VBEnumChildWindows(MDIClient1, 1)'FindChildByTitle(thiswin%, "Fwd:")
    ' Find10% = FindChildByClass(MailHand, "_AOL_Edit")
      CursorChanged = 0
      For b = 1 To 100  'Find10% = 0
        If CursorChanged = 1 Then GoTo gag1
        MailHand = FindChildByTitle(thiswin%, "Fwd:")   '= VBEnumChildWindows(MDIClient1, 1)'
     '   MHand = FindChildByTitle(thiswin%, "Send Later")
        Find10% = FindChildByClass(MailHand, "_AOL_Edit")
        If Find10% <> 0 Or MHand <> 0 Then GoTo gag1
        DoEvents

      ' If Find10% <> 0 Then
      ' GoTo gag1
      ' End If

        If CursorChanged = 1 Then GoTo gag1
        DoEvents
      ''''If CursorChanged = 1 Then GoTo gag1
      ''''DoEvents
      ''''Call Pause(2)
      ''''If CursorChanged = 1 Then GoTo gag1
      ''''DoEvents
        If CursorChanged = 1 Then GoTo gag1
        VBMsg1.SendMessage = WM_LBUTTONDOWN
        VBMsg1.SendMessage = WM_LBUTTONUP
      'Exit Sub
        DoEvents
        Call Pause(.1)
        If CursorChanged = 1 Then GoTo gag1
        MailHand = FindChildByTitle(thiswin%, "Fwd:")   '= VBEnumChildWindows(MDIClient1, 1)'
     '   MHand = FindChildByTitle(thiswin%, "Send Later")
        Find10% = FindChildByClass(MailHand, "_AOL_Edit")
        If Find10% <> 0 Or MHand <> 0 Then GoTo gag1
        Call Pause(.1)
        If CursorChanged = 1 Then GoTo gag1
        VBMsg1.SendMessage = WM_LBUTTONDOWN
        VBMsg1.SendMessage = WM_LBUTTONUP

        DoEvents
      Next b

gag1:
      DoEvents
      Call Pause(.1)
      MailHand = VBEnumChildWindows(MDIClient1, 1)
      DoEvents

    'MailHand = FindChildByTitle(thiswin%, "Fwd:")
      SendHand1 = VBEnumChildWindows(MailHand, 2)
      ToHand = VBEnumChildWindows(MailHand, 8)
      While ToHand = 0
        If qui1 = 1000 Then GoTo endit
        DoEvents
        dobodo = 4 + 4
        DoEvents
        ToHand = VBEnumChildWindows(MailHand, 8)
      Wend

      SubjectHand = VBEnumChildWindows(MailHand, 12)
      MessageHand = VBEnumChildWindows(MailHand, 13)
      DoEvents

BackStar:

      lint = 20000  '7500
      lpstring = Text1.Text

      a2 = SendMessagebyString(ToHand, WM_SETTEXT, lint, lpstring)  ',lint
      DoEvents
    'Call Pause(.1)
      ret = Chr$(13) + Chr$(10)
      If Check3D1.Value = True Then

        warezdisclaim = "*** W A R N I N G ***" + ret + "By downloading this file attached to this" + ret + "e-mail message, you agree to abide by all" + ret + "copyright laws of the United States as" + ret + "found in U.S.C.A., and specifically those" + ret + "sections regarding non-profit library" + ret + "check-out of software.  Once your check-out" + ret + "period is over, you MUST return or destroy this" + ret
        warezdisclaim = warezdisclaim + "file.  If you do not do so, you WILL BE in" + ret + "violation of Federal Law." + ret + "  " + ret + "If you have any questions regarding your" + ret + "legal liability, please consult U.S.C.A. or" + ret + "your local attorney." + ret + "  " + ret + "Making copies or distribution of this file" + ret + "for profit is expressly forbidden by" + ret + "Federal Law.  Your check-out period is" + ret + "24 hours from the time of download." + ret + "  " + ret + "If you can use this software, please purchase" + ret + "it." + ret + "  " + ret
      End If

      If Len(Text2.Text) > 0 Then
        If Check3D1.Value = True Then
          lpstring = warezdisclaim + Text2.Text + ret + ret + "--- Mass Mailed with AOHell 95 v3.0 by Da Chronic"
        Else
          lpstring = Text2.Text + ret + ret + "--- Mass Mailed with AOHell 95 v3.0 by Da Chronic"
        End If
      Else
        If Check3D1.Value = True Then
          lpstring = warezdisclaim + "--- Mass Mailed with AOHell 95 v3.0 by Da Chronic"
        Else
          lpstring = "--- Mass Mailed with AOHell 95 v3.0 by Da Chronic"
        End If
      End If
      a3 = SendMessagebyString(MessageHand, WM_SETTEXT, lint, lpstring) ',lint
      DoEvents
    '  Call Pause(.4)
      DoEvents
    ' Call Pause(.4)
    'On Error GoTo puber

      VBMsg1.SubClasshWnd = SendHand1
      VBMsg1.SendMessage = WM_LBUTTONDOWN
      DoEvents
      Call Pause(.1)
      VBMsg1.SendMessage = WM_LBUTTONUP
      DoEvents
      thiswin1% = FindWindow(0, "America Online")
      While thiswin1% = 0
        If qui1 = 1000 Then GoTo endit
        DoEvents
        DoEvents
        dodo = 4 + 4
        DoEvents
        DoEvents
        thiswin1% = FindWindow(0, "America Online")
      Wend
      DoEvents

      StatBat = VBEnumChildWindows(thiswin1%, 3)

      lint = 10000  '7500
      lpstring = Space(10000)

      Gwar = 0
      chank1 = 0
      thiswin10% = 0

      Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)  ',lint
      lpstring = Trim$(lpstring)
      lpstring = UCase$(lpstring)
      chnk = Text1.Text
      Text1.Text = UCase$(chnk)

      Gwar = InStr(1, lpstring, "-")
      If Not Gwar > 0 Then GoTo Puber
      If Gwar > 0 Then
        Gwar = Gwar - 2
        Gwar2 = Mid$(lpstring, 1, Gwar)
        Gwar2 = Trim$(Gwar2)
        Gwar2 = UCase$(Gwar2)
        gog = Len(Gwar2)
        chank = Text1.Text
        chank1 = InStr(1, chank, Gwar2)
        If chank1 > 0 Then
          gog = gog + 1
          gog1 = chank1 + Len(Gwar2)
          chank1 = chank1 - 1
          chank2 = Mid$(chank, 1, chank1)
          chank3 = Mid$(chank, gog1)
          Text1.Text = chank2 + chank3

          olecap = Ebstat.Panel3D1.Caption
          Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
          Ebstat.List1.AddItem Gwar2
          DoEvents
          Call Pause(2)
          SendKeys "{ENTER}"
          DoEvents
          Call Pause(1.5)
          Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
        End If
      End If

      thiswin10% = FindWindow(0, "America Online")
     ' DoEvents
      thiswin10% = FindWindow(0, "America Online")
     ' DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then

        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then

        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then

        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      thiswin10% = FindWindow(0, "America Online")
      DoEvents
      If thiswin10% <> 0 Then
        StatBat = VBEnumChildWindows(thiswin10%, 3)


        Y = SendMessagebyString(StatBat, WM_GETTEXT, lint, lpstring)    ',lint
        lpstring = Trim$(lpstring)
        lpstring = UCase$(lpstring)
        chnk = Text1.Text
        Text1.Text = UCase$(chnk)

        Gwar = InStr(1, lpstring, "-")
        If Gwar > 0 Then
          Gwar = Gwar - 2
          Gwar2 = Mid$(lpstring, 1, Gwar)
          Gwar2 = Trim$(Gwar2)
          Gwar2 = UCase$(Gwar2)
          gog = Len(Gwar2)
          chank = Text1.Text
          chank1 = InStr(1, chank, Gwar2)
          If chank1 > 0 Then
            gog = gog + 1
            gog1 = chank1 + Len(Gwar2)
            chank1 = chank1 - 1
            chank2 = Mid$(chank, 1, chank1)
            chank3 = Mid$(chank, gog1)
            Text1.Text = chank2 + chank3

            olecap = Ebstat.Panel3D1.Caption
            Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + Gwar2 + " from list."
            Ebstat.List1.AddItem Gwar2
            DoEvents
            Call Pause(2)
            SendKeys "{ENTER}"
            DoEvents
            Call Pause(1.5)
            Ebstat.Panel3D1.Caption = "Mass Mailing: " + Text1.Text
          End If
        End If
      End If
      If Gwar > 0 Then
        GoTo BackStar
      End If

Puber:
    find13% = FindChildByTitle(thiswin%, "Fwd:")
    While find13% > 0
      VBMsg1.SubClasshWnd = find13%
      VBMsg1.SendMessage = WM_CLOSE
      find13% = FindChildByTitle(thiswin%, "Fwd:")
      DoEvents
    Wend


      SendKeys "{ENTER}"
      DoEvents
      Call Pause(.1)
     ' VBMsg1.SubClasshWnd = ForwardHand
     ' VBMsg1.SendMessage = WM_CLOSE
      DoEvents
      Call Pause(.1)

jimbob:

      If Option3D1.Value = True Then
        MailHand1 = FindChildByTitle(thiswin%, "New Mail")
      End If
      If Option3D2.Value = True Then
        MailHand1 = FindChildByTitle(thiswin%, "Outgoing Mail")
      End If
      If Option3D3.Value = True Then
        MailHand1 = FindChildByTitle(thiswin%, "Old Mail")
      End If

      VBMsg1.SubClasshWnd = MailHand1
      VBMsg1.SendMessage = WM_CHILDACTIVATE

      If Check3D2.Value = True Then
        If Option3D1.Value = True Or Option3D3.Value = True Then
          KeepMail = FindChildByTitle(thiswin%, "Keep As")
          VBMsg1.SubClasshWnd = KeepMail
          VBMsg1.SendMessage = WM_LBUTTONDOWN
          VBMsg1.SendMessage = WM_LBUTTONUP
          DoEvents
          Call Pause(.1)
        'thiswin2% = FindWindow(0, "America Online")
        ' While thiswin2% = 0
        ' If qui1 = 1000 Then GoTo endit
        ' DoEvents
        ' DoEvents
        ' dodo1 = 4 + 4
        ' DoEvents
        ' DoEvents
        ' thiswin2% = FindWindow(0, "America Online")
        ' Wend
          DoEvents

        'OKHand = FindChildByTitle(thiswin1%, "OK")
        'VBMsg1.SubClasshWnd = OKHand
        'VBMsg1.SendMessage = LBUTTONDOWN
        'VBMsg1.SendMessage = LBUTTONUP
        'SendKeys "{ENTER}"
        'DoEvents
        'Call Pause(2)
          SendKeys "{TAB 2}"
          DoEvents
          Call Pause(.1)
        End If
      End If

      DoEvents

      SendKeys "{DOWN}"
      Ebstat.Label3.Caption = X
      TimesLeft = tex3 - X
      Ebstat.Label4.Caption = TimesLeft
      Ebstat.Percent2.Percent = X / tex3 * 100


    Next X




Everything:

    If Check3D3.Value = True Then
      AppActivate "America  Online"
      SendKeys "%FX"
      DoEvents
      Call Pause(1)
      SendKeys " "
      DoEvents
    End If

endit:
    qui1 = 0
    mm2.Show
    Unload Ebstat

  End Sub

  Sub Command3D2_Click ()
    GoTo Beg14

Err14:
    Exit Sub

Beg14:
    On Error GoTo Err14

    DaFile = InputBox$("Please enter the file name you want to save it under (without the extention!).  Use no more than 8 characters!", "File Name")
    If Len(DaFile) > 8 Then
      MsgBox "File name too large!  You must enter a file name with no more than 8 characters!"
      Exit Sub
    End If

    xfilnam$ = DaFile + ".mm"

    Open xfilnam$ For Output As 1
    Print #1, Text1.Text
    Close #1


  End Sub

  Sub Command3D3_Click ()
    Unload Me

  End Sub

  Sub Command3D4_Click ()

    thiswin% = FindWindow(0, "America  Online")
    PeopleList = FindChildByClass(thiswin%, "_AOL_Listbox")

    X = SendMessage(PeopleList, LB_GETCOUNT, 0, 0)
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

    For Y = 1 To X

      SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)
      Cur = Y
      VBMsg1.SubClasshWnd = PeopleList
      VBMsg1.SendMessage = WM_LBUTTONDBLCLK
      DoEvents
      Call Pause(.01)

      UserNam = VBEnumChildWindows(MDIClient1, 1)
      lint = 10000  '7500
      lpstring = Space(10000)

      Z = SendMessagebyString(UserNam, WM_GETTEXT, lint, lpstring)  ',lint
      lpstring = Trim$(lpstring)
      Text1.Text = Text1.Text + ", " + lpstring
      Leng = Len(Text1.Text)
      Text1.SelStart = Leng

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
    End If
    Leng = Len(Text1.Text)
    Text1.SelStart = Leng


  End Sub

  Sub Command3D5_Click ()
    GoTo begin1

titfuck1:
    Exit Sub


begin1:
    On Error GoTo titfuck1

    CMDIALOG1.Action = 1
    xfilnam1$ = CMDIALOG1.Filename


    Open xfilnam1$ For Input As 1
    Line Input #1, Temp
    Close #1
    Text1.Text = Temp

  End Sub

  Sub Command3D6_Click ()
    MsgBox "Open your  New Mail  and wait for hour glass to go away.  Then hit the OK button to this message."


    thiswin% = FindWindow(0, "America  Online")
    PeopleList = FindChildByClass(thiswin%, "_AOL_Tree")

    X = SendMessage(PeopleList, LB_GETCOUNT, 0, 0)
    MsgBox "You have" + Str(X) + " warez in your box."


  End Sub

Sub Command3D7_Click ()
      thiswin1% = FindWindow(0, "America  Online")
      newwin = FindChildByTitle(thiswin1%, ">Instant")

      While newwin <> 0
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
         DoEvents

        IMSender = Mid$(IMTitle, IMSen)

        IMSender = CStr(IMSender)
        boma = Len(IMSender)
        boma = boma - 1
        IMSender = Mid$(IMSender, 1, boma)
      VBMsg1.SubClasshWnd = newwin
      VBMsg1.SendMessage = WM_CLOSE
      DoEvents

     newwin = FindChildByTitle(thiswin1%, ">Instant")
     DoEvents
     Text1.Text = Text1.Text + IMSender + ","
     Wend

End Sub

  Sub Form_Load ()
    If AIStatus = 1 Then
      MsgBox "The AI Bot is still active.  You cannot use the Mass Mailer with the AI Bot still running.  Please bring up the AI Bot window and choose ""Unload AI Bot"", then try again.", 16, "AI Bot Still Active"
      Unload Me
      Exit Sub
    End If


    main.Timer1.Enabled = False
    main.Timer2.Enabled = False


    qui1 = 0
    Dim Success As Integer

    Success% = SetWindowPos%(mm2.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)


  End Sub

  Sub Form_Resize ()
  'Dim Success As Integer

  'Success% = SetWindowPos%(mm2.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

  End Sub

  Sub Form_Unload (Cancel As Integer)
    main.Timer1.Enabled = True
    main.Timer2.Enabled = True

    qui = 0

  End Sub

Sub Option3D5_Click ()
Text3.Enabled = False

End Sub

Sub Option3D6_Click ()
Text3.Enabled = True

End Sub

  Sub Text1_KeyDown (KeyCode As Integer, Shift As Integer)
    If KeyCode = KEY_RETURN Then
      MsgBox "Please seperate screen names with a comma "","", do not hit the Return button.  Just keep typing and the words will wrap around to the next line...Resetting text box"
      Text1.Text = ""
    End If

  End Sub

  Sub Timer2_Timer ()
    thiswin% = FindWindow(0, "America Online")
    If thiswin% > 0 Then

      dork% = FindChildByTitle(thiswin%, "OK")
      shoe = dork%
      If dork% <> 0 Then
        MsgBox shoe
      End If
    End If

  End Sub

  Sub VBMsg2_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    CursorChanged = 1

  End Sub

