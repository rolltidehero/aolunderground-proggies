VERSION 5.00
Begin VB.Form vcheck
  Caption = "bodini online version checker"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "vcheck.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 6255
  ClientHeight = 4785
  StartUpPosition = 3 'Windows Default
  PaletteMode = 1
  Begin TextBox Text2
    Left = 240
    Top = 3840
    Width = 4215
    Height = 285
    Enabled = 0   'False
    Text = "DL LINK"
    TabIndex = 10
  End
  Begin TextBox Text1
    Left = 2400
    Top = 1680
    Width = 2655
    Height = 615
    TabIndex = 8
    MultiLine = -1  'True
    ScrollBars = 2
  End
  Begin TextBox Richtextbox1
    Left = 3000
    Top = 2880
    Width = 1815
    Height = 285
    Enabled = 0   'False
    TabIndex = 2
    MultiLine = -1  'True
  End
  Begin TextBox URL
    Left = 120
    Top = 2520
    Width = 4695
    Height = 285
    Enabled = 0   'False
    Text = "http://www.saturnnet.com/dave/software/versions/version.html"
    TabIndex = 0
  End
  Begin Inet Inet1
  End
  Begin CommandButton Command1
    Caption = "&Display"
    Left = 840
    Top = 2880
    Width = 1095
    Height = 375
    Enabled = 0   'False
    TabIndex = 1
    Default = -1  'True
  End
  Begin Label Label7
    ForeColor = &HFFFFFF&
    Left = 2520
    Top = 1440
    Width = 2535
    Height = 255
    TabIndex = 9
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
  End
  Begin Label Label6
    Caption = "Upgrade..."
    ForeColor = &HC0C0C0&
    Left = 220
    Top = 1800
    Width = 855
    Height = 255
    TabIndex = 7
    Alignment = 2 'Center
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
  Begin Image Image2
    Picture = "vcheck.frx":30A
    Left = 210
    Top = 1485
    Width = 870
    Height = 285
    Visible = 0   'False
  End
  Begin Image Image1
    Picture = "vcheck.frx":105C
    Left = 165
    Top = 1440
    Width = 870
    Height = 285
    Enabled = 0   'False
    MousePointer = 99 'Custom
    MouseIcon = "vcheck.frx":1DAE
  End
  Begin Label Label5
    Caption = "Check Version"
    ForeColor = &HFFFFFF&
    Left = 1420
    Top = 1800
    Width = 855
    Height = 375
    TabIndex = 6
    Alignment = 2 'Center
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
  Begin Image Image3
    Picture = "vcheck.frx":20B8
    Left = 1410
    Top = 1485
    Width = 870
    Height = 285
    Visible = 0   'False
  End
  Begin Image Image4
    Picture = "vcheck.frx":2E0A
    Left = 1365
    Top = 1440
    Width = 870
    Height = 285
    MousePointer = 99 'Custom
    MouseIcon = "vcheck.frx":3B5C
  End
  Begin Label Label3
    Caption = "Ready."
    ForeColor = &HFFFFFF&
    Left = 0
    Top = 960
    Width = 5055
    Height = 495
    TabIndex = 5
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 6.75
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label2
    Caption = "Click on ""Check Version"" to check for the newest possible available version of Prophecy 2.0."
    ForeColor = &HFFFFFF&
    Left = 2400
    Top = 360
    Width = 2655
    Height = 615
    TabIndex = 4
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 6.75
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label1
    ForeColor = &HFFFFFF&
    Left = 0
    Top = 360
    Width = 2295
    Height = 495
    TabIndex = 3
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 6.75
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
End

Attribute VB_Name = "vcheck"

