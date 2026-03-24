VERSION 5.00
Begin VB.Form apispy
  Caption = "bodini api spy"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 3
  AutoRedraw = False
  FontTransparent = True
  Icon = "apispy.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4800
  ClientHeight = 2550
  LockControls = -1  'True
  StartUpPosition = 2 'CenterScreen
  Begin Timer Timer1
    Interval = 7
    Left = 75
    Top = 3255
  End
  Begin TextBox Text1
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 150
    Top = 150
    Width = 4500
    Height = 2280
    TabIndex = 0
    BorderStyle = 0 'None
    MultiLine = -1  'True
    Tag = "0"
    Locked = -1  'True
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    Appearance = 0 'Flat
    ToolTipText = "P - suspend timer."
  End
End

Attribute VB_Name = "apispy"

