Private Sub Form_Load() '5DF0C0
  Dim var_18 As TextBox
  loc_005DF13B: var_20 = "bodini.ini"
  loc_005DF161: var_eax = call Proc_79_42_6087C0(var_38, "Mass Mailer", "Bot Time")
  loc_005DF170: var_24 = CStr(var_38)
  loc_005DF17D: Text1.Text = var_24
  loc_005DF1E9: var_20 = "bodini.ini"
  loc_005DF20F: var_eax = call Proc_79_42_6087C0(var_38, "Mass Mailer", "Bot Add")
  loc_005DF21E: var_24 = CStr(var_38)
  loc_005DF22B: Text2.Text = var_24
  loc_005DF294: var_20 = "bodini.ini"
  loc_005DF2A8: var_18 = "Mass Mailer"
  loc_005DF2BA: var_eax = call Proc_79_42_6087C0(var_38, var_18, "Bot Remove")
  loc_005DF2C9: var_24 = CStr(var_38)
  loc_005DF2D1: Text3.Text = var_24
  loc_005DF32A: call __vbaCastObj(Me, var_0042DBEC)
  loc_005DF33B: var_eax = call Proc_60A5D0(var_28, var_28, __vbaCastObj(Me, var_0042DBEC))
  loc_005DF34B: call __vbaCastObj(Me, var_0042DBEC)
  loc_005DF35C: var_eax = call Proc_79_25_605FA0(var_28, var_28, __vbaCastObj(Me, var_0042DBEC))
  loc_005DF372: GoTo loc_005DF3A2
  loc_005DF3A1: Exit Sub
  loc_005DF3A2: 'Referenced from: 005DF372
End Sub