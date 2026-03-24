ï»¿Private Sub Image4_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) '5A16E0
  Dim var_18 As Image
  loc_005A1745: Image4.Visible = True
  loc_005A1783: Image3.Visible = False
  loc_005A17BD: var_eax = call Proc_6098C0(CLng(0.05), var_18, var_18)
  loc_005A17DC: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005A1817: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005A183B: var_eax = Call vcheck.Command1_Click
  loc_005A186E: Image4.Enabled = False
  loc_005A18B1: var_eax = Unknown_VTable_Call[eax+0000006Ch]
  loc_005A18DB: GoTo loc_005A18E7
  loc_005A18E6: Exit Sub
  loc_005A18E7: 'Referenced from: 005A18DB
End Sub