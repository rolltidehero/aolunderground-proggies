ï»¿Public Sub Proc_79_15_603B90
  loc_00603BD7: var_ret_1 = "AOL Frame25"
  loc_00603BDA: var_eax = FindWindow(var_ret_1, var_58)
  loc_00603BF3: var_30 = FindWindow(var_ret_1, var_58)
  loc_00603C06: var_ret_2 = "MDICLIENT"
  loc_00603C0F: var_eax = FindWindowEx(var_30, 0, var_ret_2, 0)
  loc_00603C1C: var_48 = FindWindowEx(var_30, 0, var_ret_2, 0)
  loc_00603C2F: var_ret_3 = "AOL Toolbar"
  loc_00603C38: var_eax = FindWindowEx(var_30, 0, var_ret_3, 0)
  loc_00603C45: var_24 = FindWindowEx(var_30, 0, var_ret_3, 0)
  loc_00603C58: var_ret_4 = "_AOL_Toolbar"
  loc_00603C61: var_eax = FindWindowEx(var_24, 0, var_ret_4, 0)
  loc_00603C6E: var_20 = FindWindowEx(var_24, 0, var_ret_4, 0)
  loc_00603C81: var_ret_5 = "_AOL_Icon"
  loc_00603C8A: var_eax = FindWindowEx(var_20, 0, var_ret_5, 0)
  loc_00603C97: var_50 = FindWindowEx(var_20, 0, var_ret_5, 0)
  loc_00603CAA: var_ret_6 = "_AOL_Icon"
  loc_00603CB5: var_eax = FindWindowEx(var_20, var_50, var_ret_6, 0)
  loc_00603CC5: var_50 = FindWindowEx(var_20, var_50, var_ret_6, 0)
  loc_00603CD7: var_eax = PostMessage(var_50, 513, 0, 0)
  loc_00603CEB: var_eax = PostMessage(var_50, 514, 0, 0)
  loc_00603D07: var_ret_7 = "Write Mail"
  loc_00603D13: var_ret_8 = "AOL Child"
  loc_00603D1C: var_eax = FindWindowEx(var_48, 0, var_ret_8, var_ret_7)
  loc_00603D33: var_1C = FindWindowEx(var_48, 0, var_ret_8, var_ret_7)
  loc_00603D4A: var_ret_9 = "_AOL_Edit"
  loc_00603D53: var_eax = FindWindowEx(var_1C, 0, var_ret_9, 0)
  loc_00603D60: var_44 = FindWindowEx(var_1C, 0, var_ret_9, 0)
  loc_00603D73: var_ret_A = "_AOL_Edit"
  loc_00603D7E: var_eax = FindWindowEx(var_1C, var_44, var_ret_A, 0)
  loc_00603D8E: var_40 = FindWindowEx(var_1C, var_44, var_ret_A, 0)
  loc_00603D9E: var_ret_B = "_AOL_Edit"
  loc_00603DA9: var_eax = FindWindowEx(var_1C, var_40, var_ret_B, 0)
  loc_00603DB9: var_3C = FindWindowEx(var_1C, var_40, var_ret_B, 0)
  loc_00603DC9: var_ret_C = "RICHCNTL"
  loc_00603DD2: var_eax = FindWindowEx(var_1C, 0, var_ret_C, 0)
  loc_00603DE2: var_18 = FindWindowEx(var_1C, 0, var_ret_C, 0)
  loc_00603DF2: var_ret_D = "_AOL_Combobox"
  loc_00603DFB: var_eax = FindWindowEx(var_1C, 0, var_ret_D, 0)
  loc_00603E0B: var_38 = FindWindowEx(var_1C, 0, var_ret_D, 0)
  loc_00603E1B: var_ret_E = "_AOL_Fontcombo"
  loc_00603E24: var_eax = FindWindowEx(var_1C, 0, var_ret_E, 0)
  loc_00603E34: var_4C = FindWindowEx(var_1C, 0, var_ret_E, 0)
  loc_00603E44: var_ret_F = "_AOL_Icon"
  loc_00603E4D: var_eax = FindWindowEx(var_1C, 0, var_ret_F, 0)
  loc_00603E5D: var_28 = FindWindowEx(var_1C, 0, var_ret_F, 0)
  loc_00603E6D: var_ret_10 = "_AOL_Icon"
  loc_00603E78: var_eax = FindWindowEx(var_1C, var_28, var_ret_10, 0)
  loc_00603E85: var_2C = FindWindowEx(var_1C, var_28, var_ret_10, 0)
  loc_00603E98: var_ret_11 = "_AOL_Icon"
  loc_00603EA1: var_eax = FindWindowEx(var_1C, 0, var_ret_11, 0)
  loc_00603EAE: var_54 = FindWindowEx(var_1C, 0, var_ret_11, 0)
  loc_00603EBD: 
  loc_00603EC7: If var_14 > 13 Then GoTo loc_00603F09
  loc_00603ED4: var_ret_12 = "_AOL_Icon"
  loc_00603EDF: var_eax = FindWindowEx(var_1C, var_54, var_ret_12, 0)
  loc_00603EEF: var_54 = FindWindowEx(var_1C, var_54, var_ret_12, 0)
  loc_00603EFC: 00000001h = 00000001h + var_14
  loc_00603F07: GoTo loc_00603EBD
  loc_00603F09: 'Referenced from: 00603EC7
  loc_00603F1C: var_58 = CStr(0)
  loc_00603F44: var_60 = var_58 & CStr(var_54)
  loc_00603F51: fcomp real8 ptr var_7C
  loc_00603F60: GoTo loc_00603F64
  loc_00603F64: 'Referenced from: 00603F60
  loc_00603F73: setnz dl
  loc_00603F80: setnz al
  loc_00603F8B: setnz al
  loc_00603F99: setnz cl
  loc_00603FA7: setnz al
  loc_00603FB5: setnz cl
  loc_00603FC3: setnz al
  loc_00603FD1: setnz cl
  loc_00603FDF: setnz al
  loc_00603FEB: var_68 = Not (eax)
  loc_00604007: If var_68 <> 0 Then GoTo loc_00603CF8
  loc_00604022: var_eax = SendMessage(var_44, 12, 0, Me)
  loc_00604031: var_ret_14 = var_58
  loc_00604057: var_eax = SendMessage(var_3C, 12, 0, arg_C)
  loc_00604066: var_ret_16 = var_58
  loc_0060408C: var_eax = SendMessage(var_18, 12, 0, arg_10)
  loc_0060409B: var_ret_18 = var_58
  loc_006040C1: var_eax = call Proc_6098C0(CLng(0.1), , )
  loc_006040DC: var_eax = SendMessage(var_54, 513, 0, 0)
  loc_006040F8: var_eax = SendMessage(var_54, 514, 0, 0)
  loc_0060410C: var_eax = call Proc_6098C0(1, , )
  loc_00604117: GoTo loc_00604131
  loc_00604130: Exit Sub
  loc_00604131: 'Referenced from: 00604117
End Sub