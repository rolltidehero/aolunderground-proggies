VERSION 2.00
Begin Form WNote 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   ClientHeight    =   1440
   ClientLeft      =   2430
   ClientTop       =   2745
   ClientWidth     =   4650
   ControlBox      =   0   'False
   Height          =   1845
   Icon            =   WNOTE.FRX:0000
   Left            =   2370
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1440
   ScaleWidth      =   4650
   Top             =   2400
   Width           =   4770
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "Cancel Send"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1560
      TabIndex        =   1
      Top             =   960
      Width           =   1455
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "Mass Mail List time limit has expired.  Stop anything you are doing while AOHell starts mass mailing to the people on your list.  ..Starting in 10 seconds"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   735
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4455
      WordWrap        =   -1  'True
   End
End
Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command3D1_Click ()
GoTo star1

star2:
Packing1 = 0
PackStatus.Show
PTime = 5
Packing1 = 2
Unload Me
Exit Sub

star1:
If Packing1 = 1 Then GoTo star2

Response = MsgBox("Are you sure you want cancel the Mass Mail?", 292, "Cancel Mass Mail")
'Possible Response values: 6--YES, 7--NO.
If Response = 6 Then
    Unload Me
    ListStatus.Show
    TimeLimit = 5
End If

If Response = 7 Then Exit Sub

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(WNote.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

