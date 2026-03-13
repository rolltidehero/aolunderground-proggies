Private Sub Form_Load() '5B6360
  loc_005B63BD: call __vbaCastObj(Me, var_0042DBEC, edi, Me, ebx)
  loc_005B63D4: var_eax = call Proc_60A5D0(var_1C, var_1C, __vbaCastObj(Me, var_0042DBEC, edi, Me, ebx))
  loc_005B63E8: call __vbaCastObj(Me, var_0042DBEC)
  loc_005B63F9: var_eax = call Proc_79_25_605FA0(var_1C, var_1C, __vbaCastObj(Me, var_0042DBEC))
  loc_005B6423: ecx = "NONE"
  loc_005B643D: ecx = &H43134C
  loc_005B6499: var_18 = CStr(Format("", "0."))
  loc_005B64A1: var_eax = Unknown_VTable_Call[ebx+00000054h]
  loc_005B64EA: GoTo loc_005B6516
  loc_005B6515: Exit Sub
  loc_005B6516: 'Referenced from: 005B64EA
End Sub