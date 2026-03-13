ï»¿Private Sub Label2_Click() '5F2E90
  loc_005F2F01: var_2C = Option1.Value
  loc_005F2F29: setz al
  loc_005F2F39: If eax = 0 Then GoTo loc_005F2F9B
  loc_005F2F49: var_24 = "bodini.ini"
  loc_005F2F79: var_eax = call Proc_79_43_6089A0("Mass Mailer", "Mail Type", "New Mail")
  loc_005F2F99: GoTo loc_005F2FA1
  loc_005F2F9B: 'Referenced from: 005F2F39
  loc_005F2FA1: 'Referenced from: 005F2F99
  loc_005F2FBE: var_2C = Option2.Value
  loc_005F2FE6: setz bl
  loc_005F2FF4: If ebx = 0 Then GoTo loc_005F304E
  loc_005F2FFE: var_24 = "bodini.ini"
  loc_005F302E: var_eax = call Proc_79_43_6089A0("Mass Mailer", "Mail Type", "Old Mail")
  loc_005F304E: 'Referenced from: 005F2FF4
  loc_005F306B: var_2C = Option3.Value
  loc_005F3093: setz bl
  loc_005F30A1: If ebx = 0 Then GoTo loc_005F30FB
  loc_005F30AB: var_24 = "bodini.ini"
  loc_005F30DB: var_eax = call Proc_79_43_6089A0("Mass Mailer", "Mail Type", "Sent Mail")
  loc_005F30FB: 'Referenced from: 005F30A1
  loc_005F3118: var_2C = Option4.Value
  loc_005F3140: setz bl
  loc_005F314E: If ebx = 0 Then GoTo loc_005F31A8
  loc_005F3158: var_24 = "bodini.ini"
  loc_005F3188: var_eax = call Proc_79_43_6089A0("Mass Mailer", "Mail Type", "Flash Mail")
  loc_005F31A8: 'Referenced from: 005F314E
  loc_005F31AB: var_eax = Unknown_VTable_Call[eax+000002B4h]
  loc_005F31D5: GoTo loc_005F31FC
  loc_005F31FB: Exit Sub
  loc_005F31FC: 'Referenced from: 005F31D5
End Sub