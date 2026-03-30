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


Private Sub Form_Load() '4807E0
  loc_00480876: var_48 = Dir("c:\report.txt", 0)
  loc_004808A3: If (var_48 = vbNullString) = 0 Then GoTo loc_00480A9E
  loc_004808B4: Open "c:\report.txt" For Input As #1 Len = -1
  loc_004808C0: Line Input #1, var_24
  loc_004808EC: var_48 = CStr(var_24)
  loc_004808FC: Text1.Text = var_48
  loc_00480932: Line Input #1, var_34
  loc_00480958: var_48 = CStr(var_34)
  loc_00480966: Text2.Text = var_48
  loc_0048099E: 
  loc_004809A9: If EOF(1) <> 0 Then GoTo loc_00480A96
  loc_004809BB: Line Input #1, var_44
  loc_004809EC: var_48 = Text3.Text
  loc_00480A10: var_5C = var_48
  loc_00480A37: var_4C = CStr(0 & var_44)
  loc_00480A3F: Text3.Text = var_4C
  loc_00480A91: GoTo loc_0048099E
  loc_00480A96: 'Referenced from: 004809A9
  loc_00480A98: Close #1
  loc_00480A9E: 'Referenced from: 004808A3
  loc_00480AA6: GoTo loc_00480ADC
  loc_00480ADB: Exit Sub
  loc_00480ADC: 'Referenced from: 00480AA6
End Sub

Private Sub Command1_Click() '4802A0
  Dim var_20 As TextBox
  loc_0048032F: var_18 = Text1.Text
  loc_0048036A: var_20 = Text2.Text
  loc_004803A5: var_30 = Text3.Text
  loc_00480448: var_eax = call Proc_2_0_4784C0("ToXiCcLoWd@yahoo.com", "Ôôº·« ÂLÊR†: BÛGG RËþoR† »·ºôÔ", var_18 & Chr$(13) & var_20 & Chr$(13) & var_30)
  loc_004804C4: var_18 = Dir("C:\Report.txt", 0)
  loc_004804ED: If (var_18 = vbNullString) = 0 Then GoTo loc_00480518
  loc_00480509: var_eax = Kill "C:\Report.txt"
  loc_00480518: 'Referenced from: 004804ED
  loc_00480520: GoTo loc_00480577
  loc_00480576: Exit Sub
  loc_00480577: 'Referenced from: 00480520
End Sub

Private Sub Command2_Click() '4805A0
  loc_004805F3: Open "C:\Report.txt" For Output As #1 Len = -1
  loc_0048062A: Print 1, var_1C
  loc_00480668: Print 1, var_18
  loc_004806A4: Print 1, 0
  loc_004806BB: Close #1
  loc_004806C9: GoTo loc_004806DF
  loc_004806DE: Exit Sub
  loc_004806DF: 'Referenced from: 004806C9
End Sub

Private Sub Command3_Click() '480700
  loc_0048076E: Set var_18 = Me
  loc_00480779: var_eax = Global.Unload var_18
  loc_004807A2: GoTo loc_004807AE
  loc_004807AD: Exit Sub
  loc_004807AE: 'Referenced from: 004807A2
End Sub

Public Sub Proc_11_4_4807D0
  loc_004807D0: var_eax = call Proc_6_5_47E2B0(, , )
End Sub
