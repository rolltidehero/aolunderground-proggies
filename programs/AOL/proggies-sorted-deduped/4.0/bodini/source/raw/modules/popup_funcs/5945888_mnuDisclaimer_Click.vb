Private Sub mnuDisclaimer_Click() '5ABA20
  loc_005ABAB7: var_24 = "I, spek, take no responsibility of what you use this prog for. This prog can be used to cause damage to aol, but it was not made for that intent. America Online, Juno, and any other service I made features for will also not take responsibility. If you click ''Yes'', then you are responsible for your own actions. If you disagree with this and do not accept the terms, click ''No'' and uninstall this prog. Do you agree to my terms?"
  loc_005ABAFB: var_34 = "bodini by: spek"
  loc_005ABB35: var_ret_1 = CLng(CLng(4132))
  loc_005ABB4F: var_CC = MsgBox(var_24, var_ret_1, var_34, var_94, var_A4)
  loc_005ABB5F: var_64 = MsgBox(var_24, var_ret_1, var_34, var_94, var_A4)
  loc_005ABBA2: If (var_64 = 7) = 0 Then GoTo loc_005ABBAA
  loc_005ABBA4: End
  loc_005ABBAA: 'Referenced from: 005ABBA2
  loc_005ABBB2: GoTo loc_005ABBCE
  loc_005ABBCD: Exit Sub
  loc_005ABBCE: 'Referenced from: 005ABBB2
End Sub