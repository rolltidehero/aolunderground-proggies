VERSION 2.00
Begin Form Form7 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Shoot Someone"
   ClientHeight    =   1140
   ClientLeft      =   2505
   ClientTop       =   2580
   ClientWidth     =   3405
   ControlBox      =   0   'False
   Height          =   1545
   Icon            =   FORM7.FRX:0000
   Left            =   2445
   LinkTopic       =   "Form7"
   MaxButton       =   0   'False
   ScaleHeight     =   1140
   ScaleWidth      =   3405
   Top             =   2235
   Width           =   3525
   Begin Init Init1 
      Application     =   ""
      Filename        =   ""
      Height          =   420
      Left            =   3120
      Parameter       =   ""
      Top             =   720
      Value           =   ""
      Width           =   420
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Cancel"
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
      Top             =   600
      Width           =   855
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&OK"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   600
      TabIndex        =   2
      Top             =   600
      Width           =   855
   End
   Begin TextBox Text1 
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   285
      Left            =   1320
      TabIndex        =   1
      Top             =   120
      Width           =   1815
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Shoot who:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1095
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal x%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


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

If Text1.Text = "" Then GoTo Endall


AppActivate "America  Online"


SendKeys ".        __        ___________               _                    "
SendKeys Text1 + "{ENTER}"
SendKeys ".        \ \\     /    ______     ||________|_\\__ {ENTER}"
SendKeys ".       _|_\\_/     {(}_____{(}|     {(}____________O                  O  {ENTER}"
DoEvents
Call Pause(1.3)
DoEvents
SendKeys ".       |_____     {(}_____{(}|    //                                       \_|_/{ENTER}"
SendKeys ".      /   #     \__ ______ _//                                           |{ENTER}"
SendKeys ".     /  ####   // \\___   //                                              / \{ENTER}"
DoEvents
Call Pause(1.3)
DoEvents
SendKeys ".    /  ####  //======//{ENTER}"
SendKeys ". _/  ####  //  {ENTER}"
SendKeys ".|_______// {ENTER}"
DoEvents
GoTo Endall

Endall:

End Sub

Sub Command3D2_Click ()



 Unload Me

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(form7.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)


End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(form7.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

