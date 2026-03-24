VERSION 2.00
Begin Form Options 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "AOHell Options"
   ClientHeight    =   4260
   ClientLeft      =   2400
   ClientTop       =   1050
   ClientWidth     =   5430
   Height          =   4665
   HelpContextID   =   10
   Icon            =   FORM4.FRX:0000
   Left            =   2340
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   ScaleHeight     =   4260
   ScaleWidth      =   5430
   Top             =   705
   Width           =   5550
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   5880
      Parameter       =   ""
      Top             =   3720
      Value           =   ""
      Width           =   420
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "&Help"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      HelpContextID   =   32
      Left            =   2160
      TabIndex        =   13
      Top             =   3720
      Width           =   1095
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&OK"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   5640
      TabIndex        =   12
      Top             =   4680
      Visible         =   0   'False
      Width           =   1335
   End
   Begin TextBox Text3 
      Height          =   285
      Left            =   2040
      TabIndex        =   11
      Top             =   3120
      Width           =   2775
   End
   Begin SSFrame Frame3d2 
      Caption         =   "Version of Windows AOL"
      Height          =   615
      Left            =   600
      TabIndex        =   7
      Top             =   1800
      Width           =   4095
      Begin OptionButton Option3D2 
         BackColor       =   &H00C0C0C0&
         Caption         =   "1.5"
         Height          =   255
         Left            =   360
         TabIndex        =   19
         Top             =   240
         Width           =   615
      End
      Begin OptionButton Option3D3 
         BackColor       =   &H00C0C0C0&
         Caption         =   "2.0"
         Height          =   255
         Left            =   1800
         TabIndex        =   18
         Top             =   240
         Width           =   735
      End
      Begin OptionButton Option3D1 
         BackColor       =   &H00C0C0C0&
         Caption         =   "2.5"
         Height          =   255
         Left            =   3120
         TabIndex        =   17
         Top             =   240
         Value           =   -1  'True
         Width           =   615
      End
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   2040
      TabIndex        =   6
      Top             =   2640
      Width           =   2775
   End
   Begin TextBox Text1 
      Height          =   285
      Left            =   5640
      TabIndex        =   5
      Top             =   3000
      Visible         =   0   'False
      Width           =   2775
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Chronic?"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   3600
      TabIndex        =   4
      Top             =   3720
      Width           =   1095
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Save"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   720
      TabIndex        =   3
      Top             =   3720
      Width           =   1095
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Settings"
      Height          =   1575
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   4935
      Begin SSCheck Check3D6 
         Caption         =   "Add &Menu to AOL"
         Height          =   255
         Left            =   2760
         TabIndex        =   20
         Top             =   1080
         Value           =   -1  'True
         Width           =   2055
      End
      Begin SSCheck Check3D5 
         Caption         =   "Show &Intro Graphic"
         Height          =   255
         Left            =   2760
         TabIndex        =   16
         Top             =   720
         Value           =   -1  'True
         Width           =   2055
      End
      Begin SSCheck Check3D4 
         Caption         =   "&Default S. Bot Settings"
         Height          =   255
         Left            =   240
         TabIndex        =   15
         Top             =   1080
         Width           =   2295
      End
      Begin SSCheck Check3D3 
         Caption         =   "&Auto-Load WAOL "
         Height          =   255
         Left            =   2760
         TabIndex        =   14
         Top             =   360
         Width           =   1935
      End
      Begin SSCheck Check3D2 
         Caption         =   "Always &Show Main Menu"
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   720
         Width           =   2535
      End
      Begin SSCheck Check3D1 
         Caption         =   "Sounds &Enabled"
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Value           =   -1  'True
         Width           =   1815
      End
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      Caption         =   "WAOL PATH:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   600
      TabIndex        =   9
      Top             =   2640
      Width           =   1215
      WordWrap        =   -1  'True
   End
   Begin Label Label3 
      BackColor       =   &H8000000F&
      Caption         =   "Default S. Bot Settings File:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   495
      Left            =   600
      TabIndex        =   10
      Top             =   3000
      Width           =   1335
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "Whale Express PATH:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   5640
      TabIndex        =   8
      Top             =   3000
      Visible         =   0   'False
      Width           =   1455
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Check3D3_Click (Value As Integer)
'If check3d3.Value = True Then
'MsgBox "WARNING:  AOHell may lock-up at the Intro screen on *some* computers using Windows version 3.11 if you set AOHell to start up WAOL automatically.  This rarely occurs on computers with Windows version 3.1.  If AOHell does lock-up at the beginning screen, refer to the Troubleshooting section of the AOHell help file.  It will show you how to fix this problem.  If you don't know what version of Windows you are using, go to Program Manager and under the HELP menu choose ""About Program Manger"".  It will then display what version of Windows it is, and other system information.", 48, "Lock-Up Warning"
'End If

End Sub

Sub Command3D1_Click ()
  
    
   Dim WD1 As String * 128  'win directory, because of DLL's return
    Dim WSD1 As String * 128 'system directory, because of DLL's return
    nWSize% = 128
    nSSize% = 128
    
    Wdir% = GetWindowsDirectory(WD1$, nWSize%)'windir
    Sdir% = GetSystemDirectory(WSD1$, nSSize%)'systemdir
    WD$ = RTrim$(LCase$(Left$(WD1$, Wdir%)))
    WSD$ = RTrim$(LCase$(Left$(WSD1$, Sdir%)))


GoTo begin

titfuck7:
                            
begin:

'On Error GoTo resume1
'Kill WD + "\aohell.ini"

'resume1:


If check3d1.Value = True Then
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Sounds"
init1.Value = "yes"
Else
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Sounds"
init1.Value = "no"

DoEvents
End If

If Check3D5.Value = True Then

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Intro"
init1.Value = "yes"
Else
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Intro"
init1.Value = "no"
DoEvents
End If




If check3d2.Value = True Then
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
init1.Value = "yes"
DoEvents
Else
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
init1.Value = "no"
DoEvents
End If

If check3d3.Value = True Then
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "AutoLoad"
init1.Value = "yes"
DoEvents
Else
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "AutoLoad"
init1.Value = "no"
DoEvents
End If

If check3d4.Value = True Then
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "DefBot"
init1.Value = "yes"
DoEvents
Else
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "DefBot"
init1.Value = "no"
DoEvents
End If

If Check3D6.Value = True Then
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "AddMenu"
init1.Value = "yes"
DoEvents
Else
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "AddMenu"
init1.Value = "no"
DoEvents
End If

If Option3D1.Value = True Then
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Version"
init1.Value = "2.5"
DoEvents
End If

If Option3D2.Value = True Then
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Version"
init1.Value = "1.5"
DoEvents
End If

If Option3D3.Value = True Then
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Version"
init1.Value = "2.0"
DoEvents
End If




DoEvents

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "WAOL"
init1.Value = Text2.Text

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "BotSet"
init1.Value = Text3.Text

'Resume

Unload options

End Sub

Sub Command3D2_Click ()

IsChron.Show



End Sub

Sub Command3D3_Click ()
Unload Me
aohell.Show
End Sub

Sub Command3D4_Click ()
SendKeys "{F1}"
DoEvents


End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(options.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2


init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Sounds"
Dab = init1.Value

If Dab = "yes" Then
check3d1.Value = True
Else check3d1.Value = False
End If

DoEvents

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Intro"
Dab10 = init1.Value

If Dab10 = "yes" Then
Check3D5.Value = True
Else Check3D5.Value = False
End If


init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "ShowMenu"
Dab2 = init1.Value


If Dab2 = "yes" Then
check3d2.Value = True
DoEvents
Else check3d2.Value = False
DoEvents
End If

DoEvents

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "AutoLoad"
Dab3 = init1.Value


If Dab3 = "yes" Then
check3d3.Value = True
DoEvents
Else check3d3.Value = False
DoEvents
End If

DoEvents

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "DefBot"
Dab4 = init1.Value

If Dab4 = "yes" Then
check3d4.Value = True
DoEvents
Else check3d4.Value = False
DoEvents
End If
 
init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "AddMenu"
Dab40 = init1.Value

If Dab40 = "yes" Then
Check3D6.Value = True
DoEvents
Else Check3D6.Value = False
DoEvents
End If

DoEvents

DoEvents

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "WAOL"
Text2.Text = init1.Value

DoEvents

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "BotSet"
Text3.Text = init1.Value

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Version"

If init1.Value = "2.5" Then Option3D1.Value = True
If init1.Value = "2.0" Then Option3D3.Value = True
If init1.Value = "1.5" Then Option3D2.Value = True



End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(options.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

