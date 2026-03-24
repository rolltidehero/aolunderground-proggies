VERSION 2.00
Begin Form elite1 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "ELiTE Talker"
   ClientHeight    =   1740
   ClientLeft      =   1440
   ClientTop       =   2055
   ClientWidth     =   6885
   ClipControls    =   0   'False
   Height          =   2145
   Icon            =   ELITE1.FRX:0000
   Left            =   1380
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1740
   ScaleWidth      =   6885
   Top             =   1710
   Width           =   7005
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   5400
      MessageCount    =   ELITE1.FRX:0302
      MessageList     =   ELITE1.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   120
      Width           =   420
   End
   Begin TextBox Text3 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   240
      MaxLength       =   91
      TabIndex        =   6
      Top             =   1200
      Width           =   6495
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Type Here"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   855
      Left            =   240
      TabIndex        =   7
      Top             =   120
      Width           =   3255
      Begin TextBox Text1 
         BackColor       =   &H0080FFFF&
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   360
         TabIndex        =   2
         Top             =   360
         Width           =   2535
      End
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "&Cancel"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   5400
      TabIndex        =   5
      Top             =   720
      Width           =   1335
   End
   Begin TextBox Text2 
      Height          =   315
      Left            =   240
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   5160
      Width           =   4575
   End
   Begin CommonDialog CMDialog1 
      Left            =   7920
      Top             =   2280
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Clear Box"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   3720
      TabIndex        =   1
      Top             =   240
      Width           =   1455
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Send"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   3720
      TabIndex        =   0
      Top             =   720
      Width           =   1455
   End
   Begin Label Label2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "ËLï†ë †@Lkë®"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   5400
      TabIndex        =   3
      Top             =   240
      Width           =   1335
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal x%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
   
GoTo EliteBeg

EliteErr:
GoTo Next1

EliteErr2:
Exit Sub

EliteBeg:
On Error GoTo EliteErr

'If Text4.Text = "wyvern" Then GoTo Valid Else GoTo Wrong
AppActivate "America  Online"
DoEvents
Call Pause(.3)
     thiswin% = FindWindow(0, "America  Online")
     EditHand4 = FindChildByClass(thiswin%, "_AOL_Edit")
     SendHand7 = FindChildByTitle(thiswin%, "Send")
     VBMsg1.SubClasshWnd = SendHand7
lint = 100
lpstring = Text3.Text
EditText = SendMessageByString(EditHand4, WM_SETTEXT, lint, lpstring)
    DoEvents
    Call Pause(.4)
    VBMsg1.SendMessage = WM_LBUTTONDOWN
    VBMsg1.SendMessage = WM_LBUTTONUP
  GoTo Next2

Next1:
 
 SendKeys "{ENTER}"

Next2:
 On Error GoTo EliteErr2

    Text3.Text = ""
    Text1.SetFocus


'Wrong:
'MsgBox "The password you entered is invalid.  This feature is password protected to avoid abuse by lame pricks who have nothing better to do than make other people pissed off because of their miserable existence."

Endall:

End Sub

Sub Command3D2_Click ()
    Text3.Text = ""
    Text1.SetFocus
End Sub

Sub Command3D4_Click ()
    'MsgBox "ELiTE Talker - courtesy of Z00P"
    Unload Me

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(elite1.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
End Sub

Sub Text1_Change ()
    If Text1.Text = "a" Then
	text2.Text = "@"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "A" Then
	text2.Text = "Ã"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "b" Then
	text2.Text = "b"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "B" Then
	text2.Text = "ß"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "c" Then
	text2.Text = "©"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "C" Then
	text2.Text = "Ç"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "d" Then
	text2.Text = "d"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "D" Then
	text2.Text = "Ð"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "e" Then
	text2.Text = "ë"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "E" Then
	text2.Text = "Ë"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "f" Then
	text2.Text = "ƒ"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "F" Then
	text2.Text = "ƒ"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "g" Then
	text2.Text = "g"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "G" Then
	text2.Text = "G"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "h" Then
	text2.Text = "h"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "H" Then
	text2.Text = "|-|"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "i" Then
	text2.Text = "ï"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "I" Then
	text2.Text = "|"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "j" Then
	text2.Text = "j"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "J" Then
	text2.Text = "J"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "k" Then
	text2.Text = "k"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "K" Then
	text2.Text = "K"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "l" Then
	text2.Text = "L"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "L" Then
	text2.Text = "£"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "m" Then
	text2.Text = "m"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "M" Then
	text2.Text = "|\/|"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "n" Then
	text2.Text = "ñ"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "N" Then
	text2.Text = "|\|"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "o" Then
	text2.Text = "ø"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "O" Then
	text2.Text = "Ø"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "p" Then
	text2.Text = "p"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "P" Then
	text2.Text = "P"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "q" Then
	text2.Text = "*q*"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "Q" Then
	text2.Text = "`Q"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "r" Then
	text2.Text = "®"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "R" Then
	text2.Text = "•R•"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "s" Then
	text2.Text = "$"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "S" Then
	text2.Text = "§"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "t" Then
	text2.Text = "†"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "T" Then
	text2.Text = "†"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "u" Then
	text2.Text = "ü"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "U" Then
	text2.Text = "•Ü•"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "v" Then
	text2.Text = "v"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "V" Then
	text2.Text = "\/"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "w" Then
	text2.Text = "vv"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "W" Then
	text2.Text = "\/\/"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "x" Then
	text2.Text = "×"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "X" Then
	text2.Text = "><"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "y" Then
	text2.Text = "ÿ"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "Y" Then
	text2.Text = "¥"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "z" Then
	text2.Text = "z™"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "Z" Then
	text2.Text = "Z"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "*" Then
	text2.Text = "™"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = " " Then
	text2.Text = " "
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "!" Then
	text2.Text = "!"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "=" Then
	text2.Text = "=)"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "'" Then
	text2.Text = "'"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "," Then
	text2.Text = ","
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "?" Then
	text2.Text = "?"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = ":" Then
	text2.Text = ":"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = ";" Then
	text2.Text = ";"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = ")" Then
	text2.Text = ")"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "(" Then
	text2.Text = "("
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "1" Then
	text2.Text = "1"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "2" Then
	text2.Text = "2"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "3" Then
	text2.Text = "3"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "4" Then
	text2.Text = "4"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "5" Then
	text2.Text = "5"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "6" Then
	text2.Text = "6"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "7" Then
	text2.Text = "7"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "8" Then
	text2.Text = "8"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "9" Then
	text2.Text = "9"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "0" Then
	text2.Text = "0"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "\" Then
	text2.Text = "\"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "<" Then
	text2.Text = "<"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = ">" Then
	text2.Text = ">"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "@" Then
	text2.Text = "@"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "#" Then
	text2.Text = "#"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "$" Then
	text2.Text = "$"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "%" Then
	text2.Text = "%"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "^" Then
	text2.Text = "^"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "&" Then
	text2.Text = "&"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "*" Then
	text2.Text = "*"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = "(" Then
	text2.Text = "("
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If
    If Text1.Text = ")" Then
	text2.Text = ")"
	Text1.Text = ""
	Text3.Text = (Text3.Text + text2.Text)
	Text1.SetFocus
    End If








    
End Sub

