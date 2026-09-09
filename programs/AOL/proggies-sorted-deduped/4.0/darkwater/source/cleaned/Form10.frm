VERSION 5.00
Begin VB.Form Form10
  Caption = "Bug Report"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form10.frx":0
  Icon = "Form10.frx":718E
  LinkTopic = "Form10"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4680
  ClientHeight = 2955
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command3
    Caption = "Cancel"
    Left = 120
    Top = 2640
    Width = 4455
    Height = 255
    TabIndex = 8
  End
  Begin CommandButton Command2
    Caption = "Wait until later"
    Left = 120
    Top = 2400
    Width = 4455
    Height = 255
    TabIndex = 7
  End
  Begin CommandButton Command1
    Caption = "Send Now"
    BackColor = &H404040&
    Left = 120
    Top = 2160
    Width = 4455
    Height = 255
    TabIndex = 6
  End
  Begin TextBox Text3
    BackColor = &H0&
    ForeColor = &HC0&
    Left = 120
    Top = 1080
    Width = 4455
    Height = 1095
    TabIndex = 5
    MultiLine = -1  'True
    ScrollBars = 2
  End
  Begin TextBox Text2
    BackColor = &H0&
    ForeColor = &HC0&
    Left = 720
    Top = 480
    Width = 3855
    Height = 285
    TabIndex = 3
  End
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HC0&
    Left = 720
    Top = 120
    Width = 3855
    Height = 285
    TabIndex = 1
  End
  Begin Label Label3
    Caption = "Summary of bug or Other Comments:"
    ForeColor = &HC00000&
    Left = 120
    Top = 840
    Width = 2655
    Height = 255
    TabIndex = 4
    BackStyle = 0 'Transparent
  End
  Begin Label Label2
    Caption = "Handle:"
    ForeColor = &HC00000&
    Left = 120
    Top = 480
    Width = 615
    Height = 255
    TabIndex = 2
    BackStyle = 0 'Transparent
  End
  Begin Label Label1
    Caption = "Name:"
    ForeColor = &HC00000&
    Left = 120
    Top = 120
    Width = 495
    Height = 255
    TabIndex = 0
    BackStyle = 0 'Transparent
  End
End

Attribute VB_Name = "Form10"


Private Sub Form_Load()
  var_48 = Dir("c:\report.txt", 0)
  If (var_48 = vbNullString) = 0 Then GoTo loc_00480A9E
  Open "c:\report.txt" For Input As #1 Len = -1
  Line Input #1, var_24
  var_48 = var_24
  Text1.Text = var_48
  Line Input #1, var_34
  var_48 = var_34
  Text2.Text = var_48
  If EOF(1) <> 0 Then GoTo loc_00480A96
  Line Input #1, var_44
  var_48 = Text3.Text
  var_5C = var_48
  var_4C = 0 & var_44
  Text3.Text = var_4C
  GoTo loc_0048099E
  Close #1
  Exit Sub
End Sub

Private Sub Command1_Click()
  Dim var_20 As TextBox
  var_18 = Text1.Text
  var_20 = Text2.Text
  var_30 = Text3.Text
  call FindForwardWindow("ToXiCcLoWd@yahoo.com", "Ôôº·« ÂLÊR: BÛGG RËþoR »·ºôÔ", var_18 & Chr$(13) & var_20 & Chr$(13) & var_30)
  var_18 = Dir("C:\Report.txt", 0)
  If (var_18 = vbNullString) = 0 Then GoTo loc_00480518
  var_eax = Kill "C:\Report.txt"
  Exit Sub
End Sub

Private Sub Command2_Click()
  Open "C:\Report.txt" For Output As #1 Len = -1
  Print 1, var_1C
  Print 1, var_18
  Print 1, 0
  Close #1
  Exit Sub
End Sub

Private Sub Command3_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Public Sub Proc_11_4_4807D0
  call Proc_6_5_47E2B0(, , )
End Sub
