ï»¿Private Sub Command1_Click() '5B76C0
  Dim var_1C As TextBox
  loc_005B7749: var_18 = Text1.Text
  loc_005B7785: ebx = (var_18 = vbNullString) + 1
  loc_005B779A: If (var_18 = vbNullString) + 1 = 0 Then GoTo loc_005B7820
  loc_005B77D1: var_40 = "The FileBox is blank!"
  loc_005B77E3: var_30 = "Please enter in a multimedia audio file to play!"
  loc_005B781B: GoTo loc_005B7B33
  loc_005B7820: 'Referenced from: 005B779A
  loc_005B782E: call edi(var_1C, var_40, %ecx = %S_edx_S, var_1C, Me, Me, 00000008h, %ecx = %S_edx_S, (var_18 = vbNullString) + 1)
  loc_005B783A: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B7869: call edi(var_1C, Unknown_VTable_Call[ecx+00000054h], %ecx = %S_edx_S, edi(var_1C, var_40, %ecx = %S_edx_S, var_1C, Me, Me, 00000008h, %ecx = %S_edx_S, (var_18 = vbNullString) + 1), "Reading File from Hard drive...")
  loc_005B7877: var_A4 = Text1.Enabled
  loc_005B78A1: setz bl
  loc_005B78AF: If ebx = 0 Then GoTo loc_005B794A
  loc_005B78C3: call edi(var_1C, %ecx = %S_edx_S, %ecx = %S_edx_S)
  loc_005B78CF: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005B78F3: var_eax = Label.1832
  loc_005B791D: call edi(var_1C, Label.1832, %ecx = %S_edx_S, %ecx = %S_edx_S, edi(var_1C, %ecx = %S_edx_S, %ecx = %S_edx_S), "Error loading file.Trying again...")
  loc_005B7929: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005B794A: 'Referenced from: 005B78AF
  loc_005B7958: call edi(var_1C, Unknown_VTable_Call[eax+00000054h], %ecx = %S_edx_S, edi(var_1C, Label.1832, %ecx = %S_edx_S, %ecx = %S_edx_S, edi(var_1C, %ecx = %S_edx_S, %ecx = %S_edx_S), "Error loading file.Trying again..."), "Error loading file.Trying again...")
  loc_005B7963: var_18 = Text1.Text
  loc_005B7991: var_28 = var_18
  loc_005B79BF: call edi(var_20, var_24, %ecx = %S_edx_S, 00000402h, var_24)
  loc_005B79F9: call edi(var_1C, var_20, %ecx = %S_edx_S, 000007D1h, 00000000h)
  loc_005B7A1C: call edi(var_1C, edi(var_1C, var_20, %ecx = %S_edx_S, 000007D1h, 00000000h), %ecx = %S_edx_S)
  loc_005B7A25: Text1.Enabled = False
  loc_005B7A5A: call edi(var_1C, edi(var_1C, edi(var_1C, var_20, %ecx = %S_edx_S, 000007D1h, 00000000h), %ecx = %S_edx_S), %ecx = %S_edx_S)
  loc_005B7A66: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005B7A95: call edi(var_1C, Unknown_VTable_Call[eax+00000054h], %ecx = %S_edx_S, edi(var_1C, edi(var_1C, edi(var_1C, var_20, %ecx = %S_edx_S, 000007D1h, 00000000h), %ecx = %S_edx_S), %ecx = %S_edx_S), "Playing file")
  loc_005B7AA1: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005B7AD0: call edi(var_1C, Unknown_VTable_Call[eax+00000054h], %ecx = %S_edx_S, edi(var_1C, Unknown_VTable_Call[eax+00000054h], %ecx = %S_edx_S, edi(var_1C, edi(var_1C, edi(var_1C, var_20, %ecx = %S_edx_S, 000007D1h, 00000000h), %ecx = %S_edx_S), %ecx = %S_edx_S), "Playing file"), var_0042E980)
  loc_005B7ADC: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005B7B0D: call edi(var_1C, Unknown_VTable_Call[eax+00000054h], %ecx = %S_edx_S, edi(var_1C, Unknown_VTable_Call[eax+00000054h], %ecx = %S_edx_S, edi(var_1C, Unknown_VTable_Call[eax+00000054h], %ecx = %S_edx_S, edi(var_1C, edi(var_1C, edi(var_1C, var_20, %ecx = %S_edx_S, 000007D1h, 00000000h), %ecx = %S_edx_S), %ecx = %S_edx_S), "Playing file"), var_0042E980), var_0042E980)
  loc_005B7B16: Timer1.Enabled = True
  loc_005B7B33: 'Referenced from: 005B781B
  loc_005B7B3F: GoTo loc_005B7B76
  loc_005B7B75: Exit Sub
  loc_005B7B76: 'Referenced from: 005B7B3F
End Sub