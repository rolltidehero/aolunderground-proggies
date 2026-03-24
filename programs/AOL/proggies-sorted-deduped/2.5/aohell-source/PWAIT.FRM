VERSION 2.00
Begin Form Pwait 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   ClientHeight    =   315
   ClientLeft      =   3840
   ClientTop       =   3285
   ClientWidth     =   1695
   ControlBox      =   0   'False
   Height          =   720
   Left            =   3780
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   315
   ScaleWidth      =   1695
   Top             =   2940
   Width           =   1815
   Begin Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "Please Wait..."
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   1500
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(PWait.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

