
Public Sub Proc_3_0_414910
  Dim var_14 As Screen
  var_1C = ebx.Width
  var_14 = Global.Screen
  var_18 = Global.Width
  If var_424000 <> 0 Then GoTo loc_004149F4
  GoTo loc_004149FF
  var_1C = Global.TwipsPerPixelY
  var_14 = Global.Screen
  var_18 = Global.Height
  If var_424000 <> 0 Then GoTo loc_00414AC6
  GoTo loc_00414AD1
  var_eax = Global.MousePointer =
  Exit Sub
  Exit Sub
End Sub

Public Sub GetListText
  ReleaseCapture(edi, esi)
  var_34 = eax.hWnd
  SendMessage(var_34, 161, 2, var_38)
  var_20 = SendMessage(var_34, 161, 2, var_38)
End Sub

Public Sub GetCaption
  GetWindowTextLength(Me)
  var_ret_1 = GetWindowTextLength(Me)
  var_24 = String$(si, "")
  GetWindowText(Me, var_24, var_ret_1 + 0001h)
  var_ret_3 = var_28
  var_20 = var_24
  GoTo loc_00414CE7
  If var_4 = 0 Then GoTo loc_00414CD4
  Exit Sub
  Exit Sub
End Sub

Public Sub GetClass
  var_20 = Space$(255)
  GetClassName(Me, var_20, 255)
  var_ret_2 = var_24
  var_3C = var_20
  var_18 = Trim(var_20)
  GoTo loc_00414EAC
  If var_4 = 0 Then GoTo loc_00414E99
  Exit Sub
End Sub

Public Sub ReplaceString
  var_40 = LCase(Me)
  var_78 = arg_C
  var_50 = LCase(arg_C)
  call InStr(var_60, edi, var_50, var_40, &h00000001, 0, Me, %x1 = LCase(%StkVar2))
  var_ret_1 = CLng(InStr(var_60, edi, var_50, var_40, &h00000001, 0, Me, %x1 = LCase(%StkVar2)))
  If var_ret_1 <= 0 Then GoTo loc_004150BC
  var_ret_1 = var_ret_1 - &h00000001
  var_28 = Left(Me, var_ret_1)
  Len(arg_C) = Len(arg_C) + var_ret_1
  var_8C = Len(arg_C)
  If var_8C > 0 Then GoTo loc_0041506F
  Len(Me) = Len(Me) - var_ret_1
  var_90 = Len(Me)
  var_90 = var_90 - Len(arg_C)
  var_1C = Right(Me, var_90 + &h00000001 + &h00000001)
  GoTo loc_00415083
  var_1C = vbNullString
  var_18 = var_28 & arg_10 & var_1C
  GoTo loc_004150C1
  Len(arg_10) = Len(arg_10) + var_ret_1
  If Len(arg_10) <= 0 Then GoTo loc_00415147
  var_40 = LCase(Me)
  var_78 = arg_C
  var_50 = LCase(arg_C)
  call InStr(var_60, &h00000000, var_50, var_40, Len(arg_10))
  var_ret_2 = CLng(InStr(var_60, &h00000000, var_50, var_40, Len(arg_10)))
  If var_ret_2 >= 1 Then GoTo loc_00414F81
  var_2C = var_18
  GoTo loc_00415193
  If var_4 = 0 Then GoTo loc_00415172
  Exit Sub
  Exit Sub
End Sub

Public Sub Proc_3_5_415230
  var_5C = arg_C."List1"
  var_5C = Me.arg_C
  var_5C = arg_C."List1"
  var_5C = Me.
  var_5C = arg_C."List1"
  var_5C = Me.
  If var_14 = 0 Then GoTo loc_004157B7
  var_3C = call GetCaption(var_14, , )
  If (var_3C = vbNullString) = 0 Then GoTo loc_004153F1
  var_3C = "vbNullString"
  var_5C = arg_C."List1"
  var_5C = Me.
  var_5C = arg_C."List1"
  var_5C = Me.
  var_44 = call GetClass(var_14, , )
  var_6C = arg_C."List1"
  var_6C = Me.
  If var_18 = 0 Then GoTo loc_004157B7
  var_18 = var_14
  GetWindowPlacement(var_14, 2)
  var_1C = GetWindowPlacement(var_14, 2)
  If var_A0 = 0 Then GoTo loc_0041538C
  var_2C = call GetCaption(var_1C, , )
  If (var_2C = vbNullString) = 0 Then GoTo loc_0041560B
  var_2C = "vbNullString"
  var_5C = arg_C."List1"
  var_5C = Me.
  var_5C = arg_C."List1"
  var_5C = Me.
  var_44 = call GetClass(var_1C, , )
  var_6C = arg_C."List1"
  var_6C = Me.
  GetWindowPlacement(var_1C, 2)
  var_A0 = GetWindowPlacement(var_1C, 2)
  var_1C = var_A0
  If var_A0 <> 0 Then GoTo loc_004155A3
  Exit Sub
End Sub

Public Sub Proc_3_6_415800
  var_44 = arg_C."List1"
  var_44 = Me.arg_C
  var_44 = arg_C."List1"
  var_44 = Me.
  var_44 = arg_C."List1"
  var_44 = Me.
  FindWindowEx(Me, 0, 0, 0)
  var_14 = FindWindowEx(Me, 0, 0, 0)
  var_24 = call GetCaption(var_14, , )
  If (var_24 = vbNullString) = 0 Then GoTo loc_004159C8
  var_24 = "vbNullString"
  If var_14 = 0 Then GoTo loc_00415BBD
  var_44 = arg_C."List1"
  var_44 = Me.
  var_44 = arg_C."List1"
  var_44 = Me.
  var_2C = call GetClass(var_14, , )
  var_54 = arg_C."List1"
  var_54 = Me.
  If var_14 = 0 Then GoTo loc_00415BBD
  FindWindowEx(Me, var_14, 0, 0)
  var_88 = FindWindowEx(Me, var_14, 0, 0)
  If (var_24 = vbNullString) = 0 Then GoTo loc_00415BB2
  var_24 = "vbNullString"
  If var_14 <> 0 Then GoTo loc_004159D3
  Exit Sub
End Sub

Public Sub GetCaption
  GetWindowTextLength(Me)
  var_18 = String(GetWindowTextLength(Me), "")
  GetWindowTextLength(Me) = GetWindowTextLength(Me) + &h00000001
  GetWindowText(Me, var_18, GetWindowTextLength(Me))
  var_ret_2 = var_24
  var_20 = var_18
  GoTo loc_00415DFB
  If var_4 = 0 Then GoTo loc_00415DDE
  Exit Sub
  Exit Sub
End Sub

Public Sub Proc_3_8_415E30
  Dim var_004240D0 As Variant
  Dim var_EC As Variant
  Dim var_2C4 As Variant
  On Error Resume Next
  If var_64 = 0 Then GoTo loc_00415FA2
  var_ret_1 = var_54
  var_ret_2 = var_98
  SetSystemCursor(var_ret_2, var_ret_1)
  var_218 = SetSystemCursor(var_ret_2, var_ret_1)
  If eax <> 0 Then GoTo loc_00415FF5
  call Proc_414D10(1, edi, var_ret_3 = %StkVar1)
  var_21C = call Proc_414D40(ebx, , )
  var_218 = var_ret_3
  var_84 = call Proc_414D70(var_218, var_21C, )
  call GetClass(var_84, , )
  call GetClass(var_84, , )
  ecx = eax
  var_C0 = vbNullString
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  var_C0 = vbNullString
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  var_BC = Chr(34)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  call ReplaceString(var_0042406C, var_BC, var_C0)
  var_214 = Options.Option19.Value
  If var_22C = 0 Then GoTo loc_00416672
  If (var_80 <> True) <> 0 Then GoTo loc_004216A0
  If var_84 = 0 Then GoTo loc_00416E70
  edi = edi + &h00000001
  edi+&h00000001 = edi+&h00000001 - &h00000001
  var_224 = edi+&h00000001
  If edi+&h00000001 < 1001 Then GoTo loc_004166A7
  var_eax = Err.Raise
  GetParent(edx+eax*4)
  var_84 = GetParent(edx+eax*4)
  If edi+&h00000001 < 1001 Then GoTo loc_004166E2
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_004166FE
  var_eax = Err.Raise
  call GetClass(var_84, var_EC, var_004240D0)
  call GetClass(var_84, var_EC, var_004240D0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416748
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416748
  var_eax = Err.Raise
  ecx = ecx+edi*4
  var_C0 = vbNullString
  If edi+&h00000001 < 1001 Then GoTo loc_00416791
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416791
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  var_C0 = vbNullString
  If edi+&h00000001 < 1001 Then GoTo loc_00416819
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416819
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_004168A1
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_004168A1
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416929
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416929
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_004169B1
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_004169B1
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416A39
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416A39
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416AC1
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416AC1
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416B49
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416B49
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  var_BC = Chr(34)
  If edi+&h00000001 < 1001 Then GoTo loc_00416BEA
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416BEA
  var_eax = Err.Raise
  call ReplaceString(edx+edi*4, var_BC, var_C0)
  call ReplaceString(edx+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416C80
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416C80
  var_eax = Err.Raise
  call ReplaceString(ecx+edi*4, var_BC, var_C0)
  call ReplaceString(ecx+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416D09
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416D09
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416D91
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416D91
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  If edi+&h00000001 < 1001 Then GoTo loc_00416E19
  var_eax = Err.Raise
  If edi+&h00000001 < 1001 Then GoTo loc_00416E19
  var_eax = Err.Raise
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  call ReplaceString(eax+edi*4, var_BC, var_C0)
  GoTo loc_00416672
  var_214 = Options.Option19.Value
  If var_22C = 0 Then GoTo loc_00417189
  InputBox("Please name the function?", var_110, 10, 10, 10, 10, 10)
  If (var_00424098 = 0) = 0 Then GoTo loc_004216A0
  var_C0 = vbNullString
  call ReplaceString(vbNullString, var_BC, var_C0)
  call ReplaceString(vbNullString, var_BC, var_C0)
  call ReplaceString(vbNullString, var_BC, var_C0)
  call ReplaceString(vbNullString, var_BC, var_C0)
  var_BC = Options.Option19.MousePointer
  var_D0 = var_BC & "vbCrLf" & "Public Function " & var_00424098 & "() As Long" & "vbCrLf"
  GoTo loc_004176AB
  var_214 = Options.Option4.Value
  If var_22C = 0 Then GoTo loc_00417397
  call ReplaceString(vbNullString, &h00407BE4, vbNullString)
  call var_2C4(var_EC, var_004240D0, var_004240D0, var_2C4, var_D0)
  call ReplaceString(vbNullString, &h004078B0, &h00407BEC)
  call var_2C4
  var_BC = Options.Option4.MousePointer
  var_D0 = var_BC & "vbCrLf" & "Public Function " & var_00424098 & "() As String" & "vbCrLf"
  GoTo loc_004176AB
  var_214 = Options.Option3.Value
  If var_22C = 0 Then GoTo loc_004176C0
  var_100 = "Enter the name of the sub"
  call var_2C4(var_EC, var_004240D0, var_004240D0, var_2C4, var_D0)
  If (var_00424098 = 0) = 0 Then GoTo loc_004216A0
  call ReplaceString(vbNullString, &h00407BE4, vbNullString)
  call var_2C4
  call ReplaceString(vbNullString, &h004078B0, &h00407BEC)
  call var_2C4
  var_BC = Options.Option3.MousePointer
  var_D0 = var_BC & "vbCrLf" & "Sub " & var_00424098 & "(TheText As String)" & "vbCrLf"
  Options.Option3.MousePointer = var_D0
  If var_D0 >= 0 Then GoTo loc_00417A2B
  GoTo loc_00417A19
  var_214 = Options.Option5.Value
  If var_22C = 0 Then GoTo loc_00417792
  Options.Option5.MousePointer = 0
  GoTo loc_00417A66
  var_100 = "Enter the name of the sub"
  call var_2C4(var_EC, var_004240D0, var_004240D0)
  If (var_00424098 = 0) = 0 Then GoTo loc_004216A0
  call ReplaceString(vbNullString, &h00407BE4, vbNullString)
  call var_2C4
  call ReplaceString(vbNullString, &h004078B0, &h00407BEC)
  call var_2C4
  var_BC = Options.Option5.MousePointer
  var_D0 = var_BC & "vbCrLf" & "Sub " & var_00424098 & "()" & "vbCrLf"
  Options.Option5.MousePointer = var_D0
  If var_D0 >= 0 Then GoTo loc_00417A2B
  edi+&h00000001 = edi+&h00000001 - &h00000001
  var_40 = edi+&h00000001
  edi+&h00000001 = edi+&h00000001 - &h00000001
  var_30 = edi+&h00000001
  var_BC = Options.Option5.MousePointer
  Options.Option5.MousePointer = var_BC & "Dim " & eax+ecx*4
  var_BC = Options.Option5.MousePointer
  var_C0 = var_BC & " As Long"
  Options.Option5.MousePointer = var_C0
  If var_30 = 0 Then GoTo loc_00417EA5
  var_30 = var_30 - &h00000001
  var_30 = var_30
  If var_30 < 1001 Then GoTo loc_00417BFC
  var_eax = Err.Raise
  var_1B8 = edx+edi*4
  var_110 = LCase(edx+edi*4)
  Set var_EC = Me
  var_1A8 = var_EC
  var_100 = LCase(var_EC)
  call __vbaCastObj(var_EC, var_00406B74)
  If var_30 < 1001 Then GoTo loc_00417C91
  var_eax = Err.Raise
  Len(edx+edi*4) = Len(edx+edi*4) - &h00000001
  var_120 = Left(var_110, Len(edx+edi*4))
  call InStr(var_130, &h00000000, var_120, var_100, &h00000001, Me, __vbaCastObj(var_EC, var_00406B74))
  var_22C = (InStr(var_130, &h00000000, var_120, var_100, &h00000001, Me, __vbaCastObj(var_EC, var_00406B74)) = 0)
  If var_22C = 0 Then GoTo loc_00417BDA
  var_BC = Options.Option5.MousePointer
  var_C4 = var_BC & ", " & ecx+edx*4
  Options.Option5.MousePointer = var_C4
  var_BC = Options.Option5.MousePointer
  Options.Option5.MousePointer = var_BC & " As Long"
  GoTo loc_00417BCC
  var_40 = var_40 - &h00000001
  var_214 = Options.Option19.Value
  If var_22C = 0 Then GoTo loc_004184DF
  FindWindowEx(4341812, 0, 0, 0)
  var_88 = FindWindowEx(4341812, 0, 0, 0)
  If var_218 = 0 Then GoTo loc_004184DF
  If ebx = 9 Then GoTo loc_004184DF
  var_3C = call GetClass(var_88, var_EC, var_004240D0)
  var_1A8 = var_3C
  Len(var_3C) = Len(var_3C) - &h00000001
  var_C0 = vbNullString
  call ReplaceString(Left(var_3C, Len(var_3C)), var_BC, var_C0)
  var_C0 = vbNullString
  call ReplaceString(call ReplaceString(var_3C, var_BC, var_C0), var_BC, var_C0)
  call ReplaceString(call ReplaceString(var_3C, var_BC, var_C0), var_BC, var_C0)
  var_3C = call ReplaceString(var_3C, var_BC, var_C0)
  Set var_EC = Me
  var_1A8 = var_EC
  var_100 = LCase(var_EC)
  call __vbaCastObj(var_EC, var_00406B74)
  var_1B8 = call ReplaceString(var_3C, var_BC, var_C0)
  var_110 = LCase(call ReplaceString(var_3C, var_BC, var_C0))
  call InStr(var_120, &h00000000, var_110, var_100, &h00000001, Me, __vbaCastObj(var_EC, var_00406B74))
  If CBool(InStr(var_120, &h00000000, var_110, var_100, &h00000001, Me, __vbaCastObj(var_EC, var_00406B74))) = 0 Then GoTo loc_00418347
  var_3C = var_3C & 0
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & ", " & var_3C
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & " As Long"
  Options.Option19.MousePointer = var_C0
  If var_30 < 1001 Then GoTo loc_00418488
  GoTo loc_00418482
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & ", " & var_3C
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & " As Long"
  Options.Option19.MousePointer = var_C0
  If var_30 < 1001 Then GoTo loc_00418488
  var_eax = Err.Raise
  ecx = var_3C
  var_30 = var_30 + &h00000001
  var_30 = var_30
  FindWindowEx(4341812, var_88, 0, 0)
  var_88 = FindWindowEx(4341812, var_88, 0, 0)
  GoTo loc_00417F7A
  var_40 = var_40 + &h00000001
  var_68 = var_40
  var_40 = var_40 - &h00000001
  If var_40 < 1001 Then GoTo loc_00418507
  var_eax = Err.Raise
  call GetCaption(ecx+ebx*4, , )
  call GetCaption(ecx+ebx*4, , )
  var_40 = var_40 - &h00000001
  If var_40 < 1001 Then GoTo loc_0041853C
  var_eax = Err.Raise
  var_ret_4 = var_00424078
  var_ret_5 = edx+ebx*4
  FindWindow(var_ret_5, var_ret_4)
  var_218 = FindWindow(var_ret_5, var_ret_4)
  var_40 = var_40 - &h00000001
  If var_40 < 1001 Then GoTo loc_00418592
  var_eax = Err.Raise
  var_ret_6 = var_BC
  var_ret_7 = var_C0
  var_B8 = var_218
  var_40 = var_40 - &h00000002
  If var_40 = -1 Then GoTo loc_00418902
  var_40 = var_40 - &h00000002
  If var_40 < 1001 Then GoTo loc_00418626
  var_eax = Err.Raise
  var_ret_8 = ecx+ebx*4
  var_ret_9 = var_B8
  FindWindowEx(var_ret_9, 0, var_ret_8, 0)
  var_218 = FindWindowEx(var_ret_9, 0, var_ret_8, 0)
  var_40 = var_40 - &h00000002
  If var_40 < 1001 Then GoTo loc_0041867A
  var_eax = Err.Raise
  var_ret_A = var_BC
  var_A8 = var_218
  If (var_A8 = 0) = 0 Then GoTo loc_00418902
  var_40 = var_40 - &h00000001
  var_68 = var_40
  var_40 = var_40 - &h00000001
  If var_40 = -1 Then GoTo loc_00418902
  var_40 = var_40 - &h00000001
  If var_40 < 1001 Then GoTo loc_0041872E
  var_eax = Err.Raise
  var_ret_B = eax+ebx*4
  var_ret_C = var_A8
  FindWindowEx(var_ret_C, 0, var_ret_B, 0)
  var_218 = FindWindowEx(var_ret_C, 0, var_ret_B, 0)
  var_40 = var_40 - &h00000001
  If var_40 < 1001 Then GoTo loc_00418781
  var_eax = Err.Raise
  var_ret_D = var_BC
  var_2C = var_218
  If (var_2C = 0) = 0 Then GoTo loc_00418902
  var_40 = var_40 - &h00000001
  var_68 = var_40
  var_40 = var_40 - &h00000001
  If var_40 = -1 Then GoTo loc_00418902
  var_40 = var_40 - &h00000001
  If var_40 < 1001 Then GoTo loc_00418830
  var_eax = Err.Raise
  var_ret_E = edx+ebx*4
  var_ret_F = var_A8
  FindWindowEx(var_ret_F, 0, var_ret_E, 0)
  var_218 = FindWindowEx(var_ret_F, 0, var_ret_E, 0)
  var_40 = var_40 - &h00000001
  If var_40 < 1001 Then GoTo loc_00418884
  var_eax = Err.Raise
  var_ret_10 = var_BC
  var_2C = var_218
  If (var_2C = 0) = 0 Then GoTo loc_00418902
  var_40 = var_40 - &h00000001
  var_68 = var_40
  var_214 = Options.Check4.Value
  If ebx = 0 Then GoTo loc_0041903F
  var_BC = Options.Check4.MousePointer
  var_40 = var_40 - &h00000001
  var_22C = var_40
  If var_40 < 1001 Then GoTo loc_004189CD
  var_eax = Err.Raise
  Options.Check4.MousePointer = var_BC & "vbCrLf" & eax+ecx*4
  If @%StkVar2 & %x1 >= 0 Then GoTo loc_00418A35
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC & "& = FindWindow("
  var_C0 = CStr(var_BC & "& = FindWindow(" & Chr(34))
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  var_68 = var_68 - &h00000001
  If var_68 < 1001 Then GoTo loc_00418B7F
  var_eax = Err.Raise
  var_C0 = var_BC & ecx+esi*4
  Options.Check4.MousePointer = var_C0
  var_214 = Options.Check4.Value
  If edx = 0 Then GoTo loc_00418F3C
  If var_40 < 1001 Then GoTo loc_00418C82
  var_eax = Err.Raise
  var_70 = call GetCaption(eax+esi*4, var_EC, var_004240D0)
  If (var_70 <> 0) <> 0 Then GoTo loc_00418D80
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", VbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)")
  Options.Check4.MousePointer = var_C0
  If var_C0 >= 0 Then GoTo loc_00419012
  GoTo loc_00419004
  var_eax = = Options.Check4.MousePointer
  var_108 = var_BC
  var_1B8 = var_70
  var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0)
  Options.Check4.MousePointer = var_C0
  GoTo loc_004193B7
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  Options.Check4.MousePointer = var_C0
  If var_C0 >= 0 Then GoTo loc_00419012
  GoTo loc_004193AC
  var_BC = Options.Check4.MousePointer
  var_2C4 = var_2C4 - &h00000001
  var_22C = var_2C4
  If var_2C4 < 1001 Then GoTo loc_0041908B
  var_eax = Err.Raise
  var_C4 = var_BC & "vbCrLf" & ecx+edx*4
  Options.Check4.MousePointer = var_C4
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC & "& = FindWindow("
  var_C0 = CStr(var_BC & "& = FindWindow(" & Chr(34))
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  var_68 = var_68 - &h00000001
  If var_68 < 1001 Then GoTo loc_0041923E
  var_eax = Err.Raise
  var_C0 = var_BC & ecx+esi*4
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ",vbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ",vbNullString)")
  Options.Check4.MousePointer = var_C0
  var_68 = var_68 - &h00000002
  var_38 = var_68
  var_1B8 = var_68
  For var_B8 = 0 To var_68 Step 1
  If var_B8 = 0 Then GoTo loc_0041C72B
  If var_68 = -1 Then GoTo loc_0041C72B
  var_214 = Options.Option19.Value
  If edx = 0 Then GoTo loc_004194CC
  If var_68 = 1 Then GoTo loc_0041C72B
  var_214 = Options.Option19.Value
  If edx = 0 Then GoTo loc_004195B2
  var_1B8 = var_68
  If (var_B8 + 2 <> var_68) <> 0 Then GoTo loc_0041BD07
  If var_38 < 1001 Then GoTo loc_004195C3
  var_eax = Err.Raise
  If var_44 = 0 Then GoTo loc_0041BCC9
  If var_38 <> 0 Then GoTo loc_00419735
  If &h00000001 < 1001 Then GoTo loc_004195F0
  var_eax = Err.Raise
  var_ret_11 = CInt(4341840)
  FindWindowEx(ecx+esi*4, 0, var_ret_11, 0)
  var_218 = FindWindowEx(ecx+esi*4, 0, var_ret_11, 0)
  var_ret_12 = var_BC
  If var_218 = &h00424034 Then GoTo loc_0041971C
  If var_38 < 1001 Then GoTo loc_0041966A
  var_eax = Err.Raise
  If var_218 = 0 Then GoTo loc_0041972B
  If var_38 < 1001 Then GoTo loc_00419682
  var_eax = Err.Raise
  var_38 = var_38 + &h00000001
  If var_38 < 1001 Then GoTo loc_0041969B
  var_eax = Err.Raise
  var_ret_13 = ecx+ebx*4
  FindWindowEx(ecx+esi*4, var_218, var_ret_13, 0)
  var_218 = FindWindowEx(ecx+esi*4, var_218, var_ret_13, 0)
  If var_38 < 1001 Then GoTo loc_004196DF
  var_eax = Err.Raise
  var_ret_14 = var_BC
  var_34 = var_34 + &h00000001
  var_34 = var_34
  GoTo loc_0041965A
  var_34 = var_34 + &h00000001
  var_34 = var_34
  If var_34 >= 4 Then GoTo loc_0041B252
  If var_38 < 1001 Then GoTo loc_00419743
  var_eax = Err.Raise
  var_38 = var_38 + &h00000001
  If var_38 < 1001 Then GoTo loc_0041975E
  var_eax = Err.Raise
  var_ret_15 = edx+ebx*4
  FindWindowEx(edx+esi*4, 0, var_ret_15, 0)
  var_218 = FindWindowEx(edx+esi*4, 0, var_ret_15, 0)
  If var_38 < 1001 Then GoTo loc_0041979F
  var_eax = Err.Raise
  var_ret_16 = var_BC
  var_44 = var_218
  If var_38 < 1001 Then GoTo loc_004197D5
  var_eax = Err.Raise
  If var_218 = 0 Then GoTo loc_0041AAD3
  If var_38 < 1001 Then GoTo loc_004197F7
  var_eax = Err.Raise
  If var_44 = 0 Then GoTo loc_0041A172
  If var_38 < 1001 Then GoTo loc_00419812
  var_eax = Err.Raise
  var_38 = var_38 + &h00000001
  If var_38 < 1001 Then GoTo loc_00419827
  var_eax = Err.Raise
  var_ret_17 = ecx+edi*4
  FindWindowEx(edx+esi*4, var_44, var_ret_17, 0)
  var_218 = FindWindowEx(edx+esi*4, var_44, var_ret_17, 0)
  If var_38 < 1001 Then GoTo loc_0041986A
  var_eax = Err.Raise
  var_ret_18 = var_BC
  var_44 = var_218
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & "vbCrLf" & eax+ecx*4
  var_C8 = var_C4 & var_00407DEC
  Options.Option19.MousePointer = var_C8
  var_BC = Options.Option19.MousePointer
  var_38 = var_38 + &h00000001
  If var_38 < 1001 Then GoTo loc_004199B2
  var_eax = Err.Raise
  var_C4 = var_BC & "& = FindWindowEx(" & edx+edi*4
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & "&, "
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & eax+ebx*4
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_108 = var_BC & "&, "
  var_100 = Chr(34)
  var_C0 = var_BC & "&, " & var_100
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & eax+ebx*4
  Options.Option19.MousePointer = var_C0
  var_214 = Options.Check4.Value
  If eax = 0 Then GoTo loc_0041A079
  If var_38 < 1001 Then GoTo loc_00419D97
  var_eax = Err.Raise
  var_70 = call GetCaption(ecx+esi*4, var_EC, var_004240D0)
  If (var_70 <> 0) <> 0 Then GoTo loc_00419EC0
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", VbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)")
  Options.Check4.MousePointer = var_C0
  GoTo loc_004197E4
  If (var_70 = 0) = 0 Then GoTo loc_004197E4
  var_BC = Options.Check4.MousePointer
  If var_BC >= 0 Then GoTo loc_00419EF9
  call ecx(var_BC, Me, var_00406B74, &h000000A0, var_004240D0)
  var_108 = var_BC
  var_1B8 = var_70
  var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0)
  Options.Check4.MousePointer = var_C0
  GoTo loc_004197E4
  var_BC = Options.Check4.MousePointer
  If var_BC >= 0 Then GoTo loc_0041A0A2
  call edx(var_BC, Me, var_00406B74, &h000000A0)
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  Options.Check4.MousePointer = var_C0
  GoTo loc_004197E4
  var_BC = Options.Check4.MousePointer
  var_C8 = var_BC & "vbCrLf" & edx+eax*4 & var_00407DEC
  Options.Check4.MousePointer = var_C8
  var_BC = Options.Check4.MousePointer
  var_38 = var_38 + &h00000001
  If var_38 < 1001 Then GoTo loc_0041A28F
  var_eax = Err.Raise
  var_C4 = var_BC & "& = FindWindowEx(" & ecx+edi*4
  Options.Check4.MousePointer = var_C4
  var_BC = Options.Check4.MousePointer
  var_C0 = var_BC & "&, "
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  var_C0 = var_BC & ecx+edi*4
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC & "&, "
  var_100 = Chr(34)
  var_C0 = var_BC & "&, " & var_100
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  var_C0 = var_BC & ecx+ebx*4
  Options.Check4.MousePointer = var_C0
  var_214 = Options.Check4.Value
  If edx = 0 Then GoTo loc_0041A9AA
  If var_38 < 1001 Then GoTo loc_0041A658
  var_eax = Err.Raise
  var_70 = call GetCaption(eax+esi*4, var_EC, var_004240D0)
  If (var_70 <> 0) <> 0 Then GoTo loc_0041A7B0
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", VbNullString)"
  var_1B8 = "vbCrLf"
  var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)" & "vbCrLf")
  Options.Check4.MousePointer = var_C0
  GoTo loc_004195B2
  If (var_70 = 0) = 0 Then GoTo loc_004195B2
  var_BC = Options.Check4.MousePointer
  If var_BC >= 0 Then GoTo loc_0041A7E9
  call eax(var_BC, var_BC, var_00406B74, &h000000A0, var_004240D0)
  var_108 = var_BC
  var_1B8 = var_70
  var_1D8 = "vbCrLf"
  var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0 & "vbCrLf")
  Options.Check4.MousePointer = var_C0
  GoTo loc_004195B2
  var_BC = Options.Check4.MousePointer
  If var_BC >= 0 Then GoTo loc_0041A9D3
  call ecx(var_BC, Me, var_00406B74, &h000000A0)
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  var_1B8 = "vbCrLf"
  var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)" & "vbCrLf")
  Options.Check4.MousePointer = var_C0
  GoTo loc_004195B2
  var_BC = Options.Check4.MousePointer
  var_C4 = var_BC & "vbCrLf" & ecx+ebx*4
  Options.Check4.MousePointer = var_C4
  var_BC = Options.Check4.MousePointer
  esi = esi + &h00000001
  If esi < 1001 Then GoTo loc_0041ABD1
  var_eax = Err.Raise
  var_C4 = var_BC & "& = FindWindowEx(" & ecx+edi*4
  Options.Check4.MousePointer = var_C4
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC & "&, 0&,"
  var_C0 = CStr(var_BC & "&, 0&," & Chr(34))
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  var_C0 = var_BC & ecx+ebx*4
  Options.Check4.MousePointer = var_C0
  var_214 = Options.Check4.Value
  If edx = 0 Then GoTo loc_0041B159
  If var_38 < 1001 Then GoTo loc_0041AE78
  var_eax = Err.Raise
  var_70 = call GetCaption(eax+esi*4, var_EC, var_004240D0)
  If (var_70 <> 0) <> 0 Then GoTo loc_0041AFA0
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", VbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)")
  Options.Check4.MousePointer = var_C0
  GoTo loc_004195B2
  If (var_70 = 0) = 0 Then GoTo loc_004195B2
  var_BC = Options.Check4.MousePointer
  If var_BC >= 0 Then GoTo loc_0041AFD9
  call eax(var_BC, var_BC, var_00406B74, &h000000A0, var_004240D0)
  var_108 = var_BC
  var_1B8 = var_70
  var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0)
  Options.Check4.MousePointer = var_C0
  GoTo loc_004195B2
  var_BC = Options.Check4.MousePointer
  If var_BC >= 0 Then GoTo loc_0041B182
  call ecx(var_BC, Me, var_00406B74, &h000000A0)
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  Options.Check4.MousePointer = var_C0
  GoTo loc_004195B2
  var_BC = Options.Check4.MousePointer
  var_C4 = var_BC & "vbCrLf" & "Dim X As Long"
  Options.Check4.MousePointer = var_C4
  var_BC = Options.Check4.MousePointer
  var_D0 = var_BC & "vbCrLf" & "For X = 0 To " & var_34 & "vbCrLf"
  Options.Check4.MousePointer = var_D0
  var_BC = Options.Check4.MousePointer
  var_C0 = var_BC & ecx+ebx*4
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  esi = esi + &h00000001
  var_22C = esi+&h00000001
  If esi < 1001 Then GoTo loc_0041B4E7
  var_eax = Err.Raise
  var_C4 = var_BC & " = FindWindowEx(" & eax+ecx*4
  Options.Check4.MousePointer = var_C4
  var_BC = Options.Check4.MousePointer
  var_C4 = var_BC & ", " & ecx+ebx*4
  Options.Check4.MousePointer = var_C4
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC & ", "
  var_100 = Chr(34)
  If esi < 1001 Then GoTo loc_0041B696
  var_eax = Err.Raise
  var_1A8 = edx+ebx*4
  var_C0 = var_BC & ", " & var_100 & edx+ebx*4
  Options.Check4.MousePointer = var_C0
  var_214 = Options.Check4.Value
  If edx = 0 Then GoTo loc_0041BB1D
  If esi < 1001 Then GoTo loc_0041B7E2
  var_eax = Err.Raise
  var_70 = call GetCaption(eax+ebx*4, var_EC, var_004240D0)
  If (var_70 <> 0) <> 0 Then GoTo loc_0041B937
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", VbNullString)"
  var_1B8 = "vbCrLf"
  var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)" & "vbCrLf")
  Options.Check4.MousePointer = var_C0
  GoTo loc_0041BC3E
  If (var_70 = 0) = 0 Then GoTo loc_0041BC49
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1B8 = var_70
  var_1D8 = "vbCrLf"
  var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0 & "vbCrLf")
  Options.Check4.MousePointer = var_C0
  GoTo loc_0041BC49
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  var_1B8 = "vbCrLf"
  var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)" & "vbCrLf")
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  var_C0 = var_BC & "Next X"
  Options.Check4.MousePointer = var_C0
  var_38 = var_38 - &h00000001
  var_38 = var_38
  Next var_B8
  GoTo loc_0041942C
  If var_38 < 1001 Then GoTo loc_0041BD16
  var_eax = Err.Raise
  var_38 = var_38 + &h00000001
  If var_38 < 1001 Then GoTo loc_0041BD30
  var_eax = Err.Raise
  var_ret_19 = ecx+edx*4
  FindWindowEx(edx+esi*4, 0, var_ret_19, 0)
  var_218 = FindWindowEx(edx+esi*4, 0, var_ret_19, 0)
  If var_38 < 1001 Then GoTo loc_0041BD79
  var_eax = Err.Raise
  var_ret_1A = var_BC
  var_BC = Options.Check4.MousePointer
  Options.Check4.MousePointer = var_BC & "vbCrLf" & eax+ecx*4 & var_00407DEC
  var_BC = Options.Check4.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041BEC7
  var_eax = Err.Raise
  Options.Check4.MousePointer = var_BC & "& = FindWindowEx(" & eax+ecx*4
  var_BC = Options.Check4.MousePointer
  var_C0 = var_BC & "&, "
  Options.Check4.MousePointer = var_C0
  var_BC = Options.Check4.MousePointer
  Options.Check4.MousePointer = var_BC & eax+ecx*4
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC & "&, "
  Options.Check4.MousePointer = CStr(var_BC & "&, " & Chr(34))
  var_BC = Options.Check4.MousePointer
  var_C0 = var_BC & ecx+edx*4
  Options.Check4.MousePointer = var_C0
  var_214 = Options.Check4.Value
  If edx = 0 Then GoTo loc_0041C5F5
  If var_38 < 1001 Then GoTo loc_0041C288
  var_eax = Err.Raise
  var_70 = call GetCaption(eax+esi*4, var_EC, var_004240D0)
  If (var_70 <> 0) <> 0 Then GoTo loc_0041C3E7
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", VbNullString)"
  var_1B8 = "vbCrLf"
  Options.Check4.MousePointer = CStr(var_BC & Chr(34) & ", VbNullString)" & "vbCrLf")
  GoTo loc_0041C720
  If (var_70 = 0) = 0 Then GoTo loc_0041C72B
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1B8 = var_70
  var_1D8 = "vbCrLf"
  var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0 & "vbCrLf")
  Options.Check4.MousePointer = var_C0
  GoTo loc_0041C72B
  var_BC = Options.Check4.MousePointer
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  var_1B8 = "vbCrLf"
  var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)" & "vbCrLf")
  Options.Check4.MousePointer = var_C0
  If arg_C = var_FFFFFF Then GoTo loc_004216A0
  var_214 = Options.Option1.Value
  If eax = 0 Then GoTo loc_0041CAAE
  var_BC = Options.Option1.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041C808
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "PostMessage " & edx+eax*4
  Options.Option1.MousePointer = var_C8
  var_BC = Options.Option1.MousePointer
  var_C0 = var_BC & "&, WM_LBUTTONDOWN, 0&, 0&"
  Options.Option1.MousePointer = var_C0
  var_BC = Options.Option1.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041C980
  var_eax = Err.Raise
  Options.Option1.MousePointer = var_BC & "vbCrLf" & "PostMessage " & eax+ecx*4
  var_BC = Options.Option1.MousePointer
  Options.Option1.MousePointer = var_BC & "&, WM_LBUTTONUP, 0&, 0&"
  GoTo loc_004212C7
  var_214 = Options.Option2.Value
  If edx = 0 Then GoTo loc_0041CE02
  var_BC = Options.Option2.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041CB7E
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessage " & ecx+edx*4
  Options.Option2.MousePointer = var_C8
  var_BC = Options.Option2.MousePointer
  var_C0 = var_BC & "&, &H201, 0&, 0&"
  Options.Option2.MousePointer = var_C0
  var_BC = Options.Option2.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041CCF6
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessage " & edx+eax*4
  Options.Option2.MousePointer = var_C8
  var_BC = Options.Option2.MousePointer
  var_C0 = var_BC & "&, &H202, 0&, 0&"
  Options.Option2.MousePointer = var_C0
  If var_C0 >= 0 Then GoTo loc_0041F877
  GoTo loc_0041F869
  var_214 = Options.Option3.Value
  If eax = 0 Then GoTo loc_0041CFCE
  var_BC = Options.Option3.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041CED2
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessageByString " & edx+eax*4
  Options.Option3.MousePointer = var_C8
  var_BC = Options.Option3.MousePointer
  var_C0 = var_BC & "&, WM_SETTEXT, 0&, TheText$"
  GoTo loc_0041CDED
  var_214 = Options.Option4.Value
  If eax = 0 Then GoTo loc_0041D641
  var_BC = Options.Option4.MousePointer
  var_C4 = var_BC & "vbCrLf" & "Dim TheText As String, TL As Long"
  Options.Option4.MousePointer = var_C4
  var_BC = Options.Option4.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041D145
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "TL& = SendMessageLong(" & ecx+edx*4
  Options.Option4.MousePointer = var_C8
  var_BC = Options.Option4.MousePointer
  var_C0 = var_BC & "&, WM_GETTEXTLENGTH, 0&, 0&)"
  Options.Option4.MousePointer = var_C0
  var_BC = Options.Option4.MousePointer
  var_C0 = var_BC & "vbCrLf"
  var_108 = var_C0 & "TheText$ = String$(TL& + 1, "
  var_C4 = CStr(var_C0 & "TheText$ = String$(TL& + 1, " & Chr(34) & &H407BE4 & Chr(34) & &H407DB0)
  Options.Option4.MousePointer = var_C4
  var_BC = Options.Option4.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041D44D
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "Call SendMessageByString(" & edx+eax*4
  Options.Option4.MousePointer = var_C8
  var_BC = Options.Option4.MousePointer
  var_C0 = var_BC & "&, WM_GETTEXT, TL + 1, TheText$)"
  Options.Option4.MousePointer = var_C0
  var_BC = Options.Option4.MousePointer
  var_C8 = var_BC & "vbCrLf" & var_00424098 & " = Left(TheText$, TL&)"
  Options.Option4.MousePointer = var_C8
  GoTo loc_004212C7
  var_214 = Options.Option5.Value
  If edx <> 0 Then GoTo loc_004216A0
  var_214 = Options.Option6.Value
  If edx = 0 Then GoTo loc_0041DA07
  var_BC = Options.Option6.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041D793
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "PostMessage " & ecx+edx*4
  Options.Option6.MousePointer = var_C8
  var_BC = Options.Option6.MousePointer
  var_C0 = var_BC & "&, &H201, 0&, 0&"
  Options.Option6.MousePointer = var_C0
  var_BC = Options.Option6.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041D90B
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "PostMessage " & edx+eax*4
  Options.Option6.MousePointer = var_C8
  var_BC = Options.Option6.MousePointer
  var_C0 = var_BC & "&, &H202, 0&, 0&"
  GoTo loc_0041CDED
  var_214 = Options.Option7.Value
  If eax = 0 Then GoTo loc_0041DD4A
  var_BC = Options.Option7.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041DAD7
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessage " & edx+eax*4
  Options.Option7.MousePointer = var_C8
  var_BC = Options.Option7.MousePointer
  var_C0 = var_BC & "&, &H204, 0&, 0&"
  Options.Option7.MousePointer = var_C0
  var_BC = Options.Option7.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041DC4F
  var_eax = Err.Raise
  Options.Option7.MousePointer = var_BC & "vbCrLf" & "SendMessage " & eax+ecx*4
  var_BC = Options.Option7.MousePointer
  var_C0 = var_BC & "&, &H205, 0&, 0&"
  GoTo loc_0041CA76
  var_214 = Options.Option8.Value
  If edx = 0 Then GoTo loc_0041DF49
  var_BC = Options.Option8.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041DE1A
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessage " & ecx+edx*4
  Options.Option8.MousePointer = var_C8
  var_BC = Options.Option8.MousePointer
  var_C0 = var_BC & "&, &H203, 0&, 0&"
  Options.Option8.MousePointer = var_C0
  GoTo loc_004212C7
  var_214 = Options.Option9.Value
  If edx = 0 Then GoTo loc_0041E115
  var_BC = Options.Option9.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041E019
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "EnableWindow " & ecx+edx*4
  Options.Option9.MousePointer = var_C8
  var_BC = Options.Option9.MousePointer
  var_C0 = var_BC & "&, 1"
  GoTo loc_0041DF11
  var_214 = Options.Option10.Value
  If edx = 0 Then GoTo loc_0041E2E1
  var_BC = Options.Option10.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041E1E5
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "EnableWindow " & ecx+edx*4
  Options.Option10.MousePointer = var_C8
  var_BC = Options.Option10.MousePointer
  var_C0 = var_BC & "&, 0"
  GoTo loc_0041DF11
  var_214 = Options.Option11.Value
  If edx = 0 Then GoTo loc_0041E4AD
  var_BC = Options.Option11.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041E3B1
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "ShowWindow " & ecx+edx*4
  Options.Option11.MousePointer = var_C8
  var_BC = Options.Option11.MousePointer
  var_C0 = var_BC & "&, 1"
  GoTo loc_0041DF11
  var_214 = Options.Option12.Value
  If edx = 0 Then GoTo loc_0041E679
  var_BC = Options.Option12.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041E57D
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "ShowWindow " & ecx+edx*4
  Options.Option12.MousePointer = var_C8
  var_BC = Options.Option12.MousePointer
  var_C0 = var_BC & "&, 0"
  GoTo loc_0041DF11
  var_214 = Options.Option13.Value
  If edx = 0 Then GoTo loc_0041E845
  var_BC = Options.Option13.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041E749
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessage " & ecx+edx*4
  Options.Option13.MousePointer = var_C8
  var_BC = Options.Option13.MousePointer
  var_C0 = var_BC & "&, &H10, 0&, 0&"
  GoTo loc_0041DF11
  var_214 = Options.Option14.Value
  If edx = 0 Then GoTo loc_0041EFBF
  var_214 = Options.Check1.Value
  If edx = 0 Then GoTo loc_0041EAFB
  var_BC = Options.Check1.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041E997
  var_eax = Err.Raise
  var_D0 = var_BC & "vbCrLf" & "Dim Count as long" & "vbCrLf" & " Count& = SendMessageLong(" & ecx+edx*4
  Options.Check1.MousePointer = var_D0
  var_BC = Options.Check1.MousePointer
  Options.Check1.MousePointer = var_BC & "&, &H18B, 0&, 0&)"
  var_214 = Options.Check2.Value
  If edx = 0 Then GoTo loc_0041EDB9
  var_BC = Options.Check2.MousePointer
  var_CC = var_BC & "vbCrLf" & "Dim Text as String, Index as long" & "vbCrLf" & "TheText$ = String$(255, 0)"
  Options.Check2.MousePointer = var_CC
  var_BC = Options.Check2.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041ECAC
  var_eax = Err.Raise
  var_C4 = var_BC & "Call SendMessageByString(" & edx+eax*4
  Options.Check2.MousePointer = var_C4
  var_BC = Options.Check2.MousePointer
  var_C0 = var_BC & "&, &H189, Index&, Text$)"
  Options.Check2.MousePointer = var_C0
  var_214 = Options.Check3.Value
  If edx = 0 Then GoTo loc_004212C7
  var_BC = Options.Check3.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041EE89
  var_eax = Err.Raise
  var_D0 = var_BC & "vbCrLf" & "Dim Index as long" & "vbCrLf" & "SendMessageLong " & ecx+edx*4
  Options.Check3.MousePointer = var_D0
  var_BC = Options.Check3.MousePointer
  var_C0 = var_BC & "&, &H186, 0, 0&"
  GoTo loc_0041CA76
  var_214 = Options.Option15.Value
  If edx = 0 Then GoTo loc_0041F186
  var_BC = Options.Option15.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041F08A
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessageLong " & ecx+edx*4
  Options.Option15.MousePointer = var_C8
  var_BC = Options.Option15.MousePointer
  var_C0 = var_BC & "&, BM_SETCHECK, True, 0&"
  GoTo loc_0041DF11
  var_214 = Options.Option16.Value
  If edx = 0 Then GoTo loc_0041F352
  var_BC = Options.Option16.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041F256
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessageLong " & ecx+edx*4
  Options.Option16.MousePointer = var_C8
  var_BC = Options.Option16.MousePointer
  var_C0 = var_BC & "&, BM_SETCHECK, False, 0&"
  GoTo loc_0041DF11
  var_214 = Options.Option17.Value
  If edx = 0 Then GoTo loc_0041F696
  var_BC = Options.Option17.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041F422
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "PostMessage " & ecx+edx*4
  Options.Option17.MousePointer = var_C8
  var_BC = Options.Option17.MousePointer
  var_C0 = var_BC & "&, WM_LBUTTONDOWN, 0&, 0&)"
  Options.Option17.MousePointer = var_C0
  var_BC = Options.Option17.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041F59A
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "PostMessage " & edx+eax*4
  Options.Option17.MousePointer = var_C8
  var_BC = Options.Option17.MousePointer
  var_C0 = var_BC & "&, WM_LBUTTONUP, 0&, 0&"
  GoTo loc_0041CDED
  var_214 = Options.Option18.Value
  If eax = 0 Then GoTo loc_0041F895
  var_BC = Options.Option18.MousePointer
  var_38 = var_38 + &h00000001
  var_22C = var_38
  If var_38 < 1001 Then GoTo loc_0041F766
  var_eax = Err.Raise
  var_C8 = var_BC & "vbCrLf" & "SendMessageLong " & edx+eax*4
  Options.Option18.MousePointer = var_C8
  var_BC = Options.Option18.MousePointer
  var_C0 = var_BC & "&, WM_CHAR, 13, 0&"
  Options.Option18.MousePointer = var_C0
  If var_C0 >= 0 Then GoTo loc_0041F877
  GoTo loc_004212C7
  var_214 = Options.Option19.Value
  If eax = 0 Then GoTo loc_004212C7
  FindWindowEx(4341812, 0, 0, 0)
  var_88 = FindWindowEx(4341812, 0, 0, 0)
  If var_218 = 0 Then GoTo loc_0041FD7F
  If esi = 9 Then GoTo loc_0041FD7F
  var_BC = Options.Option19.MousePointer
  Options.Option19.MousePointer = var_BC & "vbCrLf" & ecx+esi*4
  var_3C = call GetClass(var_88, , )
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & "& = FindWindowEx("
  var_C4 = var_C0 & 4341868
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_108 = var_BC & "&, 0&, "
  var_100 = Chr(34)
  var_C0 = var_BC & "&, 0&, " & var_100
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & var_3C
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  Options.Option19.MousePointer = var_C0
  var_30 = var_30 + &h00000001
  var_30 = var_30
  FindWindowEx(4341812, var_88, 0, 0)
  var_88 = FindWindowEx(4341812, var_88, 0, 0)
  GoTo loc_0041F948
  var_30 = var_30 - &h00000001
  var_30 = var_30
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & "vbCrLf" & "If "
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & ecx+edx*4
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & " <> 0"
  Options.Option19.MousePointer = var_C0
  var_30 = var_30 - &h00000001
  var_30 = var_30
  If var_30 <= 0 Then GoTo loc_004200EC
  var_BC = Options.Option19.MousePointer
  Options.Option19.MousePointer = var_BC & " And " & ecx+esi*4
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & " <> 0"
  Options.Option19.MousePointer = var_C0
  var_30 = var_30 - &h00000001
  var_30 = var_30
  GoTo loc_0041FF6C
  var_2C4 = var_43C
  var_BC = Options.Option19.MousePointer
  Options.Option19.MousePointer = var_BC & "Then" & "vbCrLf" & var_00424098 & "& = " & 4341868
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & var_004085F8 & "vbCrLf"
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  Options.Option19.MousePointer = var_BC & "Exit Function" & "vbCrLf" & "Else" & "vbCrLf" & "Do Until " & 4341868
  var_BC = Options.Option19.MousePointer
  Options.Option19.MousePointer = var_BC & "& = 0&" & "vbCrLf"
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & 4341868
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & " = FindWindowEx(" & edx+&h00000004
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & "&, " & 4341868
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_108 = var_BC & "&, "
  var_C0 = CStr(var_BC & "&, " & Chr(34) & &H424050)
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  Options.Option19.MousePointer = CStr(var_BC & Chr(34) & ", vbNullString)")
  FindWindowEx(4341812, 0, 0, 0)
  var_88 = FindWindowEx(4341812, 0, 0, 0)
  If var_218 = 0 Then GoTo loc_00420CC3
  If esi = 9 Then GoTo loc_00420CC3
  var_BC = Options.Option19.MousePointer
  var_464 = var_2C4
  var_C4 = var_BC & "vbCrLf" & edx+esi*4
  Options.Option19.MousePointer = var_C4
  var_3C = call GetClass(var_88, , )
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & "& = FindWindowEx(" & 4341868
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_108 = var_BC & "&, 0&, "
  var_C0 = CStr(var_BC & "&, 0&, " & Chr(34))
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & var_3C
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  var_108 = var_BC
  var_1A8 = ", vbNullString)"
  var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  Options.Option19.MousePointer = var_C0
  var_30 = var_30 + &h00000001
  var_30 = var_30
  FindWindowEx(4341812, var_88, 0, 0)
  var_218 = FindWindowEx(4341812, var_88, 0, 0)
  var_88 = var_218
  GoTo loc_0042088C
  var_30 = var_30 - &h00000001
  var_30 = var_30
  var_BC = Options.Option19.MousePointer
  Options.Option19.MousePointer = var_BC & "vbCrLf" & "If "
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & edx+eax*4
  Options.Option19.MousePointer = var_C0
  var_BC = Options.Option19.MousePointer
  Options.Option19.MousePointer = var_BC & " <> 0"
  var_30 = var_30 - &h00000001
  var_30 = var_30
  If var_30 <= 0 Then GoTo loc_00421018
  var_BC = Options.Option19.MousePointer
  var_C4 = var_BC & " And " & ecx+edx*4
  Options.Option19.MousePointer = var_C4
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & " <> 0"
  Options.Option19.MousePointer = var_C0
  var_30 = var_30 - &h00000001
  var_30 = var_30
  GoTo loc_00420EB0
  var_BC = Options.Option19.MousePointer
  var_D0 = var_BC & "Then" & "vbCrLf" & var_00424098 & "& = " & 4341868
  Options.Option19.MousePointer = var_D0
  var_BC = Options.Option19.MousePointer
  var_CC = var_BC & var_004085F8 & "vbCrLf" & "Exit Function" & "vbCrLf"
  var_DC = var_CC & "End If" & "vbCrLf" & "Loop" & "vbCrLf"
  var_E8 = var_DC & "End If" & "vbCrLf" & "End Function"
  Options.Option19.MousePointer = var_E8
  var_214 = Options.Option4.Value
  If eax = 0 Then GoTo loc_00421400
  var_BC = Options.Option4.MousePointer
  var_C4 = var_BC & "vbCrLf" & "End Function"
  Options.Option4.MousePointer = var_C4
  Exit Sub
  GoTo loc_0042177E
  var_214 = Options.Option19.Value
  If edx <> 0 Then GoTo loc_004216A0
  var_BC = Options.Option19.MousePointer
  var_C0 = var_BC & "vbCrLf"
  var_C4 = var_C0 & "End Sub"
  Options.Option19.MousePointer = var_C4
  Exit Sub
  GoTo loc_0042177E
  var_F8 = var_218 & ", " & var_C0
  Exit Sub
  Exit Sub
  Exit Sub
End Sub
