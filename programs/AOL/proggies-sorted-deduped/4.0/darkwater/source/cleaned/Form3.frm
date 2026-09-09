VERSION 5.00
Begin VB.Form Form3
  Caption = "Dark Water"
  MousePointer = 99 'Custom
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form3.frx":0
  BorderStyle = 0 'None
  Icon = "Form3.frx":718E
  LinkTopic = "Form3"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 0
  ClientTop = 0
  ClientWidth = 6585
  ClientHeight = 4530
  MouseIcon = "Form3.frx":7498
  ShowInTaskbar = 0   'False
  StartUpPosition = 2 'CenterScreen
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 10
    Left = 0
    Top = 0
  End
  Begin Image Image2
    Picture = "Form3.frx":77A2
    Left = -3720
    Top = 3360
    Width = 3840
    Height = 720
  End
  Begin Image Image1
    Picture = "Form3.frx":8AA4
    Left = -120
    Top = -2640
    Width = 7200
    Height = 2880
  End
End

Attribute VB_Name = "Form3"


Private Sub Image1_Click()
  var_eax = Me.Show var_64
  Set var_20 = Me
  var_eax = Global.Unload var_20
  var_18 = Dir("C:\Report.txt", 0)
  var_1C = call MailDeleteNewDuplicates(, , var_74)
  If (var_1C = vbNullString) = 0 Then GoTo loc_0047B66A
  var_30 = "You have a bug report on file that needs to be sent"
  var_eax = Form10.Show var_64
  Exit Sub
End Sub

Private Sub Form_Load()
  Timer1.Enabled = True
  Exit Sub
End Sub

Private Sub Form_Click()
  var_eax = Me.Show var_64
  Set var_20 = Me
  var_eax = Global.Unload var_20
  var_18 = Dir("C:\Report.txt", 0)
  var_1C = call MailDeleteNewDuplicates(, , var_74)
  If (var_1C = vbNullString) = 0 Then GoTo loc_0047B2AA
  var_30 = "You have a bug report on file that needs to be sent"
  var_eax = Form10.Show var_64
  Exit Sub
End Sub

Private Sub Timer1_Timer()
  var_20 = Image2.Left
  var_24 = Image1.Top
  GoTo loc_0047BABD
  If var_44 = 0 Then GoTo loc_0047BB74
  var_20 = Image2.Left
  Image2.Left = esi
  var_20 = Image1.Top
  GoTo loc_0047BBBE
  If di = 0 Then GoTo loc_0047BC64
  var_20 = Image1.Top
  Image1.Top = var_20
  var_20 = Image1.Top
  GoTo loc_0047BCAE
  var_24 = Image2.Left
  GoTo loc_0047BCFC
  If ebx = 0 Then GoTo loc_0047BD58
  Timer1.Enabled = False
  Exit Sub
  Exit Sub
End Sub

Private Sub Image2_Click()
  var_eax = Me.Show var_64
  Set var_20 = Me
  var_eax = Global.Unload var_20
  var_18 = Dir("C:\Report.txt", 0)
  var_1C = call MailDeleteNewDuplicates(, , var_74)
  If (var_1C = vbNullString) = 0 Then GoTo loc_0047B96A
  var_30 = "You have a bug report on file that needs to be sent"
  var_eax = Form10.Show var_64
  Exit Sub
End Sub
