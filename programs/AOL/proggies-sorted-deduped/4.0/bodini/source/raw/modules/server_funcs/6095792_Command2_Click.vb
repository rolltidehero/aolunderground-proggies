Private Sub Command2_Click() '5D03B0
  Dim var_34 As CommandButton
  loc_005D042A: var_2C = Command2.Caption
  loc_005D045A: edi = (var_2C = "Pause") + 1
  loc_005D0474: If (var_2C = "Pause") + 1 = 0 Then GoTo loc_005D0668
  loc_005D0495: Command2.Caption = "Unpause"
  loc_005D04D0: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005D0502: var_2C = "•bodini 4.0• server •paused•"
  loc_005D052A: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005D0578: var_2C = "<font face=""tahoma"">" & var_54
  loc_005D058D: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005D05B4: var_2C = "•still accepting requests•"
  loc_005D05DC: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005D061E: var_2C = "<font face=""tahoma"">" & var_54
  loc_005D0633: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005D0657: var_6C = CLng(0.5)
  loc_005D065E: var_eax = call Proc_6098C0(var_6C, Me, var_34)
  loc_005D0663: GoTo loc_005D07F5
  loc_005D0682: var_2C = Command2.Caption
  loc_005D06B2: edi = (var_2C = "Unpause") + 1
  loc_005D06C3: If (var_2C = "Unpause") + 1 = 0 Then GoTo loc_005D07F5
  loc_005D06E7: Command2.Caption = "Pause"
  loc_005D0702: var_34 = edi
  loc_005D0722: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005D073D: var_34 = esi
  loc_005D074E: var_2C = "•bodini 4.0• server •unpaused•"
  loc_005D077A: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005D07C8: var_2C = "<font face=""tahoma"">" & var_54
  loc_005D07DD: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005D07F5: 'Referenced from: 005D0663
  loc_005D0802: GoTo loc_005D0834
  loc_005D0833: Exit Sub
  loc_005D0834: 'Referenced from: 005D0802
End Sub