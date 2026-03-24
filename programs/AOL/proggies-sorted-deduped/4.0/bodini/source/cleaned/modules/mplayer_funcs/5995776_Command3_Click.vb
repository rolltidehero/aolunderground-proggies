ï»¿Private Sub Command3_Click() '5B7D00
  Dim var_64 As Variant
  Dim var_28 As CommonDialog
  Dim edx As CommonDialog
  loc_005B7D8E: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B7D93: var_68 = Unknown_VTable_Call[ecx+00000054h]
  loc_005B7DD5: On Error Resume Next
  loc_005B7E14: var_68 = Text1.Enabled
  loc_005B7E4E: setz al
  loc_005B7E66: If var_6C = 0 Then GoTo loc_005B7EB1
  loc_005B7E78: var_eax = Call mplayer.Image7_Click
  loc_005B7E7E: var_64 = Call mplayer.Image7_Click
  loc_005B7EE0: Text1.Enabled = True
  loc_005B7EE8: var_68 = var_64
  loc_005B7F53: Timer1.Enabled = False
  loc_005B7F58: var_68 = var_64
  loc_005B7F98: var_44 = "bodini media player formats |*.mid;*.rmi;*.wav;*.mp3;*.mp2;*,aiff;*.au;*.snd;*.avi;*.mov;*.mpg;*.mpeg;*.ra;*.ram"
  loc_005B7FE6: Me = CommonDialog._Action
  loc_005B804A: edx = CommonDialog._Action
  loc_005B80AE: var_28 = var_28._Action
  loc_005B80C6: On Error Resume Next
  loc_005B8113: var_3C = edx._Action
  loc_005B8128: var_24 = var_3C
  loc_005B8140: var_68 = var_3C.Copies
  loc_005B81CA: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B81CF: var_68 = Unknown_VTable_Call[ecx+00000054h]
  loc_005B8241: var_68 = Text1.Enabled
  loc_005B827B: setz al
  loc_005B8293: If var_6C = 0 Then GoTo loc_005B83C2
  loc_005B82CB: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B82D0: var_68 = Unknown_VTable_Call[ecx+00000054h]
  loc_005B8319: var_eax = Call mplayer.Label6_Click
  loc_005B831F: var_64 = Call mplayer.Label6_Click
  loc_005B8384: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005B8389: var_68 = Unknown_VTable_Call[eax+00000054h]
  loc_005B83C2: 'Referenced from: 005B8293
  loc_005B83F3: var_24 = Text1.Text
  loc_005B83FB: var_68 = var_24
  loc_005B8444: var_34 = var_24
  loc_005B850F: var_64 = var_28
  loc_005B851D: Text1.Enabled = False
  loc_005B8525: var_68 = var_64
  loc_005B8593: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B8598: var_68 = Unknown_VTable_Call[ecx+00000054h]
  loc_005B8603: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B8608: var_68 = Unknown_VTable_Call[ecx+00000054h]
  loc_005B8673: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B8678: var_68 = Unknown_VTable_Call[ecx+00000054h]
  loc_005B86D2: var_64 = var_28
  loc_005B86E0: Timer1.Enabled = True
  loc_005B86E5: var_68 = var_64
  loc_005B872A: GoTo loc_005B8752
  loc_005B8751: Exit Sub
  loc_005B8752: 'Referenced from: 005B872A
End Sub