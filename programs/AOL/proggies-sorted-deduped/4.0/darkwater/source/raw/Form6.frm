VERSION 5.00
Begin VB.Form Form6
  Caption = "Save List"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form6.frx":0
  Icon = "Form6.frx":718E
  LinkTopic = "Form6"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4680
  ClientHeight = 3435
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 2520
    Width = 4455
    Height = 285
    TabIndex = 5
  End
  Begin CommandButton Command2
    Caption = "Cancel"
    Left = 120
    Top = 3120
    Width = 4455
    Height = 255
    TabIndex = 4
  End
  Begin CommandButton Command1
    Caption = "Save List"
    Left = 120
    Top = 2880
    Width = 4455
    Height = 255
    TabIndex = 3
  End
  Begin FileListBox File1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 1440
    Width = 4455
    Height = 1065
    TabIndex = 2
    Pattern = "*.*lst"
  End
  Begin DirListBox Dir1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 240
    Width = 4455
    Height = 1215
    TabIndex = 1
  End
  Begin DriveListBox Drive1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 0
    Width = 4455
    Height = 315
    TabIndex = 0
  End
End

Attribute VB_Name = "Form6"


Private Sub Drive1_Change() '47EB60
  loc_0047EBDC: var_18 = Drive1.Drive
  loc_0047EC01: Drive1.Drive = var_18
  loc_0047EC47: GoTo loc_0047EC66
  loc_0047EC65: Exit Sub
  loc_0047EC66: 'Referenced from: 0047EC47
End Sub

Private Sub File1_Click() '47EC90
  Dim var_28 As DirListBox
  Dim var_30 As DirListBox
  Dim var_2C As FileListBox
  Dim var_84 As Variant
  loc_0047ED16: var_18 = Dir1.Path
  loc_0047ED3D: var_38 = var_18
  loc_0047ED76: var_7C = (Right(var_18, 1) = &H414E54)
  loc_0047ED9A: If var_7C = 0 Then GoTo loc_0047EE94
  loc_0047EDB0: var_84 = var_30
  loc_0047EDCC: var_18 = Dir1.Path
  loc_0047EE0D: var_1C = File1.FileName
  loc_0047EE42: var_20 = var_18 & var_1C
  loc_0047EE4A: File1.TabIndex = var_20
  loc_0047EE8F: GoTo loc_0047EF9A
  loc_0047EE9F: call var_84(var_30, var_2C, Me, var_28, Me, Me)
  loc_0047EEA4: var_84 = var_84(var_30, var_2C, Me, var_28, Me, Me)
  loc_0047EEB5: call var_84(var_28, var_84(var_30, var_2C, Me, var_28, Me, Me), var_84)
  loc_0047EEC0: var_18 = Dir1.Path
  loc_0047EEEC: call var_84(var_2C, var_18, var_84)
  loc_0047EEF7: var_1C = File1.FileName
  loc_0047EF45: var_24 = var_18 & var_00414E54 & var_1C
  loc_0047EF4D: File1.TabIndex = var_24
  loc_0047EF9A: 'Referenced from: 0047EE8F
  loc_0047EFA6: GoTo loc_0047EFEC
  loc_0047EFEB: Exit Sub
  loc_0047EFEC: 'Referenced from: 0047EFA6
End Sub

Private Sub Command1_Click() '47E690
  Dim var_20 As TextBox
  loc_0047E709: var_18 = Text1.Text
  loc_0047E752: var_eax = Unknown_VTable_Call[ecx+0000031Ch]
  loc_0047E77C: var_eax = Unknown_VTable_Call[ecx+00000318h]
  loc_0047E7EC: var_eax = call Proc_6_4_47DF70(var_18, var_24, var_28)
  loc_0047E842: Set var_20 = Me
  loc_0047E84A: var_eax = Global.Unload var_20
  loc_0047E873: GoTo loc_0047E8A9
  loc_0047E8A8: Exit Sub
  loc_0047E8A9: 'Referenced from: 0047E873
End Sub

Private Sub Command2_Click() '47E8D0
  loc_0047E93E: Set var_18 = Me
  loc_0047E949: var_eax = Global.Unload var_18
  loc_0047E972: GoTo loc_0047E97E
  loc_0047E97D: Exit Sub
  loc_0047E97E: 'Referenced from: 0047E972
End Sub

Private Sub Dir1_Change() '47E9A0
  Dim var_20 As DirListBox
  Dim var_2C As DirListBox
  loc_0047EA04: var_2C = var_20
  loc_0047EA1D: var_18 = Dir1.Path
  loc_0047EA45: Dir1.ListIndex = var_18
  loc_0047EAAA: var_18 = Dir1.Path
  loc_0047EACF: Dir1.TabIndex = var_18
  loc_0047EB15: GoTo loc_0047EB34
  loc_0047EB33: Exit Sub
  loc_0047EB34: 'Referenced from: 0047EB15
End Sub

Private Sub Form_Load() '47F010
  loc_0047F08C: var_18 = Dir1.Path
  loc_0047F0B1: Dir1.TabIndex = var_18
  loc_0047F0F7: GoTo loc_0047F116
  loc_0047F115: Exit Sub
  loc_0047F116: 'Referenced from: 0047F0F7
End Sub
