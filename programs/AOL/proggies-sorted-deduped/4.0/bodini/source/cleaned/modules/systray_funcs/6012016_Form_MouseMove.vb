ï»¿Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single) '5BBC70
  Dim var_2C As Screen
  loc_005BBCF3: var_2C = Global.Screen
  loc_005BBD17: var_80 = Global.TwipsPerPixelX
  loc_005BBD4B: If var_60C000 <> 0 Then GoTo loc_005BBD52
  loc_005BBD50: GoTo loc_005BBD5A
  loc_005BBD52: 'Referenced from: 005BBD4B
  loc_005BBD55: call _adj_fdiv_m32(var_80, 0, Me, ebx)
  loc_005BBD5A: 'Referenced from: 005BBD50
  loc_005BBD7F: If eax+00000004h <> 0 Then GoTo loc_005BBFA0
  loc_005BBD90: edx = edx - 00000202h
  loc_005BBD95: If edx-00000202h = 0 Then GoTo loc_005BBE91
  loc_005BBD9B: edx = edx - 00000003h
  loc_005BBD9E: If edx-00000003h <> 0 Then GoTo loc_005BBF99
  loc_005BBDAB: var_80 = Global.FontCount
  loc_005BBDC3: var_eax = SetForegroundWindow(var_80)
  loc_005BBE74: Set var_2C = Me.mainmenu
  loc_005BBE7C: var_eax = Unknown_VTable_Call[edi+000002BCh]
  loc_005BBE86: If Unknown_VTable_Call[edi+000002BCh] >= 0 Then GoTo loc_005BBF87
  loc_005BBE8C: GoTo loc_005BBF75
  loc_005BBE91: 'Referenced from: 005BBD95
  loc_005BBE98: var_80 = Global.FontCount
  loc_005BBE9F: If var_80 >= 0 Then GoTo loc_005BBEAC
  loc_005BBEAA: call Me(var_80, Me, var_00431EE8, 00000058h, Me, var_2C)
  loc_005BBEAC: 'Referenced from: 005BBE9F
  loc_005BBEB0: var_eax = SetForegroundWindow(var_80)
  loc_005BBF61: Set var_2C = Me.mainmenu
  loc_005BBF69: var_eax = Unknown_VTable_Call[edi+000002BCh]
  loc_005BBF73: If Unknown_VTable_Call[edi+000002BCh] >= 0 Then GoTo loc_005BBF87
  loc_005BBF75: 'Referenced from: 005BBE8C
  loc_005BBF81: Unknown_VTable_Call[edi+000002BCh] = CheckObj(Me, var_00431EE8, 700)
  loc_005BBF87: 'Referenced from: 005BBE86
  loc_005BBF99: 
  loc_005BBFA0: 'Referenced from: 005BBD7F
  loc_005BBFA9: GoTo loc_005BBFBE
  loc_005BBFBD: Exit Sub
  loc_005BBFBE: 'Referenced from: 005BBFA9
  loc_005BBFC7: Exit Sub
End Sub