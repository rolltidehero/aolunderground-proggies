Private Sub Timer1_Timer() '5DCC60
  Dim var_0060C67C As Me
  Dim var_74 As Variant
  loc_005DCE13: var_eax = GetCursorPos(var_1C)
  loc_005DCE45: var_2C = GetCursorPos(var_1C)
  loc_005DCE53: var_eax = WindowFromPoint(var_1C, var_18)
  loc_005DCE7F: var_40 = WindowFromPoint(var_1C, var_18)
  loc_005DCEAD: var_3BC = apispy.hWnd
  loc_005DCED2: var_240 = var_3BC
  loc_005DCF19: var_3C0 = apispy.Text1.hWnd
  loc_005DCF46: var_250 = var_3C0
  loc_005DCF65: var_ret_1 = (var_40 = var_3BC)
  loc_005DCF7A: var_ret_2 = (var_40 = var_3C0)
  loc_005DCF84: call Or(var_A8, var_ret_2, var_ret_1, var_74, var_0060C67C, var_0060C67C, 0, %S_eax_S = (#StkVar1%StkVar3 = %StkVar2), Me)
  loc_005DCF9F: If CBool(Or(var_A8, var_ret_2, var_ret_1, var_74, var_0060C67C, var_0060C67C, 0, var_ret_3 <> (#StkVar1%StkVar3 <> %StkVar2), Me)) <> 0 Then GoTo loc_005DD6AB
  loc_005DCFC2: var_70 = Timer1.Tag
  loc_005DCFE3: var_80 = var_70
  loc_005DD019: If (var_40 = var_70) = 0 Then GoTo loc_005DD6AB
  loc_005DD043: var_70 = CStr(var_40)
  loc_005DD049: var_3F4 = var_70
  loc_005DD05D: Timer1.Tag = var_70
  loc_005DD099: var_70 = apispy.GetClsName(CLng(var_40))
  loc_005DD0D2: var_64 = var_70
  loc_005DD0EF: var_70 = apispy.GetWndName(CLng(var_40))
  loc_005DD114: var_6C = var_70
  loc_005DD11E: var_ret_6 = CLng(var_40)
  loc_005DD125: var_eax = GetParent(var_ret_6)
  loc_005DD12A: var_3BC = GetParent(var_ret_6)
  loc_005DD13E: var_30 = var_3BC
  loc_005DD141: If var_3BC <= 0 Then GoTo loc_005DD1BB
  loc_005DD14B: var_70 = apispy.GetClsName(var_3BC)
  loc_005DD17F: var_50 = var_70
  loc_005DD190: var_70 = apispy.GetWndName(var_30)
  loc_005DD1B5: var_68 = var_70
  loc_005DD1BB: 'Referenced from: 005DD141
  loc_005DD1D3: var_2C0 = var_6C
  loc_005DD1DC: var_80 = " Current window > " & var_00433C98
  loc_005DD1E4: var_250 = "vbCrLf"
  loc_005DD1EA: var_290 = "vbCrLf"
  loc_005DD1F0: var_2E0 = "vbCrLf"
  loc_005DD1F6: var_330 = "vbCrLf"
  loc_005DD1FC: var_370 = "vbCrLf"
  loc_005DD205: var_310 = var_30
  loc_005DD253: var_3A0 = var_68
  loc_005DD2FB: var_260 = "   Class name > "
  loc_005DD305: var_2A0 = "   Window name > "
  loc_005DD30F: var_2F0 = " Parent window > "
  loc_005DD323: var_340 = "   Class name > "
  loc_005DD32D: var_380 = "   Window name > "
  loc_005DD3AB: var_108 = " Current window > " & var_00433C98 & var_40 & &H433C98 & "vbCrLf" & "   Class name > " & &H433C98 & var_64 & &H433C98 & "vbCrLf"
  loc_005DD444: var_198 = var_108 & "   Window name > " & &H433C98 & var_6C & &H433C98 & "vbCrLf" & " Parent window > " & &H433C98 & var_30 & &H433C98
  loc_005DD4EB: var_238 = var_198 & "vbCrLf" & "   Class name > " & &H433C98 & var_50 & &H433C98 & "vbCrLf" & "   Window name > " & &H433C98 & var_68 & &H433C98
  loc_005DD5EB: Text1.Text = var_238
  loc_005DD645: var_70 = Text1.Text
  loc_005DD671: Text1.SelStart = Len(var_70)
  loc_005DD6AB: 'Referenced from: 005DCF9F
  loc_005DD6B3: GoTo loc_005DD7A4
  loc_005DD7A3: Exit Sub
  loc_005DD7A4: 'Referenced from: 005DD6B3
End Sub