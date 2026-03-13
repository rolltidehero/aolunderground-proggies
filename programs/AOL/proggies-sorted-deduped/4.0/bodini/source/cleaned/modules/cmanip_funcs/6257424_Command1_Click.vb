ï»¿Private Sub Command1_Click() '5F7B10
  loc_005F7BAA: var_ret_1 = "AOL Frame25"
  loc_005F7BB1: var_eax = FindWindow(var_ret_1, 0)
  loc_005F7BD7: var_ret_2 = "MDIClient"
  loc_005F7BE6: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), esi, var_ret_2, 0)
  loc_005F7C06: var_ret_3 = "AOL Child"
  loc_005F7C15: var_eax = FindWindowEx(FindWindowEx(var_F8, esi, var_ret_2, 0), esi, var_ret_3, 0)
  loc_005F7C35: var_ret_4 = "RICHCNTL"
  loc_005F7C44: var_eax = FindWindowEx(FindWindowEx(var_F8, esi, var_ret_3, 0), esi, var_ret_4, 0)
  loc_005F7C49: var_F8 = FindWindowEx(var_F8, esi, var_ret_4, 0)
  loc_005F7C60: var_54 = Chr(13)
  loc_005F7C6C: var_64 = Chr(9)
  loc_005F7C93: var_30 = Text1.Text
  loc_005F7CC0: var_7C = var_30
  loc_005F7CE4: var_B4 = Chr(9)
  loc_005F7D07: var_34 = Text2.Text
  loc_005F7D31: var_CC = var_34
  loc_005F7DB4: var_eax = SendMessage(var_F8, 12, esi, CStr(var_54 & var_64 & var_30 & &H431C88 & var_B4 & var_34))
  loc_005F7E2C: var_eax = SendMessage(var_F8, 258, 13, esi)
  loc_005F7E3B: GoTo loc_005F7EAE
  loc_005F7EAD: Exit Sub
  loc_005F7EAE: 'Referenced from: 005F7E3B
End Sub