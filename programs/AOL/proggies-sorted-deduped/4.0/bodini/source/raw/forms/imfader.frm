VERSION 5.00
Begin VB.Form imfader
  Caption = "bodini im fader"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "imfader.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2775
  ClientHeight = 2250
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1560
    Width = 2535
    Height = 285
    Text = "bodini 4.0 by: spek"
    TabIndex = 10
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
    Top = 1200
    Width = 2535
    Height = 285
    Text = "aim spek"
    TabIndex = 8
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
    Caption = "Send"
    Left = 120
    Top = 1920
    Width = 2535
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
  Begin HScrollBar HScroll6
    Left = 1440
    Top = 960
    Width = 1215
    Height = 135
    TabIndex = 6
    Max = 255
  End
  Begin HScrollBar HScroll5
    Left = 1440
    Top = 720
    Width = 1215
    Height = 135
    TabIndex = 5
    Max = 255
  End
  Begin HScrollBar HScroll4
    Left = 1440
    Top = 480
    Width = 1215
    Height = 135
    TabIndex = 4
    Max = 255
  End
  Begin HScrollBar HScroll3
    Left = 120
    Top = 960
    Width = 1215
    Height = 135
    TabIndex = 3
    Max = 255
  End
  Begin HScrollBar HScroll2
    Left = 120
    Top = 720
    Width = 1215
    Height = 135
    TabIndex = 2
    Max = 255
  End
  Begin HScrollBar HScroll1
    Left = 120
    Top = 480
    Width = 1215
    Height = 135
    TabIndex = 1
    Max = 255
  End
  Begin Label Label1
    BackColor = &H0&
    Left = 120
    Top = 120
    Width = 1215
    Height = 255
    TabIndex = 9
    BorderStyle = 1 'Fixed Single
  End
  Begin Label Label2
    BackColor = &H0&
    Left = 1440
    Top = 120
    Width = 1215
    Height = 255
    TabIndex = 0
    BorderStyle = 1 'Fixed Single
  End
End

Attribute VB_Name = "imfader"

