ï»¿Private Sub Form_Load() '5DDE60
  Dim var_18 As ListBox
  loc_005DDEE7: var_eax = List1.AddItem "About Me", var_1C
  loc_005DDF25: var_3C = List1.AddItem "About Me", var_1C
  loc_005DDF54: var_eax = List1.AddItem "Clear History", var_1C
  loc_005DDF8F: var_40 = var_18
  loc_005DDFBE: var_eax = List1.AddItem "Help", var_1C
  loc_005DDFF9: var_44 = var_18
  loc_005DE028: var_eax = List1.AddItem "Idle Bot", var_1C
  loc_005DE063: var_48 = var_18
  loc_005DE092: var_eax = List1.AddItem "Mass Mailer", var_1C
  loc_005DE0CD: var_4C = var_18
  loc_005DE0FC: var_eax = List1.AddItem "Server", var_1C
  loc_005DE137: var_50 = var_18
  loc_005DE166: var_eax = List1.AddItem "Greets", var_1C
  loc_005DE1A1: var_54 = var_18
  loc_005DE1D0: var_eax = List1.AddItem "Upchat", var_1C
  loc_005DE20B: var_58 = var_18
  loc_005DE23A: var_eax = List1.AddItem "UnUpchat", var_1C
  loc_005DE275: var_5C = var_18
  loc_005DE2A4: var_eax = List1.AddItem "Secret Area", var_1C
  loc_005DE30D: var_eax = List1.AddItem "Encrypter", var_1C
  loc_005DE34D: List1.Selected = 0
  loc_005DE379: call __vbaCastObj(Me, var_0042DBEC, FFFFFFFFh, var_18, List1.AddItem "Encrypter", var_1C, Me)
  loc_005DE38A: var_eax = call Proc_60A5D0(var_18, var_18, __vbaCastObj(Me, var_0042DBEC, FFFFFFFFh, var_18, List1.AddItem "Encrypter", var_1C, Me))
  loc_005DE39A: call __vbaCastObj(Me, var_0042DBEC)
  loc_005DE3AB: var_eax = call Proc_79_25_605FA0(var_18, var_18, __vbaCastObj(Me, var_0042DBEC))
  loc_005DE3C1: GoTo loc_005DE3CD
  loc_005DE3CC: Exit Sub
  loc_005DE3CD: 'Referenced from: 005DE3C1
End Sub