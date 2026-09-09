
Public Sub Proc_6_0_47D320
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, var_44)
  var_18 = FindWindow(var_ret_1, var_44)
  var_ret_2 = "MDIClient"
  FindWindowEx(var_18, 0, var_ret_2, 0)
  var_20 = FindWindowEx(var_18, 0, var_ret_2, 0)
  var_ret_3 = "AOL Child"
  FindWindowEx(var_20, 0, var_ret_3, 0)
  var_28 = FindWindowEx(var_20, 0, var_ret_3, 0)
  var_ret_4 = "_AOL_Combobox"
  FindWindowEx(var_28, 0, var_ret_4, 0)
  var_40 = FindWindowEx(var_28, 0, var_ret_4, 0)
  var_ret_5 = "_AOL_Edit"
  FindWindowEx(var_28, 0, var_ret_5, 0)
  SendMessage(var_40, 326, 0, var_6C)
  SendMessage(var_40, 334, CLng(SendMessage(var_40, 326, 0, 0) - 1), 0)
  var_44 = vbNullString
  var_ret_8 = var_44
  SendMessage(FindWindowEx(var_28, 0, var_ret_5, 0), 12, 0, var_48)
  SendMessage(var_40, 258, 13, 0)
  var_ret_9 = "_AOL_Modal"
  FindWindow(var_ret_9, 0)
  var_2C = FindWindow(var_ret_9, 0)
  var_ret_A = "_AOL_Edit"
  FindWindowEx(var_2C, 0, var_ret_A, 0)
  var_1C = FindWindowEx(var_2C, 0, var_ret_A, 0)
  var_ret_B = "_AOL_Edit"
  FindWindowEx(var_2C, var_1C, var_ret_B, 0)
  var_24 = FindWindowEx(var_2C, var_1C, var_ret_B, 0)
  var_ret_C = "AOL Frame25"
  FindWindow(var_ret_C, 0)
  var_6C = FindWindow(var_ret_C, 0)
  IsWindowVisible(var_40)
  var_6C = IsWindowVisible(var_40)
  If var_6C <> 0 Then GoTo loc_0047D5D4
  If var_1C = 0 Then GoTo loc_0047D50F
  If var_24 = 0 Then GoTo loc_0047D50F
  If var_1C = 0 Then GoTo loc_0047D65A
  If var_24 = 0 Then GoTo loc_0047D65A
  SendMessage(var_1C, 12, 0, Me)
  var_ret_E = var_44
  SendMessage(var_24, 12, 0, arg_C)
  var_ret_10 = var_44
  SendMessage(var_24, 258, 13, 0)
  Exit Sub
End Sub

Public Sub Proc_6_1_47D6A0
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, var_28)
  var_ret_2 = "MDIClient"
  FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  var_2C = FindWindowEx(var_2C, 0, var_ret_2, 0)
  var_1C = var_2C
  var_ret_3 = "AOL Child"
  FindWindowEx(var_2C, 0, var_ret_3, 0)
  var_ret_4 = "AOL Child"
  FindWindowEx(var_1C, FindWindowEx(FindWindowEx(var_2C, 0, var_ret_3, 0), 0, var_ret_3, 0), var_ret_4, 0)
  var_24 = FindWindowEx(var_1C, var_24, var_ret_4, 0)
  call MailCountOld(var_24, 1, var_24 = "")
  esi = InStr(FindWindowEx(var_1C, var_24, var_ret_4, 0), GetLastError, "Welcome", 0) - 1
  If InStr(FindWindowEx(var_1C, var_24, var_ret_4, 0) <> 0 Then GoTo loc_0047D751
  call MailCountOld(var_24, 1, var_ret_5 = #StkVar1%StkVar2)
  var_18 = InStr(, var_ret_5, "Welcome", 0)
  Exit Sub
End Sub

Public Sub Proc_6_2_47D850
  var_BC = eax.hDC
  var_BC = var_BC - 0001h
  var_A0 = var_BC
  For var_30 = "" To var_BC Step 1
  If var_30 = 0 Then GoTo loc_0047DBD4
  var_BC = eax.hDC
  var_B0 = var_BC
  For var_20 = var_30 + 1 To var_BC Step 1
  If var_110 = 0 Then GoTo loc_0047DBBB
  var_30 = CInt(var_34)
  var_30 = eax.CurrentY
  var_40 = var_34
  var_58 = Ucase(0)
  var_20 = CInt(var_38)
  var_20 = eax.CurrentY
  var_60 = var_38
  var_78 = Ucase(var_38)
  If (var_58 = var_78) = 0 Then GoTo loc_0047DB9C
  var_20 = CInt(0)
  var_20 = CInt((vtable))
  var_20 = CInt(arg_C)
  Next var_20
  GoTo loc_0047DA33
  Next var_30
  GoTo loc_0047D971
  Exit Sub
  Exit Sub
End Sub

Public Sub Proc_6_3_47DC70
  On Error Resume Next
  Open Me For Input As #1 Len = -1
  If EOF(1) <> 0 Then GoTo loc_0047DF16
  Line Input #1, var_30
  Line Input #1, var_40
  Line Input #1, var_50
  var_54 = var_30
  var_6C = (vtable)
  var_54 = var_40
  var_6C = (vtable)
  var_54 = var_50
  var_6C = (vtable)
  GoTo loc_0047DCDD
  Close #1
  Exit Sub
End Sub

Public Sub Proc_6_4_47DF70
  Dim var_6C As Me
  On Error Resume Next
  Open Me For Output As #1 Len = -1
  var_6C = arg_C
  var_68 = var_6C.hDC
  var_70 = var_68
  var_68 = var_68 - 0001h
  var_4C = var_68
  For var_30 = 0 To var_68 Step 1
  var_A8 = var_80
  GoTo loc_0047E241
  var_6C = arg_C
  var_30 = CInt(var_34)
  var_70 = var_6C.CurrentY
  Print 1, var_34
  var_6C = arg_10
  var_30 = CInt(var_34)
  var_70 = var_6C.CurrentY
  Print 1, var_34
  var_6C = arg_14
  var_30 = CInt(var_34)
  var_30 = var_6C.CurrentY
  var_70 = var_30
  Print 1, var_34
  Next var_30
  var_A8 = Next var_30
  If var_A8 <> 0 Then GoTo loc_0047E095
  Close #1
  Exit Sub
  Exit Sub
End Sub

Public Sub Proc_6_5_47E2B0
  var_ret_1 = "America  Online"
  var_ret_2 = "AOL Frame25"
  FindWindow(var_ret_2, var_ret_1)
  var_ret_3 = "MDIClient"
  FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0)
  var_28 = FindWindowEx(var_68, 0, var_ret_3, 0)
  var_ret_4 = "AOL Child"
  FindWindowEx(var_28, 0, var_ret_4, 0)
  var_34 = FindWindowEx(var_28, 0, var_ret_4, 0)
  var_ret_5 = "_AOL_Icon"
  FindWindowEx(var_34, 0, var_ret_5, 0)
  var_5C = FindWindowEx(var_34, 0, var_ret_5, 0)
  var_ret_6 = "_AOL_Icon"
  FindWindowEx(var_34, var_5C, var_ret_6, 0)
  var_14 = FindWindowEx(var_34, var_5C, var_ret_6, 0)
  var_ret_7 = "_AOL_Icon"
  FindWindowEx(var_34, var_14, var_ret_7, 0)
  var_18 = FindWindowEx(var_34, var_14, var_ret_7, 0)
  var_ret_8 = "_AOL_Icon"
  FindWindowEx(var_34, var_18, var_ret_8, 0)
  var_1C = FindWindowEx(var_34, var_18, var_ret_8, 0)
  var_ret_9 = "_AOL_Icon"
  FindWindowEx(var_34, var_1C, var_ret_9, 0)
  var_24 = FindWindowEx(var_34, var_1C, var_ret_9, 0)
  var_ret_A = "_AOL_Icon"
  FindWindowEx(var_34, var_24, var_ret_A, 0)
  var_2C = FindWindowEx(var_34, var_24, var_ret_A, 0)
  var_ret_B = "_AOL_Icon"
  FindWindowEx(var_34, var_2C, var_ret_B, 0)
  var_30 = FindWindowEx(var_34, var_2C, var_ret_B, 0)
  var_ret_C = "_AOL_Icon"
  FindWindowEx(var_34, var_30, var_ret_C, 0)
  var_38 = FindWindowEx(var_34, var_30, var_ret_C, 0)
  var_ret_D = "_AOL_Icon"
  FindWindowEx(var_34, var_38, var_ret_D, 0)
  var_3C = FindWindowEx(var_34, var_38, var_ret_D, 0)
  var_ret_E = "_AOL_Icon"
  FindWindowEx(var_34, var_3C, var_ret_E, 0)
  var_40 = FindWindowEx(var_34, var_3C, var_ret_E, 0)
  var_ret_F = "_AOL_Icon"
  FindWindowEx(var_34, var_40, var_ret_F, 0)
  var_44 = FindWindowEx(var_34, var_40, var_ret_F, 0)
  var_ret_10 = "_AOL_Icon"
  FindWindowEx(var_34, var_44, var_ret_10, 0)
  var_48 = FindWindowEx(var_34, var_44, var_ret_10, 0)
  var_ret_11 = "_AOL_Icon"
  FindWindowEx(var_34, var_48, var_ret_11, 0)
  var_50 = FindWindowEx(var_34, var_48, var_ret_11, 0)
  var_ret_12 = "_AOL_Icon"
  FindWindowEx(var_34, var_50, var_ret_12, 0)
  var_54 = FindWindowEx(var_34, var_50, var_ret_12, 0)
  var_ret_13 = "_AOL_Icon"
  FindWindowEx(var_34, var_54, var_ret_13, 0)
  var_58 = FindWindowEx(var_34, var_54, var_ret_13, 0)
  var_ret_14 = "_AOL_Icon"
  FindWindowEx(var_34, var_58, var_ret_14, 0)
  var_68 = FindWindowEx(var_34, var_58, var_ret_14, 0)
  SendMessage(var_68, 513, ebx, var_68)
  SendMessage(var_68, 514, ebx, var_68)
  Exit Sub
End Sub
