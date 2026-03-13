Private Sub Command1_Click() '5F38D0
  Dim var_3C As Variant
  Dim var_50 As TextBox
  Dim var_2C As Timer
  loc_005F397A: var_2C = Text1.Text
  loc_005F39B0: esi = (var_2C = vbNullString) + 1
  loc_005F39C5: If (var_2C = vbNullString) + 1 = 0 Then GoTo loc_005F3A3D
  loc_005F39ED: 
  loc_005F3A00: var_50 = "You have to enter a word!"
  loc_005F3A38: GoTo loc_005F45DD
  loc_005F3A3D: 'Referenced from: 005F39C5
  loc_005F3A5A: var_2C = Text2.Text
  loc_005F3A90: esi = (var_2C = vbNullString) + 1
  loc_005F3AA5: If (var_2C = vbNullString) + 1 = 0 Then GoTo loc_005F3B1D
  loc_005F3AE0: var_50 = "You have to enter a clue!"
  loc_005F3B18: GoTo loc_005F45DD
  loc_005F3B1D: 'Referenced from: 005F3AA5
  loc_005F3B3A: var_2C = Text3.Text
  loc_005F3B70: esi = (var_2C = vbNullString) + 1
  loc_005F3B85: If (var_2C = vbNullString) + 1 = 0 Then GoTo loc_005F3BFD
  loc_005F3BC0: var_50 = "You have to scramble the word!"
  loc_005F3BF8: GoTo loc_005F45DD
  loc_005F3BFD: 'Referenced from: 005F3B85
  loc_005F3C1A: var_2C = Text4.Text
  loc_005F3C3E: var_48 = var_2C
  loc_005F3C5D: esi = IsNumeric(var_2C) + 1
  loc_005F3C72: If IsNumeric(var_2C) + 1 = 0 Then GoTo loc_005F3C9F
  loc_005F3C90: var_A8 = "Point value must be a number!"
  loc_005F3C9A: GoTo loc_005F39ED
  loc_005F3C9F: 'Referenced from: 005F3C72
  loc_005F3CD4: var_2C = Text4.Text
  loc_005F3D0A: call __vbaStrR8
  loc_005F3D1B: var_30 = __vbaStrR8
  loc_005F3D27: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005F3D80: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005F3DBE: var_2C = Command1.Caption
  loc_005F3DEE: ebx = (var_2C = "Start") + 1
  loc_005F3E03: If (var_2C = "Start") + 1 = 0 Then GoTo loc_005F4450
  loc_005F3E27: Command1.Caption = "Stop"
  loc_005F3E5A: var_2C = "•bodini 4.0• scrambler bot •spek•"
  loc_005F3E89: var_eax = call Proc_3_4_5A51B0(var_60, var_24, 3)
  loc_005F3ED1: var_2C = "<font face=""tahoma"">" & var_60
  loc_005F3EE6: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F3F17: var_eax = call Proc_6098C0(CLng(0.75), Me, var_3C)
  loc_005F3F37: var_F4 = var_3C
  loc_005F3F3D: var_2C = Text3.Text
  loc_005F3F67: var_48 = var_2C
  loc_005F3FAD: var_A8 = "•word• "
  loc_005F3FE5: var_30 = "•word• " & LCase(0) & &H42EC60
  loc_005F401C: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005F4095: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_A0 & vbNullString, var_24, "<font face=""tahoma"">" & var_A0 & vbNullString)
  loc_005F40C6: var_eax = call Proc_6098C0(CLng(0.75), Me, Unknown_VTable_Call[eax+00000054h])
  loc_005F40EC: var_2C = Text2.Text
  loc_005F4116: var_48 = var_2C
  loc_005F412C: var_60 = LCase(0)
  loc_005F415C: var_A8 = "•clue• "
  loc_005F4194: var_30 = "•clue• " & var_60 & &H42EC60
  loc_005F41CB: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005F422F: var_2C = "<font face=""tahoma"">" & var_A0
  loc_005F4244: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C & vbNullString)
  loc_005F4268: var_E8 = CLng(0.75)
  loc_005F4275: var_eax = call Proc_6098C0(var_E8, Me, Me)
  loc_005F429B: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005F42E6: call __vbaStrR8(var_F0, var_EC, "•points• ", call Proc_6098C0(var_E8, Me, Me), var_2C, var_3C, call Proc_6098C0(var_E8, Me, Me), Me, var_3C)
  loc_005F42F1: var_30 = __vbaStrR8(var_F0, var_EC, "•points• ", call Proc_6098C0(var_E8, Me, Me), var_2C, var_3C, call Proc_6098C0(var_E8, Me, Me), Me, var_3C)
  loc_005F430A: var_38 =  & var_30 & var_0042EC60
  loc_005F4335: var_eax = call Proc_3_4_5A51B0(var_60, var_24, 3)
  loc_005F4392: var_2C = "<font face=""tahoma"">" & var_60
  loc_005F43A7: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, , )
  loc_005F43D8: var_F4 = var_2C
  loc_005F43DE: Timer1.Interval = CInt(10)
  loc_005F4427: Timer2.Interval = CInt(1000)
  loc_005F4477: var_2C = Command1.Caption
  loc_005F44AB: eax = (var_2C = "Start") + 1
  loc_005F44AE: var_FC = (var_2C = "Start") + 1
  loc_005F44CB: If var_FC = 0 Then GoTo loc_005F45DB
  loc_005F44EC: Timer1.Interval = 0
  loc_005F451F: var_2C = "•bodini 4.0• scrambler bot off•"
  loc_005F454E: var_eax = call Proc_3_4_5A51B0(var_60, var_24, 3)
  loc_005F4590: var_2C = "<font face=""tahoma"">" & var_60
  loc_005F45A5: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F45D6: var_eax = call Proc_6098C0(CLng(0.45), Me, var_3C)
  loc_005F45DB: 'Referenced from: 005F44CB
  loc_005F45DD: 'Referenced from: 005F3A38
  loc_005F45E6: GoTo loc_005F463A
  loc_005F4639: Exit Sub
  loc_005F463A: 'Referenced from: 005F45E6
End Sub