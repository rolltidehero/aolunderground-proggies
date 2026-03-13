VERSION 5.00
Begin VB.Form pwc
  Caption = "bodini password cracker"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 1 'Fixed Single
  Icon = "pwc.frx":0
  LinkTopic = "Form1"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 45
  ClientTop = 330
  ClientWidth = 3285
  ClientHeight = 3825
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Stop1
    Caption = "Crack"
    Left = 480
    Top = 4440
    Width = 735
    Height = 255
    TabIndex = 33
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin PictureBox Picture2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1680
    Top = 720
    Width = 1455
    Height = 255
    TabIndex = 30
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
  Begin PictureBox Picture1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 720
    Width = 1455
    Height = 255
    TabIndex = 29
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
  Begin ListBox List1
    BackColor = &H0&
    ForeColor = &HFFFFFF&
    Left = 1800
    Top = 4560
    Width = 1335
    Height = 1035
    TabIndex = 23
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
  Begin ComboBox Combo4
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2640
    Top = 2400
    Width = 510
    Height = 315
    Text = ".7"
    TabIndex = 22
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
  Begin ComboBox Combo3
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 2400
    Width = 1455
    Height = 315
    TabIndex = 17
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
  Begin CommandButton Command15
    Caption = "Save"
    Left = 2400
    Top = 2040
    Width = 735
    Height = 255
    TabIndex = 16
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command14
    Caption = "Load"
    Left = 1680
    Top = 2040
    Width = 735
    Height = 255
    TabIndex = 15
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command13
    Caption = "Save"
    Left = 2400
    Top = 1560
    Width = 735
    Height = 255
    TabIndex = 14
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command12
    Caption = "Load"
    Left = 1680
    Top = 1560
    Width = 735
    Height = 255
    TabIndex = 13
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command11
    Caption = "Default"
    Left = 2400
    Top = 1320
    Width = 735
    Height = 255
    TabIndex = 12
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command10
    Caption = "Clear"
    Left = 1680
    Top = 1320
    Width = 735
    Height = 255
    TabIndex = 11
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command9
    Caption = "Remove"
    Left = 2400
    Top = 1080
    Width = 735
    Height = 255
    TabIndex = 10
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command8
    Caption = "Add"
    Left = 1680
    Top = 1080
    Width = 735
    Height = 255
    TabIndex = 9
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command1
    Caption = "Crack"
    Left = 120
    Top = 2040
    Width = 735
    Height = 255
    TabIndex = 8
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command7
    Caption = "Save"
    Left = 840
    Top = 1560
    Width = 735
    Height = 255
    TabIndex = 7
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command6
    Caption = "Load"
    Left = 120
    Top = 1560
    Width = 735
    Height = 255
    TabIndex = 6
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command5
    Caption = "+ Room"
    Left = 840
    Top = 1320
    Width = 735
    Height = 255
    TabIndex = 5
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command4
    Caption = "Clear"
    Left = 120
    Top = 1320
    Width = 735
    Height = 255
    TabIndex = 4
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command3
    Caption = "Remove"
    Left = 840
    Top = 1080
    Width = 735
    Height = 255
    TabIndex = 3
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin CommandButton Command2
    Caption = "Add"
    Left = 120
    Top = 1080
    Width = 735
    Height = 255
    TabIndex = 2
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
  End
  Begin ComboBox Combo2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1680
    Top = 360
    Width = 1455
    Height = 315
    TabIndex = 1
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
  Begin ComboBox Combo1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 360
    Width = 1455
    Height = 315
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
  Begin Label password
    BackColor = &H0&
    ForeColor = &HFFFFFF&
    Left = 1680
    Top = 3960
    Width = 1455
    Height = 255
    TabIndex = 32
    BorderStyle = 1 'Fixed Single
    Alignment = 2 'Center
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
  Begin Label account
    BackColor = &H0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 3960
    Width = 1455
    Height = 255
    TabIndex = 31
    BorderStyle = 1 'Fixed Single
    Alignment = 2 'Center
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
  Begin Label pwsleft
    Caption = "0"
    BackColor = &HC0C000&
    ForeColor = &HFFFFFF&
    Left = 3000
    Top = 3120
    Width = 90
    Height = 210
    TabIndex = 28
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
  Begin Label pwstried
    Caption = "0"
    BackColor = &HC0C000&
    ForeColor = &HFFFFFF&
    Left = 3000
    Top = 2880
    Width = 90
    Height = 210
    TabIndex = 27
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
  Begin Label accleft
    Caption = "0"
    BackColor = &HC0C000&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 3120
    Width = 90
    Height = 210
    TabIndex = 26
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
  Begin Label acctried
    Caption = "0"
    BackColor = &HC0C000&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 2880
    Width = 90
    Height = 210
    TabIndex = 25
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
  Begin Label Status
    Caption = "bodini pwc by: spek"
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 3480
    Width = 3015
    Height = 255
    TabIndex = 24
    BorderStyle = 1 'Fixed Single
    Alignment = 2 'Center
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
    Caption = "Passwords:"
    ForeColor = &HFFFFFF&
    Left = 1680
    Top = 120
    Width = 975
    Height = 255
    TabIndex = 21
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
    BackColor = &HC0C000&
    ForeColor = &HFFFFFF&
    Left = 2760
    Top = 120
    Width = 375
    Height = 255
    TabIndex = 20
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
    BackColor = &HC0C000&
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 120
    Width = 375
    Height = 255
    TabIndex = 19
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
    Caption = "Accounts:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 975
    Height = 255
    TabIndex = 18
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

Attribute VB_Name = "pwc"

