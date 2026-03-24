VERSION 2.00
Begin Form RoomBust 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Room Buster"
   ClientHeight    =   1395
   ClientLeft      =   2970
   ClientTop       =   735
   ClientWidth     =   3345
   Height          =   1800
   HelpContextID   =   23
   Icon            =   ROOMBUST.FRX:0000
   Left            =   2910
   LinkTopic       =   "Form9"
   MaxButton       =   0   'False
   ScaleHeight     =   1395
   ScaleWidth      =   3345
   Top             =   390
   Width           =   3465
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   1920
      MessageCount    =   ROOMBUST.FRX:0302
      MessageList     =   ROOMBUST.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   840
      Width           =   420
   End
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   1680
      Parameter       =   ""
      Top             =   720
      Value           =   ""
      Width           =   420
   End
   Begin TextBox Text3 
      Height          =   285
      Left            =   1800
      TabIndex        =   8
      Text            =   "300"
      Top             =   360
      Visible         =   0   'False
      Width           =   495
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
      Left            =   2400
      TabIndex        =   5
      Top             =   720
      Width           =   855
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Bust In"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2400
      TabIndex        =   4
      Top             =   240
      Width           =   855
   End
   Begin SSFrame Frame3D2 
      Caption         =   "Name of Private room"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1215
      Left            =   120
      TabIndex        =   3
      Top             =   1440
      Visible         =   0   'False
      Width           =   2175
      Begin TextBox Text1 
         Height          =   285
         Left            =   240
         TabIndex        =   7
         Top             =   360
         Width           =   1695
      End
      Begin Label Label2 
         BackColor       =   &H8000000F&
         Caption         =   "Open up the room list window before starting"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   375
         Left            =   240
         TabIndex        =   10
         Top             =   720
         Width           =   1815
      End
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Type of room"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1095
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1455
      Begin SSOption Option3D3 
         Caption         =   "Pu&blic"
         Height          =   255
         Left            =   360
         TabIndex        =   9
         Top             =   720
         Width           =   975
      End
      Begin SSOption Option3D2 
         Caption         =   "&Member"
         Height          =   255
         Left            =   360
         TabIndex        =   2
         Top             =   240
         Width           =   975
      End
      Begin SSOption Option3D1 
         Caption         =   "&Private"
         Height          =   255
         Left            =   360
         TabIndex        =   1
         Top             =   480
         Width           =   975
      End
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Highlight the room name before hitting                    Bust In"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   615
      Left            =   120
      TabIndex        =   6
      Top             =   1320
      Visible         =   0   'False
      Width           =   1935
      WordWrap        =   -1  'True
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


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
GoTo bustbeg

BustErr:
'MsgBox "An Error has occured.  Cannot continue.", 16, "Error!"
Exit Sub

bustbeg:
  On Error GoTo BustErr

label1.Visible = False
frame3d2.Visible = False
If Not option3d1.Value = True And Not option3d2.Value = True And Not option3d3.Value = True Then
MsgBox "You must choose whether the room is a Regular room or Private room."
Exit Sub
End If

If option3d1.Value = True And Text1.Text = "" Then
MsgBox "You must enter the name of the private room you wish to enter."
GoTo endall
End If

If option3d2.Value = True Then GoTo member
If option3d1.Value = True Then GoTo privat
If option3d3.Value = True Then GoTo public1


member:

AppActivate "America  Online"
DoEvents
Call Pause(.3)

Do
DoEvents
SendKeys "{ENTER}"
 thiswin1% = FindWindow(0, "America Online")
 Crater = 1
 While thiswin1% = 0
 Crater = Crater + 1
 DoEvents
 thiswin1% = FindWindow(0, "America Online")
 If Crater = 2000 Then Exit Sub
 DoEvents
 Wend

Call Pause(.3)

Loop

GoTo endall


privat:
roombust.Height = 1740
thiswin% = FindWindow(0, "America  Online")
PrivateButton = FindChildByTitle(thiswin%, "Private Room")
DoEvents
Call Pause(.2)
If PrivateButton = 0 Then
MsgBox "You must have the room list window open before starting.", 16, "Room List not Open"
Exit Sub
End If
VBMsg1.SubClasshWnd = PrivateButton


AppActivate "America  Online"
DoEvents
Call Pause(.5)
   
For z = 1 To 100
   DoEvents
   VBMsg1.SendMessage = WM_LBUTTONDOWN
   VBMsg1.SendMessage = WM_LBUTTONUP
   DoEvents
   PrivateRoom = FindChildByTitle(thiswin%, "Enter a Private Room")
   Crater = 1
   While PrivateRoom = 0
   Crater = Crater + 1
   If Crater > 2000 Then
   Crater = 0
   Exit Sub
   End If
   DoEvents
   PrivateRoom = FindChildByTitle(thiswin%, "Enter a Private Room")
   DoEvents
   Wend
   Call Pause(.2)
   EditHand9 = FindChildByClass(PrivateRoom, "_AOL_Edit")
   lint = 100
   lpstring = Text1.Text
   a2 = SendMessageByString(EditHand9, WM_SETTEXT, lint, lpstring) ',lint
   DoEvents
   Call Pause(.3)
   SendKeys "{ENTER}"
   DoEvents
   thiswin1% = FindWindow(0, "America Online")
   Crater = 1
   While thiswin1% = 0
   If Crater > 500 Then
   Crater = 0
   Exit Sub
   End If
   DoEvents
   thiswin1% = FindWindow(0, "America Online")
   DoEvents
   Wend
   Call Pause(.3)
   SendKeys "{ENTER}"
   
Next z

GoTo endall

public1:
AppActivate "America  Online"
DoEvents
Call Pause(.3)

  thiswin% = FindWindow(0, "America  Online")
  PublicRoom = FindChildByTitle(thiswin%, "Active Public Rooms")
  DoEvents
  If PublicRoom = 0 Then
  MsgBox "You must have the Public Room list window open before you try to break into a Public room.", 16, "Public Room list not found"
  Exit Sub
  End If

For G = 1 To 100

  SendKeys "{ENTER}"
  DoEvents
  ReEnter = FindChildByTitle(thiswin%, "Untitled")
  Crater = 1
  While ReEnter = 0
  If Crater = 10000 Then
  Crater = 0
  Exit Sub
  End If
  DoEvents
  ReEnter = FindChildByTitle(thiswin%, "Untitled")
  DoEvents
  Wend
  Call Pause(.2)
  NoButton = FindChildByTitle(ReEnter, "No")
  VBMsg1.SubClasshWnd = NoButton
  VBMsg1.SendMessage = WM_LBUTTONDOWN
  VBMsg1.SendMessage = WM_LBUTTONUP
  DoEvents
  Call Pause(.7)
  DoEvents
Next G


endall:
AppActivate "America  Online"
roombust.Height = 1740

End Sub

Sub Command3D2_Click ()
Unload Me

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(roombust.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(roombust.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Option3D1_Click (Value As Integer)
frame3d2.Visible = True
roombust.Height = 3165
label1.Visible = False


End Sub

Sub Option3D2_Click (Value As Integer)
label1.Visible = True
roombust.Height = 2415
frame3d2.Visible = False

End Sub

Sub Option3D3_Click (Value As Integer)
label1.Visible = True
roombust.Height = 2415
frame3d2.Visible = False

End Sub

