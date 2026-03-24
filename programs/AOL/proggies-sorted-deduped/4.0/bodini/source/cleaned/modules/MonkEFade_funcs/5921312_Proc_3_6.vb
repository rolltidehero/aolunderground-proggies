ï»¿Public Sub Proc_3_6_5A5A20
  loc_005A5A91: var_ret_1 = Len(Hex(arg_C))
  loc_005A5A9D: If var_ret_1 <> 5 Then GoTo loc_005A5AB9
  loc_005A5AB5: var_18 = var_0042E980 & var_18
  loc_005A5AB7: GoTo loc_005A5ABF
  loc_005A5AB9: 'Referenced from: 005A5A9D
  loc_005A5ABF: 'Referenced from: 005A5AB7
  loc_005A5AC3: If var_ret_1 <> 4 Then GoTo loc_005A5AD7
  loc_005A5AD5: var_18 = "00" & var_18
  loc_005A5AD7: 'Referenced from: 005A5AC3
  loc_005A5ADB: If var_ret_1 <> 3 Then GoTo loc_005A5AEF
  loc_005A5AED: var_18 = "000" & var_18
  loc_005A5AEF: 'Referenced from: 005A5ADB
  loc_005A5AF3: If var_ret_1 <> 2 Then GoTo loc_005A5B07
  loc_005A5B05: var_18 = "0000" & var_18
  loc_005A5B07: 'Referenced from: 005A5AF3
  loc_005A5B0B: If var_ret_1 <> 1 Then GoTo loc_005A5B1F
  loc_005A5B1D: var_18 = "00000" & var_18
  loc_005A5B1F: 'Referenced from: 005A5B0B
  loc_005A5B32: var_2C = var_18
  loc_005A5B3D: GoTo loc_005A5B58
  loc_005A5B43: If var_4 = 0 Then GoTo loc_005A5B4E
  loc_005A5B4E: 'Referenced from: 005A5B43
  loc_005A5B57: Exit Sub
  loc_005A5B58: 'Referenced from: 005A5B3D
End Sub