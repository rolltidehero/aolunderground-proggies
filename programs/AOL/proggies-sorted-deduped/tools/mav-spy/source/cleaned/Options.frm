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


Private Sub Option4_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option3_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option5_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Command1_Click()
  var_eax = Me.Hide
End Sub

Private Sub Option1_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option2_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option6_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option7_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option8_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option9_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option10_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option11_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option12_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option13_Click()
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  Exit Sub
End Sub

Private Sub Option14_Click()
  var_1C = Option14.Value
  If ebx = 0 Then GoTo loc_00413DDB
  Option14.Value = False
  Check1.Enabled = False
  Check2.Enabled = False
  Check3.Enabled = False
  If esi >= 0 Then GoTo loc_00413EC9
  GoTo loc_00413EB7
  Option14.Value = True
  Check1.Enabled = True
  Check2.Enabled = True
  Check3.Enabled = True
  If esi >= 0 Then GoTo loc_00413EC9
  Exit Sub
End Sub

Private Sub Form_Load()
  call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  Exit Sub
End Sub

Public Sub Proc_2_16_4134B0
  Set var_14 = Me
  var_eax = Global.Unload var_14
  Exit Sub
End Sub
