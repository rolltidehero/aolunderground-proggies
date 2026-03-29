VERSION 5.00
Begin VB.Form FRMopen
  Caption = "Open existing module"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 5295
  ClientHeight = 2655
  StartUpPosition = 3 'Windows Default
  Begin DriveListBox Drive1
    Left = 120
    Top = 2160
    Width = 2055
    Height = 315
    TabIndex = 2
  End
  Begin FileListBox File1
    Left = 2280
    Top = 120
    Width = 2895
    Height = 2430
    TabIndex = 1
    Pattern = "*.bas"
  End
  Begin DirListBox Dir1
    Left = 120
    Top = 120
    Width = 2055
    Height = 1890
    TabIndex = 0
  End
End

Attribute VB_Name = "FRMopen"


Private Sub Form_Load()
  call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  Exit Sub
End Sub

Private Sub File1_DblClick()
  Dim var_F0 As Variant
  Dim var_F8 As FileListBox
  var_38 = Dir1.Path
  var_F4 = var_38
  var_3C = File1.FileName
  var_FC = var_3C
  var_30 = var_38 & var_00407AB0 & var_3C
  On Error Resume Next
  Open var_30 For Input As #1 Len = -1
  var_28 = Input(LOF(1), 1)
  Close #1
  var_B0 = var_28
  var_58 = LCase(var_28)
  var_68 = "VB_atribute"
  var_78 = LCase(var_68)
  call InStr(var_88, &h00000000, var_78, var_58, &h00000001, FFFFFFFFh, esi, ebx)
  call Not(var_98, InStr(var_88, &h00000000, var_78, var_58, &h00000001, FFFFFFFFh, esi, ebx))
  var_F0 = CBool(Not(var_98, InStr(var_88, &h00000000, var_78, var_58, &h00000001, FFFFFFFFh, esi, ebx)))
  If var_F0 = 0 Then GoTo loc_00422A6A
  var_34 = MsgBox("This does not appear to be a valid .bas file, would you like to load it anyways?", 4, var_68, 10, var_88)
  If var_34 <> 7 Then GoTo loc_0042252F
  GoTo loc_00422A6A
  var_B0 = var_28
  var_58 = LCase(var_28)
  var_78 = LCase("sub")
  call InStr(var_88, &h00000000, var_78, var_58, &h00000001)
  var_F0 = Not ((InStr(var_88, &h00000000, var_78, var_58, &h00000001) = 0))
  If var_F0 = 0 Then GoTo loc_004229BE
  var_B0 = var_28
  var_58 = LCase(var_28)
  var_78 = LCase("End Sub")
  var_E0 = var_28
  call InStr(var_88, &h00000000, var_78, var_58, &h00000001)
  var_24 = Left(var_28, CLng(InStr(var_88, &h00000000, var_78, var_58, &h00000001) + 1))
  var_F8 = (vtable)
  var_38 = File1.TabIndex
  var_F4 = var_38
  File1.TabIndex = var_38 & var_24
  var_FC = var_F8
  var_78 = LCase("Sub")
  var_B0 = var_28
  var_58 = LCase(var_28)
  call InStr(var_88, &h00000000, var_78, var_58, &h00000001, var_A8)
  var_28 = Mid$(var_28, CLng(InStr(var_88, &h00000000, var_78, var_58, &h00000001, var_A8) + 1), )
  GoTo loc_0042252F
  Set var_44 = Me
  var_eax = Global.Unload var_44
  var_F4 = Global.Unload var_44
  Exit Sub
End Sub

Private Sub Dir1_Change()
  var_18 = Dir1.Path
  Dir1.Path = var_18
  Exit Sub
End Sub

Private Sub Drive1_Change()
  On Error Resume Next
  var_20 = Drive1.Drive
  Drive1.Drive = var_20
  GoTo loc_00422138
  Exit Sub
  Exit Sub
End Sub
