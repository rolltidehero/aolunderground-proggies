ï»¿Private Sub Command5_Click() '5F0940
  Dim var_9C As TextBox
  Dim var_0060C6B8 As ListBox
  Dim var_0060C6CC As Variant
  Dim var_B4 As Variant
  loc_005F0A69: var_9C = "â¢bodini 4.0â¢ mm â¢now startingâ¢"
  loc_005F0AAD: var_eax = call Proc_3_4_5A51B0(var_DC, var_84, 3)
  loc_005F0B0E: var_9C = "<font face=""tahoma"">" & var_DC
  loc_005F0B2D: var_eax = call Proc_79_17_604A50(var_9C & vbNullString, var_84, var_9C)
  loc_005F0B6E: Text1.Text = vbNullString
  loc_005F0BC0: var_140 = List1.ListCount
  loc_005F0BF3: setz dl
  loc_005F0C07: If var_154 = 0 Then GoTo loc_005F0CC6
  loc_005F0C56: var_DC = "bodini by: spek"
  loc_005F0C74: var_CC = "You have no one to mass mail!"
  loc_005F0CC1: GoTo loc_005F23B5
  loc_005F0CC6: 'Referenced from: 005F0C07
  loc_005F0CF5: call edi(var_B4, var_0060C6CC, var_0060C6CC, var_B4, Me, Me, var_B4, var_9C, Me, ebx)
  loc_005F0D07: var_140 = mmoption.Check2.Value
  loc_005F0D3B: setz dl
  loc_005F0D46: var_B4 =
  loc_005F0D4F: If var_154 = 0 Then GoTo loc_005F1A5D
  loc_005F0D84: call edi(var_B4, var_0060C6CC, var_0060C6CC)
  loc_005F0D96: var_140 = mmoption.Option1.Value
  loc_005F0DCA: setz dl
  loc_005F0DD5: var_B4 =
  loc_005F0DDE: If var_154 = 0 Then GoTo loc_005F1097
  loc_005F0E13: call edi(var_B4, var_0060C6B8, var_0060C6B8)
  loc_005F0E1C: var_eax = call Proc_79_12_602F90(var_B4, , )
  loc_005F0E27: var_B4 = var_B4
  loc_005F0E6C: call edi(var_B4, var_0060C6B8, var_0060C6B8)
  loc_005F0E7E: var_140 = mmselect.List1.ListCount
  loc_005F0EAE: var_140 = var_140 - 0001h
  loc_005F0ECA: var_114 = var_140
  loc_005F0EF8: For var_34 = "" To var_140 Step 1
  loc_005F0F0A: var_B4 = var_34
  loc_005F0F12: If var_22C = 0 Then GoTo loc_005F0FB0
  loc_005F0F47: call edi(var_B4, var_0060C6B8, var_0060C6B8)
  loc_005F0F53: var_34 = CInt(-1)
  loc_005F0F5B: mmselect.List1.Selected = var_34
  loc_005F0F99: Next var_34
  loc_005F0FA5: var_22C = Next var_34
  loc_005F0FAB: GoTo loc_005F0F0C
  loc_005F0FB0: 'Referenced from: 005F0F12
  loc_005F1009: var_140 = mmselect.List1.ListCount
  loc_005F1044: var_9C = CStr(var_140)
  loc_005F1054: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F1097: 'Referenced from: 005F0DDE
  loc_005F10D8: var_140 = mmoption.Option2.Value
  loc_005F110C: setz dl
  loc_005F1120: If var_154 = 0 Then GoTo loc_005F13D9
  loc_005F115E: var_eax = call Proc_79_13_603360(var_B4, var_B4, var_0060C6B8)
  loc_005F11C0: var_140 = mmselect.List1.ListCount
  loc_005F11F0: var_140 = var_140 - 0001h
  loc_005F120C: var_114 = var_140
  loc_005F123A: For var_44 = "" To var_140 Step 1
  loc_005F1246: var_230 = var_1A0
  loc_005F1254: If var_230 = 0 Then GoTo loc_005F12F2
  loc_005F1295: var_44 = CInt(-1)
  loc_005F129D: mmselect.List1.Selected = var_44
  loc_005F12DB: Next var_44
  loc_005F12E7: var_230 = Next var_44
  loc_005F12ED: GoTo loc_005F124E
  loc_005F12F2: 'Referenced from: 005F1254
  loc_005F134B: var_140 = mmselect.List1.ListCount
  loc_005F1386: var_9C = CStr(var_140)
  loc_005F1396: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F13D9: 'Referenced from: 005F1120
  loc_005F141A: var_140 = mmoption.Option3.Value
  loc_005F144E: setz dl
  loc_005F1462: If var_154 = 0 Then GoTo loc_005F171B
  loc_005F14A0: var_eax = call Proc_79_14_603760(var_B4, var_B4, var_0060C6B8)
  loc_005F1502: var_140 = mmselect.List1.ListCount
  loc_005F1532: var_140 = var_140 - 0001h
  loc_005F154E: var_114 = var_140
  loc_005F157C: For var_54 = "" To var_140 Step 1
  loc_005F1588: var_234 = var_1C0
  loc_005F1596: If var_234 = 0 Then GoTo loc_005F1634
  loc_005F15D7: var_54 = CInt(-1)
  loc_005F15DF: mmselect.List1.Selected = var_54
  loc_005F161D: Next var_54
  loc_005F1629: var_234 = Next var_54
  loc_005F162F: GoTo loc_005F1590
  loc_005F1634: 'Referenced from: 005F1596
  loc_005F168D: var_140 = mmselect.List1.ListCount
  loc_005F16C8: var_9C = CStr(var_140)
  loc_005F16D8: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F171B: 'Referenced from: 005F1462
  loc_005F175C: var_140 = mmoption.Option4.Value
  loc_005F1790: setz dl
  loc_005F17A4: If var_154 = 0 Then GoTo loc_005F1A5D
  loc_005F17E2: var_eax = call Proc_79_7_602540(var_B4, var_B4, var_0060C6B8)
  loc_005F1844: var_140 = mmselect.List1.ListCount
  loc_005F1874: var_140 = var_140 - 0001h
  loc_005F1890: var_114 = var_140
  loc_005F18BE: For var_64 = "" To var_140 Step 1
  loc_005F18CA: var_238 = var_1E0
  loc_005F18D8: If var_238 = 0 Then GoTo loc_005F1976
  loc_005F1919: var_64 = CInt(-1)
  loc_005F1921: mmselect.List1.Selected = var_64
  loc_005F195F: Next var_64
  loc_005F196B: var_238 = Next var_64
  loc_005F1971: GoTo loc_005F18D2
  loc_005F1976: 'Referenced from: 005F18D8
  loc_005F19CF: var_140 = mmselect.List1.ListCount
  loc_005F1A0A: var_9C = CStr(var_140)
  loc_005F1A1A: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F1A5D: 'Referenced from: 005F0D4F
  loc_005F1A9E: var_140 = mmoption.Check3.Value
  loc_005F1AD2: setz dl
  loc_005F1AE6: If var_154 = 0 Then GoTo loc_005F1AED
  loc_005F1AE8: var_eax = call Proc_79_31_607240(var_B4, var_0060C6CC, var_0060C6CC)
  loc_005F1AED: 'Referenced from: 005F1AE6
  loc_005F1B2E: var_140 = mmoption.Check4.Value
  loc_005F1B62: setz dl
  loc_005F1B76: If var_154 = 0 Then GoTo loc_005F1BBB
  loc_005F1B78: var_eax = call Proc_79_19_604D70(var_B4, var_0060C6CC, var_0060C6CC)
  loc_005F1B82: var_eax = SendMessage(call Proc_79_19_604D70(var_B4, var_0060C6CC, var_0060C6CC), 16, ebx, ebx)
  loc_005F1BB5: var_98 = SendMessage(call Proc_79_19_604D70(var_B4, var_0060C6CC, var_0060C6CC), 16, ebx, ebx)
  loc_005F1BBB: 'Referenced from: 005F1B76
  loc_005F1BFC: var_140 = mmoption.Check6.Value
  loc_005F1C30: setz dl
  loc_005F1C5E: If var_154 = 0 Then GoTo loc_005F1ED5
  loc_005F1C84: var_140 = List1.ListCount
  loc_005F1CB4: var_140 = var_140 - 0001h
  loc_005F1CD0: var_114 = var_140
  loc_005F1CFE: For var_74 = "" To var_140 Step 1
  loc_005F1D0A: var_23C = var_200
  loc_005F1D18: If var_23C = 0 Then GoTo loc_005F210A
  loc_005F1D5D: var_9C = Text1.Text
  loc_005F1DA4: var_74 = CInt(var_A4)
  loc_005F1DAC: var_B8 = List1.List(var_74)
  loc_005F1DEC: var_A0 = vbNullString & var_9C
  loc_005F1E30: var_B0 = var_A0 & var_00437168 & var_A4 & "), "
  loc_005F1E34: List1.FontName = var_B0
  loc_005F1EB8: Next var_74
  loc_005F1ECA: var_23C = Next var_74
  loc_005F1ED0: GoTo loc_005F1D12
  loc_005F1EF5: var_140 = List1.ListCount
  loc_005F1F25: var_140 = var_140 - 0001h
  loc_005F1F41: var_114 = var_140
  loc_005F1F6F: For var_24 = "" To var_140 Step 1
  loc_005F1F7B: var_240 = var_220
  loc_005F1F89: If var_240 = 0 Then GoTo loc_005F210A
  loc_005F1FCA: var_9C = Text1.Text
  loc_005F200D: var_24 = CInt(var_A0)
  loc_005F2015: var_B8 = List1.List(var_24)
  loc_005F2071: var_A8 = var_9C & var_A0 & ", "
  loc_005F2079: List1.FontName = var_A8
  loc_005F20ED: Next var_24
  loc_005F20FF: var_240 = Next var_24
  loc_005F2105: GoTo loc_005F1F83
  loc_005F210A: 'Referenced from: 005F1D18
  loc_005F214B: var_140 = mmoption.Option1.Value
  loc_005F217F: setz dl
  loc_005F2193: If var_154 = 0 Then GoTo loc_005F21BA
  loc_005F219B: var_eax = Call mm.Command1_Click
  loc_005F21FB: var_140 = mmoption.Option2.Value
  loc_005F222F: setz dl
  loc_005F2243: If var_154 = 0 Then GoTo loc_005F226A
  loc_005F224B: var_eax = Call mm.Command2_Click
  loc_005F22AB: var_140 = mmoption.Option3.Value
  loc_005F22DF: setz dl
  loc_005F22F3: If var_154 = 0 Then GoTo loc_005F231A
  loc_005F22FB: var_eax = Call mm.Command3_Click
  loc_005F2357: var_140 = mmoption.Option4.Value
  loc_005F2385: setz dl
  loc_005F2391: If edx = 0 Then GoTo loc_005F23B5
  loc_005F2399: var_eax = Call mm.Command4_Click
  loc_005F23B5: 'Referenced from: 005F0CC1
  loc_005F23BD: GoTo loc_005F2436
  loc_005F2435: Exit Sub
  loc_005F2436: 'Referenced from: 005F23BD
  loc_005F24D5: Exit Sub
End Sub