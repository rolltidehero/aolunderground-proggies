ï»¿Private Sub Command1_Click() '5C1D50
  Dim var_24 As TextBox
  loc_005C1DAA: 
  loc_005C1DC9: var_18 = Text1.Text
  loc_005C1E1A: var_eax = call Proc_79_35_6076D0("aol://2719:2-2-" & var_18 & vbNullString, var_24, "aol://2719:2-2-" & var_18 & vbNullString)
  loc_005C1E6A: var_18 = Text2.Text
  loc_005C1EA8: call __vbaStrR8
  loc_005C1EE2: var_20 = CStr(Str(Val(__vbaStrR8)))
  loc_005C1EEA: Text2.Text = var_20
  loc_005C1F52: var_eax = call Proc_6098C0(CLng(0.2), , )
  loc_005C1F74: var_18 = Text2.Text
  loc_005C1F9C: fcomp real8 ptr [00402230h]
  loc_005C1FAE: GoTo loc_005C1FB2
  loc_005C1FB2: 'Referenced from: 005C1FAE
  loc_005C1FCC: If eax <> 0 Then GoTo loc_005C1DAA
  loc_005C1FDF: GoTo loc_005C2019
  loc_005C2018: Exit Sub
  loc_005C2019: 'Referenced from: 005C1FDF
  loc_005C2019: Exit Sub
End Sub