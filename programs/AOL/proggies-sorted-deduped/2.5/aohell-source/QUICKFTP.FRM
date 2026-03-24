VERSION 2.00
Begin Form QuickFTP 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Quick FTP"
   ClientHeight    =   2310
   ClientLeft      =   3540
   ClientTop       =   4815
   ClientWidth     =   6030
   FontBold        =   -1  'True
   FontItalic      =   0   'False
   FontName        =   "Times New Roman"
   FontSize        =   9.75
   FontStrikethru  =   0   'False
   FontUnderline   =   0   'False
   Height          =   2715
   HelpContextID   =   31
   Icon            =   QUICKFTP.FRX:0000
   Left            =   3480
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2310
   ScaleWidth      =   6030
   Top             =   4470
   Width           =   6150
   Begin SSCheck Check3D1 
      Caption         =   "Ask for &Login info"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   1560
      Width           =   1815
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   5640
      MessageCount    =   QUICKFTP.FRX:0302
      MessageList     =   QUICKFTP.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   0
      Width           =   420
   End
   Begin MabryTips Tips1 
      BackColor       =   &H0080FFFF&
      Caption         =   "Sample Tip"
      Height          =   240
      Interval        =   2400
      Interval2       =   165
      Left            =   6000
      TipAlignment    =   0  'Cursor
      Top             =   960
      UseTag          =   -1  'True
      Width           =   1035
      XOffset         =   4
      YOffset         =   16
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Site Address"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   855
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   1935
      Begin TextBox Text1 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   120
         TabIndex        =   7
         Top             =   360
         Width           =   1695
      End
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "&Save List"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2160
      TabIndex        =   5
      Top             =   1440
      Width           =   1095
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&Connect to FTP"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   1080
      Width           =   1935
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Delete Site"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2160
      TabIndex        =   3
      Top             =   840
      Width           =   1095
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Add Site"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Top             =   240
      Width           =   1095
   End
   Begin ListBox List1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1980
      Left            =   3480
      TabIndex        =   0
      Tag             =   "Double Click to connect"
      Top             =   240
      Width           =   2415
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      Caption         =   "Quick FTP"
      FontBold        =   -1  'True
      FontItalic      =   -1  'True
      FontName        =   "Times New Roman"
      FontSize        =   13.5
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000080&
      Height          =   375
      Left            =   1800
      TabIndex        =   8
      Top             =   1920
      Width           =   1335
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "AOHell v3.0 "
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   13.5
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000080&
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   1920
      Width           =   1575
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal x%, ByVal y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
GoTo begin5

titfuck5:
MsgBox "Nothing to add!"
Exit Sub

begin5:
If Text1.Text = "" Then GoTo titfuck5
List1.AddItem Text1.Text
Text1.Text = ""

End Sub

Sub Command3D2_Click ()
GoTo begin4

titfuck4:
Exit Sub

begin4:
On Error GoTo titfuck4

List1.RemoveItem List1.ListIndex
Text1.Text = ""



End Sub

Sub Command3D3_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
If Text1.Text = "" Then
MsgBox "Please enter the FTP site address."
Exit Sub
End If

GoTo begin

titfuck:
MsgBox "An error has occured.  Cannot continue."
Exit Sub

begin:
On Error GoTo titfuck
     thiswin% = FindWindow(0, "America  Online")
AppActivate "America  Online"
DoEvents
Call Pause(.7)

'SendKeys "^K"

Test1 = FindChildByTitle(thiswin%, "Site Address")
Test2 = FindChildByTitle(thiswin%, "Anonymous FTP")
Test3 = FindChildByTitle(thiswin%, "File Transfer ")

If Test1 <> 0 Then GoTo OtherSiteWin
If Test2 <> 0 Then GoTo OtherSite
If Test3 <> 0 Then GoTo FileTran


Keyword:

SendKeys Chr$(11)
DoEvents
Call Pause(2)
SendKeys "ftp{ENTER}"
DoEvents
Call Pause(4)

FileTran:

thiswin% = FindWindow(0, "America  Online")
FTPHand = FindChildByTitle(thiswin%, "File Transfer ")
FTPButton = VBEnumChildWindows(FTPHand, 9)

If FTPButton <> 0 Then
VBMsg1.SubClasshWnd = FTPButton
VBMsg1.SendMessage = WM_LBUTTONDOWN
DoEvents
VBMsg1.SendMessage = WM_LBUTTONUP
DoEvents
Call Pause(5.2)
Else GoTo titfuck
End If

OtherSite:
OtherSiteHand = FindChildByTitle(thiswin%, "Other Site")
If OtherSiteHand <> 0 Then
VBMsg1.SubClasshWnd = OtherSiteHand
VBMsg1.SendMessage = WM_LBUTTONDOWN
DoEvents
VBMsg1.SendMessage = WM_LBUTTONUP
DoEvents
Call Pause(5.2)
Else GoTo titfuck
End If

OtherSiteWin:

ConnectButton = FindChildByTitle(thiswin%, "Connect")
LoginInfo = FindChildByTitle(thiswin%, "Ask for login name and password")


If ConnectButton <> 0 Then
SiteEdit = FindChildByClass(thiswin%, "_AOL_Edit")
lint = 1000
lpstring = Text1.Text
x = SendMessageByString(SiteEdit, WM_SETTEXT, lint, lpstring)
DoEvents
Call Pause(1.3)
If Check3D1.Value = True Then
VBMsg1.SubClasshWnd = LoginInfo
VBMsg1.SendMessage = WM_LBUTTONDOWN
DoEvents
VBMsg1.SendMessage = WM_LBUTTONUP
DoEvents
Call Pause(.3)
End If
VBMsg1.SubClasshWnd = ConnectButton
VBMsg1.SendMessage = WM_LBUTTONDOWN
DoEvents
VBMsg1.SendMessage = WM_LBUTTONUP

Else GoTo titfuck
End If

End Sub

Sub Command3D4_Click ()
GoTo begin1

titfuck1:
Close #2
Exit Sub

begin1:
On Error GoTo titfuck1


Open "c:\aohell.ftp" For Output As #2

numftps = List1.ListCount

Write #2, numftps
'jacko1 = List1.List(List1.ListIndex + 1)

'(list1.ListIndex)
'jackass2 = Right(jacko1, 35)

num = 0
 List1.ListIndex = 0

For x = 1 To numftps

'List1.ListIndex = List1.ListIndex + 1

jacko1 = List1.List(List1.ListIndex)
Write #2, jacko1
List1.ListIndex = List1.ListIndex + 1

Next x

Close #2


End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(QuickFTP.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

GoTo begin3:

titfuck3:
Exit Sub

begin3:
 On Error GoTo titfuck3
   
   For xy = 1 To 60
   ftp(xy) = ""
   Next xy

Open "c:\aohell.ftp" For Input As #1
   
Input #1, numberftps
    For y = 1 To numberftps
    Input #1, ftp(y)
    List1.AddItem ftp(y)
    Next y
Close #1


End Sub

Sub List1_Click ()
jacko = List1.List(List1.ListIndex)
jackass = Left(jacko, 35)


Text1.Text = jackass

End Sub

Sub List1_DblClick ()
jacko2 = List1.List(List1.ListIndex)
jackass2 = Left(jacko2, 35)


Text1.Text = jackass2

DoEvents
Call Command3D3_Click

End Sub

