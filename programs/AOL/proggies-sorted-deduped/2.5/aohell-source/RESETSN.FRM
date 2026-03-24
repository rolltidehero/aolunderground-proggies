VERSION 2.00
Begin Form ResetSN 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Reset AOL to New User"
   ClientHeight    =   2625
   ClientLeft      =   2850
   ClientTop       =   1860
   ClientWidth     =   3735
   Height          =   3030
   Icon            =   RESETSN.FRX:0000
   Left            =   2790
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2625
   ScaleWidth      =   3735
   Top             =   1515
   Width           =   3855
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
      Height          =   375
      HelpContextID   =   24
      Left            =   1440
      TabIndex        =   7
      Top             =   2160
      Width           =   855
   End
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   3720
      Parameter       =   ""
      Top             =   1200
      Value           =   ""
      Width           =   420
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   120
      MessageCount    =   RESETSN.FRX:0302
      MessageList     =   RESETSN.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   840
      Width           =   420
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
      Height          =   375
      Left            =   2520
      TabIndex        =   5
      Top             =   2160
      Width           =   975
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&OK"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   360
      TabIndex        =   4
      Top             =   2160
      Width           =   855
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   1920
      MaxLength       =   10
      TabIndex        =   3
      Top             =   1680
      Width           =   1575
   End
   Begin TextBox Text1 
      Height          =   285
      Left            =   1920
      TabIndex        =   1
      Top             =   1200
      Width           =   1575
   End
   Begin Label Label3 
      BackColor       =   &H8000000F&
      Caption         =   "AOHell will replace a screen name in your software with ""New User"".  The screen name must be at least 7 characters long (spaces count) and exactly as it is on AOL."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   975
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   3615
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      Caption         =   "Name to Replace:"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   1680
      Width           =   1575
   End
   Begin Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "AOL Directory:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   225
      Left            =   120
      TabIndex        =   0
      Top             =   1200
      Width           =   1305
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
GoTo Ben

reseterr:
PWait.Hide
ResetSN.Show
Exit Sub


Ben:
On Error GoTo reseterr

  Dim NU As String
  Dim Direc1 As String, Direc As String
  Dim SName As String


Direc = Text1.Text
SName = Text2.Text

If SName = "" Or Len(SName) < 7 Then
MsgBox "The screen name to replace must be at least 7 characters long (spaces count).  AOHell will replace that screen name with ""NewUser"".", 16, "Name Error"
Exit Sub
End If
If Direc = "" Then
MsgBox "Must specify a directory!", 16, "Need Directory"
Exit Sub
End If

Direc1 = Direc + "\idb\main.idx"


NU = "NewUser"

If Len(SName) = 7 Then
NU = "NewUser"
End If
If Len(SName) = 8 Then
NU = "New User"
End If
If Len(SName) = 9 Then
NU = "New User "
End If
If Len(SName) = 10 Then
NU = "New User  "
End If

PWait.Show
ResetSN.Hide
DoEvents
Call Pause(2)
Call ChangeFile(Direc1, SName, NU)
DoEvents

thiswin% = FindWindow(0, "America  Online")
find5% = FindChildByTitle(thiswin%, "Welcome")
find6% = FindChildByTitle(thiswin%, "Goodbye")

If find5% > 0 Then
VBMsg1.SubClasshWnd = find5%
VBMsg1.SendMessage = WM_CLOSE
DoEvents
End If

If find6% > 0 Then
VBMsg1.SubClasshWnd = find6%
VBMsg1.SendMessage = WM_CLOSE
DoEvents
End If

If find5% > 0 Or find6% > 0 Then
   AppActivate "America  Online"
   DoEvents
   SendKeys "%G{ENTER}"
   DoEvents
End If

Unload PWait
Unload Me
                  '    FAccount.Show
    
End Sub

Sub Command3D2_Click ()
Unload Me
'FAccount.Show

End Sub

Sub Command3D3_Click ()
SendKeys "{F1}"
DoEvents
Call Pause(.1)
DoEvents
SendKeys "%HT"

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(ResetSN.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "WAOL"
texpath = init1.Value

Dim texpath1 As Integer, texpath2 As Integer

texpath1 = Len(texpath)
texpath2 = texpath1 - 9

texpath3 = Mid$(texpath, 1, texpath2)

Text1.Text = texpath3



End Sub

Sub Form_Paint ()

Text2.SetFocus

End Sub

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

