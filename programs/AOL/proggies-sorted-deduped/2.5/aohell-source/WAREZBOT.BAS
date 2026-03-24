Global MMComment As String

Global DidGo1 As Integer

Global ListB1 As Integer
Global ListB2 As Integer
Global ListB3 As Integer
Global ListB4 As Integer
Global ListB5 As Integer

Global ListS1 As String
Global ListS2 As String
Global ListS3 As String
Global ListS4 As String
Global ListS5 As String


Global LeechLimit As Integer

Global Peoplelist As Integer

Global IgnorePer1 As String
Global IgnorePer2 As String
Global IgnorePer3 As String
Global IgnorePer4 As String
Global IgnorePer5 As String
Global IgnorePer6 As String
Global IgnorePer7 As String
Global IgnorePer8 As String
Global IgnorePer9 As String
Global IgnorePer10 As String

Global PackNotify As Integer
Global PackNotify1 As Integer

Global TriggerWord As String
Global TriggerWordSp As String
Global TimeLimit As Integer
Global TimeLimit2 As Integer
Global MMList As String
Global NWarez As Integer

Global DoMM As Integer
Global NotifyRoom As Integer
Global NotifyRoom2 As Integer
Global LastPr As String

Global Packing1 As Integer

Global Pk1 As Integer
Global Pk2 As Integer
Global Pk3 As Integer
Global Pk4 As Integer
Global Pk5 As Integer

Global P1D As String
Global P2D As String
Global P3D As String
Global P4D As String
Global P5D As String

Global P1F As Integer
Global P2F As Integer
Global P3F As Integer
Global P4F As Integer
Global P5F As Integer
Global PTime As Integer
Global PTime1 As Integer
Global PLast As String
Global PNotify As Integer

Sub MassMail (SendTo, DaNum)

AppActivate "America  Online"

       thiswin% = FindWindow(0, "America  Online")
         Cursr = FindChildByClass(thiswin%, "MDIClient")


          PackStatus.VBMsg3.SubClasshWnd = Cursr

For X = 1 To DaNum

   ' ForwardHand = VBEnumChildWindows(MDIClient1, 1)
       MDIClient1 = FindChildByClass(thiswin%, "MDIClient")

DownloadMan = FindChildByTitle(thiswin%, "Download Manager")
   DLView = VBEnumChildWindows(DownloadMan, 6)

   ' TheTree = FindChildByClass(thiswin%, "_AOL_Tree")

 PackStatus.VBMsg2.SubClasshWnd = DLView
 PackStatus.VBMsg2.SendMessage = WM_LBUTTONDOWN
 PackStatus.VBMsg2.SendMessage = WM_LBUTTONUP

  DoEvents
  Call Pause(6)
 ' SendKeys "{ESC}"
  DoEvents
         lars = 0
          ForwardHand = VBEnumChildWindows(MDIClient1, 1)
     '    ForwardHand = FindChildByTitle(thiswin%, "Fwd:")
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

     PackStatus.VBMsg4.SubClasshWnd = ForwardButton
     PackStatus.VBMsg4.SendMessage = WM_LBUTTONDOWN
     PackStatus.VBMsg4.SendMessage = WM_LBUTTONUP
     DoEvents
     Call Pause(.2)
     DoEvents

    ' MailHand = VBEnumChildWindows(MDIClient1, 1)'FindChildByTitle(thiswin%, "Fwd:")
    ' Find10% = FindChildByClass(MailHand, "_AOL_Edit")
        CursorChanged = 0
     For b = 1 To 100 'Find10% = 0
     If CursorChanged = 1 Then GoTo gag1
     MailHand = FindChildByTitle(thiswin%, "Fwd:") '= VBEnumChildWindows(MDIClient1, 1)'
     Find10% = FindChildByClass(MailHand, "_AOL_Edit")
     If Find10% <> 0 Then GoTo gag1
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
     PackStatus.VBMsg4.SendMessage = WM_LBUTTONDOWN
     PackStatus.VBMsg4.SendMessage = WM_LBUTTONUP
     'Exit Sub
     DoEvents
     Call Pause(.2)
     If CursorChanged = 1 Then GoTo gag1
     MailHand = FindChildByTitle(thiswin%, "Fwd:") '= VBEnumChildWindows(MDIClient1, 1)'
     Find10% = FindChildByClass(MailHand, "_AOL_Edit")
     If Find10% <> 0 Then GoTo gag1
     Call Pause(.1)
     If CursorChanged = 1 Then GoTo gag1
     PackStatus.VBMsg4.SendMessage = WM_LBUTTONDOWN
     PackStatus.VBMsg4.SendMessage = WM_LBUTTONUP
     
     DoEvents
     Next b
     
gag1:
 DoEvents
 Call Pause(.4)
 MailHand = VBEnumChildWindows(MDIClient1, 1)
 DoEvents
 
     'MailHand = FindChildByTitle(thiswin%, "Fwd:")
    SendHand1 = VBEnumChildWindows(MailHand, 2)
     ToHand = VBEnumChildWindows(MailHand, 6)
    While ToHand = 0
    If qui1 = 1000 Then GoTo endit
    DoEvents
    dobodo = 4 + 4
    DoEvents
    ToHand = VBEnumChildWindows(MailHand, 6)
    Wend

     SubjectHand = VBEnumChildWindows(MailHand, 10)
     MessageHand = VBEnumChildWindows(MailHand, 11)
  DoEvents

BackStar:

lint = 20000 '7500
lpstring = SendTo

a2 = SendMessageByString(ToHand, WM_SETTEXT, lint, lpstring) ',lint
DoEvents
'Call Pause(.1)
ret = Chr$(13) + Chr$(10)

   lpstring = "-==AOHell==-  WaReZ Bot  -==AOHell==-  Pack that you requested courtesy of " + ScreenName
   a3 = SendMessageByString(MessageHand, WM_SETTEXT, lint, lpstring) ',lint
   DoEvents
 '  Call Pause(.4)
   DoEvents
  ' Call Pause(.4)
'On Error
'GoTo puber

PackStatus.VBMsg4.SubClasshWnd = SendHand1
PackStatus.VBMsg4.SendMessage = WM_LBUTTONDOWN
DoEvents
Call Pause(.1)
PackStatus.VBMsg4.SendMessage = WM_LBUTTONUP
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

lint = 10000 '7500
lpstring = Space(10000)
  
    Gwar = 0
    chank1 = 0
    thiswin10% = 0
                  
 Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Not Gwar > 0 Then GoTo Puber
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
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

    
  Y = SendMessageByString(StatBat, WM_GETTEXT, lint, lpstring) ',lint
   lpstring = Trim$(lpstring)
   lpstring = UCase$(lpstring)
   chnk = SendTo
   SendTo = UCase$(chnk)

   Gwar = InStr(1, lpstring, "-")
   If Gwar > 0 Then
    Gwar = Gwar - 2
    gwar2 = Mid$(lpstring, 1, Gwar)
    gwar2 = Trim$(gwar2)
    gwar2 = UCase$(gwar2)
    gog = Len(gwar2)
    chank = SendTo
    chank1 = InStr(1, chank, gwar2)
     If chank1 > 0 Then
      gog = gog + 1
      gog1 = chank1 + Len(gwar2)
      chank1 = chank1 - 1
      chank2 = Mid$(chank, 1, chank1)
      chank3 = Mid$(chank, gog1)
      SendTo = chank2 + chank3

      olecap = Ebstat.Panel3D1.Caption
      Ebstat.Panel3D1.Caption = "Unknown or Box is full, removing " + gwar2 + " from list."
      DoEvents
      Call Pause(2)
      SendKeys "{ENTER}"
      DoEvents
      Call Pause(1.5)
      Ebstat.Panel3D1.Caption = "Mass Mailing: " + SendTo
   End If
   End If
   End If
        If Gwar > 0 Then
          GoTo BackStar
        End If

Puber:


SendKeys "{ENTER}"
DoEvents
Call Pause(.5)
PackStatus.VBMsg4.SubClasshWnd = ForwardHand
PackStatus.VBMsg4.SendMessage = WM_CLOSE
DoEvents
Call Pause(.5)

jimbob:


MailHand1 = FindChildByTitle(thiswin%, "Download Manager")

PackStatus.VBMsg4.SubClasshWnd = MailHand1
PackStatus.VBMsg4.SendMessage = WM_CHILDACTIVATE

 thiswin% = FindWindow(0, "America  Online")
 
 PeopleList1 = FindChildByClass(thiswin%, "_AOL_Tree")
 SendFing = SendMessage(PeopleList1, LB_GETCURSEL, 0, 0)
       Cur = SendFing + 1
SetCur = SendMessage(PeopleList1, LB_SETCURSEL, Cur, 0)
 
 DoEvents
 Call Pause(.2)

 Next X

endit:

End Sub

