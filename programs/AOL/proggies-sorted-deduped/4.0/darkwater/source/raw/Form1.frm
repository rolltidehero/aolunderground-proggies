VERSION 5.00
Begin VB.Form Form1
  Caption = "<>< Phish Tank ><>"
  MousePointer = 99 'Custom
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form1.frx":0
  BorderStyle = 1 'Fixed Single
  Icon = "Form1.frx":8842
  LinkTopic = "Form1"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 150
  ClientTop = 435
  ClientWidth = 3090
  ClientHeight = 2250
  MouseIcon = "Form1.frx":8B4C
  StartUpPosition = 2 'CenterScreen
  Begin TextBox Text3
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 2520
    Top = 1560
    Width = 495
    Height = 285
    Text = "M/S?"
    TabIndex = 13
  End
  Begin ListBox List3
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 2520
    Top = 0
    Width = 495
    Height = 1230
    TabIndex = 12
  End
  Begin CommandButton Command6
    Caption = "Options"
    Left = 120
    Top = 1920
    Width = 2895
    Height = 255
    TabIndex = 10
  End
  Begin CommandButton Command5
    Caption = "Clear List"
    Left = 720
    Top = 4440
    Width = 2655
    Height = 255
    TabIndex = 9
  End
  Begin CommandButton Command4
    Caption = "Remove"
    Left = 2160
    Top = 4440
    Width = 1215
    Height = 255
    TabIndex = 8
  End
  Begin TextBox Text2
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 1440
    Top = 1560
    Width = 1095
    Height = 285
    Text = "Password"
    TabIndex = 6
  End
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 1560
    Width = 1095
    Height = 285
    Text = "Name"
    TabIndex = 5
  End
  Begin ListBox List2
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 1320
    Top = 0
    Width = 1215
    Height = 1230
    TabIndex = 4
  End
  Begin ListBox List1
    BackColor = &H0&
    ForeColor = &HFF&
    Left = 120
    Top = 0
    Width = 1215
    Height = 1230
    TabIndex = 3
  End
  Begin CommandButton Command3
    Caption = "Add"
    Left = 720
    Top = 4440
    Width = 1215
    Height = 255
    TabIndex = 2
  End
  Begin CommandButton Command2
    Caption = "Load"
    Left = 2280
    Top = 3960
    Width = 1215
    Height = 255
    TabIndex = 1
  End
  Begin CommandButton Command1
    Caption = "Save"
    Left = 840
    Top = 3960
    Width = 1215
    Height = 255
    TabIndex = 0
  End
  Begin Label Label2
    Caption = "List Count:"
    ForeColor = &HFF&
    Left = 120
    Top = 1320
    Width = 855
    Height = 255
    TabIndex = 11
    BackStyle = 0 'Transparent
  End
  Begin Label Label1
    Caption = "0"
    ForeColor = &HFF&
    Left = 960
    Top = 1320
    Width = 1575
    Height = 255
    TabIndex = 7
    BackStyle = 0 'Transparent
  End
  Begin Menu Options
    Caption = "Options"
    Begin Menu Add
      Caption = "Add "
    End
    Begin Menu Remove
      Caption = "Remove"
    End
    Begin Menu ClearList
      Caption = "Clear List"
    End
    Begin Menu g
      Caption = "-"
    End
    Begin Menu SaveList
      Caption = "Save List"
    End
    Begin Menu LoadList
      Caption = "Load List"
    End
    Begin Menu h
      Caption = "-"
    End
    Begin Menu Signon
      Caption = "Sign On Using Phish"
    End
    Begin Menu phish
      Caption = "Go Phish'n"
    End
    Begin Menu CheckPhish
      Caption = "Check Phish"
    End
    Begin Menu bar
      Caption = "-"
    End
    Begin Menu about
      Caption = "About DarkWater"
    End
    Begin Menu notes
      Caption = "Beta Notes(please read)"
    End
    Begin Menu report
      Caption = "Report a Bug"
    End
    Begin Menu ice
      Caption = "IceRebels"
    End
  End
End

Attribute VB_Name = "Form1"

'VA: 413F44
Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long
'VA: 413EF0
Private Declare Sub ReleaseCapture Lib "User32"()
'VA: 413EA8
Private Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
'VA: 413E58
Private Declare Sub ShowWindow Lib "User32"()
'VA: 413E14
Private Declare Sub ShowCursor Lib "User32"()
'VA: 413DD0
Private Declare Sub SetWindowPos Lib "User32"()
'VA: 413D88
Private Declare Sub SetCursorPos Lib "User32"()
'VA: 413D40
Private Declare Sub SendMessageA Lib "User32"()
'VA: 413CF8
Private Declare Function ReadProcessMemory Lib "kernel32" Alias "ReadProcessMemory" (ByVal hProcess As Long, lpBaseAddress As Any, lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
'VA: 413CA4
Private Declare Sub PostMessageA Lib "User32"()
'VA: 413C5C
Private Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long
'VA: 413C04
Private Declare Function OpenProcess Lib "kernel32" Alias "OpenProcess" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
'VA: 413BC0
Private Declare Sub GetWindowThreadProcessId Lib "User32"()
'VA: 413B6C
Private Declare Sub GetWindowTextLengthA Lib "User32"()
'VA: 413B1C
Private Declare Sub GetWindowTextA Lib "User32"()
'VA: 413AC8
Private Declare Sub GetSubMenu Lib "User32"()
'VA: 413A84
Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
'VA: 413A30
Private Declare Sub GetMenuStringA Lib "User32"()
'VA: 4139E8
Private Declare Sub GetMenuItemID Lib "User32"()
'VA: 4139A0
Private Declare Sub GetMenuItemCount Lib "User32"()
'VA: 413954
Private Declare Sub GetMenu Lib "User32"()
'VA: 413918
Private Declare Sub GetCursorPos Lib "User32"()
'VA: 4138D0
Private Declare Sub FindWindowExA Lib "User32"()
'VA: 413888
Private Declare Sub FindWindowA Lib "User32"()
'VA: 413844
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
'VA: 4137FC
Private Declare Function CloseHandle Lib "kernel32" Alias "CloseHandle" (ByVal hObject As Long) As Long
'VA: 413790
Private Declare Sub IsWindowVisible Lib "User32"()


Private Sub List2_Click() '474660
  loc_004746CA: var_20 = List1.ListCount
  loc_004746F1: setg al
  loc_00474702: If eax = 0 Then GoTo loc_0047480E
  loc_00474734: var_20 = List2.ListIndex
  loc_0047475C: List2.ListIndex = var_20
  loc_004747B8: var_20 = List2.ListIndex
  loc_004747DD: List2.ListIndex = var_20
  loc_0047480E: 'Referenced from: 00474702
  loc_0047481A: GoTo loc_00474830
  loc_0047482F: Exit Sub
  loc_00474830: 'Referenced from: 0047481A
End Sub

Private Sub List2_DblClick() '474850
  loc_00474893: var_eax = Call Form1.Remove_Click
End Sub

Private Sub List3_Click() '4748E0
  loc_0047494A: var_20 = List1.ListCount
  loc_00474971: setg al
  loc_00474982: If eax = 0 Then GoTo loc_00474A8E
  loc_004749B4: var_20 = List3.ListIndex
  loc_004749DC: List3.ListIndex = var_20
  loc_00474A38: var_20 = List3.ListIndex
  loc_00474A5D: List3.ListIndex = var_20
  loc_00474A8E: 'Referenced from: 00474982
  loc_00474A9A: GoTo loc_00474AB0
  loc_00474AAF: Exit Sub
  loc_00474AB0: 'Referenced from: 00474A9A
End Sub

Private Sub List3_DblClick() '474AD0
  loc_00474B13: var_eax = Call Form1.Remove_Click
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer) '475940
  loc_0047598C: If KeyAscii <> 13 Then GoTo loc_004759CE
  loc_004759A7: var_eax = Text3.SetFocus
  loc_004759CE: 'Referenced from: 0047598C
  loc_004759D6: GoTo loc_004759E2
  loc_004759E1: Exit Sub
  loc_004759E2: 'Referenced from: 004759D6
End Sub

Private Sub ice_Click() '4742F0
  loc_0047438F: var_eax = Form11.Show var_18
End Sub

Private Sub Text3_KeyPress(KeyAscii As Integer) '475A10
  loc_00475A5C: If KeyAscii <> 13 Then GoTo loc_00475ABD
  loc_00475A61: var_eax = Call Form1.Add_Click
  loc_00475A96: var_eax = Text1.SetFocus
  loc_00475ABD: 'Referenced from: 00475A5C
  loc_00475AC5: GoTo loc_00475AD1
  loc_00475AD0: Exit Sub
  loc_00475AD1: 'Referenced from: 00475AC5
End Sub

Private Sub report_Click() '475370
  loc_0047540F: var_eax = Form10.Show var_18
End Sub

Private Sub notes_Click() '474C50
  loc_00474CF1: var_eax = Form9.Show var_18
End Sub

Private Sub about_Click() '471F10
  loc_00471FB1: var_eax = Form8.Show var_18
End Sub

Private Sub LoadList_Click() '474B60
  loc_00474C01: var_eax = Form7.Show var_18
End Sub

Private Sub CheckPhish_Click() '4729F0
  Dim var_80 As ListBox
  loc_00472AC7: var_eax = call Proc_6_2_47D850(var_38, var_3C, var_40)
  loc_00472B13: var_7C = List1.ListCount
  loc_00472B3B: var_7C = var_7C - 0001h
  loc_00472B48: var_60 = var_7C
  loc_00472B72: For var_24 = "" To var_7C Step 1
  loc_00472B7B: var_C0 = var_24
  loc_00472B8D: If var_C0 = 0 Then GoTo loc_00472E43
  loc_00472BBD: var_38 = List1.List(CInt(var_28))
  loc_00472C0B: var_3C = List2.List(CInt(var_2C))
  loc_00472C55: var_eax = call Proc_6_0_47D320(0, 0, Me)
  loc_00472C7D: var_eax = call Proc_6_1_47D6A0(Me, var_48, var_44)
  loc_00472C86: If call Proc_6_1_47D6A0(Me, var_48, var_44) <> 0 Then GoTo loc_00472D2C
  loc_00472C8C: var_eax = call Proc_2_14_47A6A0(Me, , )
  loc_00472C98: If call Proc_2_14_47A6A0(Me, , ) <> 0 Then GoTo loc_00472CD0
  loc_00472CB2: var_80 = var_38
  loc_00472CB5: var_24 = CInt(var_004136C4)
  loc_00472CC0: List3.List(var_24) = var_38
  loc_00472CCC: If var_24 >= 0 Then GoTo loc_00472D19
  loc_00472CCE: GoTo loc_00472D04
  loc_00472CE8: var_80 = var_38
  loc_00472CEB: var_24 = CInt(var_004136CC)
  loc_00472CF6: List3.List(var_24) = var_38
  loc_00472D02: If var_24 >= 0 Then GoTo loc_00472D19
  loc_00472D04: 'Referenced from: 00472CCE
  loc_00472D19: 
  loc_00472D22: var_eax = call Proc_47D820(CheckObj(var_80, var_004136B0, 236), call Proc_2_14_47A6A0(Me, , ), Me)
  loc_00472D27: GoTo loc_00472E20
  loc_00472D2C: 'Referenced from: 00472C86
  loc_00472D42: var_80 = var_38
  loc_00472D45: var_24 = CInt(var_38)
  loc_00472D52: var_eax = List1.RemoveItem var_24
  loc_00472D92: var_24 = CInt(var_38)
  loc_00472D98: var_D8 = var_24
  loc_00472DA9: var_eax = List2.RemoveItem var_24
  loc_00472DE9: var_24 = CInt(var_38)
  loc_00472DF4: var_eax = List3.RemoveItem var_24
  loc_00472E20: 'Referenced from: 00472D27
  loc_00472E32: Next var_24
  loc_00472E38: var_C0 = Next var_24
  loc_00472E3E: GoTo loc_00472B87
  loc_00472E43: 'Referenced from: 00472B8D
  loc_00472E4B: GoTo loc_00472E85
  loc_00472E84: Exit Sub
  loc_00472E85: 'Referenced from: 00472E4B
  loc_00472EA7: Exit Sub
End Sub

Private Sub Add_Click() '472000
  Dim var_E4 As Variant
  loc_004720A7: var_20 = Text1.Text
  loc_004720D4: var_1C = var_20
  loc_00472100: var_20 = Text2.Text
  loc_0047212D: var_18 = var_20
  loc_00472159: var_20 = Text1.Text
  loc_0047219A: var_24 = Text2.Text
  loc_0047220E: If (var_20 = "Name") = 0 Then GoTo loc_004728E5
  loc_0047222D: var_20 = Text1.Text
  loc_00472263: ebx = (var_20 = vbNullString) + 1
  loc_00472278: If (var_20 = vbNullString) + 1 = 0 Then GoTo loc_004722E6
  loc_004722B3: var_3C = "Add screen name"
  loc_004722E1: GoTo loc_0047294C
  loc_004722E6: 'Referenced from: 00472278
  loc_004722FF: var_20 = Text2.Text
  loc_00472335: ebx = (var_20 = vbNullString) + 1
  loc_0047234A: If (var_20 = vbNullString) + 1 = 0 Then GoTo loc_004723B8
  loc_00472385: var_3C = "Add Password"
  loc_004723B3: GoTo loc_0047294C
  loc_004723B8: 'Referenced from: 0047234A
  loc_004723D8: var_E4 = var_3C
  loc_004723F2: var_A4 = var_1C
  loc_0047243A: var_20 = CStr(Trim(var_1C))
  loc_0047244A: var_eax = List1.AddItem var_20, var_B0
  loc_004724BD: var_A4 = var_18
  loc_00472505: var_20 = CStr(Trim(var_18))
  loc_00472515: var_eax = List2.AddItem var_20, var_B0
  loc_0047255D: var_34 = List2.AddItem var_20, var_B0
  loc_0047256F: var_4C = Ucase(List2.AddItem var_20, var_B0)
  loc_0047258E: var_64 = var_4C
  loc_004725CB: var_ret_1 = (var_4C = &H4136C4)
  loc_004725E0: var_ret_2 = (Ucase(var_4C) = &H4136CC)
  loc_004725EA: call Or(var_9C, var_ret_2, var_ret_1, Me, Me)
  loc_00472618: If CBool(Or(var_9C, var_ret_2, var_ret_1, Me, Me)) = 0 Then GoTo loc_004726F2
  loc_0047269D: var_20 = CStr(Trim(Me))
  loc_004726AD: Text3.OLEDragMode = var_20
  loc_004726F0: GoTo loc_0047276A
  loc_004726F2: 'Referenced from: 00472618
  loc_00472743: var_eax = List3.AddItem var_004136D4, var_A0
  loc_0047276A: 'Referenced from: 004726F0
  loc_0047277A: var_EC = List3.AddItem var_004136D4, var_A0
  loc_0047279C: var_E0 = List1.ListCount
  loc_004727D4: var_20 = CStr(var_E0)
  loc_004727EE: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_0047283C: Text1.Text = vbNullString
  loc_0047287D: Text2.Text = vbNullString
  loc_004728C0: Text3.Text = vbNullString
  loc_004728E3: GoTo loc_00472957
  loc_004728E5: 'Referenced from: 0047220E
  loc_0047291E: var_3C = "Please Enter a Screen Name and Password To Add"
  loc_0047294C: 'Referenced from: 004722E1
  loc_00472957: 'Referenced from: 004728E3
  loc_00472963: GoTo loc_004729B3
  loc_004729B2: Exit Sub
  loc_004729B3: 'Referenced from: 00472963
End Sub

Private Sub Clearlist_Click() '472ED0
  loc_00472F59: var_C0 = List1.ListCount
  loc_00472F83: setz al
  loc_00472FAF: If eax = 0 Then GoTo loc_00473003
  loc_00472FC5: var_3C = "No One on List"
  loc_00472FFE: GoTo loc_00473186
  loc_00473003: 'Referenced from: 00472FAF
  loc_0047304E: var_24 = MsgBox("Clear List", 36, var_4C, var_5C, var_6C)
  loc_0047308E: If (var_24 = 6) = 0 Then GoTo loc_0047316A
  loc_004730AD: var_eax = List1.Clear
  loc_004730ED: var_eax = List2.Clear
  loc_00473138: var_28 = CStr(0)
  loc_00473140: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_0047316A: 'Referenced from: 0047308E
  loc_00473186: 'Referenced from: 00472FFE
  loc_0047318E: GoTo loc_004731BE
  loc_004731BD: Exit Sub
  loc_004731BE: 'Referenced from: 0047318E
End Sub

Private Sub Signon_Click() '475550
  Dim var_B8 As ListBox
  Dim var_BC As ListBox
  loc_004755EB: var_B8 = List1.ListIndex
  loc_00475615: setg bl
  loc_00475623: If ebx = 0 Then GoTo loc_0047577F
  loc_00475649: var_B8 = List1.ListIndex
  loc_0047568B: var_18 = List1.List(var_B8)
  loc_004756C9: var_BC = List2.ListIndex
  loc_0047570B: var_1C = List2.List(var_BC)
  loc_0047574D: var_eax = call Proc_6_0_47D320(var_18, var_1C, var_34)
  loc_0047577D: GoTo loc_004757ED
  loc_0047577F: 'Referenced from: 00475623
  loc_004757B5: var_44 = "Please Select A Screenname to sign on with"
  loc_004757ED: 'Referenced from: 0047577D
  loc_004757F5: GoTo loc_00475843
  loc_00475842: Exit Sub
  loc_00475843: 'Referenced from: 004757F5
End Sub

Private Sub SaveList_Click() '475460
  loc_00475501: var_eax = Form6.Show var_18
End Sub

Private Sub Command2_Click() '473300
  loc_0047339B: var_eax = call Proc_2_12_47A160("C:\test.lst", var_1C, var_20)
  loc_004733C8: GoTo loc_004733EB
  loc_004733EA: Exit Sub
  loc_004733EB: 'Referenced from: 004733C8
End Sub

Private Sub Command4_Click() '473950
  Dim var_20 As ListBox
  Dim var_B0 As ListBox
  loc_004739D9: var_A4 = List1.ListCount
  loc_00473A09: setz dl
  loc_00473A22: If var_B0 = 0 Then GoTo loc_00473A92
  loc_00473A54: var_30 = "No One on List"
  loc_00473A8D: GoTo loc_00473D91
  loc_00473A92: 'Referenced from: 00473A22
  loc_00473AAE: var_A4 = List1.SelCount
  loc_00473AD8: setz bl
  loc_00473AE6: If ebx = 0 Then GoTo loc_00473B0D
  loc_00473B04: var_68 = "Highlight Name"
  loc_00473B0B: GoTo loc_00473B86
  loc_00473B0D: 'Referenced from: 00473AE6
  loc_00473B29: var_A4 = List2.SelCount
  loc_00473B53: setz bl
  loc_00473B61: If ebx = 0 Then GoTo loc_00473BD1
  loc_00473B86: 'Referenced from: 00473B0B
  loc_00473B93: var_30 = "Highlight Password"
  loc_00473BCC: GoTo loc_00473D8F
  loc_00473BD1: 'Referenced from: 00473B61
  loc_00473BE4: var_B0 = var_20
  loc_00473C03: var_A4 = List1.ListIndex
  loc_00473C31: var_eax = List1.RemoveItem var_A4
  loc_00473C94: var_A4 = List2.ListIndex
  loc_00473CC2: var_eax = List2.RemoveItem var_A4
  loc_00473D21: var_A4 = List1.ListCount
  loc_00473D53: var_18 = CStr(var_A4)
  loc_00473D5B: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_00473D8F: 'Referenced from: 00473BCC
  loc_00473D91: 'Referenced from: 00473A8D
  loc_00473D99: GoTo loc_00473DD0
  loc_00473DCF: Exit Sub
  loc_00473DD0: 'Referenced from: 00473D99
End Sub

Private Sub Command5_Click() '473DF0
  loc_00473E79: var_C0 = List1.ListCount
  loc_00473EA3: setz al
  loc_00473ECF: If eax = 0 Then GoTo loc_00473F23
  loc_00473EE5: var_3C = "No One on List"
  loc_00473F1E: GoTo loc_004740A6
  loc_00473F23: 'Referenced from: 00473ECF
  loc_00473F6E: var_24 = MsgBox("Clear List", 36, var_4C, var_5C, var_6C)
  loc_00473FAE: If (var_24 = 6) = 0 Then GoTo loc_0047408A
  loc_00473FCD: var_eax = List1.Clear
  loc_0047400D: var_eax = List2.Clear
  loc_00474058: var_28 = CStr(0)
  loc_00474060: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_0047408A: 'Referenced from: 00473FAE
  loc_004740A6: 'Referenced from: 00473F1E
  loc_004740AE: GoTo loc_004740DE
  loc_004740DD: Exit Sub
  loc_004740DE: 'Referenced from: 004740AE
End Sub

Private Sub Command6_Click() '474110
  loc_00474210: var_eax = Unknown_VTable_Call[ebx+000002BCh]
  loc_00474243: GoTo loc_0047424F
  loc_0047424E: Exit Sub
  loc_0047424F: 'Referenced from: 00474243
End Sub

Private Sub phish_Click() '474D40
  loc_00474DDF: var_eax = Form2.Show var_18
End Sub

Private Sub Command3_Click() '473410
  Dim var_38 As TextBox
  Dim var_28 As ListBox
  loc_0047349C: var_20 = Text1.Text
  loc_004734C9: var_1C = var_20
  loc_004734F1: var_20 = Text2.Text
  loc_0047351C: var_18 = var_20
  loc_00473544: var_20 = Text1.Text
  loc_0047357A: edi = (var_20 = vbNullString) + 1
  loc_0047358F: If (var_20 = vbNullString) + 1 = 0 Then GoTo loc_004735FF
  loc_004735C1: var_38 = "Add screen name"
  loc_004735FA: GoTo loc_004738D1
  loc_004735FF: 'Referenced from: 0047358F
  loc_00473618: var_20 = Text2.Text
  loc_0047364E: edi = (var_20 = vbNullString) + 1
  loc_00473663: If (var_20 = vbNullString) + 1 = 0 Then GoTo loc_004736D3
  loc_00473695: var_38 = "Add Password"
  loc_004736CE: GoTo loc_004738D1
  loc_004736D3: 'Referenced from: 00473663
  loc_00473714: var_eax = List1.AddItem var_1C, var_6C
  loc_0047377C: var_eax = List2.AddItem var_18, var_6C
  loc_004737B6: var_B8 = var_28
  loc_004737D5: var_AC = List1.ListCount
  loc_0047380D: var_20 = CStr(var_AC)
  loc_0047381D: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_0047386B: Text1.Text = vbNullString
  loc_004738AE: Text2.Text = vbNullString
  loc_004738D1: 'Referenced from: 004735FA
  loc_004738DD: GoTo loc_00473914
  loc_00473913: Exit Sub
  loc_00473914: 'Referenced from: 004738DD
End Sub

Private Sub Command1_Click() '4731F0
  loc_0047328B: var_eax = call Proc_2_13_47A440("C:\test.lst", var_1C, var_20)
  loc_004732B8: GoTo loc_004732DB
  loc_004732DA: Exit Sub
  loc_004732DB: 'Referenced from: 004732B8
End Sub

Private Sub Remove_Click() '474E30
  Dim var_1C As ListBox
  Dim var_20 As ListBox
  Dim var_B0 As ListBox
  loc_00474EB9: var_A4 = List1.ListCount
  loc_00474EE9: setz dl
  loc_00474F02: If var_B0 = 0 Then GoTo loc_00474F72
  loc_00474F34: var_30 = "No One on List"
  loc_00474F6D: GoTo loc_00475302
  loc_00474F72: 'Referenced from: 00474F02
  loc_00474F8E: var_A4 = List1.SelCount
  loc_00474FB8: setz bl
  loc_00474FC6: If ebx = 0 Then GoTo loc_00474FED
  loc_00474FE4: var_68 = "Highlight Name"
  loc_00474FEB: GoTo loc_00475066
  loc_00474FED: 'Referenced from: 00474FC6
  loc_00475009: var_A4 = List2.SelCount
  loc_00475033: setz bl
  loc_00475041: If ebx = 0 Then GoTo loc_004750B1
  loc_00475066: 'Referenced from: 00474FEB
  loc_00475073: var_30 = "Highlight Password"
  loc_004750AC: GoTo loc_00475300
  loc_004750B1: 'Referenced from: 00475041
  loc_004750C4: var_B0 = var_20
  loc_004750E3: var_A4 = List1.ListIndex
  loc_00475111: var_eax = List1.RemoveItem var_A4
  loc_00475174: var_A4 = List2.ListIndex
  loc_004751A2: var_eax = List2.RemoveItem var_A4
  loc_004751E3: var_B0 = var_1C
  loc_00475205: var_A4 = List3.ListIndex
  loc_00475233: var_eax = List3.RemoveItem var_A4
  loc_00475292: var_A4 = List1.ListCount
  loc_004752C4: var_18 = CStr(var_A4)
  loc_004752CC: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_00475300: 'Referenced from: 004750AC
  loc_00475302: 'Referenced from: 00474F6D
  loc_0047530A: GoTo loc_00475341
  loc_00475340: Exit Sub
  loc_00475341: 'Referenced from: 0047530A
End Sub

Private Sub Form_Unload(Cancel As Integer) '474280
  loc_004742BF: End
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer) '475870
  loc_004758BC: If KeyAscii <> 13 Then GoTo loc_004758FE
  loc_004758D7: var_eax = Text2.SetFocus
  loc_004758FE: 'Referenced from: 004758BC
  loc_00475906: GoTo loc_00475912
  loc_00475911: Exit Sub
  loc_00475912: 'Referenced from: 00475906
End Sub

Private Sub List1_Click() '4743E0
  loc_0047444A: var_20 = List1.ListCount
  loc_00474471: setg al
  loc_00474482: If eax = 0 Then GoTo loc_0047458E
  loc_004744B4: var_20 = List1.ListIndex
  loc_004744DC: List1.ListIndex = var_20
  loc_00474538: var_20 = List1.ListIndex
  loc_0047455D: List1.ListIndex = var_20
  loc_0047458E: 'Referenced from: 00474482
  loc_0047459A: GoTo loc_004745B0
  loc_004745AF: Exit Sub
  loc_004745B0: 'Referenced from: 0047459A
End Sub

Private Sub List1_DblClick() '4745D0
  loc_00474613: var_eax = Call Form1.Remove_Click
End Sub

Public Sub Proc_0_28_474270

End Sub
