Private Sub Command1_Click() '5BC2B0
  Dim var_24 As CommonDialog
  Dim var_88 As CommonDialog
  Dim edx As CommonDialog
  Dim var_60 As PictureBox
  loc_005BC315: On Error Resume Next
  loc_005BC322: var_44 = vbNullString
  loc_005BC370: edx = CommonDialog._Action
  loc_005BC438: Me = CommonDialog._Action
  loc_005BC454: var_34 = Err
  loc_005BC468: var_60 = CBool(Err)
  loc_005BC47B: If var_60 = 0 Then GoTo loc_005BC4BB
  loc_005BC495: var_88 = Err
  loc_005BC4AA: Me.InitDir = var_24._Action
  loc_005BC4B6: GoTo loc_005BC634
  loc_005BC4BB: 'Referenced from: 005BC47B
  loc_005BC4FC: ecx = edx._Action
  loc_005BC545: var_28 = Picture1.Image
  loc_005BC54D: var_64 = var_28
  loc_005BC5BD: var_84 = var_28
  loc_005BC5EC: var_eax = Global.SavePicture var_84
  loc_005BC5F1: var_6C = Global.SavePicture var_84
  loc_005BC640: GoTo loc_005BC663
  loc_005BC662: Exit Sub
  loc_005BC663: 'Referenced from: 005BC640
End Sub