ï»¿Private Sub Command2_Click() '5BF950
  loc_005BF9D7: Randomize(10)
  loc_005BFA50: var_ret_1 = Rnd(10) * CInt(7)
  loc_005BFA7B: var_24 = Int(var_ret_1 + 1)
  loc_005BFAB6: If (var_24 = 1) = 0 Then GoTo loc_005BFAC6
  loc_005BFAC0: var_48 = "Hello, "
  loc_005BFAC6: 'Referenced from: 005BFAB6
  loc_005BFAE6: If (var_24 = 2) = 0 Then GoTo loc_005BFAF6
  loc_005BFAF0: var_48 = "Good evening, "
  loc_005BFAF6: 'Referenced from: 005BFAE6
  loc_005BFB16: If (var_24 = 3) = 0 Then GoTo loc_005BFB26
  loc_005BFB20: var_48 = "geno, And welcome to America Online. "
  loc_005BFB26: 'Referenced from: 005BFB16
  loc_005BFB46: If (var_24 = 4) = 0 Then GoTo loc_005BFB56
  loc_005BFB50: var_48 = "Welcome to America Online. "
  loc_005BFB56: 'Referenced from: 005BFB46
  loc_005BFB76: If (var_24 = 5) = 0 Then GoTo loc_005BFB86
  loc_005BFB80: var_48 = "Excuse me, "
  loc_005BFB86: 'Referenced from: 005BFB76
  loc_005BFBA6: If (var_24 = 6) = 0 Then GoTo loc_005BFBB6
  loc_005BFBB0: var_48 = "Dear User, "
  loc_005BFBB6: 'Referenced from: 005BFBA6
  loc_005BFBD6: If (var_24 = 7) = 0 Then GoTo loc_005BFBE6
  loc_005BFBE0: var_48 = "What's Up! "
  loc_005BFBE6: 'Referenced from: 005BFBD6
  loc_005BFC7B: var_24 = Int(Rnd(10) * CInt(7) + 1)
  loc_005BFCB0: If (var_24 = 1) = 0 Then GoTo loc_005BFCCC
  loc_005BFCC6: var_48 = var_48 & "I am with America Online Billing "
  loc_005BFCCC: 'Referenced from: 005BFCB0
  loc_005BFCEC: If (var_24 = 2) = 0 Then GoTo loc_005BFD08
  loc_005BFD02: var_48 = var_48 & "I am with OTC (Online Techincal Consultants) "
  loc_005BFD08: 'Referenced from: 005BFCEC
  loc_005BFD28: If (var_24 = 3) = 0 Then GoTo loc_005BFD44
  loc_005BFD3E: var_48 = var_48 & "I am with WWWC (World Wide Web Consultants) "
  loc_005BFD44: 'Referenced from: 005BFD28
  loc_005BFD64: If (var_24 = 4) = 0 Then GoTo loc_005BFD80
  loc_005BFD7A: var_48 = var_48 & "I am with AOL Techincal Staff "
  loc_005BFD80: 'Referenced from: 005BFD64
  loc_005BFDA0: If (var_24 = 5) = 0 Then GoTo loc_005BFDBC
  loc_005BFDB6: var_48 = var_48 & "I am with AOL System Security "
  loc_005BFDBC: 'Referenced from: 005BFDA0
  loc_005BFDDC: If (var_24 = 6) = 0 Then GoTo loc_005BFDF8
  loc_005BFDF2: var_48 = var_48 & "I am with AOL Resource Department "
  loc_005BFDF8: 'Referenced from: 005BFDDC
  loc_005BFE18: If (var_24 = 7) = 0 Then GoTo loc_005BFE34
  loc_005BFE2E: var_48 = var_48 & "I am with the AOL Community Action Team "
  loc_005BFE34: 'Referenced from: 005BFE18
  loc_005BFEC9: var_24 = Int(Rnd(10) * CInt(7) + 1)
  loc_005BFEFE: If (var_24 = 1) = 0 Then GoTo loc_005BFF1A
  loc_005BFF14: var_48 = var_48 & "and due to Technical Failures "
  loc_005BFF1A: 'Referenced from: 005BFEFE
  loc_005BFF3A: If (var_24 = 2) = 0 Then GoTo loc_005BFF56
  loc_005BFF50: var_48 = var_48 & "and due to Billing errors "
  loc_005BFF56: 'Referenced from: 005BFF3A
  loc_005BFF76: If (var_24 = 3) = 0 Then GoTo loc_005BFF92
  loc_005BFF8C: var_48 = var_48 & "and due to Line Noise "
  loc_005BFF92: 'Referenced from: 005BFF76
  loc_005BFFB2: If (var_24 = 4) = 0 Then GoTo loc_005BFFCE
  loc_005BFFC8: var_48 = var_48 & "and due to A virus in our database "
  loc_005BFFCE: 'Referenced from: 005BFFB2
  loc_005BFFEE: If (var_24 = 5) = 0 Then GoTo loc_005C000A
  loc_005C0004: var_48 = var_48 & "and due to Massive data flow in our database "
  loc_005C000A: 'Referenced from: 005BFFEE
  loc_005C002A: If (var_24 = 6) = 0 Then GoTo loc_005C0046
  loc_005C0040: var_48 = var_48 & "and due to data corruption "
  loc_005C0046: 'Referenced from: 005C002A
  loc_005C0066: If (var_24 = 7) = 0 Then GoTo loc_005C0082
  loc_005C007C: var_48 = var_48 & "and due to hackers by-passing out systems "
  loc_005C0082: 'Referenced from: 005C0066
  loc_005C0117: var_24 = Int(Rnd(10) * CInt(5) + 1)
  loc_005C014C: If (var_24 = 1) = 0 Then GoTo loc_005C0168
  loc_005C0162: var_48 = var_48 & "we seem to have lost your password. "
  loc_005C0168: 'Referenced from: 005C014C
  loc_005C0188: If (var_24 = 2) = 0 Then GoTo loc_005C01A4
  loc_005C019E: var_48 = var_48 & "we seem to have lost your account information. "
  loc_005C01A4: 'Referenced from: 005C0188
  loc_005C01C4: If (var_24 = 3) = 0 Then GoTo loc_005C01E0
  loc_005C01DA: var_48 = var_48 & "we seem to have failed to recieve your logon password. "
  loc_005C01E0: 'Referenced from: 005C01C4
  loc_005C0200: If (var_24 = 4) = 0 Then GoTo loc_005C021C
  loc_005C0216: var_48 = var_48 & "we seem to have failed to recieve your account information. "
  loc_005C021C: 'Referenced from: 005C0200
  loc_005C023C: If (var_24 = 5) = 0 Then GoTo loc_005C0258
  loc_005C0252: var_48 = var_48 & "we have lost your Credit Card information. "
  loc_005C0258: 'Referenced from: 005C023C
  loc_005C02ED: var_24 = Int(Rnd(10) * CInt(4) + 1)
  loc_005C0322: If (var_24 = 1) = 0 Then GoTo loc_005C033E
  loc_005C0338: var_48 = var_48 & "To correct this situation please click respond and enter "
  loc_005C033E: 'Referenced from: 005C0322
  loc_005C035E: If (var_24 = 2) = 0 Then GoTo loc_005C037A
  loc_005C0374: var_48 = var_48 & "Please click respond and enter your "
  loc_005C037A: 'Referenced from: 005C035E
  loc_005C039A: If (var_24 = 3) = 0 Then GoTo loc_005C03B6
  loc_005C03B0: var_48 = var_48 & "Please help us by entering your "
  loc_005C03B6: 'Referenced from: 005C039A
  loc_005C03D6: If (var_24 = 4) = 0 Then GoTo loc_005C03F2
  loc_005C03EC: var_48 = var_48 & "Please respond with your "
  loc_005C03F2: 'Referenced from: 005C03D6
  loc_005C0487: var_24 = Int(Rnd(10) * CInt(3) + 1)
  loc_005C04BC: If (var_24 = 1) = 0 Then GoTo loc_005C04D8
  loc_005C04D2: var_48 = var_48 & "Your password information."
  loc_005C04D8: 'Referenced from: 005C04BC
  loc_005C04F8: If (var_24 = 2) = 0 Then GoTo loc_005C0514
  loc_005C050E: var_48 = var_48 & "Your current account password."
  loc_005C0514: 'Referenced from: 005C04F8
  loc_005C0534: If (var_24 = 3) = 0 Then GoTo loc_005C0550
  loc_005C054A: var_48 = var_48 & "Your Full name, address, Credit Card #, Bank Name, Expiration Date, and home phone number."
  loc_005C0550: 'Referenced from: 005C0534
  loc_005C05E5: var_24 = Int(Rnd(10) * CInt(4) + 1)
  loc_005C061A: If (var_24 = 1) = 0 Then GoTo loc_005C0636
  loc_005C0630: var_48 = var_48 & " Please respond within 2 minutes too keep this account active."
  loc_005C0636: 'Referenced from: 005C061A
  loc_005C0656: If (var_24 = 2) = 0 Then GoTo loc_005C0672
  loc_005C066C: var_48 = var_48 & " It is very important that you respond immediately."
  loc_005C0672: 'Referenced from: 005C0656
  loc_005C0692: If (var_24 = 3) = 0 Then GoTo loc_005C06AE
  loc_005C06A8: var_48 = var_48 & " Please respond as soon as possible "
  loc_005C06AE: 'Referenced from: 005C0692
  loc_005C06CE: If (var_24 = 4) = 0 Then GoTo loc_005C06EA
  loc_005C06E4: var_48 = var_48 & " Incooperation may lead to termination of your account."
  loc_005C06EA: 'Referenced from: 005C06CE
  loc_005C077F: var_24 = Int(Rnd(10) * CInt(4) + 1)
  loc_005C07B4: If (var_24 = 1) = 0 Then GoTo loc_005C07D4
  loc_005C07D0: var_48 = var_48 & " Thank you for using America Online."
  loc_005C07D2: GoTo loc_005C07DA
  loc_005C07D4: 'Referenced from: 005C07B4
  loc_005C07DA: 'Referenced from: 005C07D2
  loc_005C07FA: If (var_24 = 2) = 0 Then GoTo loc_005C0812
  loc_005C0810: var_48 = var_48 & " Thank you for your time."
  loc_005C0812: 'Referenced from: 005C07FA
  loc_005C0832: If (var_24 = 3) = 0 Then GoTo loc_005C084A
  loc_005C0848: var_48 = var_48 & " Thank you for your cooperation."
  loc_005C084A: 'Referenced from: 005C0832
  loc_005C086A: If (var_24 = 4) = 0 Then GoTo loc_005C0882
  loc_005C0880: var_48 = var_48 & " Thank you for your help and enjoy the service!"
  loc_005C0882: 'Referenced from: 005C086A
  loc_005C089E: var_44 = var_48
  loc_005C08C4: Text1.Text = var_48
  loc_005C08F8: GoTo loc_005C0922
  loc_005C0921: Exit Sub
  loc_005C0922: 'Referenced from: 005C08F8
End Sub