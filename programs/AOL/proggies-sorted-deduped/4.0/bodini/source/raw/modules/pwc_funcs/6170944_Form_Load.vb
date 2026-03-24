Private Sub Form_Load() '5E2940
  loc_005E29F2: var_4C = "bodini by: spek"
  loc_005E2A04: var_3C = "This is really fucked up right now, i will finish it by the last beta, i think..."
  loc_005E2A3F: call __vbaCastObj(Me, var_0042DBEC, %ecx = %S_edx_S, Me, 00000008h)
  loc_005E2A56: call Proc_60A5D0(var_1C, var_1C, __vbaCastObj(Me, var_0042DBEC, var_1C = %S_edx_S, Me, 00000008h))
  loc_005E2A6C: call __vbaCastObj(Me, var_0042DBEC)
  loc_005E2A7D: var_eax = call Proc_79_25_605FA0(var_1C, var_1C, __vbaCastObj(Me, var_0042DBEC))
  loc_005E2AD3: var_eax = Combo4.AddItem ".1", var_70
  loc_005E2B48: var_eax = Combo4.AddItem ".2", var_70
  loc_005E2BBD: var_eax = Combo4.AddItem ".3", var_70
  loc_005E2C32: var_eax = Combo4.AddItem ".4", var_70
  loc_005E2CA7: var_eax = Combo4.AddItem ".5", var_70
  loc_005E2D1C: var_eax = Combo4.AddItem ".6", var_70
  loc_005E2D91: var_eax = Combo4.AddItem ".7", var_70
  loc_005E2E06: var_eax = Combo4.AddItem ".8", var_70
  loc_005E2E7B: var_eax = Combo4.AddItem ".9", var_70
  loc_005E2EF0: var_eax = Combo4.AddItem var_0042E988, var_70
  loc_005E2F65: var_eax = Combo4.AddItem "1.1", var_70
  loc_005E2FDA: var_eax = Combo4.AddItem "1.2", var_70
  loc_005E304F: var_eax = Combo4.AddItem "1.3", var_70
  loc_005E30C4: var_eax = Combo4.AddItem "1.4", var_70
  loc_005E3139: var_eax = Combo4.AddItem "1.5", var_70
  loc_005E31AE: var_eax = Combo4.AddItem "1.6", var_70
  loc_005E3223: var_eax = Combo4.AddItem "1.7", var_70
  loc_005E3298: var_eax = Combo4.AddItem "1.8", var_70
  loc_005E330D: var_eax = Combo4.AddItem "1.9", var_70
  loc_005E3382: var_eax = Combo4.AddItem var_0042E990, var_70
  loc_005E33D4: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005E3418: var_B0 = Combo1.ListCount
  loc_005E344A: var_34 = var_B0
  loc_005E3471: call __vbaCastObj(0, var_24, 0, var_00436CC0, var_20, Me, Me, 0, var_18, var_1C, 0, Me, 0, Combo4.AddItem var_0042E990, var_70, Me)
  loc_005E348D: var_eax = call Proc_79_50_609A50(var_28, CInt(var_BC), 2)
  loc_005E34EC: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E3530: var_B0 = Combo2.ListCount
  loc_005E3564: var_34 = var_B0
  loc_005E3587: call __vbaCastObj(var_24, var_24, var_2C, var_00436CC0, var_20, var_24, Me, var_1C, var_18, var_1C, eax, Me, var_2C, eax, Me)
  loc_005E35A3: var_eax = call Proc_79_50_609A50(var_28, CInt(var_BC), 2)
  loc_005E35E2: GoTo loc_005E3625
  loc_005E3624: Exit Sub
  loc_005E3625: 'Referenced from: 005E35E2
End Sub