VERSION 2.00
Begin Form Form13 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "AOHell v3.0  Encrypter "
   ClientHeight    =   5940
   ClientLeft      =   405
   ClientTop       =   660
   ClientWidth     =   8910
   Height          =   6345
   HelpContextID   =   25
   Icon            =   KTENCODE.FRX:0000
   Left            =   345
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5940
   ScaleWidth      =   8910
   Top             =   315
   Width           =   9030
   Begin SSCommand Command3D6 
      BevelWidth      =   3
      Caption         =   "&Encrypt/Decrypt"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6840
      TabIndex        =   20
      Top             =   840
      Width           =   1815
   End
   Begin SSCommand Command3D5 
      BevelWidth      =   3
      Caption         =   "&Force Encrypt"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6840
      TabIndex        =   19
      Top             =   1320
      Width           =   1815
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "&Save to File"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6840
      TabIndex        =   18
      Top             =   2280
      Width           =   1815
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&Read from File"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6840
      TabIndex        =   17
      Top             =   2760
      Width           =   1815
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Cancel"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6840
      TabIndex        =   16
      Top             =   3360
      Width           =   1815
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "Clear &Box"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   6840
      TabIndex        =   15
      Top             =   1800
      Width           =   1815
   End
   Begin CommonDialog CMDialog1 
      DialogTitle     =   "Open Encrypted File"
      Filter          =   "Encrypted Files (*.CRY)|*.CRY"
      Left            =   8280
      Top             =   4920
   End
   Begin SSPanel Label2 
      BevelOuter      =   1  'Inset
      Height          =   255
      Left            =   0
      TabIndex        =   7
      Top             =   5640
      Width           =   8895
   End
   Begin CommandButton Command5 
      Caption         =   "&Cancel"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   435
      Left            =   9000
      TabIndex        =   8
      Top             =   4680
      Visible         =   0   'False
      Width           =   2010
   End
   Begin CommandButton Command4 
      Caption         =   "&Force Encrypt"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   435
      Left            =   9000
      TabIndex        =   6
      Top             =   4680
      Visible         =   0   'False
      Width           =   2010
   End
   Begin CommandButton Command3 
      Caption         =   "&Read from File"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   435
      Left            =   9000
      TabIndex        =   4
      Top             =   4680
      Visible         =   0   'False
      Width           =   2010
   End
   Begin CommandButton Command2 
      Caption         =   "&Save to File"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   435
      Left            =   9000
      TabIndex        =   5
      Top             =   4680
      Visible         =   0   'False
      Width           =   2010
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   6720
      TabIndex        =   0
      Top             =   315
      Width           =   2025
   End
   Begin CommandButton Command1 
      Caption         =   "&Encrypt/Decrypt"
      Default         =   -1  'True
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   420
      Left            =   9000
      TabIndex        =   2
      Top             =   4680
      Visible         =   0   'False
      Width           =   2010
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Terminal"
      FontSize        =   9
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   5475
      Left            =   105
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   105
      Width           =   6525
   End
   Begin Label Label10 
      BackColor       =   &H8000000F&
      Caption         =   "Encrypter"
      FontBold        =   -1  'True
      FontItalic      =   -1  'True
      FontName        =   "Times New Roman"
      FontSize        =   18
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000080&
      Height          =   495
      Left            =   6960
      TabIndex        =   22
      Top             =   5040
      Width           =   1695
   End
   Begin Label Label9 
      BackColor       =   &H8000000F&
      Caption         =   "AOHell v3.0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000080&
      Height          =   255
      Left            =   7320
      TabIndex        =   21
      Top             =   4800
      Width           =   1335
   End
   Begin Image Image1 
      Height          =   420
      Left            =   6840
      Picture         =   KTENCODE.FRX:0302
      Top             =   4680
      Width           =   420
   End
   Begin Label Label8 
      BackColor       =   &H8000000F&
      BorderStyle     =   1  'Fixed Single
      Height          =   225
      Left            =   8085
      TabIndex        =   14
      Top             =   4320
      Width           =   645
   End
   Begin Label Label7 
      BackColor       =   &H8000000F&
      BorderStyle     =   1  'Fixed Single
      Height          =   225
      Left            =   8085
      TabIndex        =   13
      Top             =   3960
      Width           =   645
   End
   Begin Label Label6 
      BackColor       =   &H00C0C0C0&
      Caption         =   "TextBox length:"
      Height          =   195
      Left            =   6720
      TabIndex        =   12
      Top             =   4320
      Width           =   1560
   End
   Begin Label Label5 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Bytes/Second:"
      Height          =   195
      Left            =   6720
      TabIndex        =   11
      Top             =   3960
      Width           =   1335
   End
   Begin Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFF00&
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   435
      Left            =   9000
      TabIndex        =   10
      Top             =   5400
      Visible         =   0   'False
      Width           =   2010
   End
   Begin Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFF00&
      Caption         =   "K && T"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   27
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   645
      Left            =   9000
      TabIndex        =   9
      Top             =   5160
      Visible         =   0   'False
      Width           =   2010
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Password"
      Height          =   255
      Left            =   6720
      TabIndex        =   3
      Top             =   105
      Width           =   2295
   End
End
Dim Shared Temp

Sub Command1_Click ()
 
  'Encrypt/Decrypt Text1
  t = Timer
  Temp = KTEncrypt(Text2.Text, Text1.Text, 0)
  t = Timer - t
  
  'If Temp="" then an error ocurred
  If Temp <> "" Then
    Text1.Text = Temp
    Stats (t)
  Else
    Beep
  End If

  'See if file was encrypted and allow file saving
  If Left$(Text1.Text, 4) = Chr$(1) + "KT" + Chr$(1) Then
    Command2.Enabled = True
  Else
    Command2.Enabled = True
  End If

  
End Sub

Sub Command1_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = "Automatically detects if string is encrypted and checks for correct password"
  msg$ = msg$ + " if decrypting."

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Command2_Click ()
GoTo begin2

titfuck2:
Exit Sub


begin2:
On Error GoTo titfuck2

CMDIALOG1.Action = 2
Shit = CMDIALOG1.Filetitle
 xfilnam$ = CMDIALOG1.Filename

  Open xfilnam$ For Output As 1
    Print #1, Text1.Text
  Close #1
  Text1.Text = ""
  Command2.Enabled = True
  Command3.Enabled = True

  If cleartext = 1000 Then Text1.Text = ""
  DoEvents
  cleartext = 0
  End Sub

Sub Command2_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = "Saves TextBox to a file to test proper reading to and from a standard text file."

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Command3_Click ()
GoTo begin1

titfuck1:
Exit Sub


begin1:
On Error GoTo titfuck1

CMDIALOG1.Action = 1
xfilnam1$ = CMDIALOG1.Filename


  Open xfilnam1$ For Input As 1
    Line Input #1, Temp
  Close #1
  Text1.Text = Temp
  Command2.Enabled = True
  Command3.Enabled = True

End Sub

Sub Command3_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  
  msg$ = "Reads test file to the TextBox to test proper reading to and from a standard text file."
  
  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Command3D1_Click ()
Response = MsgBox("Do you want to save the text that's in the box now, first?", 36, "Save Text?")
'Possible Response values: 6--YES, 7--NO.
If Response = 6 Then
cleartext = 1000
DoEvents
Call Command2_Click
ElseIf Response = 7 Then Text1.Text = ""
 
 End If
  


End Sub

Sub Command3D2_Click ()
Call Command5_Click

End Sub

Sub Command3D3_Click ()
Call Command3_Click

End Sub

Sub Command3D4_Click ()
Call Command2_Click

End Sub

Sub Command3D5_Click ()
Call Command4_Click

End Sub

Sub Command3D6_Click ()
Call Command1_Click

End Sub

Sub Command4_Click ()

  'Force encode text1 (force% flag set to 1)
  t = Timer
  Temp = KTEncrypt(Text2.Text, Text1.Text, 1)
  t = Timer - t

  'If Temp="" then an error ocurred
  If Temp <> "" Then
    Text1.Text = Temp
    Stats (t)
  Else
    Beep
  End If
    
  'Allow saving to file
  Command2.Enabled = True
End Sub

Sub Command4_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  msg$ = "Forces an encrypt whether or not the string is already encrypted."
  msg$ = msg$ + " Allows for multi-level encryptions."

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Command5_Click ()

  Unload Me


End Sub

Sub Command5_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = " "

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Form_Load ()
  
  Command3.Enabled = True

  'Line feed
  LF$ = Chr$(13) + Chr$(10)

  'A message
  lalala = "You can, instead of saving the encrypted text to a file, highlight the text with the mouse and hit CTRL-C to copy it to the clipboard, then hit CTRL-V in the email message to paste it there.  CAUTION:  Using this method is risky.  Because of the way AOL formats their messages, it may cause long encrypted messages to be changed (bytes rearranged, extra carriage returns), therefore they cannot be decrypted."
  msg$ = "AOHell v3.0 Text Encrypter" + LF$ + LF$
  msg$ = msg$ + "Type your email message, or any other text you want to keep private, here.  Then enter the password you wish to use and hit the ENCRYPT button.  Then hit the ""Save to File"" button and save the file.  For EMAIL: Then, on AOL, send an email to the person you want and attach that file.  Make sure you notify the person by IM, or phone what PW you used, so he/she can decrypt it.  If the person sent you a file with encrypted text, download it, then on AOHell, hit the ""Read from File"" button and find the file and double click it.  The message will then appear.  You must then decrypt the message using the password the sender used to encrypt it.  The receiver can only decrypt it if they have AOHell v2.0 (beta 5) or higher version, and the password you set.  ***VERY IMPORTANT**  The password is CASE SENSITIVE!  If you try to decrypt text and the password you enter is not EXACTLY the way it was entered when encrypted you will get garbled text.  SPECIAL NOTE: " + lalala

  
  Text1.Text = msg$

  Label4.Caption = "PO Box 478" + Chr$(13) + Chr$(10) + "San Lorenzo, CA 94580"

  Stats (0)

End Sub

Sub Form_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = cryptname
  
  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Label2_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = cryptname
  
  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Label3_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = "K && T     PO Box 478, San Lorenzo, CA 94580-0478"

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Label4_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = "K && T     PO Box 478, San Lorenzo, CA 94580-0478"

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Label5_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  msg$ = "Displays encryption/decryption speed."
  msg$ = msg$ + " Somewhat unreliable because time is so short.  About 10,000."

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Label6_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  msg$ = "Displays TextBox length to show how much encryption file enlarged"
  msg$ = msg$ + " due to processing."

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Label7_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  msg$ = "Displays encryption/decryption speed."
  msg$ = msg$ + " Somewhat unreliable because time is so short.  About 10,000."

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Label8_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  msg$ = "Displays TextBox length to show how much encryption file enlarged"
  msg$ = msg$ + " due to processing."

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Stats (t)

  l = Len(Text1.Text)
  
  If t = 0 Then
    bytes = 0
  Else
    bytes = Int(l / t)
  End If

  label7.Caption = Trim$(Str$(bytes))
  label8.Caption = Trim$(Str$(l))

End Sub

Sub Text1_KeyDown (KeyCode As Integer, Shift As Integer)
If KeyCode = KEY_RETURN Then
MsgBox "Do not hit the Return button because that will cause your message to be cut off when saving the file.  Just keep typing and the words will wrap around to the next line.  Please hit the BACKSPACE key now, to get rid of the Carriage Return, unless you are not planning on saving this to a file."
End If


End Sub

Sub Text1_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = cryptname

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

Sub Text2_KeyPress (KeyAscii As Integer)

  'Trap enter
  If KeyAscii = 13 Then
    Command1_Click
    KeyAscii = 0
  End If

End Sub

Sub Text2_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)

  msg$ = "Can be any characters up to a length of 255 characters.  Password is case sensative."

  If label2.Caption <> msg$ Then label2.Caption = msg$

End Sub

