Private Sub Check2_Click() '5F2B80
  loc_005F2BE5: var_1C = Check2.Value
  loc_005F2C16: setz al
  loc_005F2C26: If eax = 0 Then GoTo loc_005F2C66
  loc_005F2C43: Check1.Value = CInt(1)
  loc_005F2C66: 'Referenced from: 005F2C26
  loc_005F2C83: var_1C = Check2.Value
  loc_005F2CA7: setz dl
  loc_005F2CB7: If edx = 0 Then GoTo loc_005F2CF7
  loc_005F2CD4: Check1.Value = 0
  loc_005F2CF7: 'Referenced from: 005F2CB7
  loc_005F2D03: GoTo loc_005F2D0F
  loc_005F2D0E: Exit Sub
  loc_005F2D0F: 'Referenced from: 005F2D03
End Sub