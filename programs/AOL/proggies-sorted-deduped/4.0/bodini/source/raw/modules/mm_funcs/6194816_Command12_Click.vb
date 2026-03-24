Private Sub Command12_Click() '5E8680
  loc_005E86E3: var_eax = call Proc_79_19_604D70(edi, Me, ebx)
  loc_005E86EA: If call Proc_79_19_604D70(edi, Me, ebx) <> 0 Then GoTo loc_005E875D
  loc_005E871C: var_30 = "Please enter a chat room to add a room to the mm."
  loc_005E8758: GoTo loc_005E8847
  loc_005E875D: 'Referenced from: 005E86EA
  loc_005E8791: var_eax = call Proc_79_23_605540(var_1C, var_A4, var_1C)
  loc_005E87D7: var_A4 = List1.ListCount
  loc_005E8809: var_18 = CStr(var_A4)
  loc_005E8811: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005E8847: 'Referenced from: 005E8758
  loc_005E884F: GoTo loc_005E8886
  loc_005E8885: Exit Sub
  loc_005E8886: 'Referenced from: 005E884F
End Sub