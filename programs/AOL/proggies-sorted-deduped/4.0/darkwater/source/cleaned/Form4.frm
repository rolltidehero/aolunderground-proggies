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


Private Sub Drive1_Change()
  var_18 = Drive1.Drive
  Drive1.Drive = var_18
  Exit Sub
End Sub

Private Sub File1_Click()
  Dim var_28 As TextBox
  Dim var_2C As Variant
  Dim var_30 As TextBox
  Dim var_94 As FileListBox
  var_18 = Text1.Text
  var_58 = var_18
  var_1C = Drive1.Drive
  var_38 = var_1C & var_00414E54
  var_ret_1 = (var_18 = Ucase(var_1C & var_00414E54))
  call Not(var_80, var_ret_1, var_2C, var_18, Me, var_28, Me, Me, Set %StkVar1 = %StkVar2 'Ignore this, Me, ebx)
  var_94 = CBool(Not(var_80, var_ret_1, var_2C, var_18, Me, var_28, Me, Me, Set %StkVar1 = %StkVar2)
  If var_94 = 0 Then GoTo loc_0047C5BE
  var_94 = var_30
  var_18 = Text1.Text
  var_1C = File1.FileName
  var_24 = var_18 & var_00414E54 & var_1C
  File1.TabIndex = var_24
  GoTo loc_0047C6B0
  var_94 = var_28
  ecx = esi
  var_18 = Text1.Text
  var_1C = File1.FileName
  var_20 = var_18 & var_1C
  File1.TabIndex = var_20
  Exit Sub
End Sub

Private Sub Command1_Click()
  var_18 = Text1.Text
  call MailCountFlash(var_20, var_18, var_20)
  Set var_20 = Me
  var_eax = Global.Unload var_20
  Exit Sub
End Sub

Private Sub Command2_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Private Sub Dir1_Change()
  Dim var_20 As DirListBox
  Dim var_2C As DirListBox
  var_2C = var_20
  var_18 = Dir1.Path
  Dir1.ListIndex = var_18
  var_18 = Dir1.Path
  Dir1.TabIndex = var_18
  Exit Sub
End Sub

Private Sub Form_Load()
  var_18 = Dir1.Path
  Dir1.TabIndex = var_18
  Exit Sub
End Sub
