VERSION 2.00
Begin Form Form14 
   BackColor       =   &H8000000F&
   Caption         =   "Form1"
   ClientHeight    =   4020
   ClientLeft      =   1095
   ClientTop       =   1485
   ClientWidth     =   7365
   Height          =   4425
   Left            =   1035
   LinkTopic       =   "Form1"
   ScaleHeight     =   540
   ScaleWidth      =   540
   Top             =   1140
   Width           =   7485
   Begin SSCommand Command3D1 
      Caption         =   "Command3D1"
      Height          =   615
      Left            =   2400
      TabIndex        =   0
      Top             =   2400
      Width           =   1335
   End
End
Sub Command3D1_Click ()
  thiswin% = FindWindow(0, "America  Online")

   SendHand1 = VBEnumChildWindows(thiswin%, -1)
   For x = 1 To SendHand1
    rb = VBEnumChildWindows(thiswin%, x)
    z = ShowWindow(rb, 4)
    
   Next x



End Sub

