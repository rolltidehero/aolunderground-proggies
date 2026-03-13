ï»¿Public Sub Proc_79_16_604150
  Dim var_70 As Screen
  Dim var_74 As Screen
  loc_006041A6: var_ret_1 = "AOL Frame25"
  loc_006041A9: var_eax = FindWindow(var_ret_1, 0)
  loc_006041C5: var_3C = FindWindow(var_ret_1, 0)
  loc_006041D5: var_ret_2 = "MDICLIENT"
  loc_006041DE: var_eax = FindWindowEx(var_3C, 0, var_ret_2, 0)
  loc_006041EE: var_48 = FindWindowEx(var_3C, 0, var_ret_2, 0)
  loc_006041FE: var_ret_3 = "AOL Toolbar"
  loc_00604207: var_eax = FindWindowEx(var_3C, 0, var_ret_3, 0)
  loc_00604217: var_28 = FindWindowEx(var_3C, 0, var_ret_3, 0)
  loc_00604227: var_ret_4 = "_AOL_Toolbar"
  loc_00604230: var_eax = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_00604240: var_24 = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_00604250: var_ret_5 = "_AOL_Icon"
  loc_00604259: var_eax = FindWindowEx(var_24, 0, var_ret_5, 0)
  loc_00604269: var_5C = FindWindowEx(var_24, 0, var_ret_5, 0)
  loc_00604279: var_ret_6 = "_AOL_Icon"
  loc_00604284: var_eax = FindWindowEx(var_24, var_5C, var_ret_6, 0)
  loc_00604294: var_5C = FindWindowEx(var_24, var_5C, var_ret_6, 0)
  loc_006042A4: var_ret_7 = "_AOL_Icon"
  loc_006042AF: var_eax = FindWindowEx(var_24, var_5C, var_ret_7, 0)
  loc_006042BC: var_5C = FindWindowEx(var_24, var_5C, var_ret_7, 0)
  loc_006042CF: var_ret_8 = "_AOL_Icon"
  loc_006042DA: var_eax = FindWindowEx(var_24, var_5C, var_ret_8, 0)
  loc_006042EA: var_5C = FindWindowEx(var_24, var_5C, var_ret_8, 0)
  loc_006042FA: var_ret_9 = "_AOL_Icon"
  loc_00604305: var_eax = FindWindowEx(var_24, var_5C, var_ret_9, 0)
  loc_00604315: var_5C = FindWindowEx(var_24, var_5C, var_ret_9, 0)
  loc_00604325: var_ret_A = "_AOL_Icon"
  loc_00604330: var_eax = FindWindowEx(var_24, var_5C, var_ret_A, 0)
  loc_0060433D: var_5C = FindWindowEx(var_24, var_5C, var_ret_A, 0)
  loc_00604349: var_eax = GetCursorPos(var_38)
  loc_00604378: var_70 = Global.Screen
  loc_006043A3: var_78 = Global.Width
  loc_006043F2: var_74 = Global.Screen
  loc_00604420: var_7C = Global.Height
  loc_00604452: var_eax = SetCursorPos(CLng(var_78), CLng(var_7C))
  loc_00604479: var_eax = PostMessage(var_5C, 513, 0, 0)
  loc_0060448D: var_eax = PostMessage(var_5C, 514, 0, 0)
  loc_00604494: 
  loc_0060449F: var_ret_B = "#32768"
  loc_006044A2: var_eax = FindWindow(var_ret_B, 0)
  loc_006044B2: var_54 = FindWindow(var_ret_B, 0)
  loc_006044BB: var_eax = IsWindowVisible(var_54)
  loc_006044C0: var_78 = IsWindowVisible(var_54)
  loc_006044C9: If var_78 <> 1 Then GoTo loc_00604494
  loc_006044D0: 
  loc_006044D9: If 00000001h > 3 Then GoTo loc_00604512
  loc_006044E6: var_eax = PostMessage(var_54, 256, 40, 0)
  loc_006044FA: var_eax = PostMessage(var_54, 257, 40, 0)
  loc_00604506: 00000001h = 00000001h + 00000001h
  loc_00604510: GoTo loc_006044D0
  loc_00604512: 'Referenced from: 006044D9
  loc_0060451D: var_eax = PostMessage(var_54, 256, 13, )
  loc_0060452E: var_eax = PostMessage(var_54, 257, 13, 0)
  loc_0060453D: var_eax = SetCursorPos(var_38, var_34)
  loc_00604559: var_ret_C = "Preferences"
  loc_00604565: var_ret_D = "AOL Child"
  loc_0060456E: var_eax = FindWindowEx(var_48, 0, var_ret_D, var_ret_C)
  loc_00604585: var_64 = FindWindowEx(var_48, 0, var_ret_D, var_ret_C)
  loc_00604596: var_ret_E = "General"
  loc_006045A2: var_ret_F = "_AOL_Static"
  loc_006045AB: var_eax = FindWindowEx(var_64, 0, var_ret_F, var_ret_E)
  loc_006045C2: var_50 = FindWindowEx(var_64, 0, var_ret_F, var_ret_E)
  loc_006045D3: var_ret_10 = "Mail"
  loc_006045DF: var_ret_11 = "_AOL_Static"
  loc_006045E8: var_eax = FindWindowEx(var_64, 0, var_ret_11, var_ret_10)
  loc_006045FF: var_60 = FindWindowEx(var_64, 0, var_ret_11, var_ret_10)
  loc_00604610: var_ret_12 = "Font"
  loc_0060461C: var_ret_13 = "_AOL_Static"
  loc_00604625: var_eax = FindWindowEx(var_64, 0, var_ret_13, var_ret_12)
  loc_0060463C: var_4C = FindWindowEx(var_64, 0, var_ret_13, var_ret_12)
  loc_0060464D: var_ret_14 = "Marketing"
  loc_00604659: var_ret_15 = "_AOL_Static"
  loc_00604662: var_eax = FindWindowEx(var_64, 0, var_ret_15, var_ret_14)
  loc_00604679: var_2C = FindWindowEx(var_64, 0, var_ret_15, var_ret_14)
  loc_00604686: If var_64 = 0 Then GoTo loc_0060454A
  loc_00604691: If var_50 = 0 Then GoTo loc_0060454A
  loc_0060469C: If var_60 = 0 Then GoTo loc_0060454A
  loc_006046A7: If var_4C = 0 Then GoTo loc_0060454A
  loc_006046B2: If var_2C = 0 Then GoTo loc_0060454A
  loc_006046C3: var_ret_16 = "_AOL_Icon"
  loc_006046CC: var_eax = FindWindowEx(var_64, 0, var_ret_16, 0)
  loc_006046D9: var_30 = FindWindowEx(var_64, 0, var_ret_16, 0)
  loc_006046F0: var_ret_17 = "_AOL_Icon"
  loc_006046FB: var_eax = FindWindowEx(var_64, var_30, var_ret_17, 0)
  loc_0060470B: var_30 = FindWindowEx(var_64, var_30, var_ret_17, 0)
  loc_0060471F: var_ret_18 = "_AOL_Icon"
  loc_0060472A: var_eax = FindWindowEx(var_64, var_30, var_ret_18, 0)
  loc_0060473A: var_30 = FindWindowEx(var_64, var_30, var_ret_18, 0)
  loc_0060475F: var_eax = SendMessage(var_30, 513, 0, 0)
  loc_0060477C: var_eax = SendMessage(var_30, 514, 0, 0)
  loc_0060478C: var_ret_19 = "Mail Preferences"
  loc_00604798: var_ret_1A = "_AOL_Modal"
  loc_0060479B: var_eax = FindWindow(var_ret_1A, var_ret_19)
  loc_006047B2: var_58 = FindWindow(var_ret_1A, var_ret_19)
  loc_006047CD: var_eax = call Proc_6098C0(CLng(0.6), , )
  loc_006047D7: If var_58 = 0 Then GoTo loc_00604743
  loc_006047E8: var_ret_1B = "_AOL_Checkbox"
  loc_006047F1: var_eax = FindWindowEx(var_58, 0, var_ret_1B, 0)
  loc_006047FE: var_20 = FindWindowEx(var_58, 0, var_ret_1B, 0)
  loc_00604815: var_ret_1C = "_AOL_Checkbox"
  loc_00604820: var_eax = FindWindowEx(var_58, var_20, var_ret_1C, 0)
  loc_00604830: var_1C = FindWindowEx(var_58, var_20, var_ret_1C, 0)
  loc_00604844: var_ret_1D = "_AOL_Checkbox"
  loc_0060484F: var_eax = FindWindowEx(var_58, var_1C, var_ret_1D, 0)
  loc_0060485F: var_40 = FindWindowEx(var_58, var_1C, var_ret_1D, 0)
  loc_00604873: var_ret_1E = "_AOL_Checkbox"
  loc_0060487E: var_eax = FindWindowEx(var_58, var_40, var_ret_1E, 0)
  loc_0060488B: var_40 = FindWindowEx(var_58, var_40, var_ret_1E, 0)
  loc_006048A2: var_ret_1F = "_AOL_Checkbox"
  loc_006048AD: var_eax = FindWindowEx(var_58, var_40, var_ret_1F, 0)
  loc_006048BD: var_40 = FindWindowEx(var_58, var_40, var_ret_1F, 0)
  loc_006048D1: var_ret_20 = "_AOL_Checkbox"
  loc_006048DC: var_eax = FindWindowEx(var_58, var_40, var_ret_20, 0)
  loc_00604900: var_ret_21 = "_AOL_icon"
  loc_00604909: var_eax = FindWindowEx(var_58, 0, var_ret_21, 0)
  loc_0060490E: var_78 = FindWindowEx(var_58, 0, var_ret_21, 0)
  loc_00604919: var_14 = var_78
  loc_00604927: var_68 =
  loc_00604932: var_ret_22 = var_78
  loc_00604943: var_eax = SendMessage(var_20, 241, 0, var_6C)
  loc_0060497A: var_eax = SendMessage(var_1C, 241, -1, var_6C)
  loc_00604995: var_68 =
  loc_006049A0: var_ret_24 = var_6C
  loc_006049B2: var_eax = SendMessage(FindWindowEx(var_58, var_40, var_ret_20, 0), 241, edi, var_6C)
  loc_006049D9: var_eax = SendMessage(var_14, 513, edi, var_78)
  loc_006049EE: var_eax = SendMessage(var_14, 514, edi, var_78)
  loc_00604A03: var_eax = PostMessage(var_64, 16, edi, edi)
  loc_00604A10: GoTo loc_00604A36
  loc_00604A35: Exit Sub
  loc_00604A36: 'Referenced from: 00604A10
End Sub