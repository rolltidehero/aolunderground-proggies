VERSION 5.00
Begin VB.Form FRMopen
  Caption = "Open existing module"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 5295
  ClientHeight = 2655
  StartUpPosition = 3 'Windows Default
  Begin DriveListBox Drive1
    Left = 120
    Top = 2160
    Width = 2055
    Height = 315
    TabIndex = 2
  End
  Begin FileListBox File1
    Left = 2280
    Top = 120
    Width = 2895
    Height = 2430
    TabIndex = 1
    Pattern = "*.bas"
  End
  Begin DirListBox Dir1
    Left = 120
    Top = 120
    Width = 2055
    Height = 1890
    TabIndex = 0
  End
End

Attribute VB_Name = "FRMopen"


Private Sub Form_Load() '422B20
  loc_00422B6B: call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  loc_00422B80: var_eax = call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  loc_00422B96: GoTo loc_00422BA2
  loc_00422BA1: Exit Sub
  loc_00422BA2: 'Referenced from: 00422B96
End Sub

Private Sub File1_DblClick() '4221A0
  Dim var_F0 As Variant
  Dim var_F8 As FileListBox
  loc_00422236: var_38 = Dir1.Path
  loc_0042223E: var_F4 = var_38
  loc_004222B0: var_3C = File1.FileName
  loc_004222B8: var_FC = var_3C
  loc_00422321: var_30 = var_38 & var_00407AB0 & var_3C
  loc_0042235A: On Error Resume Next
  loc_00422371: Open var_30 For Input As #1 Len = -1
  loc_004223AE: var_28 = Input(LOF(1), 1)
  loc_004223C6: Close #1
  loc_004223D6: var_B0 = var_28
  loc_004223F1: var_58 = LCase(var_28)
  loc_00422414: var_68 = "VB_atribute"
  loc_00422422: var_78 = LCase(var_68)
  loc_0042243B: call InStr(var_88, 00000000h, var_78, var_58, 00000001h, FFFFFFFFh, esi, ebx)
  loc_00422449: call Not(var_98, InStr(var_88, 00000000h, var_78, var_58, 00000001h, FFFFFFFFh, esi, ebx))
  loc_00422456: var_F0 = CBool(Not(var_98, InStr(var_88, 00000000h, var_78, var_58, 00000001h, FFFFFFFFh, esi, ebx)))
  loc_00422484: If var_F0 = 0 Then GoTo loc_00422A6A
  loc_004224FC: var_34 = MsgBox("This does not appear to be a valid .bas file, would you like to load it anyways?", 4, var_68, 10, var_88)
  loc_00422528: If var_34 <> 7 Then GoTo loc_0042252F
  loc_0042252A: GoTo loc_00422A6A
  loc_0042252F: 'Referenced from: 00422528
  loc_0042252F: 
  loc_00422539: var_B0 = var_28
  loc_00422554: var_58 = LCase(var_28)
  loc_00422585: var_78 = LCase("sub")
  loc_004225B2: call InStr(var_88, 00000000h, var_78, var_58, 00000001h)
  loc_004225C9: var_F0 = Not ((InStr(var_88, 00000000h, var_78, var_58, 00000001h) = 0))
  loc_004225F7: If var_F0 = 0 Then GoTo loc_004229BE
  loc_00422607: var_B0 = var_28
  loc_00422622: var_58 = LCase(var_28)
  loc_00422653: var_78 = LCase("End Sub")
  loc_00422670: var_E0 = var_28
  loc_00422693: call InStr(var_88, 00000000h, var_78, var_58, 00000001h)
  loc_004226DC: var_24 = Left(var_28, CLng(InStr(var_88, 00000000h, var_78, var_58, 00000001h) + 1))
  loc_00422757: var_eax = Unknown_VTable_Call[ecx+000003BCh]
  loc_00422768: var_F8 = Unknown_VTable_Call[ecx+000003BCh]
  loc_004227B0: var_eax = Unknown_VTable_Call[edx+000003BCh]
  loc_004227DA: var_38 = File1.TabIndex
  loc_004227E2: var_F4 = var_38
  loc_0042284A: File1.TabIndex = var_38 & var_24
  loc_00422852: var_FC = var_F8
  loc_004228E9: var_78 = LCase("Sub")
  loc_004228F2: var_B0 = var_28
  loc_0042290D: var_58 = LCase(var_28)
  loc_00422955: call InStr(var_88, 00000000h, var_78, var_58, 00000001h, var_A8)
  loc_00422987: var_28 = Mid$(var_28, CLng(InStr(var_88, 00000000h, var_78, var_58, 00000001h, var_A8) + 1), )
  loc_004229B9: GoTo loc_0042252F
  loc_004229BE: 'Referenced from: 004225F7
  loc_00422A0A: Set var_44 = Me
  loc_00422A20: var_eax = Global.Unload var_44
  loc_00422A25: var_F4 = Global.Unload var_44
  loc_00422A76: GoTo loc_00422ACF
  loc_00422ACE: Exit Sub
  loc_00422ACF: 'Referenced from: 00422A76
End Sub

Private Sub Dir1_Change() '421E70
  loc_00421EEC: var_18 = Dir1.Path
  loc_00421F11: Dir1.Path = var_18
  loc_00421F57: GoTo loc_00421F76
  loc_00421F75: Exit Sub
  loc_00421F76: 'Referenced from: 00421F57
End Sub

Private Sub Drive1_Change() '421FA0
  loc_00421FFF: On Error Resume Next
  loc_00422036: var_20 = Drive1.Drive
  loc_0042205B: Drive1.Drive = var_20
  loc_00422095: GoTo loc_00422138
  loc_004220D0: var_eax = Unknown_VTable_Call[ecx+0000002Ch]
  loc_00422138: 'Referenced from: 00422095
  loc_00422138: Exit Sub
  loc_00422143: GoTo loc_0042217A
  loc_00422179: Exit Sub
  loc_0042217A: 'Referenced from: 00422143
End Sub
