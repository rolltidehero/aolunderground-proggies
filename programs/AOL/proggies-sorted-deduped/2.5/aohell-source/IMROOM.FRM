VERSION 2.00
Begin Form IMRoom 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "IM the Room"
   ClientHeight    =   2040
   ClientLeft      =   2190
   ClientTop       =   2025
   ClientWidth     =   4485
   Height          =   2445
   HelpContextID   =   6
   Icon            =   IMROOM.FRX:0000
   Left            =   2130
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   ScaleHeight     =   2040
   ScaleWidth      =   4485
   Top             =   1680
   Width           =   4605
   Begin VBMsg VBMsg2 
      Height          =   420
      Left            =   3480
      MessageCount    =   IMROOM.FRX:0302
      MessageList     =   IMROOM.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   0
      Width           =   420
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   2760
      MessageCount    =   IMROOM.FRX:0502
      MessageList     =   IMROOM.FRX:0504
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   0
      Width           =   420
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&Help"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   3360
      TabIndex        =   4
      Top             =   1560
      Width           =   975
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
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   3360
      TabIndex        =   3
      Top             =   960
      Width           =   975
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Send"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   3360
      TabIndex        =   2
      Top             =   480
      Width           =   975
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1455
      Left            =   120
      MaxLength       =   260
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   480
      Width           =   3135
   End
   Begin Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "Enter Message to Send:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   225
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1920
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
GoTo IMBegin

IMError:
Exit Sub

IMBegin:
On Error GoTo IMError

thiswin% = FindWindow(0, "America  Online")
PeopleList = FindChildByClass(thiswin%, "_AOL_Listbox")

X = SendMessage(PeopleList, LB_GETCOUNT, 0, 0)
        Cur = 0
 AppActivate "America  Online"
 DoEvents
 Call Pause(1)
                  MBox = FindWindow(0, "America Online")
                  If MBox <> 0 Then
                  DoEvents
                  SendKeys "{ENTER}"
                  DoEvents
                  End If

For Y = 1 To X

SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)
Cur = Y
 VBMsg1.SubClasshWnd = PeopleList
 VBMsg1.SendMessage = WM_LBUTTONDBLCLK
 DoEvents
 Call Pause(1.5)
                  MBox = FindWindow(0, "America Online")
                  If MBox <> 0 Then
                  DoEvents
                  SendKeys "{ENTER}"
                  DoEvents
                  End If

 PersonWin = FindChildByTitle(thiswin%, "Message")

 While PersonWin = 0
 DoEvents
 PersonWin = FindChildByTitle(thiswin%, "Message")
 Wend
                  MBox = FindWindow(0, "America Online")
                  If MBox <> 0 Then
                  DoEvents
                  SendKeys "{ENTER}"
                  DoEvents
                  End If

 VBMsg1.SubClasshWnd = PersonWin
 VBMsg1.SendMessage = WM_LBUTTONDOWN
 VBMsg1.SendMessage = WM_LBUTTONUP
 DoEvents
 Call Pause(1)
 InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
 
 While InstantWin = 0
 DoEvents
 InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
 Wend
                  MBox = FindWindow(0, "America Online")
                  If MBox <> 0 Then
                  DoEvents
                  SendKeys "{ENTER}"
                  DoEvents
                  End If

      VBMsg2.SubClasshWnd = InstantWin
      VBMsg2.SendMessage = WM_CHILDACTIVATE
 IMEdit = VBEnumChildWindows(InstantWin, 3)
 lint = 300
 lpstring = Text1.Text
 SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
 DoEvents
 VBMsg2.SendMessage = WM_CHILDACTIVATE
 DoEvents
 SendButton = FindChildByTitle(InstantWin, "Send")
 While SendButton = 0
 DoEvents
 SendButton = FindChildByTitle(InstantWin, "Send")
 Wend
 DoEvents
 VBMsg2.SendMessage = WM_CHILDACTIVATE
 DoEvents
                  MBox = FindWindow(0, "America Online")
                  If MBox <> 0 Then
                  DoEvents
                  SendKeys "{ENTER}"
                  DoEvents
                  End If

 VBMsg1.SubClasshWnd = SendButton
 VBMsg1.SendMessage = WM_LBUTTONDOWN
 VBMsg1.SendMessage = WM_LBUTTONUP
 DoEvents
                  MBox = FindWindow(0, "America Online")
                  If MBox <> 0 Then
                  DoEvents
                  SendKeys "{ENTER}"
                  DoEvents
                  End If

 Call Pause(2)

Next Y

End Sub

Sub Command3D2_Click ()
Unload Me

End Sub

Sub Command3D3_Click ()
SendKeys "{F1}"
DoEvents

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(IMRoom.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(IMRoom.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

