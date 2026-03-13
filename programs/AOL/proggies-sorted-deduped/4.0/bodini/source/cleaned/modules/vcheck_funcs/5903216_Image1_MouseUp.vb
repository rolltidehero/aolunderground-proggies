ï»¿Private Sub Image1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) '5A1370
  Dim var_38 As Variant
  loc_005A13DF: Image1.Visible = True
  loc_005A142B: Image2.Visible = False
  loc_005A1461: var_eax = call Proc_6098C0(CLng(0.05), var_38, var_38)
  loc_005A146D: var_3C = Image2.Picture
  loc_005A149E: var_2C = Text2.Text
  loc_005A14BC: var_ret_1 = CLng(var_24)
  loc_005A14D2: var_ret_2 = "c:\"
  loc_005A14DF: var_ret_3 = var_2C
  loc_005A14E8: shell32.dll.ShellExecuteA
  loc_005A1516: var_eax = Unknown_VTable_Call[edx+000002B4h]
  loc_005A1559: Set var_38 = Me
  loc_005A1564: var_eax = Global.Unload var_38
  loc_005A158E: GoTo loc_005A15B1
  loc_005A15B0: Exit Sub
  loc_005A15B1: 'Referenced from: 005A158E
End Sub