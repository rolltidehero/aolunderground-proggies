Private Sub Form_Load() '5B8AF0
  Dim var_28 As TextBox
  loc_005B8B4A: call __vbaCastObj(Me, var_0042DBEC, edi, Me, ebx)
  loc_005B8B61: var_eax = call Proc_60A5D0(var_28, var_28, __vbaCastObj(Me, var_0042DBEC, edi, Me, ebx))
  loc_005B8B77: call __vbaCastObj(Me, var_0042DBEC)
  loc_005B8B88: var_eax = call Proc_79_25_605FA0(var_28, var_28, __vbaCastObj(Me, var_0042DBEC))
  loc_005B8BB2: var_20 = "bodini.ini"
  loc_005B8BD8: var_eax = call Proc_79_42_6087C0(var_38, "Media Player", "Last Used")
  loc_005B8BE7: var_24 = CStr(var_38)
  loc_005B8BEF: Text1.Text = var_24
  loc_005B8C59: var_18 = Text1.Text
  loc_005B8C8F: edi = (var_18 = vbNullString) + 1
  loc_005B8CA4: If (var_18 = vbNullString) + 1 = 0 Then GoTo loc_005B8CE7
  loc_005B8CC0: Text1.Text = "Choose a file."
  loc_005B8CE7: 'Referenced from: 005B8CA4
  loc_005B8CF3: GoTo loc_005B8D23
  loc_005B8D22: Exit Sub
  loc_005B8D23: 'Referenced from: 005B8CF3
End Sub