
Public Sub FindForwardWindow
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, var_58)
  var_30 = FindWindow(var_ret_1, var_58)
  var_ret_2 = "MDICLIENT"
  FindWindowEx(var_30, 0, var_ret_2, 0)
  var_48 = FindWindowEx(var_30, 0, var_ret_2, 0)
  var_ret_3 = "AOL Toolbar"
  FindWindowEx(var_30, 0, var_ret_3, 0)
  var_24 = FindWindowEx(var_30, 0, var_ret_3, 0)
  var_ret_4 = "_AOL_Toolbar"
  FindWindowEx(var_24, 0, var_ret_4, 0)
  var_20 = FindWindowEx(var_24, 0, var_ret_4, 0)
  var_ret_5 = "_AOL_Icon"
  FindWindowEx(var_20, 0, var_ret_5, 0)
  var_50 = FindWindowEx(var_20, 0, var_ret_5, 0)
  var_ret_6 = "_AOL_Icon"
  FindWindowEx(var_20, var_50, var_ret_6, 0)
  var_50 = FindWindowEx(var_20, var_50, var_ret_6, 0)
  PostMessage(var_50, 513, 0, 0)
  PostMessage(var_50, 514, 0, 0)
  var_ret_7 = "Write Mail"
  var_ret_8 = "AOL Child"
  FindWindowEx(var_48, 0, var_ret_8, var_ret_7)
  var_1C = FindWindowEx(var_48, 0, var_ret_8, var_ret_7)
  var_ret_9 = "_AOL_Edit"
  FindWindowEx(var_1C, 0, var_ret_9, 0)
  var_44 = FindWindowEx(var_1C, 0, var_ret_9, 0)
  var_ret_A = "_AOL_Edit"
  FindWindowEx(var_1C, var_44, var_ret_A, 0)
  var_40 = FindWindowEx(var_1C, var_44, var_ret_A, 0)
  var_ret_B = "_AOL_Edit"
  FindWindowEx(var_1C, var_40, var_ret_B, 0)
  var_3C = FindWindowEx(var_1C, var_40, var_ret_B, 0)
  var_ret_C = "RICHCNTL"
  FindWindowEx(var_1C, 0, var_ret_C, 0)
  var_18 = FindWindowEx(var_1C, 0, var_ret_C, 0)
  var_ret_D = "_AOL_Combobox"
  FindWindowEx(var_1C, 0, var_ret_D, 0)
  var_38 = FindWindowEx(var_1C, 0, var_ret_D, 0)
  var_ret_E = "_AOL_Fontcombo"
  FindWindowEx(var_1C, 0, var_ret_E, 0)
  var_4C = FindWindowEx(var_1C, 0, var_ret_E, 0)
  var_ret_F = "_AOL_Icon"
  FindWindowEx(var_1C, 0, var_ret_F, 0)
  var_28 = FindWindowEx(var_1C, 0, var_ret_F, 0)
  var_ret_10 = "_AOL_Icon"
  FindWindowEx(var_1C, var_28, var_ret_10, 0)
  var_2C = FindWindowEx(var_1C, var_28, var_ret_10, 0)
  var_ret_11 = "_AOL_Icon"
  FindWindowEx(var_1C, 0, var_ret_11, 0)
  var_54 = FindWindowEx(var_1C, 0, var_ret_11, 0)
  If var_14 > 13 Then GoTo loc_00478839
  var_ret_12 = "_AOL_Icon"
  FindWindowEx(var_1C, var_54, var_ret_12, 0)
  var_54 = FindWindowEx(var_1C, var_54, var_ret_12, 0)
  &h00000001 = &h00000001 + var_14
  GoTo loc_004787ED
  var_58 = 0
  var_60 = var_58 & var_54
  GoTo loc_00478894
  setnz dl
  setnz al
  setnz al
  setnz cl
  setnz al
  setnz cl
  setnz al
  setnz cl
  setnz al
  var_68 = Not (eax)
  If var_68 <> 0 Then GoTo loc_00478628
  SendMessage(var_44, 12, 0, Me)
  var_ret_14 = var_58
  SendMessage(var_3C, 12, 0, arg_C)
  var_ret_16 = var_58
  SendMessage(var_18, 12, 0, arg_10)
  var_ret_18 = var_58
  call Proc_47AEC0(0.2, , )
  call Proc_6_5_47E2B0(, , )
  Exit Sub
End Sub

Public Sub FindSendWindow
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, var_28)
  var_ret_2 = "MDIClient"
  FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  var_1C = FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  var_ret_3 = "AOL Child"
  FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0)
  var_20 = FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0)
  call MailCountOld(var_20, var_ret_4 = #StkVar1%StkVar2, FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0))
  var_14 = var_ret_4
  If InStr(1, var_14, "Instant Message", 0) = 0 Then GoTo loc_00478B28
  var_24 = var_20
  GoTo loc_00478BEF
  var_ret_5 = "AOL Child"
  FindWindowEx(var_1C, var_20, var_ret_5, 0)
  var_20 = FindWindowEx(var_1C, var_20, var_ret_5, 0)
  call MailCountOld(var_20, var_00478BF9, GetLastError())
  setnz bl
  InStr(1, call MailCountOld(var_20, var_00478BF9, GetLastError()), "Instant Message", 0) - 1
  setnz dl
  If edx = 0 Then GoTo loc_00478BCD
  If var_20 = 0 Then GoTo loc_00478BD7
  GoTo loc_00478B28
  var_24 = var_20
  GoTo loc_00478BEF
  Exit Sub
End Sub

Public Sub MailOpenFlash
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, 0)
  var_ret_2 = "MDIClient"
  FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  var_38 = FindWindowEx(var_38, 0, var_ret_2, 0)
  var_28 = var_38
  var_ret_3 = "AOL Child"
  FindWindowEx(var_38, 0, var_ret_3, 0)
  var_38 = FindWindowEx(var_38, 0, var_ret_3, 0)
  var_2C = var_38
  var_ret_4 = "RICHCNTL"
  FindWindowEx(var_38, 0, var_ret_4, 0)
  var_1C = FindWindowEx(var_38, 0, var_ret_4, 0)
  var_ret_5 = "_AOL_Listbox"
  FindWindowEx(var_2C, 0, var_ret_5, 0)
  var_24 = FindWindowEx(var_2C, 0, var_ret_5, 0)
  var_ret_6 = "_AOL_Icon"
  FindWindowEx(var_2C, 0, var_ret_6, 0)
  var_30 = FindWindowEx(var_2C, 0, var_ret_6, 0)
  var_ret_7 = "_AOL_Static"
  FindWindowEx(var_2C, 0, var_ret_7, 0)
  var_38 = FindWindowEx(var_2C, 0, var_ret_7, 0)
  If var_1C = 0 Then GoTo loc_00478D8B
  If var_24 = 0 Then GoTo loc_00478D8B
  If var_30 = 0 Then GoTo loc_00478D8B
  If var_38 = 0 Then GoTo loc_00478D8B
  var_18 = var_2C
  GoTo loc_00478EA1
  var_ret_8 = "AOL Child"
  FindWindowEx(var_28, var_2C, var_ret_8, 0)
  var_38 = FindWindowEx(var_28, var_2C, var_ret_8, 0)
  var_2C = var_38
  var_ret_9 = "RICHCNTL"
  FindWindowEx(var_38, 0, var_ret_9, 0)
  var_1C = FindWindowEx(var_38, 0, var_ret_9, 0)
  var_ret_A = "_AOL_Listbox"
  FindWindowEx(var_2C, 0, var_ret_A, 0)
  var_24 = FindWindowEx(var_2C, 0, var_ret_A, 0)
  var_ret_B = "_AOL_Icon"
  FindWindowEx(var_2C, 0, var_ret_B, 0)
  var_30 = FindWindowEx(var_2C, 0, var_ret_B, 0)
  var_ret_C = "_AOL_Static"
  FindWindowEx(var_2C, 0, var_ret_C, 0)
  var_38 = FindWindowEx(var_2C, 0, var_ret_C, 0)
  If var_1C = 0 Then GoTo loc_00478E70
  If var_24 = 0 Then GoTo loc_00478E70
  If var_30 = 0 Then GoTo loc_00478E70
  If var_38 <> 0 Then GoTo loc_00478E7C
  If var_2C = 0 Then GoTo loc_00478E89
  GoTo loc_00478D8B
  var_18 = var_2C
  GoTo loc_00478EA1
  Exit Sub
End Sub

Public Sub MailOpenNew
  On Error Resume Next
  var_34 = call MailOpenFlash(-1, edi, esi)
  If var_34 <> 0 Then GoTo loc_00478F35
  GoTo loc_00479317
  var_ret_1 = "_AOL_Listbox"
  FindWindowEx(var_34, 0, var_ret_1, 0)
  var_48 = FindWindowEx(var_34, 0, var_ret_1, 0)
  GetWindowThreadProcessId(var_48, var_40)
  var_24 = GetWindowThreadProcessId(var_48, var_40)
  OpenProcess(983056, 0, var_40)
  var_44 = OpenProcess(983056, 0, var_40)
  If var_44 = 0 Then GoTo loc_00479317
  SendMessage(var_48, 395, 0, var_70)
  var_74 = SendMessage(var_48, 395, 0, var_70)
  var_84 = var_74 - &h00000001
  GoTo loc_00479026
  var_28 = var_28 + 1
  var_28 = var_28
  If var_28 > 0 Then GoTo loc_00479301
  var_38 = String$(4, vbNullString)
  SendMessage(var_48, 409, var_28, 0)
  var_30 = SendMessage(var_48, 409, var_28, 0)
  var_30 = var_30 + &h00000018
  ReadProcessMemory(var_44, var_30, var_38, 4, var_3C)
  var_ret_3 = var_4C
  CopyMemory(var_2C, var_38, 4)
  var_ret_5 = var_4C
  var_2C = var_2C + &h00000006
  var_38 = String$(16, vbNullString)
  ReadProcessMemory(var_44, var_2C, var_38, Len(var_38), var_3C)
  var_ret_7 = var_4C
  InStr(1, var_38, vbNullString, 0) = InStr(1, var_38, vbNullString, 0) - &h00000001
  var_38 = Left$(var_38, InStr(1, var_38, vbNullString, 0))
  var_4C = call MailDeleteNewDuplicates(var_38, 0, fs:[&h00000000])
  If var_78 = 0 Then GoTo loc_004792F5
  var_7C = (vtable)
  GoTo loc_00479017
  CloseHandle(var_44)
  Exit Sub
End Sub

Public Sub MailOpenOld
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, var_30)
  var_18 = FindWindow(var_ret_1, var_30)
  var_ret_2 = "MDIClient"
  FindWindowEx(var_18, 0, var_ret_2, 0)
  var_1C = FindWindowEx(var_18, 0, var_ret_2, 0)
  var_30 = "aol://9293:" & Me
  call MailOpenEmailOld(var_30, GetLastError(), var_ret_3 = #StkVar1%StkVar2)
  var_ret_4 = "Send Instant Message"
  var_ret_5 = "AOL Child"
  FindWindowEx(var_1C, 0, var_ret_5, var_ret_4)
  var_ret_6 = "RICHCNTL"
  FindWindowEx(FindWindowEx(var_1C, 0, var_ret_5, var_ret_4), 0, var_ret_6, 0)
  var_38 = FindWindowEx(var_38, 0, var_ret_6, 0)
  var_14 = var_38
  var_ret_7 = "_AOL_Icon"
  FindWindowEx(var_38, 0, var_ret_7, 0)
  var_38 = FindWindowEx(var_38, 0, var_ret_7, 0)
  var_28 = var_38
  var_ret_8 = "_AOL_Icon"
  FindWindowEx(var_38, var_28, var_ret_8, 0)
  var_38 = FindWindowEx(var_38, var_28, var_ret_8, 0)
  var_28 = var_38
  var_ret_9 = "_AOL_Icon"
  FindWindowEx(var_38, var_28, var_ret_9, 0)
  var_38 = FindWindowEx(var_38, var_28, var_ret_9, 0)
  var_28 = var_38
  var_ret_A = "_AOL_Icon"
  FindWindowEx(var_38, var_28, var_ret_A, 0)
  var_38 = FindWindowEx(var_38, var_28, var_ret_A, 0)
  var_28 = var_38
  var_ret_B = "_AOL_Icon"
  FindWindowEx(var_38, var_28, var_ret_B, 0)
  var_38 = FindWindowEx(var_38, var_28, var_ret_B, 0)
  var_28 = var_38
  var_ret_C = "_AOL_Icon"
  FindWindowEx(var_38, var_28, var_ret_C, 0)
  var_38 = FindWindowEx(var_38, var_28, var_ret_C, 0)
  var_28 = var_38
  var_ret_D = "_AOL_Icon"
  FindWindowEx(var_38, var_28, var_ret_D, 0)
  var_38 = FindWindowEx(var_38, var_28, var_ret_D, 0)
  var_28 = var_38
  var_ret_E = "_AOL_Icon"
  FindWindowEx(var_38, var_28, var_ret_E, 0)
  var_38 = FindWindowEx(var_38, var_28, var_ret_E, 0)
  var_28 = var_38
  var_ret_F = "_AOL_Icon"
  FindWindowEx(var_38, var_28, var_ret_F, 0)
  var_28 = FindWindowEx(var_38, var_28, var_ret_F, 0)
  If var_38 = 0 Then GoTo loc_0047941B
  If var_14 = 0 Then GoTo loc_0047941B
  If var_28 = 0 Then GoTo loc_0047941B
  SendMessage(var_14, 12, 0, arg_C)
  var_ret_11 = var_30
  SendMessage(var_28, 513, 0, 0)
  SendMessage(var_28, 514, 0, 0)
  var_ret_12 = "America Online"
  var_ret_13 = "#32770"
  FindWindow(var_ret_13, var_ret_12)
  var_38 = FindWindow(var_ret_13, var_ret_12)
  var_ret_14 = "Send Instant Message"
  var_ret_15 = "AOL Child"
  FindWindowEx(var_1C, 0, var_ret_15, var_ret_14)
  var_38 = FindWindowEx(var_1C, 0, var_ret_15, var_ret_14)
  var_2C = var_38
  If var_38 <> 0 Then GoTo loc_0047972A
  If var_2C <> 0 Then GoTo loc_00479698
  If var_38 = 0 Then GoTo loc_00479784
  var_ret_16 = "Button"
  FindWindowEx(var_38, 0, var_ret_16, 0)
  var_38 = FindWindowEx(var_38, 0, var_ret_16, 0)
  PostMessage(var_38, 256, 32, 0)
  PostMessage(var_38, 257, 32, 0)
  PostMessage(var_2C, 16, 0, 0)
  Exit Sub
End Sub

Public Sub MailOpenSent
  call MailOpenOld("$IM_OFF, " & Me, "=)", 0)
  Exit Sub
End Sub

Public Sub MailOpenEmailFlash
  var_44 = call FindSendWindow(edi, esi, ebx)
  var_18 = call MailCountOld(var_44, , )
  If InStr(1, var_18, var_00414C98, 0) <> 0 Then GoTo loc_004798F5
  var_20 = vbNullString
  GoTo loc_0047996E
  var_38 = var_18
  Len(var_18) = Len(var_18) - InStr(1, var_18, var_00414C98, 0)
  Len(var_18) = Len(var_18) - &h00000001
  var_20 = Right(var_18, Len(var_18))
  GoTo loc_0047996E
  If var_4 = 0 Then GoTo loc_00479964
  Exit Sub
End Sub

Public Sub MailOpenEmailNew
  var_ret_1 = "America  Online"
  var_ret_2 = "AOL Frame25"
  FindWindow(var_ret_2, var_ret_1)
  var_ret_3 = "MDIClient"
  FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0)
  var_ret_4 = "AOL Child"
  FindWindowEx(FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0), 0, var_ret_4, 0)
  var_34 = FindWindowEx(var_34, 0, var_ret_4, 0)
  var_ret_5 = "RICHCNTL"
  FindWindowEx(var_34, 0, var_ret_5, 0)
  var_28 = FindWindowEx(var_34, 0, var_ret_5, 0)
  var_20 = call MailDeleteNewByIndex(var_28, , )
  GoTo loc_00479AC3
  If var_4 = 0 Then GoTo loc_00479AAF
  Exit Sub
End Sub

Public Sub MailOpenEmailOld
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, 0)
  var_ret_2 = "AOL Toolbar"
  FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  var_ret_3 = "_AOL_Toolbar"
  FindWindowEx(FindWindowEx(var_2C, 0, var_ret_2, 0), 0, var_ret_3, 0)
  var_ret_4 = "_AOL_Combobox"
  FindWindowEx(FindWindowEx(var_2C, 0, var_ret_3, 0), 0, var_ret_4, 0)
  var_ret_5 = "Edit"
  FindWindowEx(FindWindowEx(var_2C, 0, var_ret_4, 0), 0, var_ret_5, 0)
  var_2C = FindWindowEx(var_2C, 0, var_ret_5, 0)
  SendMessage(var_2C, 12, 0, Me)
  SendMessage(var_2C, 258, 32, 0)
  SendMessage(var_2C, 258, 13, 0)
  Exit Sub
End Sub

Public Sub MailOpenEmailSent
  var_40 = LCase(Me)
  var_78 = arg_C
  var_50 = LCase(arg_C)
  call InStr(var_60, edi, var_50, var_40, &h00000001, 0, Me, %x1 = LCase(%StkVar2))
  var_ret_1 = CLng(InStr(var_60, edi, var_50, var_40, &h00000001, 0, Me, %x1 = LCase(%StkVar2)))
  If var_ret_1 <= 0 Then GoTo loc_00479E3C
  var_ret_1 = var_ret_1 - &h00000001
  var_28 = Left(Me, var_ret_1)
  Len(arg_C) = Len(arg_C) + var_ret_1
  var_8C = Len(arg_C)
  If var_8C > 0 Then GoTo loc_00479DEF
  Len(Me) = Len(Me) - var_ret_1
  var_90 = Len(Me)
  var_90 = var_90 - Len(arg_C)
  var_1C = Right(Me, var_90 + &h00000001 + &h00000001)
  GoTo loc_00479E03
  var_1C = vbNullString
  var_18 = var_28 & arg_10 & var_1C
  GoTo loc_00479E41
  Len(arg_10) = Len(arg_10) + var_ret_1
  If Len(arg_10) <= 0 Then GoTo loc_00479EC7
  var_40 = LCase(Me)
  var_78 = arg_C
  var_50 = LCase(arg_C)
  call InStr(var_60, &h00000000, var_50, var_40, Len(arg_10))
  var_ret_2 = CLng(InStr(var_60, &h00000000, var_50, var_40, Len(arg_10)))
  If var_ret_2 >= 1 Then GoTo loc_00479D01
  var_2C = var_18
  GoTo loc_00479F13
  If var_4 = 0 Then GoTo loc_00479EF2
  Exit Sub
  Exit Sub
End Sub

Public Sub MailCountFlash
  On Error Resume Next
  Open arg_C For Input As #1 Len = -1
  Close #1
  var_50 = Input(LOF(1), 1)
  Exit Sub
End Sub

Public Sub MailToListFlash
  On Error Resume Next
  Open arg_C For Output As #1 Len = -1
  Print 1, eax
  Close #1
End Sub

Public Sub FindMailBox
  On Error Resume Next
  Open Me For Input As #1 Len = -1
  If EOF(1) <> 0 Then GoTo loc_0047A3DD
  Input 1, var_24
  var_44 = var_24
  InStr(1, var_24, var_004152D0, 0) = InStr(1, var_24, var_004152D0, 0) - &h00000001
  var_28 = Left(var_24, InStr(1, var_24, var_004152D0, 0))
  var_44 = var_24
  Len(var_24) = Len(var_24) - InStr(1, var_24, var_004152D0, 0)
  var_2C = Right(var_24, Len(var_24))
  var_54 = (vtable)
  var_54 = (vtable)
  GoTo loc_0047A1CD
  Close #1
  Exit Sub
End Sub

Public Sub MailCountNew
  Dim var_4C As Me
  On Error Resume Next
  Open Me For Output As #1 Len = -1
  var_4C = arg_C
  var_48 = var_4C.hDC
  var_50 = var_48
  var_60 = var_48 - 0001h
  GoTo loc_0047A531
  var_24 = var_24 + 1
  var_24 = var_24
  If var_24 > 0 Then GoTo loc_0047A654
  var_4C = arg_C
  var_ret_1 = var_24
  var_50 = var_4C.CurrentY
  var_ret_2 = var_24
  var_58 = var_4C.CurrentY
  Print 1, var_28 & var_004152D0 & var_2C
  GoTo loc_0047A522
  Close #1
  Exit Sub
  Exit Sub
End Sub

Public Sub MailCountSent
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, var_34)
  var_24 = FindWindow(var_ret_1, var_34)
  var_ret_2 = "MDICLIENT"
  FindWindowEx(var_24, 0, var_ret_2, 0)
  var_28 = FindWindowEx(var_24, 0, var_ret_2, 0)
  call MailOpenEmailOld("aol://4344:1580.prntcon.12263709.564517913", var_ret_3 = #StkVar1%StkVar2, GetLastError())
  var_ret_4 = " Parental Controls"
  var_ret_5 = "AOL Child"
  FindWindowEx(var_28, 0, var_ret_5, var_ret_4)
  var_14 = FindWindowEx(var_28, 0, var_ret_5, var_ret_4)
  var_ret_6 = "_AOL_Icon"
  FindWindowEx(var_14, 0, var_ret_6, 0)
  var_20 = FindWindowEx(var_14, 0, var_ret_6, 0)
  If var_14 = 0 Then GoTo loc_0047A756
  If var_20 = 0 Then GoTo loc_0047A756
  call Proc_47AEC0(0.3, , )
  PostMessage(var_20, 513, 0, 0)
  PostMessage(var_20, 514, 0, 0)
  call Proc_47AEC0(0.8, , )
  var_ret_7 = "_AOL_Modal"
  FindWindow(var_ret_7, 0)
  var_1C = FindWindow(var_ret_7, 0)
  var_ret_8 = "_AOL_Static"
  FindWindowEx(var_1C, 0, var_ret_8, 0)
  var_2C = FindWindowEx(var_1C, 0, var_ret_8, 0)
  var_18 = call MailDeleteNewByIndex(var_2C, , )
  If (var_18 = vbNullString) = 0 Then GoTo loc_0047A7EC
  If var_1C = 0 Then GoTo loc_0047A7EC
  If var_2C = 0 Then GoTo loc_0047A7EC
  var_38 = vbNullString
  var_34 = Chr(10)
  call MailOpenEmailSent(var_18, var_34, var_38)
  var_38 = vbNullString
  var_34 = Chr(13)
  call MailOpenEmailSent(call MailOpenEmailSent(var_18, var_34, var_38), var_34, var_38)
  var_18 = call MailOpenEmailSent(var_18, var_34, var_38)
  eax = (var_18 = "Set Parental Controls") - 1
  var_30 = (var_18 = "Set Parental Controls") - 1
  PostMessage(var_1C, 16, 0, 0)
  PostMessage(var_14, 16, 0, 0)
  Exit Sub
End Sub

Public Sub MailCountOld
  GetWindowTextLength(Me)
  var_20 = String(GetWindowTextLength(Me), "")
  GetWindowTextLength(Me) = GetWindowTextLength(Me) + &h00000001
  GetWindowText(Me, var_20, GetWindowTextLength(Me))
  var_ret_2 = var_24
  var_18 = var_20
  GoTo loc_0047AB1B
  If var_4 = 0 Then GoTo loc_0047AAFE
  Exit Sub
  Exit Sub
End Sub

Public Sub MailDeleteNewByIndex
  SendMessage(Me, 14, edi, var_58)
  var_1C = String(SendMessage(Me, 14, edi, var_58), "")
  SendMessage(Me, 14, edi, var_58) = SendMessage(Me, 14, edi, var_58) + &h00000001
  SendMessage(Me, 13, SendMessage(Me, 14, edi, var_58), var_1C)
  var_ret_2 = var_24
  var_20 = var_1C
  GoTo loc_0047AC67
  If var_4 = 0 Then GoTo loc_0047AC4A
  Exit Sub
  Exit Sub
End Sub

Public Sub MailDeleteNewDuplicates
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, var_30)
  var_ret_2 = "MDIClient"
  FindWindowEx(FindWindow(var_ret_1, var_30), 0, var_ret_2, 0)
  var_54 = FindWindowEx(var_54, 0, var_ret_2, 0)
  var_24 = var_54
  var_ret_3 = "AOL Child"
  FindWindowEx(var_54, 0, var_ret_3, 0)
  var_28 = FindWindowEx(var_54, 0, var_ret_3, 0)
  call MailCountOld(var_28, GetLastError(), var_ret_4 = #StkVar1%StkVar2)
  var_18 = var_ret_4
  If InStr(1, var_18, "Welcome, ", 0) <> 0 Then GoTo loc_0047ADF6
  InStr(1, var_18, var_00415430, 0) = InStr(1, var_18, var_00415430, 0) - &h0000000A
  var_38 = InStr(1, var_18, var_00415430, 0)
  var_2C = Mid$(var_18, 10, InStr(1, var_18, var_00415430, 0))
  GoTo loc_0047AE8F
  var_ret_5 = "AOL Child"
  FindWindowEx(var_24, var_28, var_ret_5, 0)
  var_54 = FindWindowEx(var_24, var_28, var_ret_5, 0)
  var_28 = var_54
  call MailCountOld(var_28, var_0047AE99, var_28 = "")
  var_18 = var_54
  If InStr(1, var_18, "Welcome, ", 0) = 0 Then GoTo loc_0047AD96
  If var_28 <> 0 Then GoTo loc_0047ADF6
  var_2C = vbNullString
  GoTo loc_0047AE8F
  If var_4 = 0 Then GoTo loc_0047AE7C
  Exit Sub
End Sub

Public Sub MailDeleteNewBySender
  var_ret_1 = "AOL Frame25"
  FindWindow(var_ret_1, 0)
  GetMenu(FindWindow(var_ret_1, 0))
  GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me)
  GetMenuItemID(GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me), arg_C)
  SendMessage(FindWindow(var_ret_1, 0), 273, GetMenuItemID(GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me), arg_C), 0)
  Exit Sub
End Sub
