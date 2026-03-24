ï»¿VERSION 5.00
Begin VB.Form phisher
  Caption = "bodini phisher"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "phisher.frx":0
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 5040
  ClientHeight = 1485
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1680
    Top = 120
    Width = 3255
    Height = 840
    Text = "phisher.frx":30A
    TabIndex = 6
    MultiLine = -1  'True
    ScrollBars = 2
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
  Begin CommandButton Command5
    Caption = "Clear"
    Left = 3960
    Top = 1080
    Width = 975
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
  Begin ListBox List1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 1545
    Height = 840
    MousePointer = 99 'Custom
    TabIndex = 4
    Sorted = -1  'True
    MouseIcon = "phisher.frx":322
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    WhatsThisHelpID = 90
  End
  Begin CommandButton Command4
    Caption = "+ Room"
    Left = 3000
    Top = 1080
    Width = 975
    Height = 255
    TabIndex = 3
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
    Caption = "Add"
    Left = 2040
    Top = 1080
    Width = 975
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
    Caption = "Generate"
    Left = 1080
    Top = 1080
    Width = 975
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
    Caption = "Start"
    Left = 120
    Top = 1080
    Width = 975
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

Attribute VB_Name = "phisher"

