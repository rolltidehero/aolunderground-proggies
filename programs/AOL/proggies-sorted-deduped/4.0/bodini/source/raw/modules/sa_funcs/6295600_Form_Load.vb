Private Sub Form_Load() '601030
  loc_006010B4: call __vbaCastObj(var_0060C060, var_0042DBEC, 0, __vbaCastObj, ebx)
  loc_006010C7: var_eax = call Proc_60A630(var_18, var_18, __vbaCastObj(var_0060C060, var_0042DBEC, 0, __vbaCastObj, ebx))
  loc_006010D5: call __vbaCastObj(var_18, var_0042E350)
  loc_00601114: var_38 = "bodini by: spek"
  loc_0060112E: var_28 = "The password must be typed EXACTLY right!!!"
  loc_0060118B: call __vbaCastObj(var_0060C060, var_0042DBEC, vbNullString, __vbaCastObj(var_18, var_0042E350))
  loc_00601198: var_eax = call Proc_60A5D0(var_18, var_18, __vbaCastObj(var_0060C060, var_0042DBEC, vbNullString, __vbaCastObj(var_18, var_0042E350)))
  loc_006011A6: call __vbaCastObj(var_18, var_0042E350)
  loc_006011BE: call __vbaCastObj(Me, var_0042DBEC, vbNullString, __vbaCastObj(var_18, var_0042E350))
  loc_006011CB: var_eax = call Proc_60A5D0(var_18, var_18, __vbaCastObj(Me, var_0042DBEC, vbNullString, __vbaCastObj(var_18, var_0042E350)))
  loc_006011DE: call __vbaCastObj(Me, var_0042DBEC)
  loc_006011EB: var_eax = call Proc_79_25_605FA0(var_18, var_18, __vbaCastObj(Me, var_0042DBEC))
  loc_00601201: GoTo loc_00601228
  loc_00601227: Exit Sub
  loc_00601228: 'Referenced from: 00601201
End Sub