VERSION 5.00
Begin VB.Form wreqbot
  Caption = "bodini warez requester bot"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "wreqbot.frx":0
  LinkTopic = "Form10"
  ClientLeft = 2370
  ClientTop = 1485
  ClientWidth = 2190
  ClientHeight = 2100
  BeginProperty Font
    Name = "Arial"
    Size = 8.25
    Charset = 0
    Weight = 400
    Underline = 0 'False
    Italic = 0 'False
    Strikethrough = 0 'False
  EndProperty
  PaletteMode = 1
  Begin TextBox Text4
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 3120
    Width = 1935
    Height = 285
    Visible = 0   'False
    TabIndex = 6
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
  Begin OptionButton Option2
    Caption = "IM Reply"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1800
    Width = 1935
    Height = 255
    TabIndex = 5
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
  Begin OptionButton Option1
    Caption = "Chat Reply"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1560
    Width = 1935
    Height = 255
    TabIndex = 4
    Value = 255
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
  Begin TextBox Text3
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 840
    Width = 1935
    Height = 285
    Text = "i got it"
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
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 1935
    Height = 285
    Text = "bodini 4.0 by: spek"
    TabIndex = 2
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
  Begin Timer Timer2
    Enabled = 0   'False
    Interval = 60000
    Left = 240
    Top = 2640
  End
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 500
    Left = 720
    Top = 2640
  End
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 480
    Width = 1935
    Height = 315
    Text = "can ya hook me up?"
    TabIndex = 1
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
    Caption = "Start"
    Left = 120
    Top = 1200
    Width = 1935
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
End

Attribute VB_Name = "wreqbot"

