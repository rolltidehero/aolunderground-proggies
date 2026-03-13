ï»¿Private Sub Richtextbox1_Change() '5A1990
  Dim var_24 As Variant
  loc_005A1A15: var_18 = Richtextbox1.Text
  loc_005A1A60: var_20 = "The version of Prophecy 2.0 found on the server is Build " & var_18 & var_0042DCAC
  loc_005A1A68: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005A1ACE: var_18 = Richtextbox1.Text
  loc_005A1B0E: var_24 = Global.App
  loc_005A1B2E: var_2C = Global.Revision
  loc_005A1B4F: var_54 = var_2C
  loc_005A1B5F: fcomp real8 ptr var_5C
  loc_005A1B6E: GoTo loc_005A1B72
  loc_005A1B72: 'Referenced from: 005A1B6E
  loc_005A1B93: If di = 0 Then GoTo loc_005A1D3E
  loc_005A1BA1: var_18 = "p21.p2m"
  loc_005A1BAB: var_eax = call Proc_79_51_60A2B0(var_18, Me, edi)
  loc_005A1BD7: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005A1C27: var_18 = Richtextbox1.Text
  loc_005A1C72: var_20 = "New in Build " & var_18 & " ..."
  loc_005A1C7A: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005A1CD6: Image1.Enabled = True
  loc_005A1D17: var_eax = Unknown_VTable_Call[eax+0000006Ch]
  loc_005A1D3E: 'Referenced from: 005A1B93
  loc_005A1D5B: var_18 = Richtextbox1.Text
  loc_005A1D9B: var_24 = Global.App
  loc_005A1DBB: var_2C = Global.Revision
  loc_005A1DDC: var_60 = var_2C
  loc_005A1DEC: fcomp real8 ptr var_68
  loc_005A1DFB: GoTo loc_005A1DFF
  loc_005A1DFF: 'Referenced from: 005A1DFB
  loc_005A1E20: If di = 0 Then GoTo loc_005A1E5D
  loc_005A1E40: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005A1E5D: 'Referenced from: 005A1E20
  loc_005A1E7A: var_18 = Richtextbox1.Text
  loc_005A1EBA: var_24 = Global.App
  loc_005A1EDA: var_2C = Global.Revision
  loc_005A1EFB: var_6C = var_2C
  loc_005A1F0B: fcomp real8 ptr var_74
  loc_005A1F1A: GoTo loc_005A1F1E
  loc_005A1F1E: 'Referenced from: 005A1F1A
  loc_005A1F41: If var_24 = 0 Then GoTo loc_005A1F7E
  loc_005A1F61: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005A1F7E: 'Referenced from: 005A1F41
  loc_005A1F8B: GoTo loc_005A1FB5
  loc_005A1FB4: Exit Sub
  loc_005A1FB5: 'Referenced from: 005A1F8B
End Sub