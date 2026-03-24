ï»¿Private Sub Command1_Click() '5DA190
  Dim var_74 As ListBox
  Dim var_70 As CommandButton
  loc_005DA2A2: var_1B8 = var_74
  loc_005DA2C5: var_1AC = List1.ListCount
  loc_005DA303: var_48 = CStr(var_1AC)
  loc_005DA313: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005DA364: var_34 = "<font color=#0000FF><font face=""tahoma"">*bodini 4.0* mass im * <a href=""www.xclipticonline.com/spek""></u>spek</a>*"
  loc_005DA383: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005DA3B4: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005DA3E5: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005DA412: call __vbaStrR8
  loc_005DA444: var_58 =  & __vbaStrR8 & var_0043137C
  loc_005DA45B: call __vbaStrR8
  loc_005DA4BD: var_44 =  & __vbaStrR8 & var_004342C4 & var_64 & "% done*"
  loc_005DA523: var_48 = Command1.Caption
  loc_005DA553: edi = (var_48 = "Stop") + 1
  loc_005DA568: If (var_48 = "Stop") + 1 = 0 Then GoTo loc_005DA5D6
  loc_005DA581: Text1.Enabled = True
  loc_005DA5C4: Command1.Caption = "Start"
  loc_005DA5CB: If edi >= 0 Then GoTo loc_005DAC77
  loc_005DA5D1: GoTo loc_005DAC68
  loc_005DA5D6: 'Referenced from: 005DA568
  loc_005DA606: var_1AC = List1.ListCount
  loc_005DA630: var_1AC = var_1AC - 0001h
  loc_005DA64C: var_180 = var_1AC
  loc_005DA67E: For var_24 = 0 To var_1AC Step 1
  loc_005DA687: var_1F0 = var_1E4
  loc_005DA699: 
  loc_005DA6A4: If var_1F0 = 0 Then GoTo loc_005DAB92
  loc_005DA6C4: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005DA6F5: var_1C0 = edi
  loc_005DA711: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005DA752: If var_60C000 <> 0 Then GoTo loc_005DA75C
  loc_005DA754: fdivr st0, real8 ptr var_200
  loc_005DA75A: GoTo loc_005DA76D
  loc_005DA75C: 'Referenced from: 005DA752
  loc_005DA76D: 'Referenced from: 005DA75A
  loc_005DA783: call __vbaStrR8
  loc_005DA794: var_204 = __vbaStrR8
  loc_005DA7A8: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005DA80F: var_24 = CInt(var_48)
  loc_005DA81F: var_70 = List1.List(var_24)
  loc_005DA85A: var_4C = Text1.Text
  loc_005DA88E: var_50 = vbNullString & var_4C
  loc_005DA8AB: var_90 = var_50 & vbNullString
  loc_005DA8D6: var_170 = "<p align center>"
  loc_005DA8E6: var_180 = vbNullString
  loc_005DA929: var_190 = "<p align center>"
  loc_005DA933: var_1A0 = vbNullString
  loc_005DA9B1: var_148 = var_50 & vbNullString & Chr(13) & Chr(10) & "<p align center>" & var_34 & vbNullString & Chr(13) & Chr(10) & "<p align center>"
  loc_005DA9FD: var_eax = call Proc_79_30_606DE0(0, var_148 & var_44 & vbNullString, var_74)
  loc_005DAAB7: var_1B8 = var_74
  loc_005DAAD3: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005DAB13: call __vbaStrR8
  loc_005DAB1E: var_4C = __vbaStrR8
  loc_005DAB2E: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005DAB7B: Next var_24
  loc_005DAB87: var_1F0 = Next var_24
  loc_005DAB8D: GoTo loc_005DA699
  loc_005DABA6: Text1.Enabled = True
  loc_005DABE7: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005DAC22: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005DAC5F: Command1.Caption = "Start"
  loc_005DAC66: If esi >= 0 Then GoTo loc_005DAC77
  loc_005DAC68: 'Referenced from: 005DA5D1
  loc_005DAC71: esi = CheckObj(esi, var_0042CCB8, 84)
  loc_005DAC77: 'Referenced from: 005DA5CB
  loc_005DAC89: GoTo loc_005DAD47
  loc_005DAD46: Exit Sub
  loc_005DAD47: 'Referenced from: 005DAC89
  loc_005DAD75: Exit Sub
End Sub