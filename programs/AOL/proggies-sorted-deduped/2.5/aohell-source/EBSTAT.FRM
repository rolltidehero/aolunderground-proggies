VERSION 2.00
Begin Form ebstat 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Email Bomb Status"
   ClientHeight    =   3135
   ClientLeft      =   4770
   ClientTop       =   315
   ClientWidth     =   4815
   ControlBox      =   0   'False
   FillStyle       =   0  'Solid
   Height          =   3540
   Icon            =   EBSTAT.FRX:0000
   Left            =   4710
   LinkTopic       =   "Form12"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3135
   ScaleWidth      =   4815
   Top             =   -30
   Width           =   4935
   Begin ListBox List1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   1290
      Left            =   3600
      TabIndex        =   12
      Top             =   1320
      Width           =   1095
   End
   Begin Percent Percent2 
      BackColor       =   &H00FFFFFF&
      BevelBar        =   0  'None
      BevelInner      =   3  'Lowered
      BevelOuter      =   0  'None
      BevelWidth      =   2
      BevelWidthBar   =   1
      Border          =   1  'Single Width
      BorderWidth     =   0
      ForeColor       =   &H00FF0000&
      Height          =   375
      Left            =   240
      Percent         =   0
      TextBackColor   =   &H00FFFFFF&
      TextForeColor   =   &H000000FF&
      ThreeD          =   -1  'True
      Top             =   360
      Width           =   4095
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Sign Off"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   615
      Left            =   360
      TabIndex        =   10
      Top             =   840
      Width           =   3135
      Begin SSCheck Check3D1 
         Caption         =   "Sign-Off when complete"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   360
         TabIndex        =   11
         Top             =   240
         Width           =   2415
      End
   End
   Begin Timer Timer1 
      Interval        =   60000
      Left            =   6360
      Top             =   2640
   End
   Begin SSPanel Panel3D1 
      BevelInner      =   2  'Raised
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   2760
      Width           =   4815
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Stop this thing!"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   960
      TabIndex        =   0
      Top             =   1560
      Width           =   1935
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "Removed from List:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   495
      Left            =   3720
      TabIndex        =   13
      Top             =   840
      Width           =   855
   End
   Begin Label Label10 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Minutes Remaining"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   6840
      TabIndex        =   8
      Top             =   3120
      Visible         =   0   'False
      Width           =   1575
   End
   Begin Label Label8 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Approximately"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   6960
      TabIndex        =   3
      Top             =   3000
      Visible         =   0   'False
      Width           =   1215
   End
   Begin Label Label9 
      BackColor       =   &H00C0C0C0&
      Caption         =   "0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   13.5
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   7200
      TabIndex        =   9
      Top             =   3000
      Visible         =   0   'False
      Width           =   255
   End
   Begin Label Label7 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Percent Complete"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   255
      Left            =   1680
      TabIndex        =   7
      Top             =   120
      Width           =   1575
   End
   Begin Label Label6 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Times Mailed"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   360
      TabIndex        =   6
      Top             =   2160
      Width           =   615
   End
   Begin Label Label5 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Times Left"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2160
      TabIndex        =   5
      Top             =   2160
      Width           =   615
   End
   Begin Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0C0&
      Caption         =   "0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   18
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2880
      TabIndex        =   2
      Top             =   2160
      Width           =   735
   End
   Begin Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0C0&
      Caption         =   "0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   18
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   1080
      TabIndex        =   4
      Top             =   2160
      Width           =   735
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Check3D1_Click (Value As Integer)
GoTo beg9

err9:
Exit Sub

beg9:
On Error GoTo err9
AppActivate "America  Online"
If Check3D1.Value = True Then
mm2.Check3D3.Value = True
Else
mm2.Check3D3.Value = False
End If

End Sub

Sub Command3D1_Click ()
GoTo StatBeg

StatErr:
Exit Sub

NexErr:
Exit Sub

StatBeg:
On Error GoTo StatErr
AppActivate "America  Online"

Nex:
On Error GoTo NexErr

qui = 1000
qui1 = 1000
panel3d1.Caption = "Cancel Request Acknowleged, please wait."

End Sub

Sub Form_Click ()
AppActivate "America  Online"

End Sub

Sub Form_DblClick ()
AppActivate "America  Online"

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(ebstat.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

'Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2


End Sub

Sub Timer1_Timer ()
minutes1 = minutes1 - 1

Label9.Caption = minutes1 * 2

If minutes1 = 0 Then
label8.Caption = "   Less Then"
Label10.Caption = "Minute Left"
Label9.Caption = 1
End If


End Sub

