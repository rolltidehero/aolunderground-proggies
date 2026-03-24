ï»¿Private Sub Form_Load() '5FBA70
  loc_005FBAC3: call __vbaCastObj(Me, var_0042DBEC, __vbaCastObj, Me, ebx)
  loc_005FBAD6: var_eax = call Proc_60A5D0(var_18, var_18, __vbaCastObj(Me, var_0042DBEC, __vbaCastObj, Me, ebx))
  loc_005FBAEA: call __vbaCastObj(Me, var_0042DBEC)
  loc_005FBAF7: var_eax = call Proc_79_25_605FA0(var_18, var_18, __vbaCastObj(Me, var_0042DBEC))
  loc_005FBB1C: Timer1.Enabled = True
  loc_005FBB56: Timer2.Enabled = True
  loc_005FBB7F: GoTo loc_005FBB8B
  loc_005FBB8A: Exit Sub
  loc_005FBB8B: 'Referenced from: 005FBB7F
End Sub