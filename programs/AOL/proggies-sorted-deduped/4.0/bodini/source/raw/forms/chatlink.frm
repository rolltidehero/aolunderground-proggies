VERSION 5.00
Begin VB.Form chatlink
  Caption = "bodini 4.0 chat link sender"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "chatlink.frx":0
  LinkTopic = "Form1"
  ClientLeft = 165
  ClientTop = 450
  ClientWidth = 3465
  ClientHeight = 1515
  StartUpPosition = 3 'Windows Default
  Begin CheckBox Check1
    Caption = "Check1"
    BackColor = &HFFC0C0&
    ForeColor = &HFFC0C0&
    Left = 840
    Top = 1200
    Width = 255
    Height = 195
    TabIndex = 5
  End
  Begin CommandButton Command1
    Caption = "Send"
    Left = 1200
    Top = 840
    Width = 1095
    Height = 255
    TabIndex = 4
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
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 480
    Width = 2175
    Height = 285
    Text = "x3 online"
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
    Left = 1200
    Top = 120
    Width = 2175
    Height = 285
    Text = "www.xclipticonline.com"
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
  Begin Label Label3
    Caption = "non underlined link"
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 1200
    Width = 1335
    Height = 210
    TabIndex = 6
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
  Begin Label Label2
    Caption = "description:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 480
    Width = 840
    Height = 210
    TabIndex = 2
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
    Caption = "link url:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 495
    Height = 210
    TabIndex = 1
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

Attribute VB_Name = "chatlink"

