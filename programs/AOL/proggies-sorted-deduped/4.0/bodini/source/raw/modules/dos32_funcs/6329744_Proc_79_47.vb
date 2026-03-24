Public Sub Proc_79_47_609590
  loc_006095DA: var_ret_1 = "AOL Frame25"
  loc_006095DD: var_eax = FindWindow(var_ret_1, var_30)
  loc_00609603: var_ret_2 = "MDIClient"
  loc_0060960C: var_eax = FindWindowEx(FindWindow(var_ret_1, var_30), 0, var_ret_2, 0)
  loc_00609611: var_54 = FindWindowEx(var_54, 0, var_ret_2, 0)
  loc_0060961C: var_24 = var_54
  loc_0060962C: var_ret_3 = "AOL Child"
  loc_00609635: var_eax = FindWindowEx(var_54, 0, var_ret_3, 0)
  loc_00609645: var_28 = FindWindowEx(var_54, 0, var_ret_3, 0)
  loc_0060964E: call Proc_79_44_608AA0(var_28, GetLastError(), var_ret_4 = #StkVar1%StkVar2)
  loc_00609658: var_18 = var_ret_4
  loc_00609674: If InStr(1, var_18, "Welcome, ", 0) <> 0 Then GoTo loc_006096D6
  loc_00609676: 
  loc_0060968F: InStr(1, var_18, var_00430680, 0) = InStr(1, var_18, var_00430680, 0) - 0000000Ah
  loc_0060969C: var_38 = InStr(1, var_18, var_00430680, 0)
  loc_006096C6: var_2C = Mid$(var_18, 10, InStr(1, var_18, var_00430680, 0))
  loc_006096D1: GoTo loc_0060976F
  loc_006096D6: 'Referenced from: 00609674
  loc_006096E1: var_ret_5 = "AOL Child"
  loc_006096EC: var_eax = FindWindowEx(var_24, var_28, var_ret_5, 0)
  loc_006096F1: var_54 = FindWindowEx(var_24, var_28, var_ret_5, 0)
  loc_006096FC: var_28 = var_54
  loc_00609705: call Proc_79_44_608AA0(var_28, var_00609779, var_28 = "")
  loc_0060970F: var_18 = var_54
  loc_0060972B: If InStr(1, var_18, "Welcome, ", 0) = 0 Then GoTo loc_00609676
  loc_00609736: If var_28 <> 0 Then GoTo loc_006096D6
  loc_00609740: var_2C = vbNullString
  loc_0060974B: GoTo loc_0060976F
  loc_00609751: If var_4 = 0 Then GoTo loc_0060975C
  loc_0060975C: 'Referenced from: 00609751
  loc_0060976E: Exit Sub
  loc_0060976F: 'Referenced from: 006096D1
End Sub