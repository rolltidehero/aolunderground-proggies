Private Sub Form_Load() '5A1070
  Dim var_24 As App
  loc_005A10CA: call __vbaCastObj(Me, var_0042DBEC, edi, Me, ebx)
  loc_005A10E1: var_eax = call Proc_60A5D0(var_24, var_24, __vbaCastObj(Me, var_0042DBEC, edi, Me, ebx))
  loc_005A10F5: call __vbaCastObj(Me, var_0042DBEC)
  loc_005A1106: var_eax = call Proc_79_25_605FA0(var_24, var_24, __vbaCastObj(Me, var_0042DBEC))
  loc_005A114F: var_24 = Global.App
  loc_005A1173: var_2C = Global.Revision
  loc_005A11CE: var_20 = "The version of Prophecy 2.0 you are using is build " & CStr(var_2C) & var_0042DCAC
  loc_005A11D5: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005A121C: GoTo loc_005A1246
  loc_005A1245: Exit Sub
  loc_005A1246: 'Referenced from: 005A121C
End Sub