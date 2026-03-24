Private Sub Command1_Click() '5A7820
  loc_005A789E: var_eax = call Proc_79_19_604D70(edi, esi, Me)
  loc_005A78BC: var_24 = call Proc_79_19_604D70(edi, esi, Me)
  loc_005A78E6: If (var_24 = "") = 0 Then GoTo loc_005A7985
  loc_005A7928: var_64 = "bodini by: spek"
  loc_005A7947: var_54 = "please enter a chat room"
  loc_005A7985: 'Referenced from: 005A78E6
  loc_005A79A0: Timer1.Enabled = True
  loc_005A79CD: GoTo loc_005A79D2
  loc_005A79CF: 
  loc_005A79D2: 'Referenced from: 005A79CD
  loc_005A79E4: var_3C = "•bodini 4.0• 8-ball bot •spek•"
  loc_005A7A13: var_eax = call Proc_3_4_5A51B0(var_64, var_34, 3)
  loc_005A7A55: var_3C = "<font face=""tahoma"">" & var_64
  loc_005A7A6A: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_34, var_3C)
  loc_005A7A94: var_3C = "•/8ball• and your question•"
  loc_005A7AC3: var_eax = call Proc_3_4_5A51B0(var_64, var_34, 3)
  loc_005A7B05: var_3C = "<font face=""tahoma"">" & var_64
  loc_005A7B1A: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_34, var_3C)
  loc_005A7B43: var_eax = call Proc_6098C0(&H3C, , )
  loc_005A7B68: var_C8 = Timer1.Enabled
  loc_005A7B8C: setnz bl
  loc_005A7B9A: If ebx <> 0 Then GoTo loc_005A79CF
  loc_005A7BAC: GoTo loc_005A7BE9
  loc_005A7BE8: Exit Sub
  loc_005A7BE9: 'Referenced from: 005A7BAC
End Sub