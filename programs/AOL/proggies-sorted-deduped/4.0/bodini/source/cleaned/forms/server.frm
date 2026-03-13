ï»¿VERSION 5.00
Begin VB.Form server
  Caption = "bodini server"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 1 'Fixed Single
  Icon = "server.frx":0
  LinkTopic = "Form1"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 45
  ClientTop = 330
  ClientWidth = 4785
  ClientHeight = 2310
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command4
    Caption = "Options"
    Left = 3720
    Top = 1920
    Width = 975
    Height = 255
    TabIndex = 24
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
    Caption = "Refresh"
    Left = 2520
    Top = 1920
    Width = 975
    Height = 255
    TabIndex = 23
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
    Caption = "Pause"
    Left = 1320
    Top = 1920
    Width = 975
    Height = 255
    Enabled = 0   'False
    TabIndex = 22
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
    Top = 1920
    Width = 975
    Height = 255
    TabIndex = 21
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
  Begin ListBox List2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2520
    Top = 360
    Width = 2175
    Height = 1425
    TabIndex = 20
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
  Begin ListBox List1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 360
    Width = 2175
    Height = 1425
    TabIndex = 19
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
  Begin Timer Timer4
    Left = 4320
    Top = 5040
  End
  Begin TextBox Multiple2
    Left = 480
    Top = 4560
    Width = 375
    Height = 315
    TabIndex = 17
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
  Begin ListBox List6
    Left = 1440
    Top = 5280
    Width = 1335
    Height = 270
    TabIndex = 15
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
  Begin ListBox List4
    Left = 120
    Top = 5280
    Width = 1335
    Height = 270
    TabIndex = 12
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
  Begin TextBox Text8
    Left = 120
    Top = 3840
    Width = 2775
    Height = 315
    TabIndex = 11
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
  Begin TextBox Text7
    Left = 120
    Top = 3480
    Width = 2775
    Height = 315
    TabIndex = 10
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
  Begin TextBox Text6
    Left = 120
    Top = 3120
    Width = 2775
    Height = 315
    TabIndex = 9
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
  Begin Timer Timer3
    Left = 3840
    Top = 5040
  End
  Begin Timer Timer2
    Left = 3360
    Top = 5040
  End
  Begin TextBox Text2
    Left = 1680
    Top = 2760
    Width = 1215
    Height = 285
    TabIndex = 7
  End
  Begin TextBox Multiple1
    Left = 120
    Top = 4560
    Width = 375
    Height = 315
    TabIndex = 4
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
  Begin ListBox List3
    Left = 120
    Top = 4200
    Width = 2775
    Height = 270
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
  Begin TextBox Text3
    Left = 120
    Top = 2760
    Width = 1455
    Height = 285
    TabIndex = 2
  End
  Begin Timer Timer1
    Interval = 1
    Left = 2880
    Top = 5040
  End
  Begin Label Label6
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 4560
    Top = 120
    Width = 90
    Height = 210
    TabIndex = 18
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
  Begin Label Label12
    Caption = "on"
    Left = 3000
    Top = 2760
    Width = 180
    Height = 210
    TabIndex = 16
    AutoSize = -1  'True
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
  Begin Label Label11
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 4920
    Width = 375
    Height = 285
    TabIndex = 14
    BorderStyle = 1 'Fixed Single
    Alignment = 2 'Center
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
  Begin Label Label10
    Caption = "whats this?"
    Left = 3480
    Top = 2880
    Width = 855
    Height = 210
    TabIndex = 13
    AutoSize = -1  'True
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
  Begin Label Label7
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 840
    Top = 4920
    Width = 615
    Height = 285
    TabIndex = 8
    BorderStyle = 1 'Fixed Single
    Alignment = 2 'Center
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
  Begin Label Label5
    Caption = "requests completed:"
    ForeColor = &HFFFFFF&
    Left = 2520
    Top = 120
    Width = 1470
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
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 4920
    Width = 735
    Height = 285
    TabIndex = 5
    BorderStyle = 1 'Fixed Single
    Alignment = 2 'Center
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
  Begin Label Label3
    Caption = "requests pending:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 1305
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
  Begin Label Label2
    Caption = "0"
    ForeColor = &HFFFFFF&
    Left = 2160
    Top = 120
    Width = 90
    Height = 210
    TabIndex = 0
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

Attribute VB_Name = "server"

