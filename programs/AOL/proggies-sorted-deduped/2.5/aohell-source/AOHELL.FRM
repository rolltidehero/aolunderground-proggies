VERSION 2.00
Begin Form AOHell 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "AOHell 95 v3.0 Beta 5  Super Pre-Alpha Hyper Special Turbo Kung-fu Edition"
   ClientHeight    =   1065
   ClientLeft      =   45
   ClientTop       =   270
   ClientWidth     =   9375
   FillColor       =   &H00FFFFFF&
   FontBold        =   -1  'True
   FontItalic      =   0   'False
   FontName        =   "Times New Roman"
   FontSize        =   8.25
   FontStrikethru  =   0   'False
   FontUnderline   =   0   'False
   ForeColor       =   &H00404040&
   Height          =   1470
   HelpContextID   =   10
   Icon            =   AOHELL.FRX:0000
   Left            =   -15
   MaxButton       =   0   'False
   ScaleHeight     =   0.94
   ScaleMode       =   0  'User
   ScaleWidth      =   1.372
   Top             =   -75
   Width           =   9495
   Begin SSPanel Panel3D4 
      BevelWidth      =   0
      BorderWidth     =   0
      Height          =   375
      Left            =   2640
      TabIndex        =   44
      Top             =   720
      Width           =   135
   End
   Begin SSPanel Panel3D3 
      BevelInner      =   1  'Inset
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   0
      TabIndex        =   43
      Top             =   720
      Width           =   2655
   End
   Begin SSCommand Command3D38 
      Caption         =   "Hide "
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   8640
      TabIndex        =   41
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D37 
      Caption         =   "D. Kill"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   8640
      TabIndex        =   40
      Top             =   0
      Width           =   735
   End
   Begin SSPanel Panel3D2 
      BevelWidth      =   0
      BorderWidth     =   0
      Height          =   375
      Left            =   8280
      TabIndex        =   29
      Top             =   720
      Width           =   135
   End
   Begin SSCommand Command3D35 
      Caption         =   "M. List"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   7920
      TabIndex        =   38
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D34 
      Caption         =   "Guide"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   7920
      TabIndex        =   37
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D33 
      Caption         =   "IRC"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   7200
      TabIndex        =   36
      Tag             =   "Internet Relay Chat"
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D32 
      Caption         =   "A. Menu"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   7200
      TabIndex        =   35
      Tag             =   "Add Menu to AOLs Menu"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D29 
      Caption         =   "Count"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   6480
      TabIndex        =   31
      Tag             =   "Count Mail"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D28 
      Caption         =   "Free"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   6480
      TabIndex        =   30
      Tag             =   "Show All Windows"
      Top             =   0
      Width           =   735
   End
   Begin SSPanel dd 
      BevelInner      =   1  'Inset
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2760
      TabIndex        =   13
      Top             =   720
      Width           =   5535
      Begin TextBox Text1 
         Height          =   285
         Left            =   2640
         TabIndex        =   33
         Text            =   "Text1"
         Top             =   360
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VBMsg VBMsg1 
         Height          =   420
         Left            =   3000
         MessageCount    =   AOHELL.FRX:0302
         MessageList     =   AOHELL.FRX:0304
         MessageTypes    =   0  'Selected Messages
         PostDefault     =   0   'False
         Top             =   360
         Width           =   420
      End
   End
   Begin SSPanel Panel3D1 
      BevelInner      =   1  'Inset
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   8400
      TabIndex        =   28
      Top             =   720
      Width           =   975
   End
   Begin Timer Timer1 
      Interval        =   1000
      Left            =   3000
      Top             =   1200
   End
   Begin SSCommand Command3D23 
      Caption         =   "Accnts"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   5760
      TabIndex        =   27
      Tag             =   "AOHell Fake Account Creator"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D27 
      Caption         =   "M Chat"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   5760
      TabIndex        =   26
      Tag             =   "Multi-Task Chat"
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D24 
      Caption         =   "AI Bot"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   5040
      TabIndex        =   23
      Tag             =   "AI Bot"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D22 
      Caption         =   "IMs"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   5040
      TabIndex        =   22
      Tag             =   "IM Manager"
      Top             =   0
      Width           =   735
   End
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   1440
      Parameter       =   ""
      Top             =   1200
      Value           =   ""
      Width           =   420
   End
   Begin SSCommand Command3D17 
      Caption         =   "B. Reprt"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   720
      TabIndex        =   21
      Tag             =   "Bug Report"
      Top             =   0
      Width           =   735
   End
   Begin MabryTips Tips1 
      BackColor       =   &H0080FFFF&
      Caption         =   "Quck FTP"
      Height          =   240
      Interval        =   2200
      Interval2       =   150
      Left            =   360
      TipAlignment    =   0  'Cursor
      Top             =   1200
      UseTag          =   -1  'True
      Width           =   945
      XOffset         =   4
      YOffset         =   16
   End
   Begin SSCommand Command3D21 
      Caption         =   "Mail B."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   2880
      TabIndex        =   20
      Tag             =   "Wicked Bombs"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D16 
      Caption         =   "Options"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   4320
      TabIndex        =   19
      Tag             =   "Turn off sounds, etc..."
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D15 
      Caption         =   "Fisher"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   4320
      TabIndex        =   18
      Tag             =   "PW/CC Fisher"
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D13 
      Caption         =   "Bust In"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   2880
      TabIndex        =   17
      Tag             =   "Break into a room that is full"
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D12 
      Caption         =   "Ghost T"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3600
      TabIndex        =   16
      Tag             =   "Ghost Tools"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D8 
      Caption         =   "Fake F."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3600
      TabIndex        =   15
      Tag             =   "Fake Forward"
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D4 
      Caption         =   "Encrypt"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   720
      TabIndex        =   14
      Tag             =   "AOHell's Encrypter"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D20 
      Caption         =   "ELiTE"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   720
      TabIndex        =   12
      Tag             =   "Talk in weird symbols"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D19 
      Caption         =   "Suggest"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3600
      TabIndex        =   11
      Tag             =   "Send your suggestions"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D18 
      Caption         =   "S. Bot"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   0
      TabIndex        =   10
      Tag             =   "Scrolling Bot"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D14 
      Caption         =   "Fix Mail"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   2160
      TabIndex        =   9
      Tag             =   "Mail Bomb recovery"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D11 
      Caption         =   "CD"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   1440
      TabIndex        =   8
      Tag             =   "CD Player"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D10 
      Caption         =   "Cursor"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   1440
      TabIndex        =   7
      Tag             =   "Get rid of the hourglass"
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D9 
      Caption         =   "C. Wiz"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   1440
      TabIndex        =   6
      Tag             =   "Credit Wizard 1.1"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D7 
      Caption         =   "Mass M."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   5040
      TabIndex        =   5
      Tag             =   "Mass Mail"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D6 
      Caption         =   "Q FTP"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   2160
      TabIndex        =   4
      Tag             =   "Quck FTP"
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D5 
      Caption         =   "Chron?"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D3 
      Caption         =   "Guest F."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   2160
      TabIndex        =   2
      Tag             =   "Guest Fix"
      Top             =   240
      Width           =   735
   End
   Begin SSCommand Command3D2 
      Caption         =   "W. Bot"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   6480
      TabIndex        =   1
      Tag             =   "Warez Bot"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D1 
      Caption         =   "Annoy"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      HelpContextID   =   10
      Left            =   2880
      TabIndex        =   0
      Tag             =   "The annoy features"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D26 
      Caption         =   "N. User"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   4320
      TabIndex        =   25
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D25 
      Caption         =   "About"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   735
   End
   Begin SSCommand Command3D30 
      Caption         =   "Mail R."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   5760
      TabIndex        =   32
      Tag             =   "Mail Room"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D31 
      Caption         =   "R. Menu"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   7200
      TabIndex        =   34
      Tag             =   "Remove AOHell from AOLs Menu"
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D36 
      Caption         =   "Punt"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   7920
      TabIndex        =   39
      Top             =   480
      Width           =   735
   End
   Begin SSCommand Command3D39 
      Caption         =   "UnHide"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   8640
      TabIndex        =   42
      Top             =   480
      Width           =   735
   End
   Begin Menu IMs 
      Caption         =   "IMs"
      Visible         =   0   'False
      Begin Menu mnuIMan 
         Caption         =   "IM &Manager"
      End
      Begin Menu mnuRoom 
         Caption         =   "IM the &Room"
      End
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal CX%, ByVal CY%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command1_Click ()
'Setupwho.Show
AOL% = FindWindow(0, "America  Online")

ab = GetMenu(AOL%)

For T = 1 To 5

d = RemoveMenu(ab, 7, MF_BYPOSITION)
DoEvents
Next T

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en42 Else AOHell.Hide

en42:


End Sub

Sub Command1_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Search for all your friends online, instantly!"

End Sub

Sub Command3D1_Click ()
annoy.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en Else AOHell.Hide

en:

End Sub

Sub Command3D1_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Things to annoy people"

End Sub

Sub Command3D10_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
X = ExitWindows(&H0, 0)

DoEvents
DoEvents
DoEvents

SendKeys "n"


End Sub

Sub Command3D10_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Takes away the hourglass!"
		
End Sub

Sub Command3D11_Click ()
CDPlay.Show


End Sub

Sub Command3D11_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "The AOHell CD Player"

End Sub

Sub Command3D12_Click ()
GoTo GhostBeg

GhostErr:
MsgBox "GHOSTOOL.EXE not found in the AOH directory!  Cannot load Ghost Tools.", 16, "Cannot load Ghost Tools"
Exit Sub


GhostBeg:
On Error GoTo GhostErr

GhostPATH = App.Path + "\ghostool.exe"
X = Shell(GhostPATH, 1)

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en6 Else AOHell.Hide

en6:

End Sub

Sub Command3D12_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "The BEST macro program ever -- the original Ghost Tools"
End Sub

Sub Command3D13_Click ()
roombust.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en8 Else AOHell.Hide

en8:

End Sub

Sub Command3D13_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Busts in room.  For when the room is full."

End Sub

Sub Command3D14_Click ()
Mailfix.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en12 Else AOHell.Hide


en12:

End Sub

Sub Command3D14_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Use this if someone Email bombed you."
 
End Sub

Sub Command3D15_Click ()
'Dim Answer, Msg, Title
 
 'Msg = "This feature may only be used by Anarchists, Hackers, or Warez pups.  Please enter the password."
 'Title = "Fisher Password"
  
   
 '  Answer = InputBox(Msg, Title)

'A$ = "a"
'B$ = "b"
'C$ = "c"
'D$ = "d"
'E$ = "e"
'F$ = "f"
'G$ = "g"
'H$ = "h"
'I$ = "i"
'J$ = "j"
'K$ = "k"
'L$ = "l"
'M$ = "m"
'N$ = "n"
'O$ = "o"
'P$ = "p"
'Q$ = "q"
'R$ = "r"
'S$ = "s"
'T$ = "t"
'U$ = "u"
'V$ = "v"
'W$ = "w"
'X$ = "x"
'Y$ = "y"
'Z$ = "z"
'SP$ = " "

'If Answer = S$ + T$ + E$ + V$ + E$ + SP$ + C$ + A$ + S$ + E$ + SP$ + I$ + S$ + SP$ + A$ + SP$ + F$ + A$ + I$ + R$ + Y$ Then
'GoTo Contin
'Else MsgBox "Password is incorrect.", 16, "Fisher Password"
'Exit Sub
'End If


    
Contin:

phish.Show

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value

If Dab = "yes" Then GoTo en4 Else AOHell.Hide

en4:

End Sub

Sub Command3D15_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Get people's passwords and credit card information"
		
End Sub

Sub Command3D16_Click ()
options.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value

If Dab = "yes" Then GoTo en3 Else AOHell.Hide

en3:

End Sub

Sub Command3D16_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Set the sound settings and other options"

End Sub

Sub Command3D17_Click ()
form10.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en15 Else AOHell.Hide

en15:

End Sub

Sub Command3D17_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Bug Report"

End Sub

Sub Command3D18_Click ()

GoTo bege2
titsluck3:
  aolbot.Show
  Exit Sub

bege2:
      On Error GoTo titsluck3


aolbot.Show
AOHell.Hide
DoEvents

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Sounds"
Dab = init1.Value

If Dab = "yes" Then

  ' SoundName$ = WD + "\ironman.wav"
    

   ' wFlags% = SND_ASYNC And SND_NODEFAULT
    'X% = sndPlaySound(SoundName$, wFlags%)

Else GoTo endall4

End If

endall4:
End Sub

Sub Command3D18_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Totally destroy a chat room with the Scrolling Bot!"

End Sub

Sub Command3D19_Click ()
suggestion.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en7 Else AOHell.Hide

en7:

End Sub

Sub Command3D19_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Send your suggestions to us"

End Sub

Sub Command3D2_Click ()
'MsgBox "This button is reserved for the Warez Bot, which will be a feature in a future AOHell v3.x beta release.  It will let you send and receive warez automatically, without you doing anything.  Much like XDCC on IRC", 16, "Coming Soon!"

GoTo stw

Errstw:
Exit Sub

stw:
On Error GoTo Errstw

If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
   
   WarezBot.Show
   AOHell.Hide


End Sub

Sub Command3D2_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Warez Bot - Offer Packs/Automated MM Lister"

End Sub

Sub Command3D20_Click ()
elite1.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en16 Else AOHell.Hide
en16:

End Sub

Sub Command3D20_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Change what you type into kewl letters"
End Sub

Sub Command3D21_Click ()
ebomb.Show

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en119 Else AOHell.Hide
en119:

End Sub

Sub Command3D21_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Destroy someone's Email box"
		
End Sub

Sub Command3D22_Click ()
   PopupMenu IMs
   


End Sub

Sub Command3D22_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "IM Manager - Have AOHell Auto-answer IMs, and more!"

End Sub

Sub Command3D23_Click ()
GoTo AccountBeg

AccountErr:
MsgBox "ACCOUNT.EXE not found in the AOH directory!  Cannot load the AOHell Fake Account Creator.", 16, "Cannot Load"
Exit Sub


AccountBeg:
On Error GoTo AccountErr

AccountPATH = App.Path + "\account.exe"
X = Shell(AccountPATH, 1)

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en27 Else AOHell.Hide

en27:

End Sub

Sub Command3D23_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
 dd.Caption = "AOH Fake Account Creator -- Create accounts in seconds"

End Sub

Sub Command3D24_Click ()
'If SignStatus = 0 Then
'MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
'Exit Sub
'End If

GoTo Beg9

Err9:
Exit Sub

Beg9:
On Error GoTo Err9

AIBot.Show
DoEvents
AIBot.Timer2.Enabled = False
AOHell.Hide

End Sub

Sub Command3D24_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Artificial Intelligence Chat Room Bot"


End Sub

Sub Command3D25_Click ()
    
GoTo Boob2:


Boob3:
Resume Boob4

Boob2:


On Error GoTo Boob3

    Dim WD1 As String * 128  'win directory, because of DLL's return
    Dim WSD1 As String * 128 'system directory, because of DLL's return
    nWSize% = 128
    nSSize% = 128
    
    Wdir% = GetWindowsDirectory(WD1$, nWSize%)'windir
    Sdir% = GetSystemDirectory(WSD1$, nSSize%)'systemdir
    WD$ = RTrim$(LCase$(Left$(WD1$, Wdir%)))
    WSD$ = RTrim$(LCase$(Left$(WSD1$, Sdir%)))

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Sounds"

 If init1.Value = "yes" Then

   SoundName$ = WD$ + "\chron2.wav"
   wFlags% = SND_ASYNC And SND_NODEFAULT
   X% = sndPlaySound(SoundName$, wFlags%)
 End If

Boob4:

Form5.Show
AOHell.Hide

End Sub

Sub Command3D25_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Credits and Greetings"

End Sub

Sub Command3D26_Click ()
AOHell.Hide
resetsn.Show

End Sub

Sub Command3D26_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Reset your AOL software to New User"

End Sub

Sub Command3D27_Click ()
GoTo harbar

heho:
Exit Sub

harbar:
On Error GoTo heho

If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Oops"
Exit Sub
End If

MultiChat.Show
DoEvents
Call Pause(2)
AOL% = FindWindow(0, "America  Online")
z = ShowWindow(AOL%, 2)
'MultiChat.Show
AOHell.Hide


End Sub

Sub Command3D27_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Multi-Task Chat -- Talk in the chat room anywhere in Windows."
End Sub

Sub Command3D28_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
 
 
 GoTo Freb

ErrFreb:
Exit Sub

Freb:
On Error GoTo ErrFreb

  thiswin% = FindWindow(0, "America  Online")

   SendHand1 = VBEnumChildWindows(thiswin%, -1)
   For X = 1 To SendHand1
    rb = VBEnumChildWindows(thiswin%, X)
    z = ShowWindow(rb, 4)
    
   Next X

End Sub

Sub Command3D28_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Show all PAY windows in a FREE area!"

End Sub

Sub Command3D29_Click ()
MsgBox "Open the Mailbox you want AOHell to count (i.e. ""New Mail""), and wait for hour glass to go away.  Then hit the OK button to this message."


thiswin% = FindWindow(0, "America  Online")
PeopleList = FindChildByClass(thiswin%, "_AOL_Tree")

X = SendMessage(PeopleList, LB_GETCOUNT, 0, 0)
	  MsgBox "You have" + Str(X) + " messages in your box."

End Sub

Sub Command3D29_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Counts all the mails in your box, Insantly!"

End Sub

Sub Command3D3_Click ()
RESETSN2.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en11 Else AOHell.Hide

en11:

End Sub

Sub Command3D3_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Guest Fix - Use the Download Manager on a Guest Account!"
		
End Sub

Sub Command3D30_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
  
  
  Text1.Text = ""
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
	   ' ForwardHand = VBEnumChildWindows(MDIClient1, 1)
	 MDIClient1 = FindChildByClass(thiswin%, "MDIClient")

For Y = 1 To X

SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)
Cur = Y
 VBMsg1.SubClasshWnd = PeopleList
 VBMsg1.SendMessage = WM_LBUTTONDBLCLK
 DoEvents
 Call Pause(.01)

 UserNam = VBEnumChildWindows(MDIClient1, 1)
lint = 10000 '7500
lpstring = Space(10000)

z = SendMessageByString(UserNam, WM_GETTEXT, lint, lpstring) ',lint
 lpstring = Trim$(lpstring)
 Text1.Text = Text1.Text + ", " + lpstring
Leng = Len(DaSting)

Next Y
  cbt = Text1.Text
  cbt = Mid$(cbt, 3)
  cbt1 = InStr(1, cbt, ScreenName)
  If cbt1 > 0 Then
      fob = Len(ScreenName)
      fob = fob + 2
      gog1 = cbt1 + fob
      chank1 = cbt1
      chank2 = Mid$(cbt, 1, chank1)
      chank3 = Mid$(cbt, gog1)
      Text1.Text = chank2 + chank3

SendKeys "%MC"
DoEvents
Call Pause(1.5)
	ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
	SendButton2 = VBEnumChildWindows(ComposeHand, 2)
	ToField = VBEnumChildWindows(ComposeHand, 10)
	SubField = VBEnumChildWindows(ComposeHand, 14)
	MsgField = VBEnumChildWindows(ComposeHand, 17)
       

lint = 20000 '7500
lpstring = Text1.Text

ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring) ',lint

  End If


End Sub

Sub Command3D30_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Mail everyone in the Room."

End Sub

Sub Command3D31_Click ()
AOHell.Hide
AppActivate "America  Online"
DoEvents

AOL% = FindWindow(0, "America  Online")

ab = GetMenu(AOL%)

For T = 1 To 10

d = RemoveMenu(ab, 6, MF_BYPOSITION)
DoEvents
Next T
 Call DrawMenuBar(AOL%)
DoEvents

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en52 Else AOHell.Hide

en52:
MenuThere = 0

End Sub

Sub Command3D31_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Remove AOHell from AOLs Menu"

End Sub

Sub Command3D32_Click ()
If Not MenuThere = 1 Then
AOHell.Hide
 AppActivate "America  Online"
 DoEvents

AOL% = FindWindow(0, "America  Online")
ab1 = GetMenu(AOL%)

For T = 1 To 10

D1 = RemoveMenu(ab1, 6, MF_BYPOSITION)
 Call DrawMenuBar(AOL%)
DoEvents
Next T

 Call DrawMenuBar(AOL%)
DoEvents

DoEvents
i = CreateMenu()
  C = AppendMenu(i, 0, 601, "&About AOHell 95")
  C = AppendMenu(i, 0, 602, "Is it &Chronic?")
  C = AppendMenu(i, 0, 603, "&Bug Report")
  C = AppendMenu(i, 0, 604, "The &Encrypter")
  C = AppendMenu(i, 0, 605, "Elite &Talker")
  C = AppendMenu(i, 0, 606, "&Get Cursor")
  C = AppendMenu(i, 0, 607, "CD &Player")
  C = AppendMenu(i, 0, 608, "Credit &Wizard v1.1")
  C = AppendMenu(i, 0, 628, "&Account Creator v1.0")
  C = AppendMenu(i, 0, 609, "&Quick FTP")
  C = AppendMenu(i, 0, 610, "G&uest Fix")
  C = AppendMenu(i, 0, 611, "Bust &In a Room")
  C = AppendMenu(i, 0, 612, "G&host Tools")
  C = AppendMenu(i, 0, 613, "S&uggestion")
  C = AppendMenu(i, 0, 614, "PW/CC &Fisher")
  C = AppendMenu(i, 0, 615, "AOHell &Options")
  C = AppendMenu(i, 0, 616, "Reset &New User")
  C = AppendMenu(i, 0, 617, "MT Chat &Room")
  C = AppendMenu(i, 0, 641, "&Internet Relay Chat")
  C = AppendMenu(i, 0, 618, "&Show All Windows")
  C = AppendMenu(i, 0, 627, "E&xit AOHell 95")
  

  AOL% = FindWindow(0, "America  Online")
ab = GetMenu(AOL%)
  TheMenu = ab
' y = AppendMenu(ab, 0, 600, "-==AOHell==-")
 X = AppendMenu(ab, MF_POPUP, i, "-==&AOHell 95==-")
 Call DrawMenuBar(AOL%)
DoEvents
j = CreateMenu()
  d = AppendMenu(j, 0, 619, "The &Warez Bot")
  d = AppendMenu(j, 0, 620, "The &AI Bot")
  d = AppendMenu(j, 0, 621, "The &Scrolling Bot")
 B = AppendMenu(ab, MF_POPUP, j, "&Bots")
Call DrawMenuBar(AOL%)
DoEvents
k = CreateMenu()
  e = AppendMenu(k, 0, 622, "&Mass Mailer")
  e = AppendMenu(k, 0, 623, "Mail the &Room")
  e = AppendMenu(k, 0, 624, "&Count Mail")
 ' e = AppendMenu(k, MF_SEPARATOR, 0, "-")
  e = AppendMenu(k, 0, 625, "Mail &Bomber")
  e = AppendMenu(k, 0, 626, "Fa&ke Forward")
  e = AppendMenu(k, 0, 629, "&Fix Your Mail")
 C = AppendMenu(ab, MF_POPUP, k, "Mail &Utils")
Call DrawMenuBar(AOL%)
DoEvents
l = CreateMenu()
  h = AppendMenu(l, 0, 630, "&IM Manager")
  h = AppendMenu(l, 0, 631, "&IM the &Room")
'  h = AppendMenu(l, MF_SEPARATOR, 0, "-")
  h = AppendMenu(l, 0, 632, "Turn IMs &Off")
  h = AppendMenu(l, 0, 633, "Turn IMs O&n")
 d = AppendMenu(ab, MF_POPUP, l, "&IMs")
Call DrawMenuBar(AOL%)
DoEvents
m = CreateMenu()
 o = AppendMenu(m, 0, 634, "&Insult Macros")
 o = AppendMenu(m, 0, 635, "&Drive Hell")
 o = AppendMenu(m, 0, 636, "&Shoot Someone")
 o = AppendMenu(m, 0, 637, "The &Dice Scroller")
' o = AppendMenu(m, MF_SEPARATOR, 0, "-")
 o = AppendMenu(m, 0, 638, "Middle &Finger Macro")
 o = AppendMenu(m, 0, 639, "Flame &Thrower Macro")
 o = AppendMenu(m, 0, 640, "&Be Right Back Macro")
Q = AppendMenu(ab, MF_POPUP, m, "A&nnoy Options")
Call DrawMenuBar(AOL%)
DoEvents
  MenuThere = 1
End If
 Call DrawMenuBar(AOL%)
DoEvents

End Sub

Sub Command3D32_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Add AOHells Menu to AOLs Menu"

End Sub

Sub Command3D33_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Oops"
Exit Sub
End If


GoTo mIRCBeg

mterr:
Resume bar1

mIRCErr:
MsgBox "MIRC.EXE not found in the AOH\MIRC directory!  Cannot start IRC.", 16, "Cannot Load IRC"
Exit Sub


mIRCBeg:
On Error GoTo mIRCErr

Response = MsgBox("Would you like to start the Multi-Task Chat Room so you can talk on AOL and IRC at the same time?", 292, "Start Multi-Task Chat Room?")
'Possible Response values: 6--YES, 7--NO.
If Response = 6 Then
 On Error GoTo mterr:
MultiChat.Show
DoEvents
DoEvents
Call Pause(2)
AOL% = FindWindow(0, "America  Online")
z = ShowWindow(AOL%, 2)


End If

bar1:
 DoEvents

mIRCPATH = App.Path + "\mirc.exe"
X = Shell(mIRCPATH, 1)
'MsgBox mIRCPATH
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo enmIRC Else AOHell.Hide

enmIRC:

End Sub

Sub Command3D33_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Internet Relay Chat (requires AOL 2.5 or higher)"

End Sub

Sub Command3D34_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Oops"
Exit Sub
End If

    TempName1 = ScreenName
C1 = "D"

thiswin% = FindWindow(0, "America  Online")
  find14% = FindChildByTitle(thiswin%, "Welcome,")
    DoEvents

lint = 50 '7500
C2 = "C"

lpstring = "Welcome, Guide " + C1 + C2 + "!"

X = SendMessageByString(find14%, WM_SETTEXT, lint, lpstring) ',lint
	DoEvents

GoTo IVYBeg


IVYErr:
MsgBox "Error - Cannot run Guide software!  Sign off, then back on, restart AOHell, and try again!", 16, "Cannot Start Guide Software"
Exit Sub


IVYBeg:
    Dim WD1 As String * 128 'win directory, because of DLL's return
    Dim WSD1 As String * 128    'system directory, because of DLL's return
    nWSize% = 128
    nSSize% = 128

    Wdir% = GetWindowsDirectory(WD1$, nWSize%)  'windir
    Sdir% = GetSystemDirectory(WSD1$, nSSize%)  'systemdir
    WD$ = RTrim$(LCase$(Left$(WD1$, Wdir%)))
    WSD$ = RTrim$(LCase$(Left$(WSD1$, Sdir%)))

IVYPATH = WD$ + "\WINFILE1.EXE"
X = Shell(IVYPATH, 1)
'MsgBox mIRCPATH
thiswin2% = FindWindow(0, "IVY Macros")
While thiswin2% = 0
DoEvents
thiswin2% = FindWindow(0, "IVY Macros")
DoEvents
Wend
DoEvents
DoEvents
Call Pause(3)
DoEvents
DoEvents
Call Pause(3)
DoEvents
DoEvents
Call Pause(3)
DoEvents
Call Pause(1)


lpstring = "Welcome, " + TempName1 + "!"

X = SendMessageByString(find14%, WM_SETTEXT, lint, lpstring) ',lint

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo endIVY Else AOHell.Hide

endIVY:


End Sub

Sub Command3D34_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "The REAL Guide software - IVY Macros"

End Sub

Sub Command3D35_Click ()
GoTo GathBeg

GathErr:
Exit Sub

GathBeg:
On Error GoTo GathErr

MsgBox "Open your New Mail and wait for hourglass to go away.  Then hit the OK button to this message."

      thiswin% = FindWindow(0, "America  Online")
      ListHand = FindChildByClass(thiswin%, "_AOL_Tree")


  T = SendMessage(ListHand, LB_GETCOUNT, 0, 0)

Cur = 0
      ret = Chr$(13) + Chr$(10)

For Y = 1 To T
 'SetCur = SendMessage(ListHand, LB_SETCURSEL, Cur, 0)
z = SendMessage(ListHand, LB_GETTEXTLEN, Cur, 0)
lpstring = Space(z)
X = SendMessageByString(ListHand, LB_GETTEXT, Cur, lpstring) ',lint
lpstring = Trim$(lpstring)
TheString = TheString + ret + lpstring
Cur = Y
Next Y
Clipboard.SetText TheString
DoEvents
AppActivate "America  Online"
DoEvents
SendKeys Chr$(14)
DoEvents
Call Pause(.2)
SendKeys Chr$(22)

End Sub

Sub Command3D35_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Instantly make a list of all the mail in your box"

End Sub

Sub Command3D36_Click ()
Punt.Show
AOHell.Hide

End Sub

Sub Command3D36_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Punt someone offline"

End Sub

Sub Command3D37_Click ()
AOHell.Hide

LT2 = DupeKiller(IsDil)

End Sub

Sub Command3D37_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Dupelicate Warez Killer"

End Sub

Sub Command3D38_Click ()
    AOHell.Hide

    AOL% = FindWindow(0, "America  Online")
    ab1 = GetMenu(AOL%)
	AOLMenu = ab1



    DoEvents
    f = CreateMenu()
    C = SetMenu(AOL%, f)
    
    Call DrawMenuBar(AOL%)

End Sub

Sub Command3D38_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Hide AOLs menu to give you more space"

End Sub

Sub Command3D39_Click ()
    AOHell.Hide
    AOL% = FindWindow(0, "America  Online")
    C = SetMenu(AOL%, AOLMenu)
    Call DrawMenuBar(AOL%)

End Sub

Sub Command3D39_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Unhide AOLs menu"

End Sub

Sub Command3D4_Click ()
form13.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en17 Else AOHell.Hide
en17:

End Sub

Sub Command3D4_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "AOHell's text encrypter/decrypter with password protection"

End Sub

Sub Command3D5_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
IsChron.Show

End Sub

Sub Command3D5_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Is that the real Chronic or a poser?  Find out!"

End Sub

Sub Command3D6_Click ()
QuickFTP.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value

If Dab = "yes" Then GoTo en2 Else AOHell.Hide

en2:

End Sub

Sub Command3D6_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Connect to FTP sites fast!"

End Sub

Sub Command3D7_Click ()
GoTo stw1

Errstw1:
Exit Sub

stw1:
On Error GoTo Errstw1:

mm2.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en10 Else AOHell.Hide

en10:

End Sub

Sub Command3D7_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Forward all your mail to other people"

End Sub

Sub Command3D8_Click ()
fakeforward.Show
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value

If Dab = "yes" Then GoTo en5 Else AOHell.Hide

en5:

End Sub

Sub Command3D8_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Fake Foward - make it look like someone mailed you something"

End Sub

Sub Command3D9_Click ()
GoTo CreditBeg

crediterr:
MsgBox "CRDTWIZ.EXE not found in the AOH directory!  Cannot load Credit Wizard.", 16, "Cannot Load CW"
Exit Sub


CreditBeg:
On Error GoTo crediterr

CreditPATH = App.Path + "\crdtwiz.exe"
X = Shell(CreditPATH, 1)

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value
If Dab = "yes" Then GoTo en14 Else AOHell.Hide

en14:

End Sub

Sub Command3D9_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Chronic and Rizzer's Credit Wizard CC # generator"

End Sub

Sub dd_DblClick ()
AOHell.Height = 1125
AOHell.ScaleHeight = 1.27

dd.Visible = False
End Sub

Sub dd_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Double Click to get rid of me"

End Sub

Sub Form_DblClick ()
dd.Visible = True
AOHell.Height = 1470

End Sub

Sub Form_KeyDown (KeyCode As Integer, Shift As Integer)
If KeyCode = KEY_F3 Then
IsChron.Show
End If

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(AOHell.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

A = "a"
B = "b"
C = "c"
d = "d"
e = "e"
f = "f"
G = "g"
h = "h"
i = "i"
j = "j"
k = "k"
l = "l"
m = "m"
N = "n"
o = "o"
P = "p"
Q = "q"
R = "r"
S = "s"
T = "t"
U = "u"
V = "v"
W = "w"
X = "x"
Y = "y"
z = "z"
SP = " "
CA = "A"
CB = "B"
CC = "C"
CD = "D"
CE = "E"
CF = "F"
CG = "G"
CH = "H"
CI = "I"
CJ = "J"
CK = "K"
CL = "L"
CM = "M"
CN = "N"
CO = "O"
CP = "P"
CQ = "Q"
CR = "R"
CS = "S"
CT = "T"
CU = "U"
CV = "V"
CW = "W"
CX = "X"
CY = "Y"
CZ = "Z"
 
   cryptname = CA + CO + CH + e + l + l + SP + "95" + SP + V + "3.0" + SP + "By:" + SP + CD + A + SP + CC + h + R + o + N + i + C '+ SP + A + N + D + SP + CT + H + E + SP + CR + I + Z + Z + E + R

Panel3D3.Caption = cryptname

DoEvents

End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(AOHell.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub Ghost_Click ()

  AppActivate "America  Online"
	
	Clipboard.SetText " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13) + " " + Chr$(13)

	  DoEvents
	SendKeys "%EP"
	SendKeys "%EP"
	aaadd = DoEvents()
	
	dd = DoEvents()
	SendKeys "{Tab}+{Enter}"


End Sub

Sub Image1_Click ()
Form5.Show
End Sub

Sub Macro_Click ()

End Sub

Sub mnuAb_Click ()
Form5.Show
End Sub

Sub mnuaohd_Click ()
dice.Show
End Sub

Sub mnuAOHEx_Click ()
Response = MsgBox("Are you sure you want to exit AOHell?", 36, "Exit AOHell")
'Possible Response values: 6--YES, 7--NO.
If Response = 6 Then End

If Response = 7 Then AOHell.Show


End Sub

Sub mnuAOHG_Click ()

End Sub

Sub mnuAOHgc_Click ()
SendKeys "%{TAB}%{TAB}%{F4}{F3 60}{TAB} ", True

End Sub

Sub mnuAOHMac_Click ()

End Sub

Sub mnuAOHMB_Click ()
ebomb.Show
End Sub

Sub mnuaohmf_Click ()
'Mailfix.Show
End Sub

Sub mnuaohmm_Click ()
mm2.Show
End Sub

Sub mnuaohp_Click ()
'Punt.Show
End Sub

Sub mnuAOHs_Click ()
form3.Show
End Sub

Sub mnuAOHT_Click ()

End Sub

Sub mnuComeS_Click ()

End Sub

Sub mnuIMan_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If

IManager.Show

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value

If Dab = "yes" Then GoTo en26 Else AOHell.Hide

en26:


End Sub

Sub mnuIn_Click ()

End Sub

Sub mnuRoom_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If

IMRoom.Show

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab = init1.Value

If Dab = "yes" Then GoTo en25 Else AOHell.Hide

en25:

End Sub

Sub Music_Click ()
'elite1.Show
End Sub

Sub Stat_DblClick ()
dd.Visible = False
DoEvents
AOHell.Height = 1095
AOHell.ScaleHeight = 1.217
DoEvents
End Sub

Sub Stat_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
dd.Caption = "Double Click to lose info bar."
End Sub

Sub TextManip_Click ()

End Sub

Sub Timer1_Timer ()
     P = Str(Time)
     P1 = Mid$(P, 1, 2)
     Dob = InStr(P1, ":")
     If Dob > 0 Then
     Panel3D1.Caption = Time
     Exit Sub
     End If
     P1 = Int(P1)
     If P1 >= 13 Then P1 = P1 - 12
     P2 = Mid$(P, 3)
     P3 = Str(P1) + P2

   Panel3D1.Caption = P3
	 

End Sub

