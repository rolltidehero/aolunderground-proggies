ï»¿Private Sub Command1_Click() '5C2180
  Dim var_84 As TextBox
  loc_005C226D: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005C22AA: var_70 = False
  loc_005C22BA: var_ret_1 = "AOL Frame25"
  loc_005C22C1: var_eax = FindWindow(var_ret_1, 0)
  loc_005C22E3: var_24 = FindWindow(var_ret_1, 0)
  loc_005C22F6: var_ret_3 = "MDIClient"
  loc_005C2303: var_eax = FindWindowEx(var_24, ebx, var_ret_3, 0)
  loc_005C2316: var_ret_4 = FindWindowEx(var_24, ebx, var_ret_3, 0)
  loc_005C2353: If (var_70 <> True) <> 0 Then GoTo loc_005C2B6F
  loc_005C237D: var_78 = Text1.Text
  loc_005C23D4: call Proc_79_35_6076D0("aol://2719:2-2-" & var_78 & vbNullString, var_84, (var_70 = True))
  loc_005C2415: var_18C = var_78
  loc_005C2437: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005C2477: call __vbaStrR8
  loc_005C2482: var_7C = __vbaStrR8
  loc_005C249C: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005C250D: var_78 = Text1.Text
  loc_005C253B: var_ret_5 = var_78
  loc_005C2544: var_ret_6 = CLng(var_3C)
  loc_005C254B: var_eax = FindWindowEx(var_ret_6, 0, var_ret_5, 0)
  loc_005C2564: var_20 = FindWindowEx(var_ret_6, 0, var_ret_5, 0)
  loc_005C2591: var_ret_8 = "#32770"
  loc_005C2594: var_eax = FindWindow(var_ret_8, 0)
  loc_005C25B0: var_1C = FindWindow(var_ret_8, 0)
  loc_005C25B9: var_eax = call Proc_79_19_604D70(, , )
  loc_005C25C4: var_180 = call Proc_79_19_604D70(, , )
  loc_005C25CB: var_eax = call Proc_79_44_608AA0(var_180, , )
  loc_005C25E9: var_50 = call Proc_79_44_608AA0(var_180, , )
  loc_005C25F4: If var_20 <> 0 Then GoTo loc_005C2601
  loc_005C25FB: If var_1C = 0 Then GoTo loc_005C24E3
  loc_005C2601: 'Referenced from: 005C25F4
  loc_005C2601: var_eax = call Proc_79_19_604D70(, , )
  loc_005C2608: If call Proc_79_19_604D70(, , ) <> 0 Then GoTo loc_005C26D6
  loc_005C2617: var_ret_A = "America Online"
  loc_005C2623: var_ret_B = "#32770"
  loc_005C2626: var_eax = FindWindow(var_ret_B, var_ret_A)
  loc_005C2643: var_40 = FindWindow(var_ret_B, var_ret_A)
  loc_005C265A: var_ret_C = "OK"
  loc_005C2663: var_eax = FindWindowEx(var_40, 0, var_ret_C, 0)
  loc_005C2668: var_180 = FindWindowEx(var_40, 0, var_ret_C, 0)
  loc_005C2689: var_eax = PostMessage(var_180, 513, 0, 0)
  loc_005C269A: var_eax = PostMessage(var_180, 514, 0, 0)
  loc_005C26C9: If (var_70 <> True) <> 0 Then GoTo loc_005C2B6D
  loc_005C26D1: GoTo loc_005C2325
  loc_005C26D6: 'Referenced from: 005C2608
  loc_005C26E4: var_2C = " try"
  loc_005C2706: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005C2728: fcomp real8 ptr [00401C10h]
  loc_005C273A: GoTo loc_005C273E
  loc_005C273E: 'Referenced from: 005C273A
  loc_005C2758: If di = 0 Then GoTo loc_005C2764
  loc_005C2762: var_2C = " tries"
  loc_005C2764: 'Referenced from: 005C2758
  loc_005C277F: var_eax = call Proc_6098C0(CLng(0.3), Me, var_78)
  loc_005C2796: var_78 = "â¢bodini 4.0â¢ room buster â¢spekâ¢"
  loc_005C27D1: var_eax = call Proc_3_4_5A51B0(var_A8, var_60, 3)
  loc_005C2826: var_78 = "<font face=""tahoma"">" & var_A8
  loc_005C2839: var_7C = var_78 & vbNullString
  loc_005C283F: var_eax = call Proc_79_17_604A50(var_7C, var_60, var_78)
  loc_005C286C: var_eax = call Proc_6098C0(CLng(0.7), Me, )
  loc_005C2891: var_78 = Text1.Text
  loc_005C28B8: var_90 = var_78
  loc_005C28D8: var_A8 = LCase(0)
  loc_005C2902: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005C2928: var_D0 = var_7C
  loc_005C293D: var_150 = var_2C
  loc_005C2976: var_130 = "â¢entered "
  loc_005C2980: var_140 = "â¢ "
  loc_005C29E8: var_80 = "â¢entered " & var_A8 & "â¢ " & var_7C & var_2C & &H42EC60
  loc_005C2A1F: var_eax = call Proc_3_4_5A51B0(var_128, var_60, 3)
  loc_005C2ACF: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_128 & vbNullString, var_88, "<font face=""tahoma"">" & var_128 & vbNullString)
  loc_005C2B00: var_eax = call Proc_6098C0(CLng(0.3), , )
  loc_005C2B22: var_70 = True
  loc_005C2B49: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005C2B6F: 'Referenced from: 005C2353
  loc_005C2B78: GoTo loc_005C2BF6
  loc_005C2BF5: Exit Sub
  loc_005C2BF6: 'Referenced from: 005C2B78
  loc_005C2C20: Exit Sub
End Sub