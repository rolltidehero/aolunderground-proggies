Private Sub Form_Load() '5FD270
  Dim var_24 As App
  loc_005FD2E4: var_24 = Global.App
  loc_005FD308: var_18 = Global.Path
  loc_005FD351: var_eax = call Proc_79_51_60A2B0(vbNullString & var_18 & "/greets.wav", 0, @%StkVar2 & %x1)
  loc_005FD384: call __vbaCastObj(Me, var_0042DBEC)
  loc_005FD397: var_eax = call Proc_60A5D0(var_24, var_24, __vbaCastObj(Me, var_0042DBEC))
  loc_005FD3AA: call __vbaCastObj(Me, var_0042DBEC)
  loc_005FD3B7: var_eax = call Proc_79_25_605FA0(var_24, var_24, __vbaCastObj(Me, var_0042DBEC))
  loc_005FD3CD: GoTo loc_005FD3F0
  loc_005FD3EF: Exit Sub
  loc_005FD3F0: 'Referenced from: 005FD3CD
End Sub