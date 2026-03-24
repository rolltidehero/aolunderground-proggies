VERSION 5.00
Begin VB.Form voterbot
  Caption = "bodini voter bot"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "voterbot.frx":0
  LinkTopic = "Form19"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2520
  ClientHeight = 2295
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Start"
    Left = 120
    Top = 1920
    Width = 2295
    Height = 255
    TabIndex = 6
    Default = -1  'True
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
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 100
    Left = 3600
    Top = 3240
  End
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 2295
    Height = 285
    Text = "is bodini a cool aol4 prog?"
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
  Begin ListBox List2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1320
    Top = 720
    Width = 1095
    Height = 1035
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
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 480
    Top = 4560
    Width = 1215
    Height = 285
    Visible = 0   'False
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
  Begin ListBox List1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 720
    Width = 1095
    Height = 1035
    TabIndex = 0
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
  Begin Label Label2
    Caption = "no:"
    BackColor = &H80000012&
    ForeColor = &HFFFFFF&
    Left = 1320
    Top = 480
    Width = 225
    Height = 210
    TabIndex = 5
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label1
    Caption = "yes:"
    BackColor = &H80000007&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 480
    Width = 315
    Height = 210
    TabIndex = 4
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
End

Attribute VB_Name = "voterbot"

