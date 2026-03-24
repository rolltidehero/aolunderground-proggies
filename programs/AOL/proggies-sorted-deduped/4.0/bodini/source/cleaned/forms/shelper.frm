ï»¿VERSION 5.00
Begin VB.Form shelper
  Caption = "bodini server helper"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "shelper.frx":0
  LinkTopic = "Form10"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 6150
  ClientHeight = 795
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command4
    Caption = "Get Number"
    Left = 1440
    Top = 480
    Width = 1215
    Height = 255
    TabIndex = 9
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
  Begin CommandButton Command3
    Caption = "Get Numbers"
    Left = 4440
    Top = 480
    Width = 1575
    Height = 255
    TabIndex = 8
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
    Caption = "Find Query"
    Left = 2760
    Top = 480
    Width = 1575
    Height = 255
    TabIndex = 7
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
    Caption = "Get List"
    Left = 120
    Top = 480
    Width = 1215
    Height = 255
    TabIndex = 6
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
  Begin TextBox Text5
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 5280
    Top = 120
    Width = 735
    Height = 285
    Text = "33"
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
  Begin TextBox Text4
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 4440
    Top = 120
    Width = 735
    Height = 285
    Text = "0"
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
  Begin TextBox Text3
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2760
    Top = 120
    Width = 1575
    Height = 285
    Text = "bodini"
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
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 120
    Width = 1215
    Height = 285
    Text = "69"
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
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 1215
    Height = 285
    Text = "aim spek"
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
  Begin Label Label1
    Caption = "0"
    Left = 240
    Top = 3480
    Width = 615
    Height = 255
    Visible = 0   'False
    TabIndex = 5
  End
End

Attribute VB_Name = "shelper"

