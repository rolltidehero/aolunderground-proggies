ï»¿Public Sub Proc_79_46_608D90
  Dim var_6C As Screen
  Dim var_70 As Screen
  loc_00608DF1: var_ret_1 = "AOL Frame25"
  loc_00608DF4: var_eax = FindWindow(var_ret_1, 0)
  loc_00608E10: var_48 = FindWindow(var_ret_1, 0)
  loc_00608E20: var_ret_2 = "MDIClient"
  loc_00608E29: var_eax = FindWindowEx(var_48, 0, var_ret_2, 0)
  loc_00608E39: var_50 = FindWindowEx(var_48, 0, var_ret_2, 0)
  loc_00608E49: var_ret_3 = "AOL Toolbar"
  loc_00608E52: var_eax = FindWindowEx(var_48, 0, var_ret_3, 0)
  loc_00608E62: var_2C = FindWindowEx(var_48, 0, var_ret_3, 0)
  loc_00608E72: var_ret_4 = "_AOL_Toolbar"
  loc_00608E7B: var_eax = FindWindowEx(var_2C, 0, var_ret_4, 0)
  loc_00608E8B: var_28 = FindWindowEx(var_2C, 0, var_ret_4, 0)
  loc_00608E9B: var_ret_5 = "_AOL_Icon"
  loc_00608EA4: var_eax = FindWindowEx(var_28, 0, var_ret_5, 0)
  loc_00608EB4: var_60 = FindWindowEx(var_28, 0, var_ret_5, 0)
  loc_00608EC4: var_ret_6 = "_AOL_Icon"
  loc_00608ECF: var_eax = FindWindowEx(var_28, var_60, var_ret_6, 0)
  loc_00608EDC: var_60 = FindWindowEx(var_28, var_60, var_ret_6, 0)
  loc_00608EEF: var_ret_7 = "_AOL_Icon"
  loc_00608EFA: var_eax = FindWindowEx(var_28, var_60, var_ret_7, 0)
  loc_00608F0A: var_60 = FindWindowEx(var_28, var_60, var_ret_7, 0)
  loc_00608F1A: var_ret_8 = "_AOL_Icon"
  loc_00608F25: var_eax = FindWindowEx(var_28, var_60, var_ret_8, 0)
  loc_00608F35: var_60 = FindWindowEx(var_28, var_60, var_ret_8, 0)
  loc_00608F45: var_ret_9 = "_AOL_Icon"
  loc_00608F50: var_eax = FindWindowEx(var_28, var_60, var_ret_9, 0)
  loc_00608F5D: var_60 = FindWindowEx(var_28, var_60, var_ret_9, 0)
  loc_00608F70: var_ret_A = "_AOL_Icon"
  loc_00608F7B: var_eax = FindWindowEx(var_28, var_60, var_ret_A, 0)
  loc_00608F8B: var_60 = FindWindowEx(var_28, var_60, var_ret_A, 0)
  loc_00608F9B: var_ret_B = "_AOL_Icon"
  loc_00608FA6: var_eax = FindWindowEx(var_28, var_60, var_ret_B, 0)
  loc_00608FB6: var_60 = FindWindowEx(var_28, var_60, var_ret_B, 0)
  loc_00608FC6: var_ret_C = "_AOL_Icon"
  loc_00608FD1: var_eax = FindWindowEx(var_28, var_60, var_ret_C, 0)
  loc_00608FDE: var_60 = FindWindowEx(var_28, var_60, var_ret_C, 0)
  loc_00608FF1: var_ret_D = "_AOL_Icon"
  loc_00608FFC: var_eax = FindWindowEx(var_28, var_60, var_ret_D, 0)
  loc_0060900C: var_60 = FindWindowEx(var_28, var_60, var_ret_D, 0)
  loc_0060901C: var_ret_E = "_AOL_Icon"
  loc_00609027: var_eax = FindWindowEx(var_28, var_60, var_ret_E, 0)
  loc_00609037: var_60 = FindWindowEx(var_28, var_60, var_ret_E, 0)
  loc_00609040: var_eax = GetCursorPos(var_3C)
  loc_0060906F: var_6C = Global.Screen
  loc_0060909A: var_74 = Global.Width
  loc_006090E9: var_70 = Global.Screen
  loc_00609117: var_78 = Global.Height
  loc_00609149: var_eax = SetCursorPos(CLng(var_74), CLng(var_78))
  loc_00609170: var_eax = PostMessage(var_60, 513, 0, 0)
  loc_00609184: var_eax = PostMessage(var_60, 514, 0, 0)
  loc_0060918B: 
  loc_00609196: var_ret_F = "#32768"
  loc_00609199: var_eax = FindWindow(var_ret_F, 0)
  loc_006091A6: var_58 = FindWindow(var_ret_F, 0)
  loc_006091B2: var_eax = IsWindowVisible(var_58)
  loc_006091B7: var_74 = IsWindowVisible(var_58)
  loc_006091C0: If var_74 <> 1 Then GoTo loc_0060918B
  loc_006091CF: var_eax = PostMessage(var_58, 256, 38, 0)
  loc_006091E3: var_eax = PostMessage(var_58, 257, 38, 0)
  loc_006091F7: var_eax = PostMessage(var_58, 256, 38, 0)
  loc_0060920B: var_eax = PostMessage(var_58, 257, 38, 0)
  loc_0060921F: var_eax = PostMessage(var_58, 256, 13, 0)
  loc_00609233: var_eax = PostMessage(var_58, 257, 13, 0)
  loc_00609242: var_eax = SetCursorPos(var_3C, var_38)
  loc_00609258: var_ret_10 = "Get a Member's Profile"
  loc_00609264: var_ret_11 = "AOL Child"
  loc_0060926D: var_eax = FindWindowEx(var_50, 0, var_ret_11, var_ret_10)
  loc_00609284: var_24 = FindWindowEx(var_50, 0, var_ret_11, var_ret_10)
  loc_0060929B: var_ret_12 = "_AOL_Edit"
  loc_006092A4: var_eax = FindWindowEx(var_24, 0, var_ret_12, 0)
  loc_006092B1: var_54 = FindWindowEx(var_24, 0, var_ret_12, 0)
  loc_006092C4: var_ret_13 = "_AOL_Icon"
  loc_006092CD: var_eax = FindWindowEx(var_24, 0, var_ret_13, 0)
  loc_006092DA: var_34 = FindWindowEx(var_24, 0, var_ret_13, 0)
  loc_006092E7: If var_24 = 0 Then GoTo loc_00609249
  loc_006092F2: If var_54 = 0 Then GoTo loc_00609249
  loc_006092FD: If var_34 = 0 Then GoTo loc_00609249
  loc_00609318: var_eax = SendMessage(var_54, 12, 0, Me)
  loc_00609327: var_ret_15 = var_64
  loc_00609348: var_eax = SendMessage(var_34, 513, 0, 0)
  loc_00609365: var_eax = SendMessage(var_34, 514, 0, 0)
  loc_00609372: 
  loc_00609385: var_eax = call Proc_6098C0(CLng(0.6), , )
  loc_00609399: var_ret_16 = "Member Profile"
  loc_006093A5: var_ret_17 = "AOL Child"
  loc_006093AE: var_eax = FindWindowEx(var_50, 0, var_ret_17, var_ret_16)
  loc_006093C5: var_1C = FindWindowEx(var_50, 0, var_ret_17, var_ret_16)
  loc_006093DC: var_ret_18 = "_AOL_View"
  loc_006093E5: var_eax = FindWindowEx(var_1C, 0, var_ret_18, 0)
  loc_006093F5: var_44 = FindWindowEx(var_1C, 0, var_ret_18, 0)
  loc_006093FE: var_eax = call Proc_79_45_608BE0(var_44, , )
  loc_00609408: var_30 = call Proc_79_45_608BE0(var_44, , )
  loc_00609417: var_ret_19 = "America Online"
  loc_00609423: var_ret_1A = "#32770"
  loc_00609426: var_eax = FindWindow(var_ret_1A, var_ret_19)
  loc_0060943D: var_40 = FindWindow(var_ret_1A, var_ret_19)
  loc_0060944E: If var_1C = 0 Then GoTo loc_00609457
  loc_00609455: If var_44 <> 0 Then GoTo loc_00609462
  loc_00609457: 'Referenced from: 0060944E
  loc_0060945C: If var_40 = 0 Then GoTo loc_00609372
  loc_0060946D: If var_40 = 0 Then GoTo loc_00609501
  loc_0060947C: var_ret_1B = "OK"
  loc_00609488: var_ret_1C = "Button"
  loc_0060948E: var_eax = FindWindowEx(var_40, 0, var_ret_1C, var_ret_1B)
  loc_00609493: var_74 = FindWindowEx(var_40, 0, var_ret_1C, var_ret_1B)
  loc_006094BF: var_eax = SendMessage(var_74, 256, 32, var_74)
  loc_006094D5: var_eax = SendMessage(var_74, 257, 32, var_74)
  loc_006094E4: var_eax = PostMessage(var_24, 16, ebx, ebx)
  loc_006094F3: var_5C = "no profile"
  loc_006094FF: GoTo loc_0060956A
  loc_00609501: 'Referenced from: 0060946D
  loc_0060950B: var_eax = PostMessage(var_1C, 16, 0, 0)
  loc_0060951C: var_eax = PostMessage(var_24, 16, 0, 0)
  loc_00609529: var_5C = var_30
  loc_00609535: GoTo loc_0060956A
  loc_0060953B: If var_4 = 0 Then GoTo loc_00609546
  loc_00609546: 'Referenced from: 0060953B
  loc_00609569: Exit Sub
  loc_0060956A: 'Referenced from: 006094FF
End Sub