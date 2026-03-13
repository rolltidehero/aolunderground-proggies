Public Sub Proc_79_21_605130
  loc_00605171: var_ret_1 = "AOL Frame25"
  loc_00605174: var_eax = FindWindow(var_ret_1, 0)
  loc_0060519A: var_ret_2 = "MDIClient"
  loc_006051A3: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_006051A8: var_3C = FindWindowEx(var_3C, 0, var_ret_2, 0)
  loc_006051B3: var_24 = var_3C
  loc_006051C3: var_ret_3 = "AOL Child"
  loc_006051CC: var_eax = FindWindowEx(var_3C, 0, var_ret_3, 0)
  loc_006051D1: var_3C = FindWindowEx(var_3C, 0, var_ret_3, 0)
  loc_006051DC: var_28 = var_3C
  loc_006051EC: var_ret_4 = "_AOL_Checkbox"
  loc_006051F5: var_eax = FindWindowEx(var_3C, 0, var_ret_4, 0)
  loc_00605205: var_18 = FindWindowEx(var_3C, 0, var_ret_4, 0)
  loc_00605215: var_ret_5 = "_AOL_Static"
  loc_0060521E: var_eax = FindWindowEx(var_28, 0, var_ret_5, 0)
  loc_0060522E: var_14 = FindWindowEx(var_28, 0, var_ret_5, 0)
  loc_0060523E: var_ret_6 = "_AOL_Glyph"
  loc_00605247: var_eax = FindWindowEx(var_28, 0, var_ret_6, 0)
  loc_00605257: var_30 = FindWindowEx(var_28, 0, var_ret_6, 0)
  loc_00605267: var_ret_7 = "_AOL_Icon"
  loc_00605270: var_eax = FindWindowEx(var_28, 0, var_ret_7, 0)
  loc_00605275: var_3C = FindWindowEx(var_28, 0, var_ret_7, 0)
  loc_00605280: var_34 = var_3C
  loc_00605290: var_ret_8 = "_AOL_Icon"
  loc_0060529B: var_eax = FindWindowEx(var_28, var_3C, var_ret_8, 0)
  loc_006052A0: var_3C = FindWindowEx(var_28, var_3C, var_ret_8, 0)
  loc_006052AF: If var_18 = 0 Then GoTo loc_006052DD
  loc_006052B6: If var_14 = 0 Then GoTo loc_006052DD
  loc_006052BD: If var_30 = 0 Then GoTo loc_006052DD
  loc_006052C4: If var_34 = 0 Then GoTo loc_006052DD
  loc_006052CB: If var_3C = 0 Then GoTo loc_006052DD
  loc_006052D5: var_2C = var_28
  loc_006052D8: GoTo loc_00605425
  loc_006052DD: 'Referenced from: 006052AF
  loc_006052E8: var_ret_9 = "AOL Child"
  loc_006052F3: var_eax = FindWindowEx(var_24, var_28, var_ret_9, 0)
  loc_006052F8: var_3C = FindWindowEx(var_24, var_28, var_ret_9, 0)
  loc_00605303: var_28 = var_3C
  loc_00605313: var_ret_A = "_AOL_Checkbox"
  loc_0060531C: var_eax = FindWindowEx(var_3C, 0, var_ret_A, 0)
  loc_0060532C: var_18 = FindWindowEx(var_3C, 0, var_ret_A, 0)
  loc_0060533C: var_ret_B = "_AOL_Static"
  loc_00605345: var_eax = FindWindowEx(var_28, 0, var_ret_B, 0)
  loc_00605355: var_14 = FindWindowEx(var_28, 0, var_ret_B, 0)
  loc_00605365: var_ret_C = "_AOL_Glyph"
  loc_0060536E: var_eax = FindWindowEx(var_28, 0, var_ret_C, 0)
  loc_0060537E: var_30 = FindWindowEx(var_28, 0, var_ret_C, 0)
  loc_0060538E: var_ret_D = "_AOL_Icon"
  loc_00605397: var_eax = FindWindowEx(var_28, 0, var_ret_D, 0)
  loc_0060539C: var_3C = FindWindowEx(var_28, 0, var_ret_D, 0)
  loc_006053A7: var_34 = var_3C
  loc_006053B7: var_ret_E = "_AOL_Icon"
  loc_006053C2: var_eax = FindWindowEx(var_28, var_3C, var_ret_E, 0)
  loc_006053C7: var_3C = FindWindowEx(var_28, var_3C, var_ret_E, 0)
  loc_006053D6: If var_18 = 0 Then GoTo loc_006053F4
  loc_006053DD: If var_14 = 0 Then GoTo loc_006053F4
  loc_006053E4: If var_30 = 0 Then GoTo loc_006053F4
  loc_006053EB: If var_34 = 0 Then GoTo loc_006053F4
  loc_006053F2: If var_3C <> 0 Then GoTo loc_00605400
  loc_006053F4: 'Referenced from: 006053D6
  loc_006053F9: If var_28 = 0 Then GoTo loc_0060540D
  loc_006053FB: GoTo loc_006052DD
  loc_00605400: 
  loc_00605408: var_2C = var_28
  loc_0060540B: GoTo loc_00605425
  loc_0060540D: 'Referenced from: 006053F9
  loc_00605419: GoTo loc_00605425
  loc_00605424: Exit Sub
  loc_00605425: 'Referenced from: 006052D8
End Sub