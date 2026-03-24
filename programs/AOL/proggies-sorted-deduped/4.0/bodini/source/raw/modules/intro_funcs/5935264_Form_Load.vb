Private Sub Form_Load() '5A90A0
  Dim var_24 As App
  loc_005A9114: var_24 = Global.App
  loc_005A9138: var_18 = Global.Path
  loc_005A9181: var_eax = call Proc_79_51_60A2B0(vbNullString & var_18 & "/intro.wav", 0, @%StkVar2 & %x1)
  loc_005A91B4: call __vbaCastObj(Me, var_0042DBEC)
  loc_005A91C7: var_eax = call Proc_60A5D0(var_24, var_24, __vbaCastObj(Me, var_0042DBEC))
  loc_005A91DA: call __vbaCastObj(Me, var_0042DBEC)
  loc_005A91E7: var_eax = call Proc_79_25_605FA0(var_24, var_24, __vbaCastObj(Me, var_0042DBEC))
  loc_005A91FD: GoTo loc_005A9220
  loc_005A921F: Exit Sub
  loc_005A9220: 'Referenced from: 005A91FD
End Sub