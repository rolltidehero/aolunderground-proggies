ï»¿Public Sub Proc_79_52_60A380
  loc_0060A3E1: var_eax = call Proc_79_38_607B50(edi, esi, ebx)
  loc_0060A404: var_4C = Left$(call Proc_79_38_607B50(edi, esi, ebx), 11)
  loc_0060A456: For var_24 = 1 To 11 Step 1
  loc_0060A464: If var_24 = 0 Then GoTo loc_0060A527
  loc_0060A492: var_50 = Mid$(var_4C, CLng(var_24), 1)
  loc_0060A4A9: esi = (var_50 = var_00431C88) + 1
  loc_0060A4BE: If (var_50 = var_00431C88) + 1 = 0 Then GoTo loc_0060A504
  loc_0060A4FE: var_34 = Left$(var_4C, CLng(var_24 - 1))
  loc_0060A504: 'Referenced from: 0060A4BE
  loc_0060A516: Next var_24
  loc_0060A522: GoTo loc_0060A462
  loc_0060A527: 'Referenced from: 0060A464
  loc_0060A52D: var_44 = var_34
  loc_0060A538: GoTo loc_0060A566
  loc_0060A53E: If var_4 = 0 Then GoTo loc_0060A549
  loc_0060A549: 'Referenced from: 0060A53E
  loc_0060A565: Exit Sub
  loc_0060A566: 'Referenced from: 0060A538
End Sub