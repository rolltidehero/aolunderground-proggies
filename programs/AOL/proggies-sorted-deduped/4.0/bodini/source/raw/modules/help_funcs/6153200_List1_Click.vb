Private Sub List1_Click() '5DE3F0
  Dim var_30 As ListBox
  Dim var_60 As ListBox
  Dim var_2C As TextBox
  loc_005DE463: var_60 = var_30
  loc_005DE47C: var_54 = List1.ListIndex
  loc_005DE4A8: var_28 = List1.List(var_54)
  loc_005DE4FF: var_74 = var_28
  loc_005DE513: var_48 = "About Me"
  loc_005DE526: If (var_74 = "About Me") = 0 Then GoTo loc_005DE546
  loc_005DE541: GoTo loc_005DE792
  loc_005DE546: 'Referenced from: 005DE526
  loc_005DE54E: var_48 = "Clear History"
  loc_005DE561: If (var_74 = "Clear History") = 0 Then GoTo loc_005DE588
  loc_005DE57D: Text1.Text = "This was written by JaKaL for me. This clears the last 25 places you visited."
  loc_005DE583: GoTo loc_005DE799
  loc_005DE588: 'Referenced from: 005DE561
  loc_005DE590: var_48 = "Help"
  loc_005DE5A3: If (var_74 = "Help") = 0 Then GoTo loc_005DE5CA
  loc_005DE5BF: Text1.Text = "This is what you are looking at."
  loc_005DE5C5: GoTo loc_005DE799
  loc_005DE5CA: 'Referenced from: 005DE5A3
  loc_005DE5D2: var_48 = "Idle Bot"
  loc_005DE5E5: If (var_74 = "Idle Bot") = 0 Then GoTo loc_005DE605
  loc_005DE600: GoTo loc_005DE792
  loc_005DE605: 'Referenced from: 005DE5E5
  loc_005DE60D: var_48 = "Mass Mailer"
  loc_005DE620: If (var_74 = "Mass Mailer") = 0 Then GoTo loc_005DE647
  loc_005DE63C: Text1.Text = "This is useful for your warez pups. This will forward your mail(either all of it or selected mails) to whoever is on your mass mailer list. It does New, Old, Sent, and Flash Mail."
  loc_005DE642: GoTo loc_005DE799
  loc_005DE647: 'Referenced from: 005DE620
  loc_005DE64F: var_48 = "Server"
  loc_005DE662: If (var_74 = "Server") = 0 Then GoTo loc_005DE689
  loc_005DE67E: Text1.Text = "This is used to let peeps request certain mails from your mailbox. This server does 10 lists max, or 5000 mails. These forms were taken from neurotek server by mune and i. mune wrote about 80% of the code, i did most of the chat picking up techniques, so basically, mune did most of the mail serving coding, thanx mune."
  loc_005DE684: GoTo loc_005DE799
  loc_005DE689: 'Referenced from: 005DE662
  loc_005DE691: var_48 = "Greets"
  loc_005DE6A4: If (var_74 = "Greets") = 0 Then GoTo loc_005DE6C4
  loc_005DE6BF: GoTo loc_005DE792
  loc_005DE6C4: 'Referenced from: 005DE6A4
  loc_005DE6CC: var_48 = "Upchat"
  loc_005DE6DF: If (var_74 = "Upchat") = 0 Then GoTo loc_005DE710
  loc_005DE6FB: Text1.Text = "This enables you to do everything normal, while you are uploading."
  loc_005DE705: If var_2C >= 0 Then GoTo loc_005DE7F6
  loc_005DE70B: GoTo loc_005DE7E4
  loc_005DE710: 'Referenced from: 005DE6DF
  loc_005DE718: var_48 = "UnUpchat"
  loc_005DE72B: If (var_74 = "UnUpchat") = 0 Then GoTo loc_005DE75C
  loc_005DE747: Text1.Text = "This turns off Upchat."
  loc_005DE751: If (var_74 <> "UnUpchat") < 0 Then GoTo loc_005DE7F6
  loc_005DE757: GoTo loc_005DE7E4
  loc_005DE75C: 'Referenced from: 005DE72B
  loc_005DE764: var_48 = "Secret Area"
  loc_005DE777: If (var_74 = "Secret Area") = 0 Then GoTo loc_005DE7A1
  loc_005DE792: 'Referenced from: 005DE541
  loc_005DE793: Text1.Text = "There are three secret areas in this prog. One is easily accessible, you need to know the password. The second is rather moderate to find. The third is literally impossible. I guarantee you won't find it without looking REAL HARD!!!"
  loc_005DE799: 'Referenced from: 005DE583
  loc_005DE79D: If esi >= 0 Then GoTo loc_005DE7F6
  loc_005DE79F: GoTo loc_005DE7E4
  loc_005DE7A1: 'Referenced from: 005DE777
  loc_005DE7A9: var_48 = "Encrypter"
  loc_005DE7BC: If (var_74 = "Encrypter") = 0 Then GoTo loc_005DE7FF
  loc_005DE7D8: Text1.Text = "This feature was redone 3 times to be perfect. What this does is allow you to talk in private conversation by changing ascii. The keyword must be typed EXACTLY CORRECT TO decrypt the message, if it is not, it will not decrypt right."
  loc_005DE7E2: If var_2C >= 0 Then GoTo loc_005DE7F6
  loc_005DE7E4: 'Referenced from: 005DE70B
  loc_005DE7F0: var_2C = CheckObj(var_2C, var_0042CCC8, 164)
  loc_005DE7F6: 
  loc_005DE7FF: 
  loc_005DE80B: GoTo loc_005DE833
  loc_005DE832: Exit Sub
  loc_005DE833: 'Referenced from: 005DE80B
End Sub