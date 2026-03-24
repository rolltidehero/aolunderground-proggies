ï»¿VERSION 5.00
Begin VB.Form about
  Caption = "bodini about..."
  BackColor = &H800000&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "about.frx":0
  Icon = "about.frx":36F2A
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 3015
  ClientHeight = 1530
  StartUpPosition = 3 'Windows Default
  Begin PictureBox Picture1
    BackColor = &H80000005&
    Picture = "about.frx":37234
    ForeColor = &H80000008&
    Left = 360
    Top = 120
    Width = 485
    Height = 485
    TabIndex = 3
    ScaleMode = 1
    AutoRedraw = False
    FontTransparent = True
    BorderStyle = 0 'None
    Appearance = 0 'Flat
  End
  Begin CommandButton Command1
    Caption = "OK"
    Left = 1080
    Top = 1200
    Width = 855
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
  Begin Label Label2
    Caption = "Build: 1                     Version: .02"
    ForeColor = &HFFFFFF&
    Left = 360
    Top = 840
    Width = 2355
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
  Begin Label Label1
    Caption = "bodini 4.0   by: spek"
    ForeColor = &HFFFFFF&
    Left = 2040
    Top = 120
    Width = 840
    Height = 450
    TabIndex = 0
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

Attribute VB_Name = "about"

