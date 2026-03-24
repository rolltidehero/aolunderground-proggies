VERSION 2.00
Begin Form Insults 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Send Insults"
   ClientHeight    =   3315
   ClientLeft      =   1980
   ClientTop       =   2235
   ClientWidth     =   6510
   Height          =   3720
   Icon            =   INSULTS.FRX:0000
   Left            =   1920
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3315
   ScaleWidth      =   6510
   Top             =   1890
   Width           =   6630
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   6240
      MessageCount    =   INSULTS.FRX:0302
      MessageList     =   INSULTS.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   3480
      Width           =   420
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
      Left            =   3720
      TabIndex        =   4
      Top             =   2760
      Width           =   1455
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Send Insult"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1200
      TabIndex        =   3
      Top             =   2760
      Width           =   1455
   End
   Begin SSFrame Frame3D1 
      Caption         =   "&Yo Momma Snaps"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   1215
      Left            =   360
      TabIndex        =   2
      Top             =   120
      Width           =   5775
      Begin OptionButton Option2 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Send a &Random Yo Momma Snap"
         Height          =   255
         Left            =   360
         TabIndex        =   7
         Top             =   720
         Width           =   3135
      End
      Begin TextBox Text2 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   3120
         MaxLength       =   2
         TabIndex        =   6
         Top             =   360
         Width           =   495
      End
      Begin OptionButton Option1 
         BackColor       =   &H00C0C0C0&
         Caption         =   "&Send Yo Momma Snap #:"
         Height          =   255
         Left            =   360
         TabIndex        =   5
         Top             =   360
         Width           =   2535
      End
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   615
      Left            =   240
      MaxLength       =   93
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   1920
      Width           =   6015
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "The Insult"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   1560
      Width           =   975
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
    
YMS1 = "Yo momma's so poor, she goes to KFC and licks other people's fingers!"
YMS2 = "Yo momma's so stupid, it takes her an hour to cook minute rice!"
YMS3 = "Yo momma's so fat, she uses a VCR for a pager!"
YMS4 = "Yo momma's so fat, she's protected by Green Peace!"
YMS5 = "Yo momma's so ugly, when she walks into Taco Bell everyone runs for the border!"
YMS6 = "Yo momma's so fat, I saw the back of her neck and thought I was in a library!"
YMS7 = "Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
YMS8 = "Yo momma's so stupid, she tripped over her cordless phone!"
YMS9 = "Yo momma's so short, she gotta cuff her panties!"
YMS10 = "Yo momma's so fat she on both sides of the family!"
YMS11 = "Yo momma's so ugly she had to go trick or treatin' over the phone!"
YMS12 = "Yo momma stink so bad she used Secret and it told!"
YMS13 = "Yo momma's so nasty I had phone sex with her and she gave me an ear infection"
YMS14 = "Yo momma's so fat she got to take her pants off to get her change!"
YMS15 = "Yo momma's is like a door knob, everyone gets a turn!"
YMS16 = "Yo momma stink so bad she used Sure and it got confused!"
YMS17 = "Yo momma's teeth so yellow when she simles you got to slow down!"
YMS18 = "Yo momma's so fat she got more chins than a Chinese telephone book!"
YMS19 = "Yo momma's so fat her blood type is Ragu!"
YMS20 = "Yo momma's so hairy, big foot took a picture of her!"
YMS21 = "Yo momma's so tall she did a cartwheel and kicked god in the chin!"
YMS22 = "Yo momma's so stupid she thought denial was a river in Egypt!"
YMS23 = "Yo momma's so stupid she got stabbed in a gun fight!"
YMS24 = "Yo momma's so old her Social Security Number is 1"
YMS25 = "Yo momma's so stupid she went to the movies with 16 other PPL because she thought under 17 not admitted!"
YMS26 = "Yo momma stink so bad she made Right Guard turn left!"
YMS27 = "Yo momma's like a video game, 3 Men for a quarter!"
YMS28 = "Yo momma's so fat she jumped for joy and got stuck!"
YMS29 = "Yo momma gums so black she spits out YooHoo!"
YMS30 = "Yo momma's teeth so yellow ""I can't believe it's not butter!"""
YMS31 = "Yo momma's so ugly she went into a haunted house and came out with a job application!"
YMS32 = "oh yeah, tell your mamma I said thanks!"

   If Option2.Value = True Then

Randomize

upperbound = 32
lowerbound = 1

RandomChoice = Int((upperbound - lowerbound + 1) * Rnd + lowerbound)
  
If RandomChoice = 1 Then Text1.Text = YMS1
If RandomChoice = 2 Then Text1.Text = YMS2
If RandomChoice = 3 Then Text1.Text = YMS3
If RandomChoice = 4 Then Text1.Text = YMS4
If RandomChoice = 5 Then Text1.Text = YMS5
If RandomChoice = 6 Then Text1.Text = YMS6
If RandomChoice = 7 Then Text1.Text = YMS7
If RandomChoice = 8 Then Text1.Text = YMS8
If RandomChoice = 9 Then Text1.Text = YMS9
If RandomChoice = 10 Then Text1.Text = YMS10
If RandomChoice = 11 Then Text1.Text = YMS11
If RandomChoice = 12 Then Text1.Text = YMS12
If RandomChoice = 13 Then Text1.Text = YMS13
If RandomChoice = 14 Then Text1.Text = YMS14
If RandomChoice = 15 Then Text1.Text = YMS15
If RandomChoice = 16 Then Text1.Text = YMS16
If RandomChoice = 17 Then Text1.Text = YMS17
If RandomChoice = 18 Then Text1.Text = YMS18
If RandomChoice = 19 Then Text1.Text = YMS19
If RandomChoice = 20 Then Text1.Text = YMS20
If RandomChoice = 21 Then Text1.Text = YMS21
If RandomChoice = 22 Then Text1.Text = YMS22
If RandomChoice = 23 Then Text1.Text = YMS23
If RandomChoice = 24 Then Text1.Text = YMS24
If RandomChoice = 25 Then Text1.Text = YMS25
If RandomChoice = 26 Then Text1.Text = YMS26
If RandomChoice = 27 Then Text1.Text = YMS27
If RandomChoice = 28 Then Text1.Text = YMS28
If RandomChoice = 29 Then Text1.Text = YMS29
If RandomChoice = 30 Then Text1.Text = YMS30
If RandomChoice = 31 Then Text1.Text = YMS31
If RandomChoice = 32 Then Text1.Text = YMS32
End If
If Option1.Value = True Then
   
    If Text2.Text = "1" Then Text1.Text = YMS1
    If Text2.Text = "2" Then Text1.Text = YMS2
    If Text2.Text = "3" Then Text1.Text = YMS3
    If Text2.Text = "4" Then Text1.Text = YMS4
    If Text2.Text = "5" Then Text1.Text = YMS5
    If Text2.Text = "6" Then Text1.Text = YMS6
    If Text2.Text = "7" Then Text1.Text = YMS7
    If Text2.Text = "8" Then Text1.Text = YMS8
    If Text2.Text = "9" Then Text1.Text = YMS9
    If Text2.Text = "10" Then Text1.Text = YMS10
    If Text2.Text = "11" Then Text1.Text = YMS11
    If Text2.Text = "12" Then Text1.Text = YMS12
    If Text2.Text = "13" Then Text1.Text = YMS13
    If Text2.Text = "14" Then Text1.Text = YMS14
    If Text2.Text = "15" Then Text1.Text = YMS15
    If Text2.Text = "16" Then Text1.Text = YMS16
    If Text2.Text = "17" Then Text1.Text = YMS17
    If Text2.Text = "18" Then Text1.Text = YMS18
    If Text2.Text = "19" Then Text1.Text = YMS19
    If Text2.Text = "20" Then Text1.Text = YMS20
    If Text2.Text = "21" Then Text1.Text = YMS21
    If Text2.Text = "22" Then Text1.Text = YMS22
    If Text2.Text = "23" Then Text1.Text = YMS23
    If Text2.Text = "24" Then Text1.Text = YMS24
    If Text2.Text = "25" Then Text1.Text = YMS25
    If Text2.Text = "26" Then Text1.Text = YMS26
    If Text2.Text = "27" Then Text1.Text = YMS27
    If Text2.Text = "28" Then Text1.Text = YMS28
    If Text2.Text = "29" Then Text1.Text = YMS29
    If Text2.Text = "30" Then Text1.Text = YMS30
    If Text2.Text = "31" Then Text1.Text = YMS31
    If Text2.Text = "32" Then Text1.Text = YMS32
    End If

  '  AsInt = Text2.Text
  '  If AsInt < 1 Or AsInt > 32 Then
  '  MsgBox "Must choose a number between 1 and 32 for yo momma snaps!"
  '  Exit Sub
  '  End If

    thiswin% = FindWindow(0, "America  Online")
    EditHand = FindChildByClass(thiswin%, "_AOL_Edit")
    SendHand4 = FindChildByTitle(thiswin%, "Send")
    VBMsg1.SubClasshWnd = SendHand4
    lint = 95
    lpstring = Text1.Text
 SendThat = SendMessageByString(EditHand, WM_SETTEXT, lint, lpstring) ',lint
   DoEvents
   VBMsg1.SendMessage = WM_LBUTTONDOWN
   VBMsg1.SendMessage = WM_LBUTTONUP
   DoEvents

End Sub

Sub Command3D2_Click ()
Unload Me

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(insults.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Option1_Click ()
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"
Text1.Text = ", Yo momma's so poor, when she went to McDonalds she had to put your Happy Meal on lay-away!"
Text1.Text = ", Yo momma's so fat she had to be babtised at Sea World!"
Text1.Text = ", Yo momma's so stupid, it takes her an hour to cook minute rice!"
Text1.Text = ", Yo momma's so fat, she uses a VCR for a pager!"
Text1.Text = ", Yo momma's so fat, she's protected by Green Peace!"
Text1.Text = ", Yo momma's so ungly, when she walks into Taco Bell everyone runs for the border!"
Text1.Text = ", Yo momma's so fat, I saw the back of her neck and though I was in a library!"
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"

End Sub

Sub Option10_Click ()
Text1.Text = ", Yo momma's so poor, when she went to McDonalds she had to put your Happy Meal on lay-away!"
Text1.Text = ", Yo momma's so fat she had to be babtised at Sea World!"
Text1.Text = ", Yo momma's so stupid, it takes her an hour to cook minute rice!"
Text1.Text = ", Yo momma's so fat, she uses a VCR for a pager!"
Text1.Text = ", Yo momma's so fat, she's protected by Green Peace!"
Text1.Text = ", Yo momma's so ungly, when she walks into Taco Bell everyone runs for the border!"
Text1.Text = ", Yo momma's so fat, I saw the back of her neck and though I was in a library!"
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"

End Sub

Sub Option2_Click ()
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"


End Sub

Sub Option3_Click ()
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"


End Sub

Sub Option4_Click ()
Text1.Text = ", Yo momma's so fat, I saw the back of her neck and though I was in a library!"
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"

End Sub

Sub Option5_Click ()
Text1.Text = ", Yo momma's so ungly, when she walks into Taco Bell everyone runs for the border!"
Text1.Text = ", Yo momma's so fat, I saw the back of her neck and though I was in a library!"
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"

End Sub

Sub Option6_Click ()
Text1.Text = ", Yo momma's so fat, she's protected by Green Peace!"
Text1.Text = ", Yo momma's so ungly, when she walks into Taco Bell everyone runs for the border!"
Text1.Text = ", Yo momma's so fat, I saw the back of her neck and though I was in a library!"
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"

End Sub

Sub Option7_Click ()
Text1.Text = ", Yo momma's so fat, she uses a VCR for a pager!"
Text1.Text = ", Yo momma's so fat, she's protected by Green Peace!"
Text1.Text = ", Yo momma's so ungly, when she walks into Taco Bell everyone runs for the border!"
Text1.Text = ", Yo momma's so fat, I saw the back of her neck and though I was in a library!"
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"

End Sub

Sub Option8_Click ()
Text1.Text = ", Yo momma's so stupid, it takes her an hour to cook minute rice!"
Text1.Text = ", Yo momma's so fat, she uses a VCR for a pager!"
Text1.Text = ", Yo momma's so fat, she's protected by Green Peace!"
Text1.Text = ", Yo momma's so ungly, when she walks into Taco Bell everyone runs for the border!"
Text1.Text = ", Yo momma's so fat, I saw the back of her neck and though I was in a library!"
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"

End Sub

Sub Option9_Click ()
Text1.Text = ", Yo momma's so fat she had to be babtised at Sea World!"
Text1.Text = ", Yo momma's so stupid, it takes her an hour to cook minute rice!"
Text1.Text = ", Yo momma's so fat, she uses a VCR for a pager!"
Text1.Text = ", Yo momma's so fat, she's protected by Green Peace!"
Text1.Text = ", Yo momma's so ungly, when she walks into Taco Bell everyone runs for the border!"
Text1.Text = ", Yo momma's so fat, I saw the back of her neck and though I was in a library!"
Text1.Text = ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
Text1.Text = ", Yo mommas so stupid, she tripped over her cordless phone!"
  Text1.Text = ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"

End Sub

Sub Text2_Change ()
YMS1 = "Yo momma's so poor, she goes to KFC and licks other people's fingers!"
YMS2 = "Yo momma's so stupid, it takes her an hour to cook minute rice!"
YMS3 = "Yo momma's so fat, she uses a VCR for a pager!"
YMS4 = "Yo momma's so fat, she's protected by Green Peace!"
YMS5 = "Yo momma's so ugly, when she walks into Taco Bell everyone runs for the border!"
YMS6 = "Yo momma's so fat, I saw the back of her neck and thought I was in a library!"
YMS7 = "Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
YMS8 = "Yo momma's so stupid, she tripped over her cordless phone!"
YMS9 = "Yo momma's so short, she gotta cuff her panties!"
YMS10 = "Yo momma's so fat she on both sides of the family!"
YMS11 = "Yo momma's so ugly she had to go trick or treatin' over the phone!"
YMS12 = "Yo momma stink so bad she used Secret and it told!"
YMS13 = "Yo momma's so nasty I had phone sex with her and she gave me an ear infection"
YMS14 = "Yo momma's so fat she got to take her pants off to get her change!"
YMS15 = "Yo momma's is like a door knob, everyone gets a turn!"
YMS16 = "Yo momma stink so bad she used Sure and it got confused!"
YMS17 = "Yo momma's teeth so yellow when she simles you got to slow down!"
YMS18 = "Yo momma's so fat she got more chins than a Chinese telephone book!"
YMS19 = "Yo momma's so fat her blood type is Ragu!"
YMS20 = "Yo momma's so hairy, big foot took a picture of her!"
YMS21 = "Yo momma's so tall she did a cartwheel and kicked god in the chin!"
YMS22 = "Yo momma's so stupid she thought denial was a river in Egypt!"
YMS23 = "Yo momma's so stupid she got stabbed in a gun fight!"
YMS24 = "Yo momma's so old her Social Security Number is 1"
YMS25 = "Yo momma's so stupid she went to the movies with 16 other PPL because she thought under 17 not admitted!"
YMS26 = "Yo momma stink so bad she made Right Guard turn left!"
YMS27 = "Yo momma's like a video game, 3 Men for a quarter!"
YMS28 = "Yo momma's so fat she jumped for joy and got stuck!"
YMS29 = "Yo momma gums so black she spits out YooHoo!"
YMS30 = "Yo momma's teeth so yellow ""I can't believe it's not butter!"""
YMS31 = "Yo momma's so ugly she went into a haunted house and came out with a job application!"
YMS32 = "oh yeah, tell your mamma I said thanks!"
    
    If Text2.Text = "1" Then Text1.Text = YMS1
    If Text2.Text = "2" Then Text1.Text = YMS2
    If Text2.Text = "3" Then Text1.Text = YMS3
    If Text2.Text = "4" Then Text1.Text = YMS4
    If Text2.Text = "5" Then Text1.Text = YMS5
    If Text2.Text = "6" Then Text1.Text = YMS6
    If Text2.Text = "7" Then Text1.Text = YMS7
    If Text2.Text = "8" Then Text1.Text = YMS8
    If Text2.Text = "9" Then Text1.Text = YMS9
    If Text2.Text = "10" Then Text1.Text = YMS10
    If Text2.Text = "11" Then Text1.Text = YMS11
    If Text2.Text = "12" Then Text1.Text = YMS12
    If Text2.Text = "13" Then Text1.Text = YMS13
    If Text2.Text = "14" Then Text1.Text = YMS14
    If Text2.Text = "15" Then Text1.Text = YMS15
    If Text2.Text = "16" Then Text1.Text = YMS16
    If Text2.Text = "17" Then Text1.Text = YMS17
    If Text2.Text = "18" Then Text1.Text = YMS18
    If Text2.Text = "19" Then Text1.Text = YMS19
    If Text2.Text = "20" Then Text1.Text = YMS20
    If Text2.Text = "21" Then Text1.Text = YMS21
    If Text2.Text = "22" Then Text1.Text = YMS22
    If Text2.Text = "23" Then Text1.Text = YMS23
    If Text2.Text = "24" Then Text1.Text = YMS24
    If Text2.Text = "25" Then Text1.Text = YMS25
    If Text2.Text = "26" Then Text1.Text = YMS26
    If Text2.Text = "27" Then Text1.Text = YMS27
    If Text2.Text = "28" Then Text1.Text = YMS28
    If Text2.Text = "29" Then Text1.Text = YMS29
    If Text2.Text = "30" Then Text1.Text = YMS30
    If Text2.Text = "31" Then Text1.Text = YMS31
    If Text2.Text = "32" Then Text1.Text = YMS32

End Sub

