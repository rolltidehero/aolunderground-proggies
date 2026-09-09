VERSION 5.00
Begin VB.Form Form7
  Caption = "Load List"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form7.frx":0
  Icon = "Form7.frx":718E
  LinkTopic = "Form7"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4680
  ClientHeight = 3405
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command2
    Caption = "Cancel"
    Left = 120
    Top = 3120
    Width = 4455
    Height = 255
    TabIndex = 5
  End
  Begin CommandButton Command1
    Caption = "Load List"
    Left = 120
    Top = 2880
    Width = 4455
    Height = 255
    TabIndex = 4
  End
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 2520
    Width = 4455
    Height = 285
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

Attribute VB_Name = "Form7"


Private Sub Drive1_Change() '47F610
  loc_0047F68C: var_18 = Drive1.Drive
  loc_0047F6B1: Drive1.Drive = var_18
  loc_0047F6F7: GoTo loc_0047F716
  loc_0047F715: Exit Sub
  loc_0047F716: 'Referenced from: 0047F6F7
End Sub

Private Sub File1_Click() '47F740
  Dim var_28 As DirListBox
  Dim var_30 As DirListBox
  Dim var_2C As FileListBox
  Dim var_84 As Variant
  loc_0047F7C6: var_18 = Dir1.Path
  loc_0047F7ED: var_38 = var_18
  loc_0047F826: var_7C = (Right(var_18, 1) = &H414E54)
  loc_0047F84A: If var_7C = 0 Then GoTo loc_0047F944
  loc_0047F860: var_84 = var_30
  loc_0047F87C: var_18 = Dir1.Path
  loc_0047F8BD: var_1C = File1.FileName
  loc_0047F8F2: var_20 = var_18 & var_1C
  loc_0047F8FA: File1.TabIndex = var_20
  loc_0047F93F: GoTo loc_0047FA4A
  loc_0047F94F: call var_84(var_30, var_2C, Me, var_28, Me, Me)
  loc_0047F954: var_84 = var_84(var_30, var_2C, Me, var_28, Me, Me)
  loc_0047F965: call var_84(var_28, var_84(var_30, var_2C, Me, var_28, Me, Me), var_84)
  loc_0047F970: var_18 = Dir1.Path
  loc_0047F99C: call var_84(var_2C, var_18, var_84)
  loc_0047F9A7: var_1C = File1.FileName
  loc_0047F9F5: var_24 = var_18 & var_00414E54 & var_1C
  loc_0047F9FD: File1.TabIndex = var_24
  loc_0047FA4A: 'Referenced from: 0047F93F
  loc_0047FA56: GoTo loc_0047FA9C
  loc_0047FA9B: Exit Sub
  loc_0047FA9C: 'Referenced from: 0047FA56
End Sub

Private Sub Command1_Click() '47F140
  Dim var_20 As TextBox
  loc_0047F1B9: var_18 = Text1.Text
  loc_0047F202: var_eax = Unknown_VTable_Call[ecx+0000031Ch]
  loc_0047F22C: var_eax = Unknown_VTable_Call[ecx+00000318h]
  loc_0047F29C: var_eax = call Proc_6_3_47DC70(var_18, var_24, var_28)
  loc_0047F2F2: Set var_20 = Me
  loc_0047F2FA: var_eax = Global.Unload var_20
  loc_0047F323: GoTo loc_0047F359
  loc_0047F358: Exit Sub
  loc_0047F359: 'Referenced from: 0047F323
End Sub

Private Sub Command2_Click() '47F380
  loc_0047F3EE: Set var_18 = Me
  loc_0047F3F9: var_eax = Global.Unload var_18
  loc_0047F422: GoTo loc_0047F42E
  loc_0047F42D: Exit Sub
  loc_0047F42E: 'Referenced from: 0047F422
End Sub

Private Sub Dir1_Change() '47F450
  Dim var_20 As DirListBox
  Dim var_2C As DirListBox
  loc_0047F4B4: var_2C = var_20
  loc_0047F4CD: var_18 = Dir1.Path
  loc_0047F4F5: Dir1.ListIndex = var_18
  loc_0047F55A: var_18 = Dir1.Path
  loc_0047F57F: Dir1.TabIndex = var_18
  loc_0047F5C5: GoTo loc_0047F5E4
  loc_0047F5E3: Exit Sub
  loc_0047F5E4: 'Referenced from: 0047F5C5
End Sub

Private Sub Form_Load() '47FAC0
  loc_0047FB3C: var_18 = Dir1.Path
  loc_0047FB61: Dir1.TabIndex = var_18
  loc_0047FBA7: GoTo loc_0047FBC6
  loc_0047FBC5: Exit Sub
  loc_0047FBC6: 'Referenced from: 0047FBA7
End Sub
