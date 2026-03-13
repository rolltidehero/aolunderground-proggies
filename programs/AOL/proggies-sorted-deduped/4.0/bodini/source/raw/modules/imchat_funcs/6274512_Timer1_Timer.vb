Private Sub Timer1_Timer() '5FBDD0
  Dim var_F0 As Variant
  Dim var_60 As ListBox
  Dim var_F8 As TextBox
  loc_005FBE7C: var_ret_1 = "AOL Frame25"
  loc_005FBE7F: var_eax = FindWindow(var_ret_1, 0)
  loc_005FBE9F: var_18 = FindWindow(var_ret_1, 0)
  loc_005FBEB2: var_ret_3 = "MDIClient"
  loc_005FBEBB: var_eax = FindWindowEx(var_18, edi, var_ret_3, 0)
  loc_005FBED3: var_1C = FindWindowEx(var_18, edi, var_ret_3, 0)
  loc_005FBEDF: var_BC = ">Instant Message From: "
  loc_005FBF0D: var_F0 = var_60
  loc_005FBF14: var_50 = CInt(var_54)
  loc_005FBF1A: var_130 = var_50
  loc_005FBF2E: var_60 = List1.List(var_50)
  loc_005FBF5D: var_6C = var_54
  loc_005FBF98: var_ret_5 = CStr(">Instant Message From: " + LCase(var_54))
  loc_005FBFA6: var_eax = FindWindowEx(var_1C, edi, edi, var_ret_5)
  loc_005FBFBB: var_20 = FindWindowEx(var_1C, edi, edi, var_ret_5)
  loc_005FC02B: var_E8 = List1.ListCount
  loc_005FC056: var_E8 = var_E8 - 0001h
  loc_005FC066: var_CC = var_E8
  loc_005FC09F: For var_50 = "" To var_E8 Step 1
  loc_005FC0B2: If var_50 = 0 Then GoTo loc_005FC2C7
  loc_005FC0BC: If var_20 = 0 Then GoTo loc_005FC2A8
  loc_005FC0D8: var_F8 = var_50
  loc_005FC0F7: var_54 = Text1.Text
  loc_005FC127: var_134 = var_F8
  loc_005FC13B: Text1.SelStart = Len(var_54)
  loc_005FC19F: var_BC = "vbCrLf"
  loc_005FC21D: var_54 = CStr("vbCrLf" & var_30 & &H431C88 & Chr(9) & var_40)
  loc_005FC22D: Text1.SelText = var_54
  loc_005FC29D: var_eax = SendMessage(var_20, 16, edi, var_E8)
  loc_005FC2A8: 'Referenced from: 005FC0BC
  loc_005FC2BA: Next var_50
  loc_005FC2C2: GoTo loc_005FC0B0
  loc_005FC2C7: 'Referenced from: 005FC0B2
  loc_005FC2CF: GoTo loc_005FC321
  loc_005FC320: Exit Sub
  loc_005FC321: 'Referenced from: 005FC2CF
  loc_005FC34F: Exit Sub
End Sub