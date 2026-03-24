ï»¿Private Sub Command6_Click() '5DB4C0
  Dim var_24 As TextBox
  Dim var_34 As TextBox
  Dim var_A8 As TextBox
  Dim var_154 As TextBox
  loc_005DB598: var_134 = var_24
  loc_005DB59E: Text1.Text = vbNullString
  loc_005DB5E8: var_18 = Text1.Text
  loc_005DB62F: var_154 = var_34
  loc_005DB652: var_12C = Text1.SelStart
  loc_005DB67F: var_40 = var_18
  loc_005DB695: var_58 = Left(var_18, var_12C)
  loc_005DB6A1: var_100 = " <a href="
  loc_005DB6B5: var_78 = Chr(34)
  loc_005DB6C4: var_110 = "http://www.xclipticonline.com/spek"
  loc_005DB6D8: var_A8 = Chr(34)
  loc_005DB6E1: var_120 = ">spek online</a>"
  loc_005DB70B: var_1C = Text1.Text
  loc_005DB749: var_130 = Text1.SelStart
  loc_005DB76D: var_D0 = var_38
  loc_005DB793: Len(var_1C) = Len(var_1C) - var_130
  loc_005DB819: var_F8 = var_58 & " <a href=" & var_78 & "http://www.xclipticonline.com/spek" & var_A8 & ">spek online</a>" & Right(var_38, Len(var_1C))
  loc_005DB820: var_20 = CStr(var_F8)
  loc_005DB82E: Text1.Text = var_20
  loc_005DB8D7: GoTo loc_005DB964
  loc_005DB963: Exit Sub
  loc_005DB964: 'Referenced from: 005DB8D7
  loc_005DB964: Exit Sub
End Sub