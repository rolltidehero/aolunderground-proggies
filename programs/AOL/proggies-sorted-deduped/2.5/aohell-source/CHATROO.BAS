'Declare Function FindWindow% Lib "user" (ByVal junk&, ByVal Title$)
'Declare Function FindChildByTitle% Lib "ole02.dll" (ByVal parent%, ByVal Title$)
'Declare Function FindChildByClass% Lib "ole02.dll" (ByVal parent%, ByVal Title$)
Global DoGo As Integer

Global MTR1 As String
Global MTR2 As String
Global MTR3 As String
Global MTR4 As String
Global MTR5 As String
Global MTR6 As String
Global MTR7 As String
Global MTR8 As String
Global MTR9 As String
Global MTR10 As String

Global IgDice As Integer
Global IgSounds As Integer

Global SaidChat As Integer
Global SaidChat1 As Integer

Global ChatCount As Integer
Global TheGuide As String

Global AOLViewHandle As Integer
Global AOLSendHandle As Integer
Global AOLEditHandle As Integer

Global Destroyed As Integer

Global ChatName As String
Global ChatLine As String

Global ChatLineSp As String
Global ChatNameSp As String

Global MessageNum As Integer

Global Message1 As String
Global Message2 As String
Global Message3 As String
Global Message4 As String
Global Message5 As String
Global Message6 As String
Global Message7 As String
Global Message8 As String
Global Message9 As String
Global Message10 As String

Global Message1Sp As String
Global Message2Sp As String
Global Message3Sp As String
Global Message4Sp As String
Global Message5Sp As String
Global Message6Sp As String
Global Message7Sp As String
Global Message8Sp As String
Global Message9Sp As String
Global Message10Sp As String


Global PersonNum As Integer

Global Person1 As String
Global Person2 As String
Global Person3 As String
Global Person4 As String
Global Person5 As String

Global Person1Sp As String
Global Person2Sp As String
Global Person3Sp As String
Global Person4Sp As String
Global Person5Sp As String


Global WordNum As Integer

Global Word1 As String
Global Word2 As String
Global Word3 As String

Global Word1Sp As String
Global Word2Sp As String
Global Word3Sp As String

Global LastChat As String
Global LastChatSp As String

Global Event1 As Integer
Global Event2 As Integer
Global Event3 As Integer
Global Event4 As Integer
Global Event5 As Integer
Global Event6 As Integer
Global Event7 As Integer
Global Event8 As Integer
Global Event9 As Integer
Global Event10 As Integer


Global SendTo1 As String
Global SendTo2 As String
Global SendTo3 As String
Global SendTo4 As String
Global SendTo5 As String
Global SendTo6 As String
Global SendTo7 As String
Global SendTo8 As String
Global SendTo9 As String
Global SendTo10 As String

Global MSubject1 As String
Global MSubject2 As String
Global MSubject3 As String
Global MSubject4 As String
Global MSubject5 As String
Global MSubject6 As String
Global MSubject7 As String
Global MSubject8 As String
Global MSubject9 As String
Global MSubject10 As String

Global MMessage1 As String
Global MMessage2 As String
Global MMessage3 As String
Global MMessage4 As String
Global MMessage5 As String
Global MMessage6 As String
Global MMessage7 As String
Global MMessage8 As String
Global MMessage9 As String
Global MMessage10 As String
                 

Global IMTo1 As String
Global IMTo2 As String
Global IMTo3 As String
Global IMTo4 As String
Global IMTo5 As String
Global IMTo6 As String
Global IMTo7 As String
Global IMTo8 As String
Global IMTo9 As String
Global IMTo10 As String

Global IMess1 As String
Global IMess2 As String
Global IMess3 As String
Global IMess4 As String
Global IMess5 As String
Global IMess6 As String
Global IMess7 As String
Global IMess8 As String
Global IMess9 As String
Global IMess10 As String

Global LeaveChat1 As Integer
Global LeaveChat2 As Integer
Global LeaveChat3 As Integer
Global LeaveChat4 As Integer
Global LeaveChat5 As Integer
Global LeaveChat6 As Integer
Global LeaveChat7 As Integer
Global LeaveChat8 As Integer
Global LeaveChat9 As Integer
Global LeaveChat10 As Integer

Global RName1 As String
Global RName2 As String
Global RName3 As String
Global RName4 As String
Global RName5 As String
Global RName6 As String
Global RName7 As String
Global RName8 As String
Global RName9 As String
Global RName10 As String

Global TypeR1 As Integer
Global TypeR2 As Integer
Global TypeR3 As Integer
Global TypeR4 As Integer
Global TypeR5 As Integer
Global TypeR6 As Integer
Global TypeR7 As Integer
Global TypeR8 As Integer
Global TypeR9 As Integer
Global TypeR10 As Integer

Global BustIt1 As Integer
Global BustIt2 As Integer
Global BustIt3 As Integer
Global BustIt4 As Integer
Global BustIt5 As Integer
Global BustIt6 As Integer
Global BustIt7 As Integer
Global BustIt8 As Integer
Global BustIt9 As Integer
Global BustIt10 As Integer


Global LocateName1 As String
Global LocateName2 As String
Global LocateName3 As String
Global LocateName4 As String
Global LocateName5 As String
Global LocateName6 As String
Global LocateName7 As String
Global LocateName8 As String
Global LocateName9 As String
Global LocateName10 As String

Global InsultNum1 As String
Global InsultNum2 As String
Global InsultNum3 As String
Global InsultNum4 As String
Global InsultNum5 As String
Global InsultNum6 As String
Global InsultNum7 As String
Global InsultNum8 As String
Global InsultNum9 As String
Global InsultNum10 As String

Global SInsult1 As Integer
Global SInsult2 As Integer
Global SInsult3 As Integer
Global SInsult4 As Integer
Global SInsult5 As Integer
Global SInsult6 As Integer
Global SInsult7 As Integer
Global SInsult8 As Integer
Global SInsult9 As Integer
Global SInsult10 As Integer

Sub Pause (ByVal nSecond As Single)
   Dim t0 As Single
   t0 = Timer
   Do While Timer - t0 < nSecond
      Dim dummy As Integer
      dummy = DoEvents()
      ' if we cross midnight, back up one day
      If Timer < t0 Then
         t0 = t0 - 24 * 60 * 60
      End If
   Loop
End Sub

