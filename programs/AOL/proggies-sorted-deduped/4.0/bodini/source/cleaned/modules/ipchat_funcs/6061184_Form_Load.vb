ï»¿Private Sub Form_Load() '5C7C80
  Dim esi As Winsock
  loc_005C7CDA: call __vbaCastObj(Me, var_0042DBEC, edi, Me, __vbaCastObj)
  loc_005C7CED: var_eax = call Proc_60A5D0(var_1C, var_1C, __vbaCastObj(Me, var_0042DBEC, edi, Me, __vbaCastObj))
  loc_005C7D01: call __vbaCastObj(Me, var_0042DBEC)
  loc_005C7D0E: var_eax = call Proc_79_25_605FA0(var_1C, var_1C, __vbaCastObj(Me, var_0042DBEC))
  loc_005C7D37: var_44 = esi
  loc_005C7D61: var_18 = Me
  loc_005C7D6C: var_18 = esi._RemoteHost.BytesReceived
  loc_005C7DB5: GoTo loc_005C7DDD
  loc_005C7DDC: Exit Sub
  loc_005C7DDD: 'Referenced from: 005C7DB5
End Sub