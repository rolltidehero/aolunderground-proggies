VERSION 2.00
Begin Form DupeKill 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Dupe Killer Status"
   ClientHeight    =   1365
   ClientLeft      =   2040
   ClientTop       =   1200
   ClientWidth     =   5385
   ControlBox      =   0   'False
   Height          =   1770
   Left            =   1980
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1365
   ScaleWidth      =   5385
   Top             =   855
   Width           =   5505
   Begin Percent Percent1 
      BackColor       =   &H00FFFFFF&
      BevelBar        =   0  'None
      BevelInner      =   2  'Inset
      BevelOuter      =   2  'Inset
      BevelWidth      =   1
      BevelWidthBar   =   0
      Border          =   1  'Single Width
      BorderWidth     =   0
      ForeColor       =   &H00FF0000&
      Height          =   375
      Left            =   600
      Percent         =   0
      TextBackColor   =   &H00FFFFFF&
      TextForeColor   =   &H00FF0000&
      ThreeD          =   -1  'True
      Top             =   840
      Width           =   4095
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   5400
      MessageCount    =   DUPEKILL.FRX:0000
      MessageList     =   DUPEKILL.FRX:0002
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   3240
      Width           =   420
   End
   Begin Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H8000000F&
      Caption         =   "Searchin....   Seek and Destroy"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   960
      TabIndex        =   1
      Top             =   480
      Width           =   3375
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "Searching for duplicate warez...  This may take a minute."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   120
      Width           =   5535
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal CX%, ByVal CY%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
MsgBox "please"

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(DupeKill.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

