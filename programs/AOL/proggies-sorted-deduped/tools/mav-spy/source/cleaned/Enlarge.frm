VERSION 5.00
Begin VB.Form Enlarge
  Caption = "Enlarged Code"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4935
  ClientHeight = 3405
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    Left = 120
    Top = 120
    Width = 4695
    Height = 3135
    Text = "Text1"
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

Attribute VB_Name = "Enlarge"


Private Sub Form_Load()
  call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  Exit Sub
End Sub

Private Sub Form_Resize()
  var_1C = Enlarge.WindowState
  If var_1C <> 0 Then GoTo loc_00421E28
  var_20 = Enlarge.Height
  var_24 = Enlarge.Width
  GoTo loc_00421CEF
  If var_40 <> 0 Then GoTo loc_00421E28
  var_20 = Enlarge.Width
  Enlarge.Top = var_20
  var_20 = Enlarge.Height
  Enlarge.Width = var_20
  Exit Sub
  Exit Sub
End Sub
