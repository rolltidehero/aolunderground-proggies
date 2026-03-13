ï»¿VERSION 5.00
Begin VB.Form pwsd
  Caption = "bodini pwsd"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "pwsd.frx":0
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2745
  ClientHeight = 825
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 2535
    Height = 285
    Text = "File..."
    TabIndex = 3
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
  Begin CommandButton Command3
    Caption = "Delete"
    Left = 1800
    Top = 480
    Width = 855
    Height = 255
    TabIndex = 2
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
  Begin CommandButton Command2
    Caption = "Load"
    Left = 960
    Top = 480
    Width = 855
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
  Begin CommandButton Command1
    Caption = "Scan"
    Left = 120
    Top = 480
    Width = 855
    Height = 255
    TabIndex = 0
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
  Begin CommonDialog CommonDialog1
  End
End

Attribute VB_Name = "pwsd"

