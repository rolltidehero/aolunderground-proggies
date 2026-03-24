VERSION 2.00
Begin Form Dice 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "Dice Scroll"
   ClientHeight    =   2205
   ClientLeft      =   2415
   ClientTop       =   2310
   ClientWidth     =   3105
   ControlBox      =   0   'False
   Height          =   2610
   Icon            =   DICE.FRX:0000
   Left            =   2355
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2205
   ScaleWidth      =   3105
   Top             =   1965
   Width           =   3225
   Begin CommandButton Command3 
      Caption         =   "Cancel"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   2160
      TabIndex        =   10
      Top             =   1680
      Width           =   855
   End
   Begin TextBox Text3 
      Height          =   285
      Left            =   2160
      TabIndex        =   9
      Text            =   "100"
      Top             =   1320
      Width           =   495
   End
   Begin TextBox Text2 
      Height          =   285
      Left            =   2160
      TabIndex        =   8
      Text            =   "15"
      Top             =   720
      Width           =   375
   End
   Begin TextBox Text1 
      Height          =   285
      Left            =   2160
      TabIndex        =   7
      Text            =   "3"
      Top             =   120
      Width           =   375
   End
   Begin CommandButton Command2 
      Caption         =   "&Random"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1200
      TabIndex        =   6
      Top             =   1680
      Width           =   855
   End
   Begin CommandButton Command1 
      Caption         =   "&Start"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Top             =   1680
      Width           =   855
   End
   Begin HScrollBar HScroll2 
      Height          =   255
      Left            =   2160
      TabIndex        =   4
      Top             =   960
      Visible         =   0   'False
      Width           =   735
   End
   Begin HScrollBar HScroll1 
      Height          =   240
      Left            =   2160
      TabIndex        =   2
      Top             =   360
      Visible         =   0   'False
      Width           =   735
   End
   Begin Label Label3 
      BackColor       =   &H00C0C0C0&
      Caption         =   "This many times:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   1320
      Width           =   1695
   End
   Begin Label Label2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Number Of Sides"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   720
      Width           =   1695
   End
   Begin Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Number Of Dice"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   8.25
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   1695
   End
End
Declare Function SetWindowPos Lib "User" (ByVal h%, ByVal hb%, ByVal X%, ByVal Y%, ByVal cx%, ByVal cy%, ByVal f%) As Integer


Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

Sub Command1_Click ()
  
If Text1.Text = "" Or Text2.Text = "" Or Text3.Text = "" Then
MsgBox "You have not completed filled out this form.", 16, "Oops!"

Exit Sub
End If

If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If

GoTo begindice

dicerr:
MsgBox "An error has occured, cannot continue.", 16, "Dice Error"
Exit Sub

begindice:
 On Error GoTo dicerr
 AppActivate "America  Online"
 DoEvents

  Dado = 0
      

For Y = 1 To Text3
   Dado = Dado + 1
   SendKeys "//Roll -dice" + Text1 + " -sides" + Text2 + "{ENTER}"
   If Dado = 3 Then
   DoEvents
   Call Pause(1)
   Dado = 0
   End If
  
Next Y

End Sub

Sub Command2_Click ()
If SignStatus = 0 Then
MsgBox "You must be signed on to AOL before you can use this feature!", 16, "Not Signed On!"
Exit Sub
End If
 
 If Text1.Text = "" Or Text2.Text = "" Or Text3.Text = "" Then
 MsgBox "You have not completely filled out this form."
 End If
 GoTo RandomBeg

RandomErr:
Exit Sub

RandomBeg:
On Error GoTo RandomErr


lint = 200

 
 AppActivate "America  Online"
 DoEvents
 Randomize
            Mamo = 0

 For Y = 1 To Text3


 RD = Rnd * 15
 DC = Rnd * 999
    RD = CStr(RD)
    DC = CStr(DC)
       Mamo = Mamo + 1

   SendKeys "//Roll -dice" + RD + " -sides" + DC + "{ENTER}"
       If Mamo = 3 Then
       DoEvents
       Call Pause(1.3)
       Mamo = 0
       End If


Next Y

End Sub

Sub Command3_Click ()
Unload Me

End Sub

Sub Command3D1_Click ()
Unload Me

End Sub

Sub Form_Load ()
Dim Success As Integer

Success% = SetWindowPos%(dice.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

Hscroll1.Max = 15
Hscroll1.Min = 0
Hscroll1.LargeChange = 3
Hscroll1.SmallChange = 1
Hscroll2.Min = 0
Hscroll2.Max = 999
Hscroll2.LargeChange = 100
Hscroll2.SmallChange = 10

End Sub

Sub Form_Resize ()
Dim Success As Integer

Success% = SetWindowPos%(dice.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

End Sub

Sub HScroll1_Change ()
Text1 = Hscroll1


End Sub

Sub HScroll2_Change ()
Text2 = Hscroll2


End Sub

