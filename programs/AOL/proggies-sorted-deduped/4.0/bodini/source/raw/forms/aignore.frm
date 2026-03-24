VERSION 5.00
Begin VB.Form aignore
  Caption = "bodini auto ignorer"
  BackColor = &H800000&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "aignore.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2670
  ClientHeight = 1785
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command2
    Caption = "Refresh R. List"
    Left = 1320
    Top = 1440
    Width = 1215
    Height = 255
    TabIndex = 3
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
  Begin CommandButton Command1
    Caption = "Ignore"
    Left = 120
    Top = 1440
    Width = 1215
    Height = 255
    TabIndex = 2
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
  Begin TextBox Text1
    Left = 2880
    Top = 120
    Width = 2415
    Height = 285
    TabIndex = 1
    MultiLine = -1  'True
  End
  Begin ListBox List1
    Left = 120
    Top = 120
    Width = 2415
    Height = 1230
    TabIndex = 0
  End
End

Attribute VB_Name = "aignore"

