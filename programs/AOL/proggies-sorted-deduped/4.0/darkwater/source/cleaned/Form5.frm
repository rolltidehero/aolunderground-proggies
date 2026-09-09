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


Private Sub Drive1_Change()
  var_18 = Drive1.Drive
  Drive1.Drive = var_18
  Exit Sub
End Sub

Private Sub File1_Click()
  Dim var_2C As TextBox
  Dim var_28 As DriveListBox
  Dim var_84 As Variant
  var_1C = Text1.Text
  var_58 = var_1C
  var_18 = Drive1.Drive
  var_38 = var_18 & var_00414E54
  var_84 = (var_1C = Ucase(var_18 & var_00414E54))
  If var_84 = 0 Then GoTo loc_0047D072
  var_1C = Text1.Text
  var_18 = File1.FileName
  var_20 = var_1C & var_18
  File1.TabIndex = var_20
  GoTo loc_0047D178
  call var_84(var_30, var_30, Me, var_2C, Me, Me)
  var_84 = var_84(var_30, var_30, Me, var_2C, Me, Me)
  call var_84(var_28, var_84(var_30, var_30, Me, var_2C, Me, Me), var_84)
  var_18 = Text1.Text
  call var_84(var_2C, var_84, var_84)
  var_1C = File1.FileName
  var_24 = var_18 & var_00414E54 & var_1C
  File1.TabIndex = var_24
  Exit Sub
End Sub

Private Sub Command1_Click()
  var_1C = Form2.Text2.Text
  var_18 = Text1.Text
  call MailToListFlash(var_1C, var_18 & var_004156F0, var_28)
  Set var_28 = Me
  var_eax = Global.Unload var_28
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
