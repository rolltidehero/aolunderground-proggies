ï»¿Public Sub Proc_3_0_5A35D0
  Dim var_100 As Me
  Dim var_18C As Me
  loc_005A36E9: var_FC = "+chr13+"
  loc_005A3726: var_eax = call Proc_3_5_5A5800(var_120, arg_C, Chr(13))
  loc_005A373C: var_D4 = var_120
  loc_005A377C: var_184 = edx.FontTransparent
  loc_005A37C4: var_8C = var_184
  loc_005A37D6: edx.FontTransparent = True
  loc_005A384A: var_30 = CInt(2)
  loc_005A3873: var_148 = "Arial"
  loc_005A3893: var_100 = edx.Count
  loc_005A390C: eax.FontSize = var_41200000
  loc_005A393F: eax.FontBold = esi
  loc_005A3972: eax.FontItalic = esi
  loc_005A39A5: eax.FontUnderline = esi
  loc_005A39D8: eax.FontStrikethru = esi
  loc_005A3A0C: eax.Picture = CInt(-1)
  loc_005A3A3F: eax.ForeColor = 0
  loc_005A3A6B: var_144 = eax.StartUpPosition
  loc_005A3AB6: var_158 = Len(var_D4)
  loc_005A3AFE: For var_F4 = 1 To Len(var_D4) Step 1
  loc_005A3B06: If var_F4 = 0 Then GoTo loc_005A46C2
  loc_005A3B4A: var_94 = Mid$(var_D4, CLng(var_F4), 1)
  loc_005A3B6C: If (var_94 <> var_0042E89C) <> 0 Then GoTo loc_005A43CE
  loc_005A3BA9: var_AC = var_F4 + 1
  loc_005A3BDB: var_ret_2 = CLng(var_F4 + 1)
  loc_005A3BF5: InStr(var_ret_2, var_D4, var_0042E8A4, 0) = InStr(var_ret_2, var_D4, var_0042E8A4, 0) - 00000001h
  loc_005A3C1A: var_E4 = InStr(var_ret_2, var_D4, var_0042E8A4, 0)
  loc_005A3CA1: var_98 = LCase$(Mid$(var_D4, CLng(var_AC), var_E4 - var_AC + 1))
  loc_005A3CF2: var_F4 = var_E4 + 1
  loc_005A3D00: var_194 = var_98
  loc_005A3D1A: If (var_194 <> var_0042E8AC) <> 0 Then GoTo loc_005A3D59
  loc_005A3D2C: eax.FontUnderline = True
  loc_005A3D88: If ecx >= 0 Then GoTo loc_005A46A2
  loc_005A3D93: GoTo loc_005A3F49
  loc_005A3DAC: If (var_194 <> var_0042E8C0) <> 0 Then GoTo loc_005A3DEB
  loc_005A3DBE: eax.FontStrikethru = True
  loc_005A3E1A: If ecx >= 0 Then GoTo loc_005A46A2
  loc_005A3E25: GoTo loc_005A3F49
  loc_005A3E3E: If (var_194 <> var_0042E8D4) <> 0 Then GoTo loc_005A3E7D
  loc_005A3E50: eax.FontBold = True
  loc_005A3EAC: If ecx >= 0 Then GoTo loc_005A46A2
  loc_005A3EB7: GoTo loc_005A3F49
  loc_005A3ED0: If (var_194 <> var_0042E8E8) <> 0 Then GoTo loc_005A3F0F
  loc_005A3EE2: eax.FontItalic = True
  loc_005A3F3E: If ecx >= 0 Then GoTo loc_005A46A2
  loc_005A3F49: 'Referenced from: 005A3D93
  loc_005A3F56: var_18C = CheckObj(var_18C, var_0042E878, 196)
  loc_005A3F5C: GoTo loc_005A46A2
  loc_005A3F75: If (var_194 <> "sup") <> 0 Then GoTo loc_005A3F9B
  loc_005A3F94: var_40 = CInt(-1)
  loc_005A3F96: GoTo loc_005A46A2
  loc_005A3F9B: 'Referenced from: 005A3F75
  loc_005A3FAF: If (var_194 = "/sup") = 0 Then GoTo loc_005A4001
  loc_005A3FC5: If (var_194 <> "sub") <> 0 Then GoTo loc_005A3FEB
  loc_005A3FE4: var_40 = CInt(1)
  loc_005A3FE6: GoTo loc_005A46A2
  loc_005A3FEB: 'Referenced from: 005A3FC5
  loc_005A3FFF: If (var_194 <> "/sub") <> 0 Then GoTo loc_005A4021
  loc_005A4001: 'Referenced from: 005A3FAF
  loc_005A401C: GoTo loc_005A46A2
  loc_005A4021: 'Referenced from: 005A3FFF
  loc_005A4038: var_F8 = Left$(var_98, 10)
  loc_005A4052: esi = (var_F8 = "font color") + 1
  loc_005A405E: If (var_F8 = "font color") + 1 = 0 Then GoTo loc_005A4234
  loc_005A40F8: var_9C = Mid$(var_98, CLng(InStr(1, var_98, var_0042E950, 0) + 1), 6)
  loc_005A4127: var_64 = Left$(var_9C, 2)
  loc_005A4151: var_7C = Mid$(var_9C, 3, 2)
  loc_005A4176: var_D0 = Right$(var_9C, 2)
  loc_005A417C: var_eax = call Proc_3_1_5A4820(var_64, 188, 204)
  loc_005A419B: var_60 = call Proc_3_1_5A4820(var_64, 188, 204)
  loc_005A41A1: var_eax = call Proc_3_1_5A4820(var_7C, 212, )
  loc_005A41BE: var_CC = call Proc_3_1_5A4820(var_7C, 212, )
  loc_005A41C7: var_eax = call Proc_3_1_5A4820(var_D0, , )
  loc_005A41E1: var_50 = call Proc_3_1_5A4820(var_D0, , )
  loc_005A4207: var_60 = CInt(CInt(CInt(Me = %S_edx_S)))
  loc_005A4216: eax.ForeColor = RGB(var_60, , )
  loc_005A4234: 'Referenced from: 005A405E
  loc_005A424B: var_F8 = Left$(var_98, 9)
  loc_005A4265: esi = (var_F8 = "font face") + 1
  loc_005A4271: If (var_F8 = "font face") + 1 = 0 Then GoTo loc_005A46A0
  loc_005A4286: var_148 = var_98
  loc_005A4296: var_110 = Chr(34)
  loc_005A42B5: call InStr(var_120, 00000000h, var_110, var_150, 00000001h)
  loc_005A42BC: InStr(var_120, 00000000h, var_110, var_150, 00000001h) = CInt()
  loc_005A42F4: var_148 = var_98
  loc_005A4303: Len(var_98) = Len(var_98) - si
  loc_005A434C: var_148 = Right(var_98, Len(var_98))
  loc_005A4368: var_100 = eax.Count
  loc_005A43C9: GoTo loc_005A46A0
  loc_005A43CE: 'Referenced from: 005A3B6C
  loc_005A43EA: eax = (var_94 = var_0042E970) + 1
  loc_005A43F3: var_178 = (var_94 = var_0042E970) + 1
  loc_005A4420: var_148 = var_D4
  loc_005A4467: var_168 = "+chr13+"
  loc_005A4496: var_18C = CBool((var_94 = var_0042E970) + 1 And (Mid(var_D4, CLng(var_E4 + 1), 7) = "+chr13+"))
  loc_005A44C4: If var_18C = eax Then GoTo loc_005A455C
  loc_005A4501: var_BC = var_BC + 16
  loc_005A451C: var_74 = var_BC
  loc_005A4555: var_F4 = var_F4 + 6
  loc_005A4557: GoTo loc_005A46A2
  loc_005A455C: 'Referenced from: 005A44C4
  loc_005A456C: var_18C = eax
  loc_005A4595: var_18C.ScaleLeft = var_40 = CSng(var_144)
  loc_005A45CD: var_18C = var_110
  loc_005A45E2: var_30 + var_74 = CSng()
  loc_005A45F5: var_18C.CurrentY = var_74
  loc_005A4631: call __vbaPrintObj(var_0042E978, Me, var_94)
  loc_005A464D: var_94 = var_18C.Moveable
  loc_005A4674: var_148 = var_188
  loc_005A469E: var_74 = var_74 + var_188
  loc_005A46A0: 'Referenced from: 005A4271
  loc_005A46B7: Next var_F4
  loc_005A46BD: GoTo loc_005A3B04
  loc_005A46C2: 'Referenced from: 005A3B06
  loc_005A46D8: var_18C.FontTransparent = CInt(var_1A4)
  loc_005A46FC: GoTo loc_005A474B
  loc_005A474A: Exit Sub
  loc_005A474B: 'Referenced from: 005A46FC
End Sub