ï»¿Private Sub Form_Click() '5CDEF0
  Dim var_B4 As Variant
  loc_005CDFAC: var_120 = var_B4
  loc_005CDFB2: Image1.Visible = ebx
  loc_005CE000: Image2.Visible = True
  loc_005CE049: var_eax = call Proc_6098C0(CLng(0.1), var_B4, Me)
  loc_005CE068: Image1.Visible = True
  loc_005CE0AC: Image2.Visible = False
  loc_005CE0E2: var_118 = CLng(0.1)
  loc_005CE0EF: var_eax = call Proc_6098C0(var_118, var_B4, Me)
  loc_005CE10E: Image1.Visible = False
  loc_005CE152: Image2.Visible = True
  loc_005CE195: var_eax = call Proc_6098C0(CLng(0.1), var_B4, ebx)
  loc_005CE1B4: Image1.Visible = False
  loc_005CE202: Image2.Visible = False
  loc_005CE251: var_B4 = Global.Screen
  loc_005CE277: var_11C = Global.TwipsPerPixelY
  loc_005CE29B: var_118 = Global.MousePointer
  loc_005CE2BC: If var_60C000 <> 0 Then GoTo loc_005CE2C6
  loc_005CE2C4: GoTo loc_005CE2D1
  loc_005CE2C6: 'Referenced from: 005CE2BC
  loc_005CE2CC: call _adj_fdiv_m32(var_11C, var_B4, var_B4, Me, var_B4, call Proc_6098C0(var_118, var_B4, ebx), Me, Me, var_B4, call Proc_6098C0(var_118, var_B4, Me), Me, Me, var_B4)
  loc_005CE2D1: 'Referenced from: 005CE2C4
  loc_005CE300: var_74 = ((var_118 / var_11C) + &H42200000&H)
  loc_005CE337: var_B4 = Global.Screen
  loc_005CE361: var_11C = Global.TwipsPerPixelX
  loc_005CE389: var_118 = Global.ActiveControl
  loc_005CE3AE: If var_60C000 <> 0 Then GoTo loc_005CE3B8
  loc_005CE3B6: GoTo loc_005CE3C3
  loc_005CE3B8: 'Referenced from: 005CE3AE
  loc_005CE3BE: call _adj_fdiv_m32(var_11C)
  loc_005CE3C3: 'Referenced from: 005CE3B6
  loc_005CE3E6: var_44 = (var_118 / var_11C)
  loc_005CE410: var_ret_1 = CLng(Me.hWnd)
  loc_005CE417: var_eax = GetMenu(var_ret_1)
  loc_005CE463: var_ret_2 = CLng(GetMenu(var_ret_1))
  loc_005CE46A: var_eax = GetSubMenu(var_ret_2, 0)
  loc_005CE496: var_64 = GetSubMenu(var_ret_2, 0)
  loc_005CE4B6: var_ret_3 = CStr(0)
  loc_005CE4C9: var_ret_4 = "AOL FRAME25"
  loc_005CE4D0: var_eax = FindWindow(var_ret_4, var_ret_3)
  loc_005CE4FF: var_94 = FindWindow(var_ret_4, var_ret_3)
  loc_005CE55C: var_eax = call Proc_79_20_605020(var_D4, var_94, "AOL TOOLBAR")
  loc_005CE56A: var_24 = var_D4
  loc_005CE581: var_ret_5 = CLng(var_94)
  loc_005CE588: var_eax = ShowWindow(var_ret_5, 3)
  loc_005CE5B7: var_A4 = ShowWindow(var_ret_5, 3)
  loc_005CE689: Set var_B4 = Me.mainmenu
  loc_005CE691: var_eax = Unknown_VTable_Call[edi+000002BCh]
  loc_005CE6D4: GoTo loc_005CE71C
  loc_005CE71B: Exit Sub
  loc_005CE71C: 'Referenced from: 005CE6D4
  loc_005CE758: Exit Sub
End Sub