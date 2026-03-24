ï»¿Private Sub Timer1_Timer() '5A7EC0
  loc_005A7F47: var_eax = call Proc_79_37_607940(var_50, edi, esi)
  loc_005A7F5A: var_60 = LCase(var_50)
  loc_005A7F87: var_80 = LCase("/8ball *")
  loc_005A7F98: call __vbaVarLikeVar(var_90, var_80, var_60, 0)
  loc_005A7FC5: If CBool(__vbaVarLikeVar(var_90, var_80, var_60, 0)) = 0 Then GoTo loc_005A8F09
  loc_005A7FE4: var_eax = call Proc_6098C0(CLng(0.1), , )
  loc_005A8036: var_38 = Int(((Rnd(var_50) * 10) + 1))
  loc_005A806D: If (var_38 = 1) = 0 Then GoTo loc_005A81C5
  loc_005A8077: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A80BC: var_B8 = "â¢ hell no!!!â¢"
  loc_005A80EA: var_3C = &H42EC60 & LCase(var_50) & "â¢ hell no!!!â¢"
  loc_005A8121: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A817C: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A8195: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A81BE: var_eax = call Proc_6098C0(1, , )
  loc_005A81C3: GoTo loc_005A81D7
  loc_005A81C5: 'Referenced from: 005A806D
  loc_005A81D7: 'Referenced from: 005A81C3
  loc_005A81FF: If (var_38 = 2) = 0 Then GoTo loc_005A834B
  loc_005A8209: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A8250: var_B8 = "â¢ hell yeah!!!â¢"
  loc_005A8272: var_3C = &H42EC60 & LCase(var_50) & "â¢ hell yeah!!!â¢"
  loc_005A82A9: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A8304: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A831D: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A8346: var_eax = call Proc_6098C0(1, , )
  loc_005A834B: 'Referenced from: 005A81FF
  loc_005A8373: If (var_38 = 3) = 0 Then GoTo loc_005A84BF
  loc_005A837D: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A83C4: var_B8 = "â¢ maybe...â¢"
  loc_005A83E6: var_3C = &H42EC60 & LCase(var_50) & "â¢ maybe...â¢"
  loc_005A841D: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A8478: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A8491: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A84BA: var_eax = call Proc_6098C0(1, , )
  loc_005A84BF: 'Referenced from: 005A8373
  loc_005A84E7: If (var_38 = 4) = 0 Then GoTo loc_005A8633
  loc_005A84F1: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A8538: var_B8 = "â¢ most likelyâ¢"
  loc_005A855A: var_3C = &H42EC60 & LCase(var_50) & "â¢ most likelyâ¢"
  loc_005A8591: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A85EC: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A8605: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A862E: var_eax = call Proc_6098C0(1, , )
  loc_005A8633: 'Referenced from: 005A84E7
  loc_005A865B: If (var_38 = 5) = 0 Then GoTo loc_005A87A7
  loc_005A8665: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A86AC: var_B8 = "â¢ no chance in hellâ¢"
  loc_005A86CE: var_3C = &H42EC60 & LCase(var_50) & "â¢ no chance in hellâ¢"
  loc_005A8705: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A8760: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A8779: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A87A2: var_eax = call Proc_6098C0(1, , )
  loc_005A87A7: 'Referenced from: 005A865B
  loc_005A87CF: If (var_38 = 6) = 0 Then GoTo loc_005A891B
  loc_005A87D9: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A8820: var_B8 = "â¢ not sureâ¢"
  loc_005A8842: var_3C = &H42EC60 & LCase(var_50) & "â¢ not sureâ¢"
  loc_005A8879: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A88D4: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A88ED: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A8916: var_eax = call Proc_6098C0(1, , )
  loc_005A891B: 'Referenced from: 005A87CF
  loc_005A8943: If (var_38 = 7) = 0 Then GoTo loc_005A8A8F
  loc_005A894D: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A8994: var_B8 = "â¢ you wish!â¢"
  loc_005A89B6: var_3C = &H42EC60 & LCase(var_50) & "â¢ you wish!â¢"
  loc_005A89ED: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A8A48: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A8A61: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A8A8A: var_eax = call Proc_6098C0(1, , )
  loc_005A8A8F: 'Referenced from: 005A8943
  loc_005A8AB7: If (var_38 = 8) = 0 Then GoTo loc_005A8C03
  loc_005A8AC1: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A8B08: var_B8 = "â¢ i don't know, i'm a botâ¢"
  loc_005A8B2A: var_3C = &H42EC60 & LCase(var_50) & "â¢ i don't know, i'm a botâ¢"
  loc_005A8B61: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A8BBC: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A8BD5: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A8BFE: var_eax = call Proc_6098C0(1, , )
  loc_005A8C03: 'Referenced from: 005A8AB7
  loc_005A8C2B: If (var_38 = 9) = 0 Then GoTo loc_005A8D77
  loc_005A8C35: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A8C7C: var_B8 = "â¢ ask again laterâ¢"
  loc_005A8C9E: var_3C = &H42EC60 & LCase(var_50) & "â¢ ask again laterâ¢"
  loc_005A8CD5: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A8D30: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A8D49: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A8D72: var_eax = call Proc_6098C0(1, , )
  loc_005A8D77: 'Referenced from: 005A8C2B
  loc_005A8D9F: If (var_38 = 10) = 0 Then GoTo loc_005A8EE9
  loc_005A8DA9: var_eax = call Proc_79_52_60A380(var_50, , )
  loc_005A8DF0: var_B8 = "â¢ go pray...â¢"
  loc_005A8E12: var_3C = &H42EC60 & LCase(var_50) & "â¢ go pray...â¢"
  loc_005A8E49: var_eax = call Proc_3_4_5A51B0(var_A0, var_24, 3)
  loc_005A8EA6: var_3C = "<font face=""tahoma"">" & var_A0
  loc_005A8EBB: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_24, var_3C)
  loc_005A8EE4: var_eax = call Proc_6098C0(1, , )
  loc_005A8EE9: 'Referenced from: 005A8D9F
  loc_005A8F02: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005A8F09: 'Referenced from: 005A7FC5
  loc_005A8F12: GoTo loc_005A8F4E
  loc_005A8F4D: Exit Sub
  loc_005A8F4E: 'Referenced from: 005A8F12
End Sub