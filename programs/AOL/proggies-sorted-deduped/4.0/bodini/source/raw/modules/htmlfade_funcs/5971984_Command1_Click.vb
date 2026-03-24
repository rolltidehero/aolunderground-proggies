Private Sub Command1_Click() '5B2010
  loc_005B209F: var_eax = Unknown_VTable_Call[ecx+00000060h]
  loc_005B20D7: var_eax = Unknown_VTable_Call[edx+00000060h]
  loc_005B210C: var_1C = Text1.Text
  loc_005B213C: var_20 = var_1C
  loc_005B214F: var_44 = var_88
  loc_005B215B: var_34 = var_84
  loc_005B216F: var_eax = call Proc_3_3_5A4D40(var_5C, 3, 3)
  loc_005B21D6: Text2.Text = var_5C
  loc_005B222C: var_1C = Text2.Text
  loc_005B225F: var_eax = call Proc_3_0_5A35D0(var_28, var_1C, var_28)
  loc_005B228C: GoTo loc_005B22CA
  loc_005B22C9: Exit Sub
  loc_005B22CA: 'Referenced from: 005B228C
End Sub