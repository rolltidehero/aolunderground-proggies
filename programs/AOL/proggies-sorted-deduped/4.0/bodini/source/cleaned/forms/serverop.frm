ï»¿VERSION 5.00
Begin VB.Form serverop
  Caption = "neurotek - options"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 0 'None
  'Icon = n/a
  LinkTopic = "Form2"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 0
  ClientTop = 0
  ClientWidth = 4620
  ClientHeight = 2175
  ShowInTaskbar = 0   'False
  StartUpPosition = 3 'Windows Default
  Begin CheckBox Check2
    Caption = "Remove Fwd:"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 840
    Width = 1575
    Height = 195
    TabIndex = 12
    Value = 1
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
  Begin CheckBox Check1
    Caption = "Turn IMs Off"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 600
    Width = 1575
    Height = 195
    TabIndex = 11
    Value = 1
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
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1800
    Top = 1200
    Width = 2655
    Height = 855
    Text = "serverop.frx":0
    TabIndex = 7
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
  Begin OptionButton Option4
    Caption = "Flash Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 3240
    Width = 1215
    Height = 255
    TabIndex = 5
    Value = 255
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
  Begin OptionButton Option3
    Caption = "Sent Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 3000
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
  Begin OptionButton Option2
    Caption = "Old Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 2760
    Width = 1215
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
  Begin OptionButton Option1
    Caption = "New Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 2520
    Width = 1215
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
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1800
    Top = 600
    Width = 2655
    Height = 315
    Text = "sent by: spek"
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
    Caption = "x"
    ForeColor = &HFFFFFF&
    Left = 4440
    Top = 0
    Width = 90
    Height = 210
    TabIndex = 10
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
    Caption = "-"
    ForeColor = &HFFFFFF&
    Left = 4320
    Top = 0
    Width = 60
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
  Begin Label Label1
    Caption = "bodini server options"
    ForeColor = &HFFFFFF&
    Left = 1560
    Top = 0
    Width = 1500
    Height = 195
    TabIndex = 8
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label5
    Caption = "mail message:"
    ForeColor = &HFFFFFF&
    Left = 1800
    Top = 960
    Width = 1020
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
  Begin Label Label4
    Caption = "suffix:"
    ForeColor = &HFFFFFF&
    Left = 1800
    Top = 360
    Width = 465
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

Attribute VB_Name = "serverop"

