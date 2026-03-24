ï»¿Public Sub Proc_3_1_5A4820
  loc_005A4893: var_24 = Me
  loc_005A48A8: If Len(var_24) <= 8 Then GoTo loc_005A48C5
  loc_005A48C1: var_24 = Right$(var_24, 8)
  loc_005A48C3: GoTo loc_005A48CB
  loc_005A48C5: 'Referenced from: 005A48A8
  loc_005A48CB: 'Referenced from: 005A48C3
  loc_005A48F9: var_AC = Len(var_24)
  loc_005A4930: For var_38 = Len(var_24) To 1 Step -1
  loc_005A493E: If var_D4 = 0 Then GoTo loc_005A4A8D
  loc_005A4953: var_44 = UCase$(var_24)
  loc_005A498F: var_40 = Mid$(0, CLng(var_38), 1)
  loc_005A4992: call Proc_3_2_5A4B20(var_40, 0, ecx = %S_edx_S)
  loc_005A49DB: var_AC = var_28
  loc_005A4A01: var_8C = Len(var_24)
  loc_005A4A48: var_ret_4 = var_40 * 16 ^ Len(var_24) - var_38
  loc_005A4A5D: var_28 + var_ret_4 = CSng()
  loc_005A4A80: Next var_38
  loc_005A4A88: GoTo loc_005A493C
  loc_005A4A8D: 'Referenced from: 005A493E
  loc_005A4A93: GoTo loc_005A4AC8
  loc_005A4AC7: Exit Sub
  loc_005A4AC8: 'Referenced from: 005A4A93
End Sub