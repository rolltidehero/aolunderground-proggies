
Declare Function RemoveMenu Lib "User" (ByVal hMenu As Integer, ByVal nPosition As Integer, ByVal wFlags As Integer) As Integer
Declare Function ShowWindow Lib "User" (ByVal hWnd As Integer, ByVal nCmdShow As Integer) As Integer
Declare Function mciexecute Lib "mmsystem" (ByVal lpstrCommand As String) As Integer
Global Const EW_REBOOTSYSTEM = &H43, EW_RESTARTWINDOWS = &H42
Declare Function SetWindowPos% Lib "user" (ByVal win%, ByVal awin%, ByVal xp%, ByVal yp%, ByVal xs%, ByVal ys%, ByVal FLAGS%)
Declare Function SetMenu Lib "User" (ByVal hWnd As Integer, ByVal hMenu As Integer) As Integer


'Declare Function ShowWindow Lib "User" (ByVal hWnd As Integer, ByVal nCmdShow As Integer) As Integer
Declare Function GetParent Lib "User" (ByVal hWnd As Integer) As Integer
Global lParam1 As Long

Global lpstring1 As String
Global AOLMenu As Long
Global MenuThere As Integer
Global TheMenu As Integer
Global SkipPause As Integer
Global AIStatus As Integer
Dim StayOnTop As Integer
Global startout1

Global cryptname
Global ftp(1 To 60) As String
Global LastChat2 As String

Global thiswin4 As Integer

Global LastSaid


     
     Global quit3 As Integer

Global crapocrap As Integer

Global ScreenName As String
Global SignStatus As Integer

Global StopCreate As Integer

Declare Function FindWindow% Lib "user" (ByVal junk&, ByVal Title$)
Declare Function FindChildByTitle% Lib "ole02.dll" (ByVal parent%, ByVal Title$)
Declare Function FindChildByClass% Lib "ole02.dll" (ByVal parent%, ByVal Title$)
Declare Function VBEnumChildWindows% Lib "ole01.dll" (ByVal win%, ByVal iNum%)
Declare Function ExitWindows Lib "User" (ByVal Reserved&, ByVal ReturnCode%) As Integer

Global Const KEY_F3 = &H72

Function BRB (ByVal dook)
GoTo bebe9

titsluck9:
Exit Function


bebe9:

On Error GoTo titsluck9

 thiswin% = FindWindow(0, "America  Online")
 EditHand = FindChildByClass(thiswin%, "_AOL_Edit")
  lint = 200


AppActivate "America  Online"

DoEvents
   lpstring = ". "
   SendFing = SendMessage(EditHand, WM_SETFOCUS, 0, 0)
   DoEvents
   Call Pause(1)

SendKeys ".                {(}  {}}{ENTER}"
SendKeys ".       ===    /\\              Got to take a shit...brb{ENTER}"
SendKeys ".       |    |  /  /\\{ENTER}"
DoEvents
Call Pause(1.5)
DoEvents
SendKeys ".       |__|   L_==n{ENTER}"
SendKeys ".         L|{)}   ||{ENTER}"
SendKeys ".            {)}{(}     |L{ENTER}"
DoEvents

End Function

Function DupeKiller (ByVal dook)
MsgBox "Open your New Mail and wait for hourglass to go away.  Then hit the OK button to this message."
GoTo bob

nect:
Resume nect1


bob:

      thiswin% = FindWindow(0, "America  Online")
      ListHand = FindChildByClass(thiswin%, "_AOL_Tree")
       If ListHand = 0 Then
       MsgBox "You must have your mailbox open.  Bring up your New Mail and try again."
       Exit Function
       End If
DupeKill.Show
DoEvents

  Dim dom As String
   V = 0
   
  T = SendMessage(ListHand, LB_GETCOUNT, 0, 0)

Cur = 0
      ret = Chr$(13) + Chr$(10)
         AppActivate "America  Online"
         DoEvents

For Y = 1 To T
 'SetCur = SendMessage(ListHand, LB_SETCURSEL, Cur, 0)
z = SendMessage(ListHand, LB_GETTEXTLEN, Cur, 0)
lpstring = Space(z)
X = SendMessageByString(ListHand, LB_GETTEXT, Cur, lpstring) ',lint
lpstring = Trim$(lpstring)
Dom1 = InStr(lpstring, "Fwd")
   If Dom1 = 0 Then GoTo nect1
  
dom = Mid$(lpstring, Dom1)

  h = T - Y
  V = Y
 For B = 1 To h
  z = SendMessage(ListHand, LB_GETTEXTLEN, V, 0)
On Error GoTo nect

lpstring = Space(z)
X = SendMessageByString(ListHand, LB_GETTEXT, V, lpstring) ',lint
  lpstring = Trim$(lpstring)
     Dom2 = InStr(lpstring, "Fwd")
      If Dom2 = 0 Then GoTo nect3
      lpstring1 = Mid$(lpstring, Dom2)
                     d1 = V
  If lpstring1 = dom Then
     DupeKill.Label2.Caption = "Found duplicate ware at #" + d1 + ".  Deleting..."
     DupeKill.Label2.Refresh
     NewMail = FindChildByTitle(thiswin%, "New Mail")
     DeleteButton = FindChildByTitle(thiswin%, "Delete")
     SetCur = SendMessage(ListHand, LB_SETCURSEL, V, 0)
     DoEvents
     DupeKill.VBMsg1.SubClasshWnd = DeleteButton
     DupeKill.VBMsg1.SendMessage = WM_LBUTTONDOWN
     DupeKill.VBMsg1.SendMessage = WM_LBUTTONUP
     DoEvents
    End If

nect3:

    V = V + 1
   Next B

nect1:
Cur = Y
DupeKill.Percent1.Percent = Y / T * 100
DupeKill.Percent1.Refresh

Next Y
 Unload DupeKill

End Function

Function Flame (ByVal dook)
GoTo bebe8

titsluck8:
Exit Function


bebe8:
     Flamer = InputBox$("Enter person to flame.", "Flame Who?")
     

On Error GoTo titsluck8

 thiswin% = FindWindow(0, "America  Online")
 EditHand = FindChildByClass(thiswin%, "_AOL_Edit")
  lint = 200


AppActivate "America  Online"

DoEvents
   lpstring = ". "
   SendFing = SendMessage(EditHand, WM_SETFOCUS, 0, 0)
   DoEvents
   Call Pause(1)


SendKeys ". {ENTER}"
SendKeys ".                                   ;      {ENTER}"
SendKeys ".    .--. /                       ;';    {ENTER}"
DoEvents
Call Pause(1.5)
DoEvents
SendKeys ".  _,|_{(}|                        ;''';    {ENTER}"
SendKeys ". | | {(}\__ ____                 ;''';     {ENTER}"
SendKeys ". | |  \--|_.-'""""""xxxx      ;''''';         O  <---" + Flamer + "{ENTER}"
DoEvents
Call Pause(1.5)
DoEvents
SendKeys ". `-'\ /                xxxxxx;;''''';;  \_|_/ {ENTER}"
SendKeys ".    | |                   xx;;''''''';;        | {ENTER}"
SendKeys ".    | |_                     ;;;;;;;;;     / \{ENTER}"
DoEvents
Call Pause(1.5)
DoEvents
SendKeys ".    `--'  {ENTER}"

End Function

Function KTEncrypt (ByVal password, ByVal strng, force%)

  'Set error capture routine
  On Local Error GoTo ErrorHandler

  
  'Is there Password??
  If Len(password) = 0 Then Error 31100
  
  'Is password too long
  If Len(password) > 255 Then Error 31100

  'Is there a strng$ to work with?
  If Len(strng) = 0 Then Error 31100

  
  'Check if file is encrypted and not forcing
  If force% = 0 Then
    
    'Check for encryption ID tag
    chk$ = Left$(strng, 4) + Right$(strng, 4)
    
    If chk$ = Chr$(1) + "KT" + Chr$(1) + Chr$(1) + "KT" + Chr$(1) Then
      
      'Remove ID tag
      strng = Mid$(strng, 5, Len(strng) - 8)
      
      'String was encrypted so filter out CHR$(1) flags
      look = 1
      Do
        look = InStr(look, strng, Chr$(1))
        If look = 0 Then
          Exit Do
        Else
          Addin$ = Chr$(Asc(Mid$(strng, look + 1)) - 1)
          strng = Left$(strng, look - 1) + Addin$ + Mid$(strng, look + 2)
        End If
        look = look + 1
      Loop
      
      'Since it is encrypted we want to decrypt it
      EncryptFlag% = False
    
    Else
      'Tag not found so flag to encrypt string
      EncryptFlag% = True
    End If
  Else
    'force% flag set, ecrypt string regardless of tag
    EncryptFlag% = True
  End If
    


  'Set up variables
  PassUp = 1
  PassMax = Len(password)
  
  
  'Tack on leading characters to prevent repetative recognition
  password = Chr$(Asc(Left$(password, 1)) Xor PassMax) + password
  password = Chr$(Asc(Mid$(password, 1, 1)) Xor Asc(Mid$(password, 2, 1))) + password
  password = password + Chr$(Asc(Right$(password, 1)) Xor PassMax)
  password = password + Chr$(Asc(Right$(password, 2)) Xor Asc(Right$(password, 1)))
  
  
  'If Encrypting add password check tag now so it is encrypted with string
  If EncryptFlag% = True Then
    strng = Left$(password, 3) + Format$(Asc(Right$(password, 1)), "000") + Format$(Len(password), "000") + strng
  End If
  
  'Loop until scanned though the whole string
  For Looper = 1 To Len(strng)

    'Alter character code
    ToChange = Asc(Mid$(strng, Looper, 1)) Xor Asc(Mid$(password, PassUp, 1))

    'Insert altered character code
    Mid$(strng, Looper, 1) = Chr$(ToChange)
    
    'Scroll through password string one character at a time
    PassUp = PassUp + 1
    If PassUp > PassMax + 4 Then PassUp = 1
      
  Next Looper

  'If encrypting we need to filter out all bad character codes (0, 10, 13, 26)
  If EncryptFlag% = True Then
    'First get rid of all CHR$(1) since that is what we use for our flag
    look = 1
    Do
      look = InStr(look, strng, Chr$(1))
      If look > 0 Then
        strng = Left$(strng, look - 1) + Chr$(1) + Chr$(2) + Mid$(strng, look + 1)
        look = look + 1
      End If
    Loop While look > 0

    'Check for CHR$(0)
    Do
      look = InStr(strng, Chr$(0))
      If look > 0 Then strng = Left$(strng, look - 1) + Chr$(1) + Chr$(1) + Mid$(strng, look + 1)
    Loop While look > 0

    'Check for CHR$(10)
    Do
      look = InStr(strng, Chr$(10))
      If look > 0 Then strng = Left$(strng, look - 1) + Chr$(1) + Chr$(11) + Mid$(strng, look + 1)
    Loop While look > 0

    'Check for CHR$(13)
    Do
      look = InStr(strng, Chr$(13))
      If look > 0 Then strng = Left$(strng, look - 1) + Chr$(1) + Chr$(14) + Mid$(strng, look + 1)
    Loop While look > 0

    'Check for CHR$(26)
    Do
      look = InStr(strng, Chr$(26))
      If look > 0 Then strng = Left$(strng, look - 1) + Chr$(1) + Chr$(27) + Mid$(strng, look + 1)
    Loop While look > 0

    'Tack on encryted tag
    strng = Chr$(1) + "KT" + Chr$(1) + strng + Chr$(1) + "KT" + Chr$(1)

  Else
    
    'We decrypted so ensure password used was the correct one
    If Left$(strng, 9) <> Left$(password, 3) + Format$(Asc(Right$(password, 1)), "000") + Format$(Len(password), "000") Then
      'Password bad cause error
      Error 31100
    Else
      'Password good, remove password check tag
      strng = Mid$(strng, 10)
    End If

  End If


  'Set function equal to modified string
  KTEncrypt = strng
  

  'Were out of here
  Exit Function


ErrorHandler:
  
  'We had an error!  Were out of here
  Exit Function

End Function

Function MacKill (ByVal dook)
GoTo bebe19

titsluck19:
Exit Function


bebe19:

On Error GoTo titsluck19

 thiswin% = FindWindow(0, "America  Online")
 EditHand = FindChildByClass(thiswin%, "_AOL_Edit")
  lint = 200


AppActivate "America  Online"

DoEvents
   lpstring = ". "
   SendFing = SendMessage(EditHand, WM_SETFOCUS, 0, 0)
   DoEvents
   'Call Pause(1)
   lpstring = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    d = SendMessageByString(EditHand, WM_SETTEXT, lint, lpstring)
    DoEvents
    DoEvents

  '  Call Pause(1)
    'SendKeys "{ENTER}"
   lpstring = "@@@@@@@@@@@@@@@@@@@@AOHell Macro Killer@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    d = SendMessageByString(EditHand, WM_SETTEXT, lint, lpstring)
    DoEvents
    DoEvents
    Call Pause(.2)
    SendKeys "{ENTER}"
    DoEvents
    Call Pause(1)
    lpstring = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    d = SendMessageByString(EditHand, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.2)
    SendKeys "{ENTER}"

End Function

Function MiddleMac (ByVal dook)
If SignStatus = 0 Then

MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Function
End If

GoTo bebe5

titsluck6:
Exit Function


bebe5:

On Error GoTo titsluck6

 thiswin% = FindWindow(0, "America  Online")
 EditHand = FindChildByClass(thiswin%, "_AOL_Edit")
  lint = 200


AppActivate "America  Online"

DoEvents
   lpstring = ". "
   SendFing = SendMessage(EditHand, WM_SETFOCUS, 0, 0)
   DoEvents
   Call Pause(1.1)
SendKeys ". {ENTER}"
SendKeys ". {ENTER}"
SendKeys ".                               ___{ENTER}"
DoEvents
Call Pause(1.5)
DoEvents
SendKeys ".                              /      \{ENTER}"
SendKeys ".                              | ----- |{ENTER}"
SendKeys ".                              |       |{ENTER}"
DoEvents
Call Pause(1.5)
DoEvents
SendKeys ".                              |       |{ENTER}"
SendKeys ".                              |       |{ENTER}"
SendKeys ".                      ___   |       |  __{ENTER}"
DoEvents
Call Pause(1.5)
DoEvents
SendKeys ".                     /      \ |       | /     \   ___{ENTER}"
SendKeys ".       ___        |         |       |         |       \{ENTER}"
SendKeys ".       \-----   \   |         |       |         |        |{ENTER}"
DoEvents
Call Pause(1.5)
DoEvents
SendKeys ".        \-----   \  | {(}   {)}     {(}   {)}    {(}   {)}  |        |{ENTER}"
SendKeys ".         \        \ |                                    |{ENTER}"
SendKeys ".          \                                              |{ENTER}"
DoEvents
Call Pause(1.5)
SendKeys ".           \                                            /{ENTER}"
  


ending2:

End Function

