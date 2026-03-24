Private Sub Command1_Click() '5FDC40
  Dim var_8C As ListBox
  Dim var_34 As Variant
  Dim var_170 As ListBox
  loc_005FDD65: var_16C = List1.ListCount
  loc_005FDD92: setz bl
  loc_005FDDA0: If ebx <> 0 Then GoTo loc_005FEB25
  loc_005FDDC9: var_16C = Option1.Value
  loc_005FDDF7: setz bl
  loc_005FDE05: If ebx = 0 Then GoTo loc_005FE578
  loc_005FDE28: var_34 = vbNullString
  loc_005FDE65: var_16C = List1.ListCount
  loc_005FDE8F: var_16C = var_16C - 0001h
  loc_005FDEAB: var_150 = var_16C
  loc_005FDED9: For var_54 = "" To var_16C Step 1
  loc_005FDEE5: var_1D8 = var_1AC
  loc_005FDEFD: If var_1D8 = 0 Then GoTo loc_005FE1A0
  loc_005FDF2A: var_16C = Check1.Value
  loc_005FDF5E: setz al
  loc_005FDF77: If var_178 = 0 Then GoTo loc_005FE07A
  loc_005FDFC6: var_8C = List1.List(CInt(var_58))
  loc_005FDFF2: var_B0 = var_58
  loc_005FE01B: var_150 = "),"
  loc_005FE04E: var_34 = var_34 & &H437168 & var_58 & "),"
  loc_005FE075: GoTo loc_005FE172
  loc_005FE07A: 'Referenced from: 005FDF77
  loc_005FE07D: var_140 = vbNullString
  loc_005FE0B5: var_54 = CInt(var_58)
  loc_005FE0C3: var_8C = List1.List(var_54)
  loc_005FE0F2: var_B0 = var_58
  loc_005FE14B: var_34 = var_34 & vbNullString & var_58 & &H437A70
  loc_005FE172: 'Referenced from: 005FE075
  loc_005FE18F: Next var_54
  loc_005FE195: var_1D8 = Next var_54
  loc_005FE19B: GoTo loc_005FDEF7
  loc_005FE1A0: 'Referenced from: 005FDEFD
  loc_005FE1FC: var_34 = Left(var_34, CLng(Len(var_34) - 1))
  loc_005FE220: var_170 = var_34
  loc_005FE226: var_58 = Text1.Text
  loc_005FE26E: var_60 = Text3.Text
  loc_005FE2B2: var_6C = Text2.Text
  loc_005FE327: var_78 = vbNullString & "< a href=" & var_60 & var_0042E8A4 & var_6C & vbNullString
  loc_005FE33A: var_D0 = var_78 & "</a>"
  loc_005FE34A: var_C8 = Chr(13)
  loc_005FE359: var_F8 = Chr(10)
  loc_005FE386: var_7C = Text4.Text
  loc_005FE3B3: var_110 = var_7C
  loc_005FE3E0: var_160 = vbNullString
  loc_005FE46A: var_140 = vbNullString
  loc_005FE470: var_150 = vbNullString
  loc_005FE4BB: var_eax = call Proc_79_15_603B90(vbNullString & var_34 & vbNullString, vbNullString & var_58 & vbNullString, var_78 & "</a>" & var_C8 & var_F8 & 0 & vbNullString)
  loc_005FE576: GoTo loc_005FE58A
  loc_005FE578: 'Referenced from: 005FDE05
  loc_005FE58A: 'Referenced from: 005FE576
  loc_005FE5B4: var_16C = Option2.Value
  loc_005FE5E8: setz dl
  loc_005FE602: If var_178 = 0 Then GoTo loc_005FEB23
  loc_005FE646: var_16C = List1.ListCount
  loc_005FE676: var_16C = var_16C - 0001h
  loc_005FE692: var_150 = var_16C
  loc_005FE6C4: For var_24 = 0 To var_16C Step 1
  loc_005FE6D0: var_1E8 = var_1CC
  loc_005FE6DC: 
  loc_005FE6E4: If var_1E8 = 0 Then GoTo loc_005FEB23
  loc_005FE714: var_16C = Check1.Value
  loc_005FE748: setz dl
  loc_005FE77F: var_44 = " & List1.List(i) & "
  loc_005FE7AC: var_58 = Text1.Text
  loc_005FE7F7: var_60 = Text3.Text
  loc_005FE842: var_6C = Text2.Text
  loc_005FE8B1: var_78 = vbNullString & "< a href=" & var_60 & var_0042E8A4 & var_6C & vbNullString
  loc_005FE8C4: var_D0 = var_78 & "</a>"
  loc_005FE8D4: var_C8 = Chr(13)
  loc_005FE8E3: var_F8 = Chr(10)
  loc_005FE910: var_7C = Text4.Text
  loc_005FE93D: var_110 = var_7C
  loc_005FE96A: var_160 = vbNullString
  loc_005FE9F4: var_140 = vbNullString
  loc_005FE9FA: var_150 = vbNullString
  loc_005FEA45: var_eax = call Proc_79_15_603B90(vbNullString & var_44 & vbNullString, vbNullString & var_58 & vbNullString, var_78 & "</a>" & var_C8 & var_F8 & 0 & vbNullString)
  loc_005FEB12: Next var_24
  loc_005FEB18: var_1E8 = Next var_24
  loc_005FEB1E: GoTo loc_005FE6DC
  loc_005FEB23: 'Referenced from: 005FE602
  loc_005FEB25: 'Referenced from: 005FDDA0
  loc_005FEB2D: GoTo loc_005FEBED
  loc_005FEBEC: Exit Sub
  loc_005FEBED: 'Referenced from: 005FEB2D
  loc_005FEC2E: Exit Sub
End Sub