VERSION 5.00
Begin VB.Form iextract
  Caption = "bodini icon extractor"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "iextract.frx":0
  LinkTopic = "Form1"
  ClientLeft = 5970
  ClientTop = 5145
  ClientWidth = 1665
  ClientHeight = 1245
  Begin CommonDialog CommonDialog1
  End
  Begin CommandButton Command2
    Caption = "Open"
    Left = 840
    Top = 840
    Width = 735
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
  Begin VScrollBar VScroll1
    Left = 1080
    Top = 240
    Width = 135
    Height = 485
    TabIndex = 2
  End
  Begin CommandButton Command1
    Caption = "Save"
    Left = 120
    Top = 840
    Width = 735
    Height = 255
    TabIndex = 1
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
  Begin PictureBox Picture1
    BackColor = &H80000005&
    ForeColor = &H80000008&
    Left = 600
    Top = 240
    Width = 485
    Height = 485
    TabIndex = 0
    ScaleMode = 1
    AutoRedraw = True
    FontTransparent = True
    AutoSize = -1  'True
    BorderStyle = 0 'None
    Appearance = 0 'Flat
    ToolTipText = "Use the scroll bar to view the images"
  End
  Begin Label Label1
    Caption = " no image"
    ForeColor = &HFFFFFF&
    Left = 535
    Top = 0
    Width = 690
    Height = 210
    TabIndex = 4
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

Attribute VB_Name = "iextract"

