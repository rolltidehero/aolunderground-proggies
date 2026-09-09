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


Private Sub Image1_Click() '47B3D0
  loc_0047B490: var_eax = Me.Show var_64
  loc_0047B4D7: Set var_20 = Me
  loc_0047B4DF: var_eax = Global.Unload var_20
  loc_0047B531: var_18 = Dir("C:\Report.txt", 0)
  loc_0047B547: var_eax = call Proc_2_17_47ACB0(, , var_74)
  loc_0047B551: var_1C = call Proc_2_17_47ACB0(, , var_74)
  loc_0047B580: If (var_1C = vbNullString) = 0 Then GoTo loc_0047B66A
  loc_0047B5B6: var_30 = "You have a bug report on file that needs to be sent"
  loc_0047B64C: var_eax = Form10.Show var_64
  loc_0047B66A: 'Referenced from: 0047B580
  loc_0047B676: GoTo loc_0047B6B0
  loc_0047B6AF: Exit Sub
  loc_0047B6B0: 'Referenced from: 0047B676
End Sub

Private Sub Form_Load() '47B310
  loc_0047B370: Timer1.Enabled = True
  loc_0047B399: GoTo loc_0047B3A5
  loc_0047B3A4: Exit Sub
  loc_0047B3A5: 'Referenced from: 0047B399
End Sub

Private Sub Form_Click() '47B010
  loc_0047B0D0: var_eax = Me.Show var_64
  loc_0047B117: Set var_20 = Me
  loc_0047B11F: var_eax = Global.Unload var_20
  loc_0047B171: var_18 = Dir("C:\Report.txt", 0)
  loc_0047B187: var_eax = call Proc_2_17_47ACB0(, , var_74)
  loc_0047B191: var_1C = call Proc_2_17_47ACB0(, , var_74)
  loc_0047B1C0: If (var_1C = vbNullString) = 0 Then GoTo loc_0047B2AA
  loc_0047B1F6: var_30 = "You have a bug report on file that needs to be sent"
  loc_0047B28C: var_eax = Form10.Show var_64
  loc_0047B2AA: 'Referenced from: 0047B1C0
  loc_0047B2B6: GoTo loc_0047B2F0
  loc_0047B2EF: Exit Sub
  loc_0047B2F0: 'Referenced from: 0047B2B6
End Sub

Private Sub Timer1_Timer() '47B9D0
  loc_0047BA3D: var_20 = Image2.Left
  loc_0047BA58: fcomp real4 ptr [00401720h]
  loc_0047BA8C: var_24 = Image1.Top
  loc_0047BAA7: fcomp real4 ptr [0040171Ch]
  loc_0047BAB9: GoTo loc_0047BABD
  loc_0047BABD: 'Referenced from: 0047BAB9
  loc_0047BADC: If var_44 = 0 Then GoTo loc_0047BB74
  loc_0047BB11: var_20 = Image2.Left
  loc_0047BB43: Image2.Left = esi
  loc_0047BB74: 'Referenced from: 0047BADC
  loc_0047BB8D: var_20 = Image1.Top
  loc_0047BBA8: fcomp real4 ptr [0040171Ch]
  loc_0047BBBA: GoTo loc_0047BBBE
  loc_0047BBBE: 'Referenced from: 0047BBBA
  loc_0047BBCC: If di = 0 Then GoTo loc_0047BC64
  loc_0047BC01: var_20 = Image1.Top
  loc_0047BC33: Image1.Top = var_20
  loc_0047BC64: 'Referenced from: 0047BBCC
  loc_0047BC7D: var_20 = Image1.Top
  loc_0047BC98: fcomp real4 ptr [0040171Ch]
  loc_0047BCAA: GoTo loc_0047BCAE
  loc_0047BCAE: 'Referenced from: 0047BCAA
  loc_0047BCCB: var_24 = Image2.Left
  loc_0047BCE6: fcomp real4 ptr [00401720h]
  loc_0047BCF8: GoTo loc_0047BCFC
  loc_0047BCFC: 'Referenced from: 0047BCF8
  loc_0047BD1A: If ebx = 0 Then GoTo loc_0047BD58
  loc_0047BD37: Timer1.Enabled = False
  loc_0047BD58: 'Referenced from: 0047BD1A
  loc_0047BD65: GoTo loc_0047BD7B
  loc_0047BD7A: Exit Sub
  loc_0047BD7B: 'Referenced from: 0047BD65
  loc_0047BD7B: Exit Sub
End Sub

Private Sub Image2_Click() '47B6D0
  loc_0047B790: var_eax = Me.Show var_64
  loc_0047B7D7: Set var_20 = Me
  loc_0047B7DF: var_eax = Global.Unload var_20
  loc_0047B831: var_18 = Dir("C:\Report.txt", 0)
  loc_0047B847: var_eax = call Proc_2_17_47ACB0(, , var_74)
  loc_0047B851: var_1C = call Proc_2_17_47ACB0(, , var_74)
  loc_0047B880: If (var_1C = vbNullString) = 0 Then GoTo loc_0047B96A
  loc_0047B8B6: var_30 = "You have a bug report on file that needs to be sent"
  loc_0047B94C: var_eax = Form10.Show var_64
  loc_0047B96A: 'Referenced from: 0047B880
  loc_0047B976: GoTo loc_0047B9B0
  loc_0047B9AF: Exit Sub
  loc_0047B9B0: 'Referenced from: 0047B976
End Sub
