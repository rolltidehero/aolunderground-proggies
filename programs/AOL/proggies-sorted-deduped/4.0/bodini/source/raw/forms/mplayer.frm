VERSION 5.00
Begin VB.Form mplayer
  Caption = "bodini media player"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 1 'Fixed Single
  Icon = "mplayer.frx":0
  LinkTopic = "Form1"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 45
  ClientTop = 330
  ClientWidth = 3690
  ClientHeight = 1365
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 360
    Width = 3495
    Height = 285
    Text = "C:\spek.mp3"
    TabIndex = 12
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
    Caption = "Pause"
    Left = 2640
    Top = 720
    Width = 975
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
  End
  Begin CommandButton Command4
    Caption = "?"
    Left = 4560
    Top = 2880
    Width = 735
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
    Caption = "Browse"
    Left = 1800
    Top = 720
    Width = 855
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
    Caption = "Stop"
    Left = 960
    Top = 720
    Width = 855
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
    Caption = "Play"
    Left = 120
    Top = 720
    Width = 855
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
  Begin CommonDialog CmDialog1
  End
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 1000
    Left = 480
    Top = 3480
  End
  Begin Label Label2
    Caption = "No Repeat"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1080
    Width = 3495
    Height = 210
    TabIndex = 11
    Alignment = 2 'Center
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
  Begin MediaPlayer MediaPlayer1
    Left = 1200
    Top = 3480
    Width = 2295
    Height = 855
    TabIndex = 5
  End
  Begin Label seconds
    Caption = "0"
    Left = 4440
    Top = 840
    Width = 1695
    Height = 255
    TabIndex = 4
  End
  Begin Label minutes
    Caption = "0"
    Left = 4440
    Top = 600
    Width = 1695
    Height = 255
    TabIndex = 3
  End
  Begin Label Label6
    Caption = "0"
    Left = 4440
    Top = 360
    Width = 1695
    Height = 255
    TabIndex = 2
  End
  Begin Label status
    Caption = "Awaiting File..."
    ForeColor = &HFFFFFF&
    Left = 1320
    Top = 120
    Width = 2265
    Height = 210
    TabIndex = 1
    Alignment = 1 'Right Justify
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
  Begin Image Image7
    Left = 1800
    Top = 3840
    Width = 615
    Height = 255
  End
  Begin Label Label1
    Caption = "Filename:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 675
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

Attribute VB_Name = "mplayer"

