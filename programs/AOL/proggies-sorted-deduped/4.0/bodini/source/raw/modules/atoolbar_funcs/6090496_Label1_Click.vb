Private Sub Label1_Click() '5CEF00
  Dim var_B4 As Screen
  loc_005CEFC1: var_B4 = Global.Screen
  loc_005CEFF5: var_10C = Global.TwipsPerPixelY
  loc_005CF01C: var_108 = Global.MousePointer
  loc_005CF03D: If var_60C000 <> 0 Then GoTo loc_005CF047
  loc_005CF045: GoTo loc_005CF052
  loc_005CF047: 'Referenced from: 005CF03D
  loc_005CF04D: call _adj_fdiv_m32(var_10C, 0, Me, %StkVar1 = CheckObj(%StkVar2, %StkVar3, %StkVar4))
  loc_005CF052: 'Referenced from: 005CF045
  loc_005CF081: var_74 = ((var_108 / var_10C) + &H42200000&H)
  loc_005CF0B7: var_B4 = Global.Screen
  loc_005CF0DD: var_10C = Global.TwipsPerPixelX
  loc_005CF104: var_108 = Global.ActiveControl
  loc_005CF125: If var_60C000 <> 0 Then GoTo loc_005CF12F
  loc_005CF12D: GoTo loc_005CF13A
  loc_005CF12F: 'Referenced from: 005CF125
  loc_005CF135: call _adj_fdiv_m32(var_10C)
  loc_005CF13A: 'Referenced from: 005CF12D
  loc_005CF15D: var_44 = (var_108 / var_10C)
  loc_005CF18D: var_ret_1 = CLng(Me.hWnd)
  loc_005CF190: var_eax = GetMenu(var_ret_1)
  loc_005CF1DC: var_ret_2 = CLng(GetMenu(var_ret_1))
  loc_005CF1DF: var_eax = GetSubMenu(var_ret_2, 0)
  loc_005CF20B: var_64 = GetSubMenu(var_ret_2, 0)
  loc_005CF22B: var_ret_3 = CStr(0)
  loc_005CF23E: var_ret_4 = "AOL FRAME25"
  loc_005CF245: var_eax = FindWindow(var_ret_4, var_ret_3)
  loc_005CF274: var_94 = FindWindow(var_ret_4, var_ret_3)
  loc_005CF2A4: var_ret_5 = "AOL TOOLBAR"
  loc_005CF2B4: var_ret_6 = CLng(var_94)
  loc_005CF2B7: var_eax = FindWindowEx(var_ret_6, 0, var_ret_5, 0)
  loc_005CF2E3: var_24 = FindWindowEx(var_ret_6, 0, var_ret_5, 0)
  loc_005CF2FA: var_ret_7 = CLng(var_94)
  loc_005CF2FD: var_eax = ShowWindow(var_ret_7, 3)
  loc_005CF32C: var_A4 = ShowWindow(var_ret_7, 3)
  loc_005CF3F6: Set var_B4 = Me.mainmenu
  loc_005CF401: var_eax = Unknown_VTable_Call[edi+000002BCh]
  loc_005CF444: GoTo loc_005CF47F
  loc_005CF47E: Exit Sub
  loc_005CF47F: 'Referenced from: 005CF444
  loc_005CF4BB: Exit Sub
End Sub