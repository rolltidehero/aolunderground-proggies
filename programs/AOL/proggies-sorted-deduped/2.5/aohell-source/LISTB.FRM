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
      Height          =   855
      Left            =   3120
      TabIndex        =   2
      Top             =   2640
      Width           =   2295
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   5880
      MessageCount    =   LISTB.FRX:0000
      MessageList     =   LISTB.FRX:0002
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   3240
      Width           =   420
   End
   Begin TextBox Text1 
      Height          =   2055
      Left            =   360
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   240
      Width           =   6135
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "Command3D1"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   855
      Left            =   720
      TabIndex        =   0
      Top             =   2640
      Width           =   2175
   End
End

Sub Command3D1_Click ()
      thiswin% = FindWindow(0, "America  Online")
      ListHand = FindChildByClass(thiswin%, "_AOL_Tree")

lint = 100
'lpstring = Space(lint)

  T = SendMessage(ListHand, LB_GETCOUNT, 0, 0)

Cur = 0
      ret = Chr$(13) + Chr$(10)
 Text1.Text = ""

For Y = 1 To T
 'SetCur = SendMessage(ListHand, LB_SETCURSEL, Cur, 0)
z = SendMessage(ListHand, LB_GETTEXTLEN, Cur, 0)
lpstring = Space(z)
x = SendMessageByString(ListHand, LB_GETTEXT, Cur, lpstring) ',lint
lpstring = Trim$(lpstring)
TheString = TheString + ret + lpstring
Cur = Y
Next Y
Clipboard.SetText TheString

End Sub

