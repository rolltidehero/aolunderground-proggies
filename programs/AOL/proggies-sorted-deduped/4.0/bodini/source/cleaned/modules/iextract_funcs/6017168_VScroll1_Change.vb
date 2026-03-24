ï»¿Private Sub VScroll1_Change() '5BD090
  Dim var_1C As Variant
  loc_005BD0E8: var_eax = DestroyIcon(var_0060C024)
  loc_005BD10E: var_eax = Picture1.Cls
  loc_005BD15B: var_1C = Global.App
  loc_005BD17F: var_28 = Global.hInstance
  loc_005BD1B6: var_24 = VScroll1.Value
  loc_005BD1E4: var_ret_1 = var_0060C028
  loc_005BD1EF: var_eax = ExtractIcon(var_28, var_ret_1, var_24)
  loc_005BD205: var_ret_2 = var_18
  loc_005BD20E: var_60C024 = ExtractIcon(var_28, var_ret_1, var_24)
  loc_005BD244: Picture1.AutoSize = True
  loc_005BD282: Picture1.AutoRedraw = True
  loc_005BD2C2: var_28 = Picture1.hDC
  loc_005BD2EF: var_eax = DrawIcon(var_28, 0, 0, var_0060C024)
  loc_005BD31A: var_eax = Picture1.Refresh
  loc_005BD349: GoTo loc_005BD368
  loc_005BD367: Exit Sub
  loc_005BD368: 'Referenced from: 005BD349
End Sub