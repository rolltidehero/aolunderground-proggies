ï»¿Private Sub Command2_Click() '600740
  Dim var_30 As CommonDialog
  Dim edx As CommonDialog
  Dim var_64 As TextBox
  loc_006007A3: var_48 = "All Files (*.*) |*.*"
  loc_006007F1: edx = CommonDialog._Action
  loc_00600809: On Error Resume Next
  loc_00600816: var_48 = "Open File"
  loc_00600864: var_30 = var_30._Action
  loc_006008C8: Me = CommonDialog._Action
  loc_00600916: var_24 = edx._Action
  loc_00600946: If (var_24 <> vbNullString) <> 0 Then GoTo loc_0060094D
  loc_00600948: GoTo loc_00600A76
  loc_0060094D: 'Referenced from: 00600946
  loc_00600965: If (var_24 <> "*.*") <> 0 Then GoTo loc_0060096C
  loc_00600967: GoTo loc_00600A76
  loc_0060096C: 'Referenced from: 00600965
  loc_00600988: If InStr(1, var_24, var_0042DCAC, 0) <> 0 Then GoTo loc_006009AB
  loc_006009A5: var_24 = var_24 & var_0042DCAC
  loc_006009AB: 'Referenced from: 00600988
  loc_006009BC: Open var_24 For Input As #1 Len = -1
  loc_006009E3: var_64 = var_30
  loc_006009F3: Text1.Text = var_24
  loc_006009FB: var_68 = var_64
  loc_00600A43: Input 1, var_28
  loc_00600A5E: Input 1, var_2C
  loc_00600A70: Close #1
  loc_00600A76: 'Referenced from: 00600948
  loc_00600A82: GoTo loc_00600A97
  loc_00600A96: Exit Sub
  loc_00600A97: 'Referenced from: 00600A82
End Sub