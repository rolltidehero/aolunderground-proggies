ï»¿Public Sub Proc_79_50_609A50
  loc_00609A9E: On Error Resume Next
  loc_00609AE7: Me."AutoRedraw" = Me
  loc_00609B30: Me."FillStyle" = edx
  loc_00609B79: Me."DrawStyle" = var_6C
  loc_00609B86: var_70 = "Tahoma"
  loc_00609BC2: Me."FontName" = Me
  loc_00609C0B: Me."FontSize" = edx
  loc_00609C54: Me."FontBold" = var_6C
  loc_00609C67: var_70 = arg_C
  loc_00609C7F: call __vbaVarVargNofree(var_78, var_6C, edi, esi, ebx)
  loc_00609C8A: var_ret_1 =  / __vbaVarVargNofree(var_78, var_6C, edi, esi, ebx)
  loc_00609D1C: var_F0 = RGB(128, 128, 255)
  loc_00609DBE: var_48 = Me."Width"
  loc_00609DFC: var_58 = Me."Height"
  loc_00609E65: Me = Me.line
  loc_00609EE4: var_100 = RGB(192, 192, 255)
  loc_00609F87: var_ret_3 =  * Me."Width" - 10
  loc_00609FC2: var_58 = Me."Height"
  loc_0060A02B: Me = Me.line
  loc_0060A098: var_ret_5 = Me."Width" / 2 - 100
  loc_0060A0CD: edx.GetTypeInfoCount 'Ignore this.Me = edx
  loc_0060A137: var_ret_7 = Me."Height" / 2 - 125
  loc_0060A16C: edx.GetTypeInfoCount 'Ignore this.Me = Me
  loc_0060A197: var_70 = RGB(255, 255, 255)
  loc_0060A1CF: Me."ForeColor" = edx
  loc_0060A1F4: var_eax = call Proc_79_49_609950(arg_C, arg_10, var_11C)
  loc_0060A23C: call __vbaPrintObj(var_0042E978, Me, CStr(call Proc_79_49_609950(arg_C, arg_10, var_11C)) & var_0043156C, var_6C)
  loc_0060A25D: GoTo loc_0060A28A
  loc_0060A289: Exit Sub
  loc_0060A28A: 'Referenced from: 0060A25D
End Sub