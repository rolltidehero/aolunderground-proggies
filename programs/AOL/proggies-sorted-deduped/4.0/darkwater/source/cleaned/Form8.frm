VERSION 5.00
Begin VB.Form Form8
  Caption = "Form8"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form8.frx":0
  BorderStyle = 0 'None
  'Icon = n/a
  LinkTopic = "Form8"
  ClientLeft = 0
  ClientTop = 0
  ClientWidth = 6330
  ClientHeight = 4725
  ShowInTaskbar = 0   'False
  StartUpPosition = 2 'CenterScreen
  Begin Label Label5
    Caption = "A Y2K IceRebels Production"
    ForeColor = &H8000&
    Left = 120
    Top = 4440
    Width = 2295
    Height = 255
    TabIndex = 4
    BackStyle = 0 'Transparent
  End
  Begin Label Label4
    Caption = "ToX -n- Thief"
    ForeColor = &HC00000&
    Left = 2640
    Top = 1920
    Width = 1215
    Height = 2775
    TabIndex = 3
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Sticker ttnorm"
      Size = 36
      Charset = 0
      Weight = 500
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label3
    Caption = "By:"
    ForeColor = &HC00000&
    Left = 2760
    Top = 1320
    Width = 1095
    Height = 615
    TabIndex = 2
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Sticker ttnorm"
      Size = 26.25
      Charset = 0
      Weight = 500
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label2
    Caption = "Version 1.0 beta 1"
    ForeColor = &HC00000&
    Left = 1560
    Top = 840
    Width = 3255
    Height = 495
    TabIndex = 1
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Sticker ttnorm"
      Size = 20.25
      Charset = 0
      Weight = 500
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label1
    Caption = "DarkWater Phisher"
    ForeColor = &HFF0000&
    Left = 120
    Top = 0
    Width = 6015
    Height = 735
    TabIndex = 0
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Sticker ttnorm"
      Size = 36
      Charset = 0
      Weight = 500
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
End

Attribute VB_Name = "Form8"


Private Sub Form_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Private Sub Label1_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Private Sub Label2_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Private Sub Label4_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Private Sub Label5_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Private Sub Label3_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub
