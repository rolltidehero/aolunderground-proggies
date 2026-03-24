ï»¿VERSION 5.00
Begin VB.Form hexid
  Caption = "bodini hex id tool"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "hexid.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2055
  ClientHeight = 1575
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Find ID"
    BackColor = &H0&
    Left = 240
    Top = 1200
    Width = 1575
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
  Begin HScrollBar HScroll3
    Left = 240
    Top = 960
    Width = 1215
    Height = 135
    TabIndex = 3
    Max = 255
  End
  Begin HScrollBar HScroll2
    Left = 240
    Top = 720
    Width = 1215
    Height = 135
    TabIndex = 2
    Max = 255
  End
  Begin HScrollBar HScroll1
    Left = 240
    Top = 480
    Width = 1215
    Height = 135
    TabIndex = 1
    Max = 255
  End
  Begin Label Label4
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 1560
    Top = 960
    Width = 255
    Height = 135
    TabIndex = 7
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 6
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label3
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 1560
    Top = 720
    Width = 255
    Height = 135
    TabIndex = 6
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 6
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label2
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 1560
    Top = 480
    Width = 255
    Height = 135
    TabIndex = 5
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 6
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label1
    BackColor = &H0&
    Left = 240
    Top = 120
    Width = 1575
    Height = 255
    TabIndex = 0
    BorderStyle = 1 'Fixed Single
  End
End

Attribute VB_Name = "hexid"

