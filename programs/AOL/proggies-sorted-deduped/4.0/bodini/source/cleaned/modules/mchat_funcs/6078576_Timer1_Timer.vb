ï»¿Private Sub Timer1_Timer() '5CC070
  Dim var_24 As TextBox
  Dim var_104 As TextBox
  Dim var_48 As TextBox
  loc_005CC11F: var_eax = call Proc_79_38_607B50(var_24, Me, Me)
  loc_005CC129: var_18 = call Proc_79_38_607B50(var_24, Me, Me)
  loc_005CC139: Text4.Text = var_18
  loc_005CC186: var_18 = Text3.Text
  loc_005CC1C1: var_1C = Text4.Text
  loc_005CC1FA: edi = (var_18 = var_1C) + 1
  loc_005CC21C: If (var_18 <> var_1C) + 1 <> 0 Then GoTo loc_005CC4EF
  loc_005CC238: var_104 = var_24
  loc_005CC257: var_18 = Text2.Text
  loc_005CC28B: var_1C = vbNullString & var_18
  loc_005CC2AA: var_40 = var_1C & vbNullString
  loc_005CC2B8: var_D0 = vbNullString
  loc_005CC2D5: var_E0 = vbNullString
  loc_005CC2DB: var_eax = call Proc_79_38_607B50(var_24, Me, Me)
  loc_005CC2E6: var_A0 = call Proc_79_38_607B50(var_24, Me, Me)
  loc_005CC2F2: var_F0 = vbNullString
  loc_005CC361: var_C8 = var_1C & vbNullString & Chr(13) & vbNullString & Chr(10) & vbNullString & call Proc_79_38_607B50(var_24, Me, Me) & vbNullString
  loc_005CC368: var_20 = CStr(var_C8)
  loc_005CC376: Text2.Text = var_20
  loc_005CC412: var_eax = call Proc_79_38_607B50(var_24, var_48, Me)
  loc_005CC41C: var_18 = call Proc_79_38_607B50(var_24, var_48, Me)
  loc_005CC424: Text3.Text = var_18
  loc_005CC489: var_18 = Text2.Text
  loc_005CC4B5: Text2.SelStart = Len(var_18)
  loc_005CC4EF: 'Referenced from: 005CC21C
  loc_005CC4F7: GoTo loc_005CC560
  loc_005CC55F: Exit Sub
  loc_005CC560: 'Referenced from: 005CC4F7
End Sub