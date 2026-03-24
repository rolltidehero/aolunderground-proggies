Private Sub Timer1_Timer() '5C8AD0
  Dim var_18 As Winsock
  Dim esi As Winsock
  loc_005C8B36: var_28 = var_18._RemoteHost
  loc_005C8B40: var_18 = CInt(Me)
  loc_005C8B54: eax = var_18 + 1
  loc_005C8B57: var_2C = var_18 + 1
  loc_005C8B6B: If var_2C = 0 Then GoTo loc_005C8BA8
  loc_005C8B88: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005C8BA8: 'Referenced from: 005C8B6B
  loc_005C8BC1: var_28 = esi._RemoteHost
  loc_005C8BCB: Me = CInt("Closed")
  loc_005C8BD1: eax = esi - 1
  loc_005C8BDB: eax = esi - 1 + 1
  loc_005C8BDE: var_2C = esi - 1 + 1
  loc_005C8BF2: If var_2C = 0 Then GoTo loc_005C8C2F
  loc_005C8C0F: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C8C2F: 'Referenced from: 005C8BF2
  loc_005C8C48: var_28 = var_18._RemoteHost
  loc_005C8C52: var_18 = CInt("Open")
  loc_005C8C5E: setz dl
  loc_005C8C7A: If var_2C = 0 Then GoTo loc_005C8CB7
  loc_005C8C97: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C8CB7: 'Referenced from: 005C8C7A
  loc_005C8CD0: var_28 = var_18._RemoteHost
  loc_005C8CDA: var_18 = CInt("Listening")
  loc_005C8CE6: setz dl
  loc_005C8D02: If var_2C = 0 Then GoTo loc_005C8D3F
  loc_005C8D1F: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C8D3F: 'Referenced from: 005C8D02
  loc_005C8D58: var_28 = var_18._RemoteHost
  loc_005C8D62: var_18 = CInt("Connection Pending")
  loc_005C8D6E: setz dl
  loc_005C8D8A: If var_2C = 0 Then GoTo loc_005C8DC7
  loc_005C8DA7: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C8DC7: 'Referenced from: 005C8D8A
  loc_005C8DE0: var_28 = var_18._RemoteHost
  loc_005C8DEA: var_18 = CInt("Resolving Host")
  loc_005C8DF6: setz dl
  loc_005C8E12: If var_2C = 0 Then GoTo loc_005C8E4F
  loc_005C8E2F: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C8E4F: 'Referenced from: 005C8E12
  loc_005C8E68: var_28 = var_18._RemoteHost
  loc_005C8E72: var_18 = CInt("Host Resolved")
  loc_005C8E7E: setz dl
  loc_005C8E9A: If var_2C = 0 Then GoTo loc_005C8ED7
  loc_005C8EB7: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C8ED7: 'Referenced from: 005C8E9A
  loc_005C8EF0: var_28 = var_18._RemoteHost
  loc_005C8EFA: var_18 = CInt("Connecting")
  loc_005C8F06: setz dl
  loc_005C8F22: If var_2C = 0 Then GoTo loc_005C8F5F
  loc_005C8F3F: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C8F5F: 'Referenced from: 005C8F22
  loc_005C8F78: var_28 = var_18._RemoteHost
  loc_005C8F82: var_18 = CInt("Connected")
  loc_005C8F8E: setz dl
  loc_005C8FAA: If var_2C = 0 Then GoTo loc_005C8FE7
  loc_005C8FC7: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C8FE7: 'Referenced from: 005C8FAA
  loc_005C9000: var_28 = var_18._RemoteHost
  loc_005C900A: var_18 = CInt("No Carrier")
  loc_005C9016: setz dl
  loc_005C9032: If var_2C = 0 Then GoTo loc_005C906F
  loc_005C904F: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C906F: 'Referenced from: 005C9032
  loc_005C9088: var_28 = var_18._RemoteHost
  loc_005C9092: var_18 = CInt("Error")
  loc_005C90A0: eax = var_18 + 1
  loc_005C90A3: var_2C = var_18 + 1
  loc_005C90B7: If var_2C = 0 Then GoTo loc_005C90F4
  loc_005C90D4: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005C90F4: 'Referenced from: 005C90B7
  loc_005C910D: var_28 = esi._RemoteHost
  loc_005C9117: Me = CInt("Closed")
  loc_005C911D: eax = esi - 1
  loc_005C9127: eax = esi - 1 + 1
  loc_005C912A: var_2C = esi - 1 + 1
  loc_005C913E: If var_2C = 0 Then GoTo loc_005C917B
  loc_005C915B: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C917B: 'Referenced from: 005C913E
  loc_005C9194: var_28 = var_18._RemoteHost
  loc_005C919E: var_18 = CInt("Open")
  loc_005C91AA: setz dl
  loc_005C91C6: If var_2C = 0 Then GoTo loc_005C9203
  loc_005C91E3: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C9203: 'Referenced from: 005C91C6
  loc_005C921C: var_28 = var_18._RemoteHost
  loc_005C9226: var_18 = CInt("Listening")
  loc_005C9232: setz dl
  loc_005C924E: If var_2C = 0 Then GoTo loc_005C928B
  loc_005C926B: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C928B: 'Referenced from: 005C924E
  loc_005C92A4: var_28 = var_18._RemoteHost
  loc_005C92AE: var_18 = CInt("Connection Pending")
  loc_005C92BA: setz dl
  loc_005C92D6: If var_2C = 0 Then GoTo loc_005C9313
  loc_005C92F3: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C9313: 'Referenced from: 005C92D6
  loc_005C932C: var_28 = var_18._RemoteHost
  loc_005C9336: var_18 = CInt("Resolving Host")
  loc_005C9342: setz dl
  loc_005C935E: If var_2C = 0 Then GoTo loc_005C939B
  loc_005C937B: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C939B: 'Referenced from: 005C935E
  loc_005C93B4: var_28 = var_18._RemoteHost
  loc_005C93BE: var_18 = CInt("Host Resolved")
  loc_005C93CA: setz dl
  loc_005C93E6: If var_2C = 0 Then GoTo loc_005C9423
  loc_005C9403: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C9423: 'Referenced from: 005C93E6
  loc_005C943C: var_28 = var_18._RemoteHost
  loc_005C9446: var_18 = CInt("Connecting")
  loc_005C9452: setz dl
  loc_005C946E: If var_2C = 0 Then GoTo loc_005C94AB
  loc_005C948B: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C94AB: 'Referenced from: 005C946E
  loc_005C94C4: var_28 = var_18._RemoteHost
  loc_005C94CE: var_18 = CInt("Connected")
  loc_005C94DA: setz dl
  loc_005C94F6: If var_2C = 0 Then GoTo loc_005C9533
  loc_005C9513: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C9533: 'Referenced from: 005C94F6
  loc_005C954C: var_28 = var_18._RemoteHost
  loc_005C9556: var_18 = CInt("No Carrier")
  loc_005C9562: setz dl
  loc_005C957E: If var_2C = 0 Then GoTo loc_005C95B7
  loc_005C959A: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005C95B7: 'Referenced from: 005C957E
  loc_005C95C3: GoTo loc_005C95D8
  loc_005C95D7: Exit Sub
  loc_005C95D8: 'Referenced from: 005C95C3
End Sub