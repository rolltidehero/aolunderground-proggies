ï»¿Private Sub MediaPlayer1_UnknownEvent_9 '5B94A0
  loc_005B9507: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005B9537: edi = (var_18 = "Repeat") + 1
  loc_005B954C: If (var_18 = "Repeat") + 1 = 0 Then GoTo loc_005B95F1
  loc_005B9569: Text1.Enabled = True
  loc_005B959D: var_eax = Call mplayer.Command1_Click
  loc_005B95CC: Text1.Enabled = False
  loc_005B95EF: GoTo loc_005B9662
  loc_005B95F1: 'Referenced from: 005B954C
  loc_005B9608: Timer1.Enabled = False
  loc_005B9645: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B9662: 'Referenced from: 005B95EF
  loc_005B966E: GoTo loc_005B9683
  loc_005B9682: Exit Sub
  loc_005B9683: 'Referenced from: 005B966E
End Sub