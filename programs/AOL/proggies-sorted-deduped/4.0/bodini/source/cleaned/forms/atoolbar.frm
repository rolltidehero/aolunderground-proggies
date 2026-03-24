ï»¿VERSION 5.00
Begin VB.Form atoolbar
  Caption = "bodini aol toolbar menu"
  BackColor = &H800000&
  MousePointer = 99 'Custom
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "atoolbar.frx":0
  BorderStyle = 0 'None
  Icon = "atoolbar.frx":1D31
  LinkTopic = "Form2"
  ClientLeft = 150
  ClientTop = 435
  ClientWidth = 690
  ClientHeight = 570
  MouseIcon = "atoolbar.frx":203B
  ShowInTaskbar = 0   'False
  StartUpPosition = 3 'Windows Default
  Begin Image Image2
    Picture = "atoolbar.frx":2345
    Left = 0
    Top = 0
    Width = 780
    Height = 780
    Visible = 0   'False
  End
  Begin Image Image1
    Picture = "atoolbar.frx":4337
    Left = 0
    Top = 0
    Width = 780
    Height = 780
    Visible = 0   'False
  End
  Begin Label Label1
    Caption = "P2"
    ForeColor = &HFFFFFF&
    Left = 1320
    Top = 1560
    Width = 735
    Height = 615
    MousePointer = 99 'Custom
    TabIndex = 0
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    MouseIcon = "atoolbar.frx":6329
    BeginProperty Font
      Name = "Arial"
      Size = 21.75
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = -1 'True
      Strikethrough = 0 'False
    EndProperty
  End
End

Attribute VB_Name = "atoolbar"

