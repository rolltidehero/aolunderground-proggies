VERSION 5.00
Begin VB.Form Options
  Caption = "Captions"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4485
  ClientHeight = 5145
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Save Changes"
    Left = 1440
    Top = 4680
    Width = 1455
    Height = 375
    TabIndex = 18
  End
  Begin Frame Frame1
    Left = 120
    Top = 120
    Width = 4215
    Height = 4455
    TabIndex = 0
    Begin CheckBox Check5
      Caption = "Find Target Window By Caption"
      Left = 2040
      Top = 1920
      Width = 1935
      Height = 495
      Enabled = 0   'False
      TabIndex = 25
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin CheckBox Check4
      Caption = "Find All Windows By Their Caption"
      Left = 2040
      Top = 1560
      Width = 1815
      Height = 435
      TabIndex = 24
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option19
      Caption = "A Function That Finds a Window"
      Left = 2040
      Top = 1200
      Width = 2055
      Height = 375
      TabIndex = 23
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option18
      Caption = "Hit Enter Key"
      Left = 2040
      Top = 960
      Width = 1815
      Height = 255
      TabIndex = 22
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option17
      Caption = "Click on Check box"
      Left = 2040
      Top = 720
      Width = 1935
      Height = 255
      TabIndex = 21
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option16
      Caption = "UnCheck Check Box"
      Left = 2040
      Top = 480
      Width = 1695
      Height = 255
      TabIndex = 20
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option15
      Caption = "Check a Check Box"
      Left = 2040
      Top = 240
      Width = 1695
      Height = 255
      TabIndex = 19
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option4
      Caption = "Get Text"
      Left = 240
      Top = 1200
      Width = 1335
      Height = 255
      TabIndex = 17
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option3
      Caption = "Set Text"
      Left = 240
      Top = 960
      Width = 1575
      Height = 255
      TabIndex = 16
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option2
      Caption = "Click Icon"
      Left = 240
      Top = 720
      Width = 1215
      Height = 255
      TabIndex = 15
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option1
      Caption = "Click Button"
      Left = 240
      Top = 480
      Width = 1215
      Height = 255
      TabIndex = 14
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option5
      Caption = "Just Find the Window"
      Left = 240
      Top = 240
      Width = 1695
      Height = 255
      TabIndex = 13
      Value = 255
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option6
      Caption = "Click a msgbox"
      Left = 240
      Top = 1440
      Width = 1335
      Height = 255
      TabIndex = 12
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option7
      Caption = "Right Click"
      Left = 240
      Top = 1680
      Width = 1095
      Height = 255
      TabIndex = 11
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option8
      Caption = "Double CLick"
      Left = 240
      Top = 1920
      Width = 1215
      Height = 255
      TabIndex = 10
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option11
      Caption = "Show Window"
      Left = 240
      Top = 2640
      Width = 1335
      Height = 255
      TabIndex = 9
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option12
      Caption = "Hide Window"
      Left = 240
      Top = 2880
      Width = 1215
      Height = 255
      TabIndex = 8
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option13
      Caption = "Close Window"
      Left = 240
      Top = 3120
      Width = 1215
      Height = 255
      TabIndex = 7
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option14
      Caption = "ListBox "
      Left = 240
      Top = 3360
      Width = 855
      Height = 255
      TabIndex = 6
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option10
      Caption = "Disable Window"
      Left = 240
      Top = 2400
      Width = 1335
      Height = 255
      TabIndex = 5
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin OptionButton Option9
      Caption = "Enable Window"
      Left = 240
      Top = 2160
      Width = 1335
      Height = 255
      TabIndex = 4
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin CheckBox Check1
      Caption = "Get Count"
      Left = 240
      Top = 3600
      Width = 1335
      Height = 255
      Enabled = 0   'False
      TabIndex = 3
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin CheckBox Check2
      Caption = "Get item in list"
      Left = 240
      Top = 3840
      Width = 1455
      Height = 255
      Enabled = 0   'False
      TabIndex = 2
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin CheckBox Check3
      Caption = "Select Item in list"
      Left = 240
      Top = 4080
      Width = 1455
      Height = 255
      Enabled = 0   'False
      TabIndex = 1
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
  End
End

Attribute VB_Name = "Options"


Private Sub Option4_Click() '414190
  loc_004141F4: Check1.Enabled = False
  loc_00414232: Check2.Enabled = False
  loc_00414272: Check3.Enabled = False
  loc_004142A1: GoTo loc_004142AD
  loc_004142AC: Exit Sub
  loc_004142AD: 'Referenced from: 004142A1
End Sub

Private Sub Option3_Click() '414050
  loc_004140B4: Check1.Enabled = False
  loc_004140F2: Check2.Enabled = False
  loc_00414132: Check3.Enabled = False
  loc_00414161: GoTo loc_0041416D
  loc_0041416C: Exit Sub
  loc_0041416D: 'Referenced from: 00414161
End Sub

Private Sub Option5_Click() '4142D0
  loc_00414334: Check1.Enabled = False
  loc_00414372: Check2.Enabled = False
  loc_004143B2: Check3.Enabled = False
  loc_004143E1: GoTo loc_004143ED
  loc_004143EC: Exit Sub
  loc_004143ED: 'Referenced from: 004143E1
End Sub

Private Sub Command1_Click() '413420
  loc_00413463: var_eax = Me.Hide
End Sub

Private Sub Option1_Click() '413610
  loc_00413674: Check1.Enabled = False
  loc_004136B2: Check2.Enabled = False
  loc_004136F2: Check3.Enabled = False
  loc_00413721: GoTo loc_0041372D
  loc_0041372C: Exit Sub
  loc_0041372D: 'Referenced from: 00413721
End Sub

Private Sub Option2_Click() '413F10
  loc_00413F74: Check1.Enabled = False
  loc_00413FB2: Check2.Enabled = False
  loc_00413FF2: Check3.Enabled = False
  loc_00414021: GoTo loc_0041402D
  loc_0041402C: Exit Sub
  loc_0041402D: 'Referenced from: 00414021
End Sub

Private Sub Option6_Click() '414410
  loc_00414474: Check1.Enabled = False
  loc_004144B2: Check2.Enabled = False
  loc_004144F2: Check3.Enabled = False
  loc_00414521: GoTo loc_0041452D
  loc_0041452C: Exit Sub
  loc_0041452D: 'Referenced from: 00414521
End Sub

Private Sub Option7_Click() '414550
  loc_004145B4: Check1.Enabled = False
  loc_004145F2: Check2.Enabled = False
  loc_00414632: Check3.Enabled = False
  loc_00414661: GoTo loc_0041466D
  loc_0041466C: Exit Sub
  loc_0041466D: 'Referenced from: 00414661
End Sub

Private Sub Option8_Click() '414690
  loc_004146F4: Check1.Enabled = False
  loc_00414732: Check2.Enabled = False
  loc_00414772: Check3.Enabled = False
  loc_004147A1: GoTo loc_004147AD
  loc_004147AC: Exit Sub
  loc_004147AD: 'Referenced from: 004147A1
End Sub

Private Sub Option9_Click() '4147D0
  loc_00414834: Check1.Enabled = False
  loc_00414872: Check2.Enabled = False
  loc_004148B2: Check3.Enabled = False
  loc_004148E1: GoTo loc_004148ED
  loc_004148EC: Exit Sub
  loc_004148ED: 'Referenced from: 004148E1
End Sub

Private Sub Option10_Click() '413750
  loc_004137B4: Check1.Enabled = False
  loc_004137F2: Check2.Enabled = False
  loc_00413832: Check3.Enabled = False
  loc_00413861: GoTo loc_0041386D
  loc_0041386C: Exit Sub
  loc_0041386D: 'Referenced from: 00413861
End Sub

Private Sub Option11_Click() '413890
  loc_004138F4: Check1.Enabled = False
  loc_00413932: Check2.Enabled = False
  loc_00413972: Check3.Enabled = False
  loc_004139A1: GoTo loc_004139AD
  loc_004139AC: Exit Sub
  loc_004139AD: 'Referenced from: 004139A1
End Sub

Private Sub Option12_Click() '4139D0
  loc_00413A34: Check1.Enabled = False
  loc_00413A72: Check2.Enabled = False
  loc_00413AB2: Check3.Enabled = False
  loc_00413AE1: GoTo loc_00413AED
  loc_00413AEC: Exit Sub
  loc_00413AED: 'Referenced from: 00413AE1
End Sub

Private Sub Option13_Click() '413B10
  loc_00413B74: Check1.Enabled = False
  loc_00413BB2: Check2.Enabled = False
  loc_00413BF2: Check3.Enabled = False
  loc_00413C21: GoTo loc_00413C2D
  loc_00413C2C: Exit Sub
  loc_00413C2D: 'Referenced from: 00413C21
End Sub

Private Sub Option14_Click() '413C50
  loc_00413CB7: var_1C = Option14.Value
  loc_00413CDF: setz bl
  loc_00413CF0: If ebx = 0 Then GoTo loc_00413DDB
  loc_00413D0A: Option14.Value = False
  loc_00413D48: Check1.Enabled = False
  loc_00413D86: Check2.Enabled = False
  loc_00413DC6: Check3.Enabled = False
  loc_00413DD0: If esi >= 0 Then GoTo loc_00413EC9
  loc_00413DD6: GoTo loc_00413EB7
  loc_00413DEF: Option14.Value = True
  loc_00413E2D: Check1.Enabled = True
  loc_00413E6B: Check2.Enabled = True
  loc_00413EAB: Check3.Enabled = True
  loc_00413EB5: If esi >= 0 Then GoTo loc_00413EC9
  loc_00413EB7: 'Referenced from: 00413DD6
  loc_00413EC3: esi = CheckObj(esi, var_00407B60, 148)
  loc_00413EC9: 'Referenced from: 00413DD0
  loc_00413EDA: GoTo loc_00413EE6
  loc_00413EE5: Exit Sub
  loc_00413EE6: 'Referenced from: 00413EDA
End Sub

Private Sub Form_Load() '413560
  loc_004135AB: call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  loc_004135C0: var_eax = call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  loc_004135D6: GoTo loc_004135E2
  loc_004135E1: Exit Sub
  loc_004135E2: 'Referenced from: 004135D6
End Sub

Public Sub Proc_2_16_4134B0
  loc_00413509: Set var_14 = Me
  loc_00413511: var_eax = Global.Unload var_14
  loc_00413537: GoTo loc_00413543
  loc_00413542: Exit Sub
  loc_00413543: 'Referenced from: 00413537
End Sub
