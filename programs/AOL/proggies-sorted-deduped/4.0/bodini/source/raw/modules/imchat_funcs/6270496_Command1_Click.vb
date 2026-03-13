Private Sub Command1_Click() '5FAE20
  Dim var_38 As TextBox
  Dim var_3C As TextBox
  Dim var_CC As TextBox
  loc_005FAECD: var_28 = Text2.Text
  loc_005FAF03: edi = (var_28 = vbNullString) + 1
  loc_005FAF18: If (var_28 <> vbNullString) + 1 <> 0 Then GoTo loc_005FB32A
  loc_005FAF52: var_C0 = List1.ListCount
  loc_005FAF7C: var_C0 = var_C0 - 0001h
  loc_005FAF98: var_A4 = var_C0
  loc_005FAFC6: For var_24 = "" To var_C0 Step 1
  loc_005FAFCF: var_FC = var_F0
  loc_005FAFE7: If var_FC = 0 Then GoTo loc_005FB0DF
  loc_005FB00D: var_24 = CInt(var_28)
  loc_005FB015: var_38 = List1.List(var_24)
  loc_005FB052: var_2C = Text2.Text
  loc_005FB094: var_eax = call Proc_79_30_606DE0(var_28, var_2C, var_3C)
  loc_005FB0CE: Next var_24
  loc_005FB0D4: var_FC = Next var_24
  loc_005FB0DA: GoTo loc_005FAFE1
  loc_005FB0DF: 'Referenced from: 005FAFE7
  loc_005FB0F6: var_CC = var_3C
  loc_005FB11A: var_28 = Text1.Text
  loc_005FB158: Text1.SelStart = Len(var_28)
  loc_005FB1B3: var_CC = var_3C
  loc_005FB1B9: var_eax = call Proc_79_47_609590("vbCrLf", var_3C, var_3C)
  loc_005FB1D1: var_2C = Me & call Proc_79_47_609590("vbCrLf", var_3C, var_3C)
  loc_005FB1E5: var_54 = var_2C & var_00431C88
  loc_005FB1EF: var_4C = Chr(9)
  loc_005FB212: var_30 = Text2.Text
  loc_005FB236: var_74 = var_30
  loc_005FB271: var_34 = CStr(var_2C & var_00431C88 & var_4C & var_30)
  loc_005FB281: Text2.SelText = var_34
  loc_005FB303: Text2.Text = vbNullString
  loc_005FB32A: 'Referenced from: 005FAF18
  loc_005FB332: GoTo loc_005FB37F
  loc_005FB37E: Exit Sub
  loc_005FB37F: 'Referenced from: 005FB332
  loc_005FB3A1: Exit Sub
End Sub