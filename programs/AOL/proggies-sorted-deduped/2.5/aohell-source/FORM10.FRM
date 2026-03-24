VERSION 2.00
Begin Form Form10 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "AOHell v3.0   Bug Report"
   ClientHeight    =   4575
   ClientLeft      =   1470
   ClientTop       =   930
   ClientWidth     =   7065
   Height          =   4980
   Icon            =   FORM10.FRX:0000
   Left            =   1410
   LinkTopic       =   "Form10"
   ScaleHeight     =   4575
   ScaleWidth      =   7065
   Top             =   585
   Width           =   7185
   Begin SSOption Option6 
      Caption         =   "Win 95"
      Height          =   255
      Left            =   4800
      TabIndex        =   18
      Top             =   840
      Value           =   -1  'True
      Width           =   975
   End
   Begin SSOption Option5 
      Caption         =   "3.11"
      Height          =   255
      Left            =   3960
      TabIndex        =   17
      TabStop         =   0   'False
      Top             =   840
      Width           =   735
   End
   Begin SSOption Option4 
      Caption         =   "3.1"
      Height          =   255
      Left            =   3120
      TabIndex        =   16
      TabStop         =   0   'False
      Top             =   840
      Width           =   735
   End
   Begin SSOption Option3 
      Caption         =   "Pentium"
      Height          =   255
      Left            =   4800
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   240
      Width           =   1095
   End
   Begin SSOption Option2 
      Caption         =   "486"
      Height          =   255
      Left            =   3960
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   240
      Width           =   735
   End
   Begin SSOption Option1 
      Caption         =   "386"
      Height          =   255
      Left            =   3120
      TabIndex        =   13
      TabStop         =   0   'False
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "Chronic?"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   4320
      TabIndex        =   12
      Top             =   4080
      Width           =   975
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   360
      MessageCount    =   FORM10.FRX:0302
      MessageList     =   FORM10.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   480
      Width           =   420
   End
   Begin SSFrame Frame3D1 
      Height          =   615
      Left            =   1080
      TabIndex        =   10
      Top             =   600
      Width           =   4935
      Begin Line Line4 
         BorderColor     =   &H00C0C0C0&
         BorderWidth     =   3
         X1              =   4920
         X2              =   4920
         Y1              =   120
         Y2              =   600
      End
      Begin Line Line2 
         BorderColor     =   &H00C0C0C0&
         BorderWidth     =   3
         X1              =   0
         X2              =   0
         Y1              =   120
         Y2              =   600
      End
      Begin Line Line1 
         BorderColor     =   &H00C0C0C0&
         BorderWidth     =   3
         X1              =   0
         X2              =   4920
         Y1              =   600
         Y2              =   600
      End
      Begin Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000F&
         Caption         =   "Version of Windows:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   225
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   1710
      End
   End
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   6240
      Parameter       =   ""
      Top             =   4680
      Value           =   ""
      Width           =   420
   End
   Begin TextBox Text8 
      Height          =   855
      Left            =   360
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   1680
      Width           =   6495
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Forget it"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   5520
      TabIndex        =   9
      Top             =   4080
      Width           =   1215
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Send It"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2880
      TabIndex        =   7
      Top             =   4080
      Width           =   1215
   End
   Begin TextBox Text7 
      Height          =   285
      Left            =   6360
      TabIndex        =   8
      Text            =   "3.0"
      Top             =   1320
      Visible         =   0   'False
      Width           =   495
   End
   Begin TextBox Text5 
      Height          =   855
      Left            =   360
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   3120
      Width           =   6495
   End
   Begin TextBox Text4 
      Height          =   285
      Left            =   2040
      TabIndex        =   2
      Top             =   4080
      Width           =   495
   End
   Begin Line Line3 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   1080
      X2              =   5880
      Y1              =   720
      Y2              =   720
   End
   Begin Label Label10 
      BackColor       =   &H8000000F&
      Caption         =   "What you were trying to do at the time of error:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   1320
      Width           =   3855
      WordWrap        =   -1  'True
   End
   Begin Label Label5 
      BackColor       =   &H8000000F&
      Caption         =   "Error that you received:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   2760
      Width           =   2055
   End
   Begin Label Label4 
      BackColor       =   &H8000000F&
      Caption         =   "Amount of RAM:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   4080
      Width           =   1575
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      Caption         =   "Type of computer:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   1200
      TabIndex        =   3
      Top             =   240
      Width           =   1695
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

If Text4.Text = "" Or Text5.Text = "" Or Text8.Text = "" Then
MsgBox "You have not completely filled out this form.", 16, "Bug Report"
Exit Sub
End If

GoTo BugStart

BugErr:
MsgBox "An error has occured while trying to send the Bug Report", 48, "Bug Report Error"
Exit Sub

BugStart:
On Error GoTo BugErr
               ret = Chr$(13) + Chr$(10)

AppActivate "America  Online"
DoEvents

SendKeys "%MC"
DoEvents
Call Pause(1)

     thiswin% = FindWindow(0, "America  Online")
     ComposeHand = FindChildByTitle(thiswin%, "Compose")
     SendButton = VBEnumChildWindows(ComposeHand, 2)
     ToField = VBEnumChildWindows(ComposeHand, 10)
     SubField = VBEnumChildWindows(ComposeHand, 14)
     MsgField = VBEnumChildWindows(ComposeHand, 17)
     VBMsg1.SubClasshWnd = SendButton

lint = 8000

lpstring = "password@anon.penet.fi"
ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)
 DoEvents
lpstring = "Password"
SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring)
 DoEvents
lpstring = "aohell"
MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring)
 DoEvents
 DoEvents
Call Pause(1)
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP
Snap = FindWindow(0, "America Online")
While Snap = 0
DoEvents
Snap = FindWindow(0, "America Online")
DoEvents
Wend
SendKeys "{ENTER}"
DoEvents
Call Pause(1)


SendKeys "%MC"
DoEvents
Call Pause(1.5)

     thiswin% = FindWindow(0, "America  Online")
     ComposeHand = FindChildByTitle(thiswin%, "Compose")
     SendButton = VBEnumChildWindows(ComposeHand, 2)
     ToField = VBEnumChildWindows(ComposeHand, 10)
     SubField = VBEnumChildWindows(ComposeHand, 14)
     MsgField = VBEnumChildWindows(ComposeHand, 17)
     VBMsg1.SubClasshWnd = SendButton


lint = 8000
lpstring = "anon@anon.penet.fi"
ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)
 DoEvents
lpstring = "Bug Report"
SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring)
 DoEvents

lpstring = "X-Anon-Password: aohell" + ret + "X-Anon-To: an211669" + ret + ret + "Screen Name:     " + ScreenName + ret + ret + "Type of Computer" + ret + "*************************" + ret + ret
If Option1.Value = True Then
lpstring = lpstring + "386" + ret + ret
End If
If Option2.Value = True Then
lpstring = lpstring + "486" + ret + ret
End If
If Option3.Value = True Then
lpstring = lpstring + "586 Pentium" + ret + ret
End If
lpstring = lpstring + "Version of Windows" + ret + "*****************************" + ret + ret
If Option4.Value = True Then
lpstring = lpstring + "3.1" + ret + ret
End If
If Option5.Value = True Then
lpstring = lpstring + "3.11" + ret + ret
End If
If Option6.Value = True Then
lpstring = lpstring + "Windows '95" + ret + ret
End If
                                               
lpstring = lpstring + "Amount of RAM" + ret + "***********************" + ret + ret + Text4.Text + ret + ret
lpstring = lpstring + "What I was trying to do" + ret + "*********************************" + ret + ret + Text8.Text + ret + ret + "The Error that occured was" + ret + "***************************************" + ret + ret + Text5.Text + ret + ret + "                         AOHell 95 v3.0 b5 Bug Report"
                                                                                                                                                                         

MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring)
 DoEvents
Call Pause(2)
DoEvents
VBMsg1.SendMessage = WM_LBUTTONDOWN
VBMsg1.SendMessage = WM_LBUTTONUP






endall:

Unload Me

Endall1:

End Sub

Sub Command3D2_Click ()
Unload Me
AOHell.Show

End Sub

Sub Command3D3_Click ()
IsChron.Show

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(form10.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

