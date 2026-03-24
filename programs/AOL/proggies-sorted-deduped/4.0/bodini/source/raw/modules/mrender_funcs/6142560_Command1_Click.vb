Private Sub Command1_Click() '5DBA60
  Dim var_40 As Variant
  Dim var_58 As TextBox
  Dim var_44 As TextBox
  loc_005DBAE4: var_48 = Picture1.ScaleWidth
  loc_005DBB08: fcomp real4 ptr var_48
  loc_005DBB17: GoTo loc_005DBB1B
  loc_005DBB1B: 'Referenced from: 005DBB17
  loc_005DBB29: If di = 0 Then GoTo loc_005DBB87
  loc_005DBB44: var_48 = Picture1.ScaleWidth
  loc_005DBB7E: var_24 = CInt((var_48 - 1))
  loc_005DBB87: 'Referenced from: 005DBB29
  loc_005DBBA0: var_48 = Picture1.ScaleHeight
  loc_005DBBC4: fcomp real4 ptr var_48
  loc_005DBBD3: GoTo loc_005DBBD7
  loc_005DBBD7: 'Referenced from: 005DBBD3
  loc_005DBBE8: If eax = 0 Then GoTo loc_005DBC36
  loc_005DBC03: var_48 = Picture1.ScaleHeight
  loc_005DBC2D: var_18 = CInt(var_48)
  loc_005DBC36: 'Referenced from: 005DBBE8
  loc_005DBC67: Picture1.BackColor = RGB(255, 255, 255)
  loc_005DBCB0: Picture1.ForeColor = RGB(0, 0, 0)
  loc_005DBCE8: Picture1.ScaleMode = CInt(3)
  loc_005DBD29: Text1.FontName = "Arial"
  loc_005DBD6A: Text1.FontSize = var_41200000
  loc_005DBDAB: Text1.Text = vbNullString
  loc_005DBDE0: 
  loc_005DBDE8: If var_1C > 0 Then GoTo loc_005DC2A2
  loc_005DBDF5: 
  loc_005DBE00: If var_28 > 0 Then GoTo loc_005DC1A1
  loc_005DBE1C: var_48 = Picture1.hDC
  loc_005DBE48: var_eax = GetPixel(var_48, var_28, var_1C)
  loc_005DBE6C: If GetPixel(var_48, var_28, var_1C) > 0 Then GoTo loc_005DBF28
  loc_005DBE9E: var_2C = Text1.Text
  loc_005DBED5: var_30 = var_2C & var_00435488
  loc_005DBEE2: Text1.Text = var_30
  loc_005DBF23: var_eax = Unknown_16D80(var_40, var_1C, Me)
  loc_005DBF28: 'Referenced from: 005DBE6C
  loc_005DBF3F: If var_58 > 0 Then GoTo loc_005DC005
  loc_005DBF55: var_58 = RGB(180, 180, 180)
  loc_005DBF71: var_2C = Text1.Text
  loc_005DBFBF: Text1.Text = var_2C & var_00431C88
  loc_005DC000: var_eax = Unknown_16D80(var_40, esi)
  loc_005DC005: 'Referenced from: 005DBF3F
  loc_005DC01C: If var_58 > 0 Then GoTo loc_005DC0D8
  loc_005DC035: var_58 = var_44
  loc_005DC04E: var_2C = Text1.Text
  loc_005DC085: var_30 = var_2C & var_0042DCAC
  loc_005DC092: Text1.Text = var_30
  loc_005DC0D3: var_eax = Unknown_16D80(Me)
  loc_005DC0D8: 'Referenced from: 005DC01C
  loc_005DC107: var_2C = Text1.Text
  loc_005DC13B: var_30 = var_2C & var_0043134C
  loc_005DC143: Text1.Text = var_30
  loc_005DC18F: 00000001h = 00000001h + var_28
  loc_005DC19C: GoTo loc_005DBDF5
  loc_005DC1B1: var_58 = var_44
  loc_005DC1CA: var_2C = Text1.Text
  loc_005DC236: var_3C = var_2C & Chr$(13) & Chr$(10)
  loc_005DC243: Text1.Text = var_3C
  loc_005DC29A: var_1C = var_60 + var_1C
  loc_005DC29D: GoTo loc_005DBDE0
  loc_005DC2A2: 'Referenced from: 005DBDE8
  loc_005DC2AF: GoTo loc_005DC2E1
  loc_005DC2E0: Exit Sub
  loc_005DC2E1: 'Referenced from: 005DC2AF
  loc_005DC2E1: Exit Sub
End Sub