VERSION 5.00
Begin VB.Form Form4
  Caption = "Dark Water - Load Phish Phrase Dialog Box"
  MousePointer = 99 'Custom
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form4.frx":0
  BorderStyle = 1 'Fixed Single
  Icon = "Form4.frx":718E
  LinkTopic = "Form4"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 45
  ClientTop = 330
  ClientWidth = 4905
  ClientHeight = 3075
  MouseIcon = "Form4.frx":7498
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 2160
    Width = 4695
    Height = 285
    TabIndex = 5
    Locked = -1  'True
  End
  Begin CommandButton Command2
    Caption = "Cancel"
    Left = 120
    Top = 2760
    Width = 4695
    Height = 255
    TabIndex = 4
  End
  Begin CommandButton Command1
    Caption = "Load Phrase"
    Left = 120
    Top = 2520
    Width = 4695
    Height = 255
    TabIndex = 3
  End
  Begin FileListBox File1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 1320
    Width = 4695
    Height = 870
    TabIndex = 2
    Pattern = "*.*phr"
  End
  Begin DirListBox Dir1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 360
    Width = 4695
    Height = 990
    TabIndex = 1
  End
  Begin DriveListBox Drive1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 120
    Width = 4695
    Height = 315
    TabIndex = 0
  End
End

Attribute VB_Name = "Form4"


Private Sub Drive1_Change() '47C1F0
  loc_0047C26C: var_18 = Drive1.Drive
  loc_0047C291: Drive1.Drive = var_18
  loc_0047C2D7: GoTo loc_0047C2F6
  loc_0047C2F5: Exit Sub
  loc_0047C2F6: 'Referenced from: 0047C2D7
End Sub

Private Sub File1_Click() '47C320
  Dim var_28 As TextBox
  Dim var_2C As Variant
  Dim var_30 As TextBox
  Dim var_94 As FileListBox
  loc_0047C3AC: var_18 = Text1.Text
  loc_0047C3D9: var_58 = var_18
  loc_0047C3FD: var_1C = Drive1.Drive
  loc_0047C430: var_38 = var_1C & var_00414E54
  loc_0047C454: var_ret_1 = (var_18 = Ucase(var_1C & var_00414E54))
  loc_0047C45F: call Not(var_80, var_ret_1, var_2C, var_18, Me, var_28, Me, Me, Set %StkVar1 = %StkVar2 'Ignore this, Me, ebx)
  loc_0047C46F: var_94 = CBool(Not(var_80, var_ret_1, var_2C, var_18, Me, var_28, Me, Me, Set %StkVar1 = %StkVar2)
  loc_0047C4AA: If var_94 = 0 Then GoTo loc_0047C5BE
  loc_0047C4C3: var_94 = var_30
  loc_0047C4DF: var_18 = Text1.Text
  loc_0047C516: var_1C = File1.FileName
  loc_0047C568: var_24 = var_18 & var_00414E54 & var_1C
  loc_0047C56C: File1.TabIndex = var_24
  loc_0047C5B9: GoTo loc_0047C6B0
  loc_0047C5BE: 'Referenced from: 0047C4AA
  loc_0047C5D1: var_94 = var_28
  loc_0047C5E2: ecx = esi
  loc_0047C5ED: var_18 = Text1.Text
  loc_0047C62E: var_1C = File1.FileName
  loc_0047C663: var_20 = var_18 & var_1C
  loc_0047C66B: File1.TabIndex = var_20
  loc_0047C6B0: 'Referenced from: 0047C5B9
  loc_0047C6BC: GoTo loc_0047C70A
  loc_0047C709: Exit Sub
  loc_0047C70A: 'Referenced from: 0047C6BC
End Sub

Private Sub Command1_Click() '47BDA0
  loc_0047BE3E: var_18 = Text1.Text
  loc_0047BE88: var_eax = call Proc_2_10_479F50(var_20, var_18, var_20)
  loc_0047BED3: Set var_20 = Me
  loc_0047BEDB: var_eax = Global.Unload var_20
  loc_0047BF08: GoTo loc_0047BF32
  loc_0047BF31: Exit Sub
  loc_0047BF32: 'Referenced from: 0047BF08
End Sub

Private Sub Command2_Click() '47BF60
  loc_0047BFCE: Set var_18 = Me
  loc_0047BFD9: var_eax = Global.Unload var_18
  loc_0047C002: GoTo loc_0047C00E
  loc_0047C00D: Exit Sub
  loc_0047C00E: 'Referenced from: 0047C002
End Sub

Private Sub Dir1_Change() '47C030
  Dim var_20 As DirListBox
  Dim var_2C As DirListBox
  loc_0047C094: var_2C = var_20
  loc_0047C0AD: var_18 = Dir1.Path
  loc_0047C0D5: Dir1.ListIndex = var_18
  loc_0047C13A: var_18 = Dir1.Path
  loc_0047C15F: Dir1.TabIndex = var_18
  loc_0047C1A5: GoTo loc_0047C1C4
  loc_0047C1C3: Exit Sub
  loc_0047C1C4: 'Referenced from: 0047C1A5
End Sub

Private Sub Form_Load() '47C730
  loc_0047C7AC: var_18 = Dir1.Path
  loc_0047C7D1: Dir1.TabIndex = var_18
  loc_0047C817: GoTo loc_0047C836
  loc_0047C835: Exit Sub
  loc_0047C836: 'Referenced from: 0047C817
End Sub
