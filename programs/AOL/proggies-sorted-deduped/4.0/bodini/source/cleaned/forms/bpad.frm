ï»¿VERSION 5.00
Begin VB.Form bpad
  Caption = "bodini pad"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form2"
  ClientLeft = 165
  ClientTop = 450
  ClientWidth = 5280
  ClientHeight = 2865
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 5055
    Height = 2295
    Text = "bpad.frx":0
    TabIndex = 2
    MultiLine = -1  'True
    ScrollBars = 3
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin CommandButton Command1
    Caption = "Menu"
    Left = 120
    Top = 2520
    Width = 5055
    Height = 255
    TabIndex = 1
    BeginProperty Font
      Name = "Verdana"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin CommonDialog CMDialog1
  End
  Begin Image Image2
    Picture = "bpad.frx":18
    Left = 2100
    Top = 2910
    Width = 870
    Height = 285
    Visible = 0   'False
  End
  Begin Image Image1
    Picture = "bpad.frx":D6A
    Left = 2040
    Top = 2880
    Width = 870
    Height = 285
    MousePointer = 99 'Custom
    MouseIcon = "bpad.frx":1ABC
  End
  Begin Label Label3
    Caption = "Menu"
    ForeColor = &HFFFFFF&
    Left = 2040
    Top = 3195
    Width = 855
    Height = 255
    TabIndex = 0
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
End

Attribute VB_Name = "bpad"

