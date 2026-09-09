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


Private Sub Drive1_Change()
  var_18 = Drive1.Drive
  Drive1.Drive = var_18
  Exit Sub
End Sub

Private Sub File1_Click()
  Dim var_28 As DirListBox
  Dim var_30 As DirListBox
  Dim var_2C As FileListBox
  Dim var_84 As Variant
  var_18 = Dir1.Path
  var_38 = var_18
  var_7C = (Right(var_18, 1) = &H414E54)
  If var_7C = 0 Then GoTo loc_0047EE94
  var_84 = var_30
  var_18 = Dir1.Path
  var_1C = File1.FileName
  var_20 = var_18 & var_1C
  File1.TabIndex = var_20
  GoTo loc_0047EF9A
  call var_84(var_30, var_2C, Me, var_28, Me, Me)
  var_84 = var_84(var_30, var_2C, Me, var_28, Me, Me)
  call var_84(var_28, var_84(var_30, var_2C, Me, var_28, Me, Me), var_84)
  var_18 = Dir1.Path
  call var_84(var_2C, var_18, var_84)
  var_1C = File1.FileName
  var_24 = var_18 & var_00414E54 & var_1C
  File1.TabIndex = var_24
  Exit Sub
End Sub

Private Sub Command1_Click()
  Dim var_20 As TextBox
  var_18 = Text1.Text
  call Proc_6_4_47DF70(var_18, var_24, var_28)
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
