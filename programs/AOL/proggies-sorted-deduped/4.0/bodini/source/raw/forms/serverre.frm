VERSION 5.00
Begin VB.Form serverre
  Caption = "neurotek server - refresh"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 0 'None
  'Icon = n/a
  LinkTopic = "Form3"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 0
  ClientTop = 0
  ClientWidth = 2055
  ClientHeight = 795
  ShowInTaskbar = 0   'False
  StartUpPosition = 3 'Windows Default
  Begin Label Label1
    Caption = "refreshing mail..."
    BackColor = &H0&
    ForeColor = &HFFFFFF&
    Left = 405
    Top = 300
    Width = 1215
    Height = 210
    TabIndex = 0
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
End

Attribute VB_Name = "serverre"

