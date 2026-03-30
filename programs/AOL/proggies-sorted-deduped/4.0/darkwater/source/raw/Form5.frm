VERSION 5.00
Begin VB.Form Form5
  Caption = "Save Phish Phrase Dialog Box"
  MousePointer = 99 'Custom
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form5.frx":0
  BorderStyle = 1 'Fixed Single
  Icon = "Form5.frx":718E
  LinkTopic = "Form5"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 45
  ClientTop = 330
  ClientWidth = 4680
  ClientHeight = 3225
  MouseIcon = "Form5.frx":7498
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command2
    Caption = "Cancel"
    Left = 120
    Top = 2880
    Width = 4455
    Height = 255
    TabIndex = 5
  End
  Begin CommandButton Command1
    Caption = "Save Phrase"
    Left = 120
    Top = 2640
    Width = 4455
    Height = 255
    TabIndex = 4
  End
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 2400
    Width = 4455
    Height = 285
    TabIndex = 3
  End
  Begin FileListBox File1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 1560
    Width = 4455
    Height = 870
    TabIndex = 2
    Pattern = "*.*phr"
  End
  Begin DirListBox Dir1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 480
    Width = 4455
    Height = 990
    TabIndex = 1
  End
  Begin DriveListBox Drive1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 120
    Width = 4455
    Height = 315
    TabIndex = 0
  End
End

Attribute VB_Name = "Form5"


Private Sub Drive1_Change() '47CCE0
  loc_0047CD5C: var_18 = Drive1.Drive
  loc_0047CD81: Drive1.Drive = var_18
  loc_0047CDC7: GoTo loc_0047CDE6
  loc_0047CDE5: Exit Sub
  loc_0047CDE6: 'Referenced from: 0047CDC7
End Sub

Private Sub File1_Click() '47CE10
  Dim var_2C As TextBox
  Dim var_28 As DriveListBox
  Dim var_84 As Variant
  loc_0047CE96: var_1C = Text1.Text
  loc_0047CEC0: var_58 = var_1C
  loc_0047CEE1: var_18 = Drive1.Drive
  loc_0047CF11: var_38 = var_18 & var_00414E54
  loc_0047CF3A: var_84 = (var_1C = Ucase(var_18 & var_00414E54))
  loc_0047CF78: If var_84 = 0 Then GoTo loc_0047D072
  loc_0047CFAA: var_1C = Text1.Text
  loc_0047CFEB: var_18 = File1.FileName
  loc_0047D020: var_20 = var_1C & var_18
  loc_0047D028: File1.TabIndex = var_20
  loc_0047D06D: GoTo loc_0047D178
  loc_0047D07D: call var_84(var_30, var_30, Me, var_2C, Me, Me)
  loc_0047D082: var_84 = var_84(var_30, var_30, Me, var_2C, Me, Me)
  loc_0047D093: call var_84(var_28, var_84(var_30, var_30, Me, var_2C, Me, Me), var_84)
  loc_0047D09E: var_18 = Text1.Text
  loc_0047D0CA: call var_84(var_2C, var_84, var_84)
  loc_0047D0D5: var_1C = File1.FileName
  loc_0047D127: var_24 = var_18 & var_00414E54 & var_1C
  loc_0047D12B: File1.TabIndex = var_24
  loc_0047D178: 'Referenced from: 0047D06D
  loc_0047D184: GoTo loc_0047D1CE
  loc_0047D1CD: Exit Sub
  loc_0047D1CE: 'Referenced from: 0047D184
End Sub

Private Sub Command1_Click() '47C860
  loc_0047C8F1: var_1C = Form2.Text2.Text
  loc_0047C928: var_18 = Text1.Text
  loc_0047C977: var_eax = call Proc_2_11_47A090(var_1C, var_18 & var_004156F0, var_28)
  loc_0047C9CC: Set var_28 = Me
  loc_0047C9D7: var_eax = Global.Unload var_28
  loc_0047CA00: GoTo loc_0047CA2E
  loc_0047CA2D: Exit Sub
  loc_0047CA2E: 'Referenced from: 0047CA00
End Sub

Private Sub Command2_Click() '47CA50
  loc_0047CABE: Set var_18 = Me
  loc_0047CAC9: var_eax = Global.Unload var_18
  loc_0047CAF2: GoTo loc_0047CAFE
  loc_0047CAFD: Exit Sub
  loc_0047CAFE: 'Referenced from: 0047CAF2
End Sub

Private Sub Dir1_Change() '47CB20
  Dim var_20 As DirListBox
  Dim var_2C As DirListBox
  loc_0047CB84: var_2C = var_20
  loc_0047CB9D: var_18 = Dir1.Path
  loc_0047CBC5: Dir1.ListIndex = var_18
  loc_0047CC2A: var_18 = Dir1.Path
  loc_0047CC4F: Dir1.TabIndex = var_18
  loc_0047CC95: GoTo loc_0047CCB4
  loc_0047CCB3: Exit Sub
  loc_0047CCB4: 'Referenced from: 0047CC95
End Sub

Private Sub Form_Load() '47D1F0
  loc_0047D26C: var_18 = Dir1.Path
  loc_0047D291: Dir1.TabIndex = var_18
  loc_0047D2D7: GoTo loc_0047D2F6
  loc_0047D2F5: Exit Sub
  loc_0047D2F6: 'Referenced from: 0047D2D7
End Sub
