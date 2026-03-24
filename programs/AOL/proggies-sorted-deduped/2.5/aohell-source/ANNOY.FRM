VERSION 2.00
Begin Form annoy 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Annoy Features"
   ClientHeight    =   1920
   ClientLeft      =   2640
   ClientTop       =   1815
   ClientWidth     =   3960
   Height          =   2325
   Icon            =   ANNOY.FRX:0000
   Left            =   2580
   LinkTopic       =   "Form8"
   MaxButton       =   0   'False
   ScaleHeight     =   1920
   ScaleWidth      =   3960
   Top             =   1470
   Width           =   4080
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   3840
      MessageCount    =   ANNOY.FRX:0302
      MessageList     =   ANNOY.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   1200
      Width           =   420
   End
   Begin SSPanel ss 
      BevelInner      =   1  'Inset
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   0
      TabIndex        =   6
      Top             =   1560
      Width           =   3975
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Annoy Features"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   1455
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   3735
      Begin SSCommand Command3D8 
         BevelWidth      =   3
         Caption         =   "BRB"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   2760
         TabIndex        =   9
         Top             =   840
         Width           =   735
      End
      Begin SSCommand Command3D7 
         BevelWidth      =   3
         Caption         =   "Flame"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   2760
         TabIndex        =   8
         Top             =   360
         Width           =   735
      End
      Begin SSCommand Command3D3 
         BevelWidth      =   3
         Caption         =   "Drive H"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   1080
         TabIndex        =   7
         Top             =   360
         Width           =   735
      End
      Begin Init Init1 
         Application     =   ""
         Filename        =   ""
         Height          =   420
         Left            =   2640
         Parameter       =   ""
         Top             =   1200
         Value           =   ""
         Width           =   420
      End
      Begin SSCommand Command3D6 
         BevelWidth      =   3
         Caption         =   "&Scroll"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   1080
         TabIndex        =   5
         Top             =   840
         Width           =   735
      End
      Begin SSCommand Command3D5 
         BevelWidth      =   3
         Caption         =   "&Insult"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   240
         TabIndex        =   4
         Top             =   360
         Width           =   735
      End
      Begin SSCommand Command3D4 
         BevelWidth      =   3
         Caption         =   "&Shoot"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   1920
         TabIndex        =   3
         Top             =   840
         Width           =   735
      End
      Begin SSCommand Command3D2 
         BevelWidth      =   3
         Caption         =   "&Dice"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   240
         TabIndex        =   2
         Top             =   840
         Width           =   735
      End
      Begin SSCommand Command3D1 
         BevelWidth      =   3
         Caption         =   "&Finger"
         Font3D          =   3  'Inset w/light shading
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   1920
         TabIndex        =   1
         Top             =   360
         Width           =   735
      End
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub command3d1_click ()
LT1 = MiddleMac(IsDil)

End Sub

Sub Command3D1_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = "Scroll an ASCII picture of a middle finger"

End Sub

Sub Command3D2_Click ()
dice.Show
'Unload annoy

End Sub

Sub Command3D2_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = "Scrolls dice throws"
End Sub

Sub Command3D3_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If

DriveH.Show

End Sub

Sub Command3D3_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = "The new *working* Drive Hell"

End Sub

Sub Command3D4_Click ()
form7.Show
DoEvents

'Unload annoy

End Sub

Sub Command3D4_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = "Scrolls an ascii picture of a gun pointing at someone"

End Sub

Sub Command3D5_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
   insults.Show


End Sub

Sub Command3D5_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = "Insults: Yo Momma snaps and more.."

End Sub

Sub Command3D6_Click ()
form3.Show
'Unload annoy

End Sub

Sub Command3D6_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = "Scroll up to 3 different lines over and over"

End Sub

Sub Command3D7_Click ()
LT1 = Flame(IsDil)
End Sub

Sub Command3D7_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = "Flame macro"

End Sub

Sub Command3D8_Click ()
 LT1 = BRB(IsDil)
End Sub

Sub Command3D8_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = "Gotta take a shit...brb -- Macro"

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(annoy.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
ss.Caption = cryptname

End Sub

Sub Form_MouseMove (Button As Integer, Shift As Integer, X As Single, Y As Single)
ss.Caption = cryptname
End Sub

