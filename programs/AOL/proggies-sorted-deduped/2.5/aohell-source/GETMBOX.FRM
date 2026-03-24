VERSION 2.00
Begin Form Form1 
   BackColor       =   &H8000000F&
   Caption         =   "Form1"
   ClientHeight    =   4020
   ClientLeft      =   1095
   ClientTop       =   1485
   ClientWidth     =   7365
   Height          =   4425
   Left            =   1035
   LinkTopic       =   "Form1"
   ScaleHeight     =   4020
   ScaleWidth      =   7365
   Top             =   1140
   Width           =   7485
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "Command3D1"
      Font3D          =   3  'Inset w/light shading
      ForeColor       =   &H00000000&
      Height          =   735
      Left            =   2880
      TabIndex        =   0
      Top             =   1800
      Width           =   1575
   End
End

Sub Command3D1_Click ()
thiswin% = FindWindow(0, "America  Online")
PeopleList = FindChildByClass(thiswin%, "_AOL_Tree")
    Cur = 4

SetCur = SendMessage(PeopleList, LB_SETCURSEL, Cur, 0)

End Sub

