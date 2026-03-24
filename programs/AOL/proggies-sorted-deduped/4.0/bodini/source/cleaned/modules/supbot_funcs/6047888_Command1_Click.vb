ï»¿Private Sub Command1_Click() '5C4890
  Dim var_5C As ListBox
  Dim var_48 As ListBox
  Dim var_4C As TextBox
  loc_005C4944: var_eax = call Proc_79_19_604D70(edi, esi, Me)
  loc_005C494B: If call Proc_79_19_604D70(edi, esi, Me) <> 0 Then GoTo loc_005C49EC
  loc_005C4991: var_6C = "bodini by: spek"
  loc_005C49AC: var_5C = "You need to be in a chat room to use the Sup Bot."
  loc_005C49E7: GoTo loc_005C4E9B
  loc_005C49EC: 'Referenced from: 005C494B
  loc_005C4A0B: var_eax = List1.Clear
  loc_005C4A66: var_eax = call Proc_79_23_605540(var_48, var_120, var_48)
  loc_005C4A8C: var_3C = "â¢bodini 4.0â¢ sup bot â¢spekâ¢"
  loc_005C4ABB: var_eax = call Proc_3_4_5A51B0(var_6C, var_34, 3)
  loc_005C4B09: var_3C = "<font face=""tahoma"">" & var_6C
  loc_005C4B1E: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_34, var_3C)
  loc_005C4B6A: var_120 = List1.ListCount
  loc_005C4B95: var_120 = var_120 - 0001h
  loc_005C4BA5: var_F4 = var_120
  loc_005C4BE2: For var_24 = 0 To var_120 Step 1
  loc_005C4BEB: var_164 = var_24
  loc_005C4BFD: 
  loc_005C4C05: If var_164 = 0 Then GoTo loc_005C4E99
  loc_005C4C2F: var_24 = CInt(var_3C)
  loc_005C4C3F: var_48 = List1.List(var_24)
  loc_005C4C63: var_54 = var_3C
  loc_005C4C79: var_6C = LCase(0)
  loc_005C4CA3: var_40 = Text1.Text
  loc_005C4CE0: var_94 = var_40
  loc_005C4D17: var_F4 = "â¢ "
  loc_005C4D69: var_44 = &H42EC60 & var_6C & "â¢ " & 0 & &H42EC60
  loc_005C4DA0: var_eax = call Proc_3_4_5A51B0(var_DC, var_34, 3)
  loc_005C4E40: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_DC & vbNullString, var_4C, var_6C)
  loc_005C4E71: var_eax = call Proc_6098C0(CLng(0.7), , )
  loc_005C4E88: Next var_24
  loc_005C4E8E: var_164 = Next var_24
  loc_005C4E94: GoTo loc_005C4BFD
  loc_005C4E99: 'Referenced from: 005C4C05
  loc_005C4E9B: 'Referenced from: 005C49E7
  loc_005C4EA4: GoTo loc_005C4F0C
  loc_005C4F0B: Exit Sub
  loc_005C4F0C: 'Referenced from: 005C4EA4
  loc_005C4F3E: Exit Sub
End Sub