ï»¿VERSION 5.00
Begin VB.Form htmlfade
  Caption = "bodini html fader"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "htmlfade.frx":0
  LinkTopic = "Form2"
  ClientLeft = 1275
  ClientTop = 960
  ClientWidth = 2745
  ClientHeight = 3210
  PaletteMode = 1
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1920
    Width = 2535
    Height = 855
    TabIndex = 12
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
  Begin PictureBox Picture1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1560
    Width = 2535
    Height = 255
    TabIndex = 11
    ScaleMode = 1
    AutoRedraw = False
    FontTransparent = True
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
  Begin CommandButton Command2
    Caption = "Copy HTML"
    Left = 1440
    Top = 2880
    Width = 1215
    Height = 255
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
    Appearance = 0 'Flat
  End
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1200
    Width = 2535
    Height = 285
    Text = "bodini 4.0 by: spek"
    TabIndex = 9
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
  Begin HScrollBar HScroll6
    Left = 1440
    Top = 600
    Width = 1215
    Height = 135
    TabIndex = 7
    Max = 255
  End
  Begin HScrollBar HScroll5
    Left = 1440
    Top = 360
    Width = 1215
    Height = 135
    TabIndex = 6
    Max = 255
  End
  Begin HScrollBar HScroll4
    Left = 1440
    Top = 120
    Width = 1215
    Height = 135
    TabIndex = 5
    Max = 255
  End
  Begin HScrollBar HScroll3
    Left = 120
    Top = 600
    Width = 1215
    Height = 135
    TabIndex = 3
    Max = 255
  End
  Begin HScrollBar HScroll2
    Left = 120
    Top = 360
    Width = 1215
    Height = 135
    TabIndex = 2
    Max = 255
  End
  Begin HScrollBar HScroll1
    Left = 120
    Top = 120
    Width = 1215
    Height = 135
    TabIndex = 1
    Max = 255
  End
  Begin CommandButton Command1
    Caption = "Fade"
    Left = 120
    Top = 2880
    Width = 1215
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
    Appearance = 0 'Flat
  End
  Begin Label Label2
    BackColor = &H0&
    Left = 1440
    Top = 840
    Width = 1215
    Height = 255
    TabIndex = 8
    BorderStyle = 1 'Fixed Single
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
    BackColor = &H0&
    Left = 120
    Top = 840
    Width = 1215
    Height = 255
    TabIndex = 4
    BorderStyle = 1 'Fixed Single
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

Attribute VB_Name = "htmlfade"

