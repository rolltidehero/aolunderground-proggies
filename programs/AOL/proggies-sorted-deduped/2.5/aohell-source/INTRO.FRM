VERSION 2.00
Begin Form INTRO 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   0  'None
   ClientHeight    =   4920
   ClientLeft      =   435
   ClientTop       =   945
   ClientWidth     =   8415
   ControlBox      =   0   'False
   ForeColor       =   &H00FFFFFF&
   Height          =   5325
   Left            =   375
   LinkTopic       =   "Form7"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4920
   ScaleWidth      =   8415
   Top             =   600
   Width           =   8535
   Begin SSPanel Panel3D1 
      BevelInner      =   2  'Raised
      Height          =   4935
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8415
      Begin Init Init1 
         Application     =   ""
         Filename        =   ""
         Height          =   420
         Left            =   7920
         Parameter       =   ""
         Top             =   4920
         Value           =   ""
         Width           =   420
      End
      Begin csPicture csPicture1 
         AnimatedCursor  =   0   'False
         BorderStyle     =   0  'None
         Caption         =   "csPicture1"
         DragMode        =   1  'Automatic
         DrawMode        =   13  'Merge Pen Not
         DrawStyle       =   0  'Solid
         DrawWidth       =   0
         FillColor       =   &H00000000&
         FillStyle       =   1  'Transparent
         Height          =   4575
         Left            =   240
         MDBFormat       =   0  'Bitmap
         PrintLeft       =   0
         PrintTop        =   0
         PrintXScale     =   0
         PrintYScale     =   0
         ScaleMode       =   1  'Twip
         ScrollBars      =   0  'None
         TabIndex        =   1
         Text            =   "csPicture1"
         Top             =   240
         Width           =   7935
         ZoomFactor      =   1
         Begin Ctl3D Ctl3D1 
            CenterDialogs   =   -1  'True
            ClassList       =   INTRO.FRX:0000
            FastRedraw      =   -1  'True
            Left            =   6720
            Top             =   3360
         End
         Begin Shape Shape1 
            BackColor       =   &H00C0C0C0&
            BorderColor     =   &H00C0C0C0&
            BorderWidth     =   8
            Height          =   135
            Left            =   0
            Top             =   4560
            Width           =   7935
         End
         Begin Line Line1 
            X1              =   7920
            X2              =   3840
            Y1              =   4560
            Y2              =   5040
         End
      End
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer

Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Form_GotFocus ()
Static i
If i = 1 Then Exit Sub
Call Pause(7)
Unload Me
Form6.Show
i = 1

End Sub

Sub Form_Load ()

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "EmergencyStart"
Dab11 = init1.Value

If Dab11 = "yes" Then
  Unload Me
  main.Show
  Exit Sub
Else
  GoTo proc
End If


proc:

init1.Filename = "aohell.ini"
init1.Application = "Options"
init1.Parameter = "Intro"
Dab10 = init1.Value

If Dab10 = "yes" Then
GoTo Proceed1
Else
Form6.Show
Unload Me
Exit Sub
End If

Proceed1:


intro.MousePointer = 11

cspicture1.Picture = "aoh.bin"
Dim Success As Integer

Success% = SetWindowPos%(intro.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2




End Sub

