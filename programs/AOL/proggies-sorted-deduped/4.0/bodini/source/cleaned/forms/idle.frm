ï»¿VERSION 5.00
Begin VB.Form idle
  Caption = "bodini idle bot"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "idle.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2790
  ClientHeight = 1080
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Start"
    Left = 840
    Top = 120
    Width = 1215
    Height = 255
    TabIndex = 4
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
    Enabled = 0   'False
    Interval = 60000
    Left = 1440
    Top = 1200
  End
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 1000
    Left = 960
    Top = 1200
  End
  Begin Label Label4
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 2280
    Top = 720
    Width = 135
    Height = 195
    TabIndex = 3
    Alignment = 2 'Center
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
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
    Caption = "idle windows closed:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 720
    Width = 1725
    Height = 195
    TabIndex = 2
    Alignment = 2 'Center
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
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
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 2280
    Top = 480
    Width = 135
    Height = 195
    TabIndex = 1
    Alignment = 2 'Center
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
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
  Begin Label Label1
    Caption = "idle for:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 480
    Width = 645
    Height = 195
    TabIndex = 0
    Alignment = 2 'Center
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
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
End

Attribute VB_Name = "idle"

