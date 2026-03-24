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
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "Command3D2"
      Font3D          =   3  'Inset w/light shading
      Height          =   255
      Left            =   3360
      TabIndex        =   2
      Top             =   2880
      Width           =   495
   End
   Begin ListBox List1 
      Height          =   3150
      Left            =   720
      TabIndex        =   1
      Top             =   240
      Width           =   1935
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "Command3D1"
      Font3D          =   3  'Inset w/light shading
      Height          =   375
      Left            =   3360
      TabIndex        =   0
      Top             =   1920
      Width           =   1575
   End
End

Sub Command3D1_Click ()
  thiswin% = FindWindow(0, "America  Online")
ForwardHand = FindChildByTitle(thiswin%, "Download Manager")
   SendHand1 = VBEnumChildWindows(ForwardHand, -1)
   For x = 1 To SendHand1
    rb = VBEnumChildWindows(ForwardHand, x)
    List1.AddItem rb
   Next x


End Sub

Sub Command3D2_Click ()
List1.Clear

End Sub

