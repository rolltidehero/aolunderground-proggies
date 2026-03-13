Public Sub Proc_79_0_601250
  loc_00601291: var_ret_1 = "AOL Frame25"
  loc_00601294: var_eax = FindWindow(var_ret_1, 0)
  loc_006012BA: var_ret_2 = "MDIClient"
  loc_006012C3: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_006012C8: var_38 = FindWindowEx(var_38, 0, var_ret_2, 0)
  loc_006012D3: var_2C = var_38
  loc_006012E3: var_ret_3 = "AOL Child"
  loc_006012EC: var_eax = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_006012F1: var_38 = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_006012FC: var_30 = var_38
  loc_0060130C: var_ret_4 = "RICHCNTL"
  loc_00601315: var_eax = FindWindowEx(var_38, 0, var_ret_4, 0)
  loc_0060131A: var_38 = FindWindowEx(var_38, 0, var_ret_4, 0)
  loc_00601325: var_18 = var_38
  loc_00601335: var_ret_5 = "RICHCNTL"
  loc_00601340: var_eax = FindWindowEx(var_30, var_38, var_ret_5, 0)
  loc_0060134D: var_20 = FindWindowEx(var_30, var_38, var_ret_5, 0)
  loc_00601360: var_ret_6 = "_AOL_Combobox"
  loc_00601369: var_eax = FindWindowEx(var_30, 0, var_ret_6, 0)
  loc_00601376: var_28 = FindWindowEx(var_30, 0, var_ret_6, 0)
  loc_00601389: var_ret_7 = "_AOL_FontCombo"
  loc_00601392: var_eax = FindWindowEx(var_30, 0, var_ret_7, 0)
  loc_00601397: var_38 = FindWindowEx(var_30, 0, var_ret_7, 0)
  loc_006013A6: If var_18 = 0 Then GoTo loc_006013CD
  loc_006013AD: If var_20 <> 0 Then GoTo loc_006013CD
  loc_006013B4: If var_28 <> 0 Then GoTo loc_006013CD
  loc_006013BB: If var_38 <> 0 Then GoTo loc_006013CD
  loc_006013C5: var_1C = var_30
  loc_006013C8: GoTo loc_006014E5
  loc_006013CD: 'Referenced from: 006013A6
  loc_006013D8: var_ret_8 = "AOL Child"
  loc_006013E3: var_eax = FindWindowEx(var_2C, var_30, var_ret_8, 0)
  loc_006013E8: var_38 = FindWindowEx(var_2C, var_30, var_ret_8, 0)
  loc_006013F3: var_30 = var_38
  loc_00601403: var_ret_9 = "RICHCNTL"
  loc_0060140C: var_eax = FindWindowEx(var_38, 0, var_ret_9, 0)
  loc_00601411: var_38 = FindWindowEx(var_38, 0, var_ret_9, 0)
  loc_0060141C: var_18 = var_38
  loc_0060142C: var_ret_A = "RICHCNTL"
  loc_00601437: var_eax = FindWindowEx(var_30, var_38, var_ret_A, 0)
  loc_00601447: var_20 = FindWindowEx(var_30, var_38, var_ret_A, 0)
  loc_00601457: var_ret_B = "_AOL_Combobox"
  loc_00601460: var_eax = FindWindowEx(var_30, 0, var_ret_B, 0)
  loc_00601470: var_28 = FindWindowEx(var_30, 0, var_ret_B, 0)
  loc_00601480: var_ret_C = "_AOL_FontCombo"
  loc_00601489: var_eax = FindWindowEx(var_30, 0, var_ret_C, 0)
  loc_0060148E: var_38 = FindWindowEx(var_30, 0, var_ret_C, 0)
  loc_0060149D: If var_18 = 0 Then GoTo loc_006014B4
  loc_006014A4: If var_20 <> 0 Then GoTo loc_006014B4
  loc_006014AB: If var_28 <> 0 Then GoTo loc_006014B4
  loc_006014B2: If var_38 = 0 Then GoTo loc_006014C0
  loc_006014B4: 'Referenced from: 0060149D
  loc_006014B9: If var_30 = 0 Then GoTo loc_006014CD
  loc_006014BB: GoTo loc_006013CD
  loc_006014C0: 
  loc_006014C8: var_1C = var_30
  loc_006014CB: GoTo loc_006014E5
  loc_006014CD: 'Referenced from: 006014B9
  loc_006014D9: GoTo loc_006014E5
  loc_006014E4: Exit Sub
  loc_006014E5: 'Referenced from: 006013C8
End Sub