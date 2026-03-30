VERSION 5.00
Begin VB.Form APIcalls
  Caption = "Whats needed in your module"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4710
  ClientHeight = 3195
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    Left = 120
    Top = 120
    Width = 4455
    Height = 3015
    Text = "APIcalls.frx":0
    TabIndex = 0
    MultiLine = -1  'True
    ScrollBars = 3
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

Attribute VB_Name = "APIcalls"


Private Sub Form_Load()
  call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  Exit Sub
End Sub

Private Sub Form_Resize()
  Dim var_18 As TextBox
  var_1C = Me.WindowState
  If var_1C <> 0 Then GoTo loc_004133DF
  var_20 = Me.Height
  var_24 = Me.Width
  GoTo loc_004132F7
  If eax <> 0 Then GoTo loc_004133DD
  var_20 = Text1.Height
  Text1.Width = var_18
  var_20 = Text1.Enabled
  Text1.Height = var_18
  Exit Sub
  Exit Sub
End Sub
