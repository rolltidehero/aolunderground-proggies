ï»¿Private Sub Form_Load() '5DCB70
  loc_005DCBC3: call __vbaCastObj(Me, var_0042DBEC, __vbaCastObj, Me, ebx)
  loc_005DCBD6: var_eax = call Proc_60A5D0(var_18, var_18, __vbaCastObj(Me, var_0042DBEC, __vbaCastObj, Me, ebx))
  loc_005DCBEA: call __vbaCastObj(Me, var_0042DBEC)
  loc_005DCBF7: var_eax = call Proc_79_25_605FA0(var_18, var_18, __vbaCastObj(Me, var_0042DBEC))
  loc_005DCC08: var_eax = Me.Refresh
  loc_005DCC32: GoTo loc_005DCC3E
  loc_005DCC3D: Exit Sub
  loc_005DCC3E: 'Referenced from: 005DCC32
End Sub