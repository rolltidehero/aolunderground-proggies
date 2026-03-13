ï»¿Private Sub Picture1_Click() '5DC540
  loc_005DC61E: var_28 = "Hey, if you type my first name in the textbox, you can see a picture of me, I don't know if you would want to though :). Oh yea, type it exactly so the first letter is capitalized!"
  loc_005DC64A: var_18 = InputBox(var_28, "spek's secret area", var_48, var_58, 10, 10, 10)
  loc_005DC69C: var_A0 = "bodini by: spek"
  loc_005DC6A6: If (var_18 <> "Jason") <> 0 Then GoTo loc_005DC7CB
  loc_005DC6BF: var_38 = "bodini by: spek"
  loc_005DC6DE: var_28 = "You must be one of my good friends to know my first name, or you just got lucky, but anyways, here is my ugly picture..."
  loc_005DC724: call Proc_6098C0(5, 0, var_28 = %S_edx_S)
  loc_005DC7AB: var_eax = jason.Show var_8C
  loc_005DC7C9: GoTo loc_005DC82F
  loc_005DC7CB: 'Referenced from: 005DC6A6
  loc_005DC7DF: call 
  loc_005DC7EA: var_90 = "That is not my real first name..."
  loc_005DC7FA: call 
  loc_005DC837: GoTo loc_005DC864
  loc_005DC863: Exit Sub
  loc_005DC864: 'Referenced from: 005DC837
End Sub