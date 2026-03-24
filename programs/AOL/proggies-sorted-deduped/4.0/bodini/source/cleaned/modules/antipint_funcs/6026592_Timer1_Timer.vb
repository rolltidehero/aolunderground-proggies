ï»¿Private Sub Timer1_Timer() '5BF560
  loc_005BF5BA: var_ret_1 = "AOL Frame25"
  loc_005BF5BD: var_eax = FindWindow(var_ret_1, var_30)
  loc_005BF5D9: var_1C = FindWindow(var_ret_1, var_30)
  loc_005BF5EB: var_ret_3 = "Invitation From:"
  loc_005BF5F7: var_eax = FindWindowEx(var_1C, 0, 0, var_ret_3)
  loc_005BF602: var_ret_4 = FindWindowEx(var_1C, 0, 0, var_ret_3)
  loc_005BF612: If var_ret_4 = 0 Then GoTo loc_005BF63D
  loc_005BF61E: var_eax = SendMessage(var_ret_4, 16, 0, 0)
  loc_005BF637: var_2C = SendMessage(var_ret_4, 16, 0, 0)
  loc_005BF63D: 'Referenced from: 005BF612
  loc_005BF649: GoTo loc_005BF655
  loc_005BF654: Exit Sub
  loc_005BF655: 'Referenced from: 005BF649
End Sub