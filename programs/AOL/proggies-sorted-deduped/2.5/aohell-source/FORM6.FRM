VERSION 2.00
Begin Form Form6 
   BackColor       =   &H8000000F&
   BorderStyle     =   0  'None
   ClientHeight    =   2895
   ClientLeft      =   495
   ClientTop       =   2370
   ClientWidth     =   8775
   ControlBox      =   0   'False
   Height          =   3300
   Left            =   435
   LinkTopic       =   "Form6"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2895
   ScaleWidth      =   8775
   Top             =   2025
   Width           =   8895
   Begin SSFrame Frame3D1 
      Caption         =   "Did You Know?"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   2415
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   8295
      Begin CommandButton Command1 
         Height          =   255
         Left            =   7680
         TabIndex        =   3
         Top             =   1560
         Visible         =   0   'False
         Width           =   495
      End
      Begin Init Init1 
         Application     =   ""
         Filename        =   ""
         Height          =   420
         Left            =   7680
         Parameter       =   ""
         Top             =   840
         Value           =   ""
         Width           =   420
      End
      Begin Label Label1 
         BackColor       =   &H8000000F&
         FontBold        =   0   'False
         FontItalic      =   -1  'True
         FontName        =   "Times New Roman"
         FontSize        =   12
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   1815
         Left            =   240
         TabIndex        =   1
         Top             =   480
         Width           =   7935
         WordWrap        =   -1  'True
      End
   End
   Begin SSPanel Panel3D1 
      BevelInner      =   1  'Inset
      BevelWidth      =   3
      BorderWidth     =   4
      Caption         =   "Panel3D1"
      Height          =   2895
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   8775
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command1_Click ()
    Dim WD1 As String * 128  'win directory, because of DLL's return
    Dim WSD1 As String * 128 'system directory, because of DLL's return
    nWSize% = 128
    nSSize% = 128
    
    Wdir% = GetWindowsDirectory(WD1$, nWSize%)'windir
    Sdir% = GetSystemDirectory(WSD1$, nSSize%)'systemdir
    WD$ = RTrim$(LCase$(Left$(WD1$, Wdir%)))
    WSD$ = RTrim$(LCase$(Left$(WSD1$, Sdir%)))


GoTo vaba1

vabaerr:
main.Show
Unload Me
Exit Sub

vaba1:
On Error GoTo vabaerr

If crapocrap = 1 Then Exit Sub

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "AutoLoad"
Dab3 = init1.Value

If Dab3 = "yes" Then

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "WAOL"
Dab4 = init1.Value

X = Shell(Dab4, 1)

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Sounds"
Dab5 = init1.Value
 If Dab5 = "yes" Then
    
   
   main.Show
   
   SoundName$ = WD$ + "\chronic.wav"
   wFlags% = SND_ASYNC And SND_NODEFAULT
   Y% = sndPlaySound(SoundName$, wFlags%)
    
    DoEvents
    Unload Me
   Else
   main.Show
   DoEvents
   Unload Me
   End If

Else
Call Pause(2)
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Sounds"
Dab6 = init1.Value
    If Dab6 = "yes" Then
    main.Show
   SoundName$ = WD$ + "\chronic.wav"
   wFlags% = SND_ASYNC And SND_NODEFAULT
   Z% = sndPlaySound(SoundName$, wFlags%)
    
    DoEvents
    Unload Me
    Else

  
   main.Show
   DoEvents
   Unload Me
  End If

End If

   crapocrap = 1


End Sub

Sub Form_Activate ()
DoEvents
DoEvents
DoEvents
Call Pause(1)
DoEvents
DoEvents
DoEvents
Call Command1_Click
DoEvents

End Sub

Sub Form_Load ()
Randomize

Form6.MousePointer = 11

Dim Success As Integer

Success% = SetWindowPos%(Form6.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2
upperbound = 35
lowerbound = 1

RandomChoice = Int((upperbound - lowerbound + 1) * Rnd + lowerbound)

If RandomChoice = 1 Then Label1.Caption = "Standard Unix password files are kept in the directory /etc/passwd.  On a Unix system with eitehr NIS/yp or password shadowing, much of the password data may be elsewhere."
If RandomChoice = 2 Then Label1.Caption = "The best cracking program for Unix passwords is currently Crack by Alec Muffett.  For PC-DOS, the best package to use is currently CrackerJack."
If RandomChoice = 3 Then Label1.Caption = "Password shadowing is a security system where the encrypted password field of /etc/password is replaced with a special token and the encrypted password is stored in a seperate file which is not readable by normal users."
If RandomChoice = 4 Then Label1.Caption = "Under VMS, the password file is SYS$SYSTEM:SYSUAF.DAT.  Unlike Unix, most users do not have access to read the password file.  To crack this file, you need to write a prgoram that uses the SYS$GETUAF functions to compare the results of encrypted words against the encrypted data in SYSUAF.DAT."
If RandomChoice = 5 Then Label1.Caption = "On poorly implemented restricted shells, you can break out of the restricted environment by running a program that features a shell function.  A good example is vi.  Run vi and use this command: "":set shell=/bin/sh"" then shell using this command: "":shell"""
If RandomChoice = 6 Then Label1.Caption = "You can erase your presence from the system logs in Unix by editing /etc/utmp, /usr/adm/wtmp, and /usr/adm/lastlog.  These are not text files that can be edited by hand with vi, you must use a program specifically written for this purpose."
If RandomChoice = 7 Then Label1.Caption = "You can hack Ops on IRC by finding a server that is split from the rest of IRC, and creating your own channel there using the name of the channel you want Ops on.  When that server reconnects to the net, you will have Ops on the real channel.  If you have ServerOp on a server, you can cause it to split on purpose."
If RandomChoice = 8 Then Label1.Caption = "You can modify your IRC client to hide your real username by getting the IRC client from cs.bu.edu /irc/clients, and looking at the source code files irc.c and ctcp.c.  The code you are looking for is fairly easy to spot.  Change it.  Change the username code in irc.c and the ctcp information code in ctcp.c.  Compile and run your client."
If RandomChoice = 9 Then Label1.Caption = "Ethernet sniffing is listening (with software) to the raw ethernet device packets that interest you.  When your software sees a packet that fits a certain criteria, it logs it to a file.  The most common criteria for an interesting packet is one that contains words like ""login"" or ""password."""
If RandomChoice = 10 Then Label1.Caption = "An Internet outdial is a modem connected to the Internet that you can use to dial out.  Normal outdials will only call local numbers.  A GOD (Global OutDial) is capable of calling long distance.  These are particularly good for calling LD BBS's"
If RandomChoice = 11 Then Label1.Caption = "On IRC, you can prevent being flashed by typing ""/exec mesg n"" or, before you start IRC, type ""mesg n""."
If RandomChoice = 12 Then Label1.Caption = "A Virus is a code fragment (not an independent program) that reproduces by attaching to another program.  It may damage data directly, or it may degrade system performance by taking over the system resources which are then not available to authorized users."
If RandomChoice = 13 Then Label1.Caption = "A Worm is an independent program that reproduces by copying itself from one system to another, usually over a network.  Like a virus, a worm may damage data directly, or it may degrade system performance by tying up system resources and even shutting down a network."
If RandomChoice = 14 Then Label1.Caption = "A Red Box is a device that simulates tones that are emitted when a coin is inserted into a payphone, with the purpose of fooling the payphone into believing you have inserted an actual coin.  The actual tones are:  Nickel: 1700+2200 0.060s on - Dime: 1700+2200 0.060s on, 0.060s off, twice repeating - Quarter: 1700+2200 33ms on, 33ms off, 5 times repeating."
If RandomChoice = 15 Then Label1.Caption = "Blue boxes use 2600hz tone to convince telepone switches that use in-band signalling that the caller is actually a telephone operator.  The caller may then access special switch functions, with the usual purpose of making free long distance phone calls."
If RandomChoice = 16 Then Label1.Caption = "A Black Box is a 1.8k ohm resistor placed across your phone line to cause the phone company equipment to be unable to detect that you have answered your telephone.  People who call you will then not be billed for the call.  Black boxes do not work under ESS out-of-band signalling."
If RandomChoice = 17 Then Label1.Caption = "An Acrylic Box steals Three-Way-Calling, Call Waiting, and programmable Call Forwarding on old 4-wire phone systems."
If RandomChoice = 18 Then Label1.Caption = "An Aqua Box drains voltage of the FBI lock-in-trace/trap-trace devices, used to trace phone calls, even after the caller has hung up."
If RandomChoice = 19 Then Label1.Caption = "A Beige Box is a lineman's hand set, or similar device with the same function."
If RandomChoice = 20 Then Label1.Caption = "A Blast box is a phone micropohne amplifier"
If RandomChoice = 21 Then Label1.Caption = "A Blotto Box supposedly shorts every phone out, in the immediate area."
If RandomChoice = 22 Then Label1.Caption = "A Brown Box creates a party line from 2 phone lines."
If RandomChoice = 23 Then Label1.Caption = "A Bud Box taps into your neighbors phone line."
If RandomChoice = 24 Then Label1.Caption = "A divertor box is used to re-route outgoing or incoming calls to another phone."
If RandomChoice = 25 Then Label1.Caption = "A Gold Box can trace calls, tell if a call is being traced, and can change a trace.  -- Something we'd all find useful, I'm sure"
If RandomChoice = 26 Then Label1.Caption = "A Green box can emulate the Coin Collect, Coin Return, and Ringback tones."
If RandomChoice = 27 Then Label1.Caption = "An ANAC (Automatic Number Announcement Circuit) number is a telephone number that plays back the number of the telephone that called it.  ANAC numbers are convenient if you want to know the phone number of a pair of wires. <G>"
If RandomChoice = 28 Then Label1.Caption = "That in January-March 1994, you could log on to America Online with the screen name ""555555555"" (hence the name ""555 trick"").  When logged on a 555 account, no AOL Guide, or op, nor TOSAdvisor himself could log you off."
If RandomChoice = 29 Then Label1.Caption = "That in January of 1994, the IM interception trick was found.  When this trick was performed, you would then receive every IM that was sent on AOL at that moment.  The trick was done by IMing yourself a € symbol."
If RandomChoice = 30 Then Label1.Caption = "That years ago, the founder of the DownChat trick was noneother than your's truly, Da Chronic.  I named it ""DownChat"" because of the name of the .txt file I wrote explaining it was limited to the DOS naming conventions of 10 chars."
If RandomChoice = 31 Then Label1.Caption = "In October of 1994, there was a trick to make invincible accounts that could not be logged off, like back in the 555 days.  Found by my friend Soul Crusher. "
If RandomChoice = 32 Then Label1.Caption = "You can have AOHell automatically send an IM to people entering the room by selecting Auto-Greet on the AI Bot and choosing the action ""Send IM"""
If RandomChoice = 33 Then Label1.Caption = "You can make AOHell load 6 times faster by editing the AOHELL.INI file located in c:\windows.  Change the entry ""EmergencyStart"" to equal ""yes""."
If RandomChoice = 34 Then Label1.Caption = "AOHell was the first AOL ""hack"" program ever released.  AOHell v1.0 Beta 1 was released in November, 1994."
If RandomChoice = 35 Then Label1.Caption = "AOHell has been mentioned in several newspapers and magazines, including The Boston Globe, a San Francisco paper, Wired, Chicago Tribune, New York Times, Wall Street Journal, and Newsweek."



End Sub

