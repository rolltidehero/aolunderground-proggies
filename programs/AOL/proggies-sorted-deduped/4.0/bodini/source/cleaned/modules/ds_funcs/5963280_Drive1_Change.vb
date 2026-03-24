ï»¿Private Sub Drive1_Change() '5AFE10
  Dim var_B0 As DriveListBox
  Dim var_B8 As DriveListBox
  loc_005AFE75: On Error Resume Next
  loc_005AFE9C: var_B8 = var_2C
  loc_005AFED5: var_24 = Drive1.Drive
  loc_005AFEDD: var_B4 = var_24
  loc_005AFF2F: Drive1.Drive = var_24
  loc_005AFF37: var_BC = var_B8
  loc_005AFF9F: var_34 = Err
  loc_005AFFB3: var_B0 = CBool(Err)
  loc_005AFFCC: If var_B0 = 0 Then GoTo loc_005B0065
  loc_005B0012: var_4C = "bodini by: spek"
  loc_005B002C: var_3C = "Drive is not available"
  loc_005B0065: 'Referenced from: 005AFFCC
  loc_005B0071: GoTo loc_005B00AB
  loc_005B00AA: Exit Sub
  loc_005B00AB: 'Referenced from: 005B0071
End Sub