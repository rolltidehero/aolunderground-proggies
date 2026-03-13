ï»¿Private Sub Command1_Click() '5B4CD0
  Dim var_68 As TextBox
  Dim var_78 As TextBox
  loc_005B4D47: var_50 = Text2.Text
  loc_005B4D9D: var_ret_1 = vbNullString & var_50 & " - Juno"
  loc_005B4DA9: var_ret_2 = "JunoMainWndXQW21"
  loc_005B4DAC: var_eax = FindWindow(var_ret_2, var_ret_1)
  loc_005B4DF2: var_ret_3 = "Afx:400000:8"
  loc_005B4DF8: var_eax = FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0)
  loc_005B4E0E: var_28 = FindWindowEx(var_6C, 0, var_ret_3, 0)
  loc_005B4E1D: var_eax = call Proc_608D20(var_28, , )
  loc_005B4E2D: var_ret_4 = "#32770"
  loc_005B4E36: var_eax = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_005B4E43: var_38 = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_005B4E56: var_ret_5 = "Edit"
  loc_005B4E5F: var_eax = FindWindowEx(var_38, 0, var_ret_5, 0)
  loc_005B4E6F: var_24 = FindWindowEx(var_38, 0, var_ret_5, 0)
  loc_005B4E95: var_50 = Text1.Text
  loc_005B4EC9: var_eax = SendMessage(var_24, 0, 12, var_50)
  loc_005B4EF7: var_ret_7 = "Edit"
  loc_005B4F02: var_eax = FindWindowEx(var_38, var_24, var_ret_7, 0)
  loc_005B4F0F: var_40 = FindWindowEx(var_38, var_24, var_ret_7, 0)
  loc_005B4F22: var_ret_8 = "Edit"
  loc_005B4F2D: var_eax = FindWindowEx(var_38, var_40, var_ret_8, 0)
  loc_005B4F3D: var_4C = FindWindowEx(var_38, var_40, var_ret_8, 0)
  loc_005B4F63: var_50 = Text3.Text
  loc_005B4F97: var_eax = SendMessage(var_4C, 0, 12, var_50)
  loc_005B4FC5: var_ret_A = "RICHEDIT"
  loc_005B4FCC: var_eax = FindWindowEx(0, 0, var_ret_A, 0)
  loc_005B4FDC: var_48 = FindWindowEx(0, 0, var_ret_A, 0)
  loc_005B5002: var_50 = Text4.Text
  loc_005B5036: var_eax = SendMessage(var_48, 0, 12, var_50)
  loc_005B5064: var_ret_C = "Button"
  loc_005B506D: var_eax = FindWindowEx(var_38, 0, var_ret_C, 0)
  loc_005B507D: var_34 = FindWindowEx(var_38, 0, var_ret_C, 0)
  loc_005B508D: var_ret_D = "Button"
  loc_005B5098: var_eax = FindWindowEx(var_38, var_34, var_ret_D, 0)
  loc_005B50A5: var_18 = FindWindowEx(var_38, var_34, var_ret_D, 0)
  loc_005B50B8: var_ret_E = "Button"
  loc_005B50C3: var_eax = FindWindowEx(var_38, var_18, var_ret_E, 0)
  loc_005B50D3: var_1C = FindWindowEx(var_38, var_18, var_ret_E, 0)
  loc_005B50E3: var_ret_F = "Button"
  loc_005B50EE: var_eax = FindWindowEx(var_38, var_1C, var_ret_F, 0)
  loc_005B510D: var_eax = call Proc_608D20(FindWindowEx(var_38, var_1C, var_ret_F, 0), , )
  loc_005B5125: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005B5135: var_ret_10 = "Button"
  loc_005B513E: var_eax = FindWindowEx(var_38, 0, var_ret_10, 0)
  loc_005B514E: var_20 = FindWindowEx(var_38, 0, var_ret_10, 0)
  loc_005B515E: var_ret_11 = "Button"
  loc_005B5169: var_eax = FindWindowEx(var_38, var_20, var_ret_11, 0)
  loc_005B516E: var_6C = FindWindowEx(var_38, var_20, var_ret_11, 0)
  loc_005B5182: var_eax = call Proc_608D20(var_6C, , )
  loc_005B51A3: var_78 = var_68
  loc_005B51BC: var_50 = Text5.Text
  loc_005B51FF: call __vbaStrR8
  loc_005B520A: var_54 = __vbaStrR8
  loc_005B521D: call __vbaStrR8
  loc_005B5228: var_58 = __vbaStrR8
  loc_005B5235: Text5.Text = var_58
  loc_005B5297: var_50 = Text5.Text
  loc_005B52DC: GoTo loc_005B530E
  loc_005B530D: Exit Sub
  loc_005B530E: 'Referenced from: 005B52DC
  loc_005B530E: Exit Sub
End Sub