ï»¿VERSION 5.00
Begin VB.Form mchat
  Caption = "bodini m-chat"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "mchat.frx":0
  LinkTopic = "Form31"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 7065
  ClientHeight = 3165
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command2
    Caption = "Refresh"
    Left = 5280
    Top = 2640
    Width = 1455
    Height = 285
    TabIndex = 11
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
    Caption = "Send"
    Left = 4440
    Top = 2640
    Width = 735
    Height = 285
    TabIndex = 10
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
  Begin Timer Timer2
    Interval = 1
    Left = 7800
    Top = 1680
  End
  Begin ListBox List1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 5280
    Top = 360
    Width = 1455
    Height = 2205
    TabIndex = 5
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
  Begin TextBox Text5
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 2640
    Width = 4215
    Height = 285
    TabIndex = 4
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
  Begin Timer Timer1
    Interval = 10
    Left = 7800
    Top = 600
  End
  Begin TextBox Text4
    Left = 10560
    Top = 2040
    Width = 2535
    Height = 2895
    TabIndex = 3
    MultiLine = -1  'True
    ScrollBars = 2
  End
  Begin TextBox Text3
    Left = 10200
    Top = 2040
    Width = 2535
    Height = 2055
    TabIndex = 2
    MultiLine = -1  'True
    ScrollBars = 2
  End
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 360
    Width = 5055
    Height = 2205
    TabIndex = 1
    MultiLine = -1  'True
    ScrollBars = 2
    Locked = -1  'True
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
    Left = 8640
    Top = 3120
    Width = 2415
    Height = 1935
    TabIndex = 0
    MultiLine = -1  'True
    ScrollBars = 2
  End
  Begin Label Label3
    Caption = "bodini 4.0 multitask chat"
    ForeColor = &HFFFFFF&
    Left = 1560
    Top = 120
    Width = 1710
    Height = 210
    TabIndex = 9
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
    Caption = "Send"
    BackColor = &HFFFFFF&
    ForeColor = &HFFFFFF&
    Left = 4440
    Top = 2760
    Width = 495
    Height = 255
    TabIndex = 8
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
  Begin Label Label7
    Caption = "people:"
    ForeColor = &H8000000E&
    Left = 5280
    Top = 120
    Width = 525
    Height = 210
    TabIndex = 7
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
  Begin Label Label6
    Caption = "0"
    ForeColor = &H8000000E&
    Left = 6600
    Top = 120
    Width = 90
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
End

Attribute VB_Name = "mchat"

