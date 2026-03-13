Private Sub Command1_Click() '5CF4E0
  Dim var_38 As Variant
  Dim var_2C As Variant
  loc_005CF587: var_D4 = var_38
  loc_005CF58D: var_CC = List3.ListCount
  loc_005CF5BD: setz dl
  loc_005CF5D5: If var_DC <> 0 Then GoTo loc_005D031E
  loc_005CF5F8: var_2C = Command1.Caption
  loc_005CF62E: esi = (var_2C = "Start") + 1
  loc_005CF646: If (var_2C = "Start") + 1 = 0 Then GoTo loc_005CFD91
  loc_005CF663: Command1.Caption = "Stop"
  loc_005CF69B: Command2.Enabled = True
  loc_005CF6D9: Command3.Enabled = False
  loc_005CF700: var_eax = call Proc_79_16_604150(var_38, esi, Me)
  loc_005CF73F: var_CC = serverop.Check1.Value
  loc_005CF76A: setz dl
  loc_005CF77A: If edx = 0 Then GoTo loc_005CF7B6
  loc_005CF794: var_2C = "$im_off"
  loc_005CF79E: var_eax = call Proc_79_30_606DE0(var_2C, "bodini by: spek", var_38)
  loc_005CF7B6: 'Referenced from: 005CF77A
  loc_005CF7CF: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005CF81C: var_34 = "•bodini 4.0• server •" & var_2C & " mail(s)•"
  loc_005CF847: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005CF8A0: var_2C = "<font face=""tahoma"">" & var_58
  loc_005CF8B5: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_2C, var_38)
  loc_005CF8D9: var_D0 = CLng(0.7)
  loc_005CF8E6: var_eax = call Proc_6098C0(var_D0, Me, var_38)
  loc_005CF8EB: call Proc_79_47_609590((var_2C = "Start"), , )
  loc_005CF8F0: var_40 = call Proc_6098C0(var_D0, Me, var_38)
  loc_005CF932: var_A0 = "•type• ""/"
  loc_005CF93C: var_B0 = " send list"" • - list•"
  loc_005CF96A: var_2C = "•type• ""/" + LCase(call Proc_6098C0(var_D0, Me, var_38)) + " send list"" • - list•"
  loc_005CF99E: var_eax = call Proc_3_4_5A51B0(var_98, var_24, 3)
  loc_005CF9F9: var_2C = "<font face=""tahoma"">" & var_98
  loc_005CFA0E: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005CFA3F: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005CFA44: var_eax = call Proc_79_47_609590(, , )
  loc_005CFA49: var_40 = call Proc_79_47_609590(, , )
  loc_005CFA8B: var_A0 = "•type• ""/"
  loc_005CFA95: var_B0 = " send x"" • - index•"
  loc_005CFAC3: var_2C = "•type• ""/" + LCase(call Proc_79_47_609590(, , )) + " send x"" • - index•"
  loc_005CFAF7: var_eax = call Proc_3_4_5A51B0(var_98, var_24, 3)
  loc_005CFB52: var_2C = "<font face=""tahoma"">" & var_98
  loc_005CFB67: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005CFB98: var_eax = call Proc_6098C0(CLng(0.7), , )
  loc_005CFB9D: var_eax = call Proc_79_47_609590(, , )
  loc_005CFBAA: var_40 = call Proc_79_47_609590(, , )
  loc_005CFBB4: var_58 = LCase(call Proc_79_47_609590(, , ))
  loc_005CFBE4: var_A0 = "•type• ""/"
  loc_005CFBEE: var_B0 = " find x"" • - query•"
  loc_005CFC1C: var_2C = "•type• ""/" + var_58 + " find x"" • - query•"
  loc_005CFC50: var_eax = call Proc_3_4_5A51B0(var_98, var_24, 3)
  loc_005CFCAB: var_2C = "<font face=""tahoma"">" & var_98
  loc_005CFCC0: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005CFCF8: Timer2.Interval = CInt(1000)
  loc_005CFD30: Timer3.Interval = CInt(1)
  loc_005CFD6B: Timer4.Interval = CInt(150)
  loc_005CFD8C: GoTo loc_005D031C
  loc_005CFDA7: var_2C = Command1.Caption
  loc_005CFDD7: esi = (var_2C = "Stop") + 1
  loc_005CFDEC: If (var_2C = "Stop") + 1 = 0 Then GoTo loc_005D031C
  loc_005CFE09: Timer2.Interval = 0
  loc_005CFE41: Timer3.Interval = 0
  loc_005CFE79: Timer4.Interval = 0
  loc_005CFEB3: var_2C = Command2.Caption
  loc_005CFEE3: esi = (var_2C = "Unpause") + 1
  loc_005CFEF8: If (var_2C = "Unpause") + 1 = 0 Then GoTo loc_005CFF70
  loc_005CFF14: Command2.Caption = "Pause"
  loc_005CFF4F: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005CFF70: 'Referenced from: 005CFEF8
  loc_005CFF87: Command3.Enabled = True
  loc_005CFFC5: Command2.Enabled = False
  loc_005D0006: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005D0061: var_CC = serverop.Check1.Value
  loc_005D008C: setz al
  loc_005D009C: If eax = 0 Then GoTo loc_005D00DA
  loc_005D00AC: var_30 = "bodini by: spek"
  loc_005D00C0: var_eax = call Proc_79_30_606DE0("$im_on", var_30, var_38)
  loc_005D00D8: GoTo loc_005D00E0
  loc_005D00DA: 'Referenced from: 005D009C
  loc_005D00E0: 'Referenced from: 005D00D8
  loc_005D00FA: Command1.Caption = "Start"
  loc_005D0134: var_eax = call Proc_6098C0(CLng(0.5), var_38, var_30)
  loc_005D014B: var_2C = "•bodini 4.0• server •off•"
  loc_005D0176: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005D01C4: var_2C = "<font face=""tahoma"">" & var_58
  loc_005D01D9: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005D020A: var_eax = call Proc_6098C0(CLng(0.7), var_38, var_38)
  loc_005D022C: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005D026D: var_34 = var_0042EC60 & var_2C & " •completed•"
  loc_005D0298: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005D02F3: var_2C = "<font face=""tahoma"">" & var_58
  loc_005D0308: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_2C, var_38)
  loc_005D031C: 'Referenced from: 005CFD8C
  loc_005D031E: 'Referenced from: 005CF5D5
  loc_005D0327: GoTo loc_005D0373
  loc_005D0372: Exit Sub
  loc_005D0373: 'Referenced from: 005D0327
End Sub