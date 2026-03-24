ï»¿Private Sub Form_Load() '5CB920
  loc_005CB9D3: var_eax = call Proc_79_23_605540(var_34, FFFFFFFFh, var_34)
  loc_005CB9FC: var_eax = call Proc_6098C0(1, Me, Me)
  loc_005CBA07: call __vbaCastObj(Me, var_0042DBEC, esi, Set %StkVar1 = %StkVar2 'Ignore this)
  loc_005CBA18: call Proc_60A5D0(var_34, var_34, __vbaCastObj(Me, var_0042DBEC, esi, Set %StkVar1 = %StkVar2)
  loc_005CBA2C: call __vbaCastObj(Me, var_0042DBEC)
  loc_005CBA3D: var_eax = call Proc_79_25_605FA0(var_34, var_34, __vbaCastObj(Me, var_0042DBEC))
  loc_005CBA85: var_58 = "bodini by: spek"
  loc_005CBA9D: var_48 = "This will be improved on greatly in upcoming beta's of bodini!"
  loc_005CBAE2: var_2C = "â¢bodini 4.0â¢ m-chat â¢spekâ¢"
  loc_005CBB11: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005CBB5B: var_2C = "<font face=""tahoma"">" & var_58
  loc_005CBB70: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005CBB90: GoTo loc_005CBBCE
  loc_005CBBCD: Exit Sub
  loc_005CBBCE: 'Referenced from: 005CBB90
End Sub