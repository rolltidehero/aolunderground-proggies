VERSION 2.00
Begin Form AIBot 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "AOHell v3.0   Artificial Intelligence Bot"
   ClientHeight    =   6210
   ClientLeft      =   120
   ClientTop       =   525
   ClientWidth     =   9345
   ControlBox      =   0   'False
   Height          =   6615
   HelpContextID   =   19
   Icon            =   CHATROO.FRX:0000
   Left            =   60
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   6210
   ScaleWidth      =   9345
   Top             =   180
   Width           =   9465
   Begin Timer Timer1 
      Interval        =   200
      Left            =   7560
      Top             =   5160
   End
   Begin SSCommand Command3D23 
      BevelWidth      =   3
      Caption         =   "Unload AI Bot"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   7440
      TabIndex        =   47
      Top             =   2880
      Width           =   1695
   End
   Begin VBMsg VBMsg2 
      Height          =   420
      Left            =   6120
      MessageCount    =   CHATROO.FRX:0302
      MessageList     =   CHATROO.FRX:0304
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   4080
      Width           =   420
   End
   Begin CommonDialog CMDialog1 
      Filter          =   "AI Bot Settings(*.AIS)|*.AIS"
      Left            =   9360
      Top             =   5040
   End
   Begin SSCommand Command3D22 
      BevelWidth      =   3
      Caption         =   "&Save Settings"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   7440
      TabIndex        =   44
      Top             =   2400
      Width           =   1695
   End
   Begin SSCommand Command3D21 
      BevelWidth      =   3
      Caption         =   "&Load Settings"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   7440
      TabIndex        =   43
      Top             =   1920
      Width           =   1695
   End
   Begin SSCommand Command3D20 
      BevelWidth      =   3
      Caption         =   "&Help"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      HelpContextID   =   19
      Left            =   7440
      TabIndex        =   42
      Top             =   3480
      Width           =   1695
   End
   Begin SSCommand Command3D19 
      BevelWidth      =   3
      Caption         =   "&OK"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   7440
      TabIndex        =   41
      Top             =   1440
      Width           =   1695
   End
   Begin SSFrame Frame3D2 
      Caption         =   "Annoy Options"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   1095
      Left            =   7320
      TabIndex        =   38
      Top             =   120
      Width           =   1935
      Begin SSCheck Check3D20 
         Caption         =   "Check3D20"
         Height          =   255
         Left            =   240
         TabIndex        =   6
         Top             =   2760
         Visible         =   0   'False
         Width           =   1695
      End
      Begin SSCheck Check3D19 
         Caption         =   "Check3D19"
         Height          =   255
         Left            =   240
         TabIndex        =   8
         Top             =   2400
         Visible         =   0   'False
         Width           =   1455
      End
      Begin SSCheck Check3D18 
         Caption         =   "Check3D18"
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   2160
         Visible         =   0   'False
         Width           =   1575
      End
      Begin SSCheck Check3D17 
         Caption         =   "Check3D17"
         Height          =   255
         Left            =   240
         TabIndex        =   26
         Top             =   1920
         Visible         =   0   'False
         Width           =   1455
      End
      Begin SSCheck Check3D16 
         Caption         =   "Check3D16"
         Height          =   255
         Left            =   240
         TabIndex        =   30
         Top             =   1680
         Visible         =   0   'False
         Width           =   1575
      End
      Begin SSCheck Check3D15 
         Caption         =   "Check3D15"
         Height          =   255
         Left            =   240
         TabIndex        =   35
         Top             =   1320
         Visible         =   0   'False
         Width           =   1335
      End
      Begin SSCommand Command3D18 
         BevelWidth      =   1
         Caption         =   "Person"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   720
         Outline         =   0   'False
         TabIndex        =   40
         Top             =   720
         Width           =   735
      End
      Begin SSCheck Check3D13 
         Caption         =   "Echo Someone"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   -1  'True
         Height          =   255
         Left            =   240
         TabIndex        =   39
         Top             =   360
         Width           =   1575
      End
   End
   Begin SSFrame Frame3D1 
      Caption         =   "AI Bot Response Options"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   5055
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   7095
      Begin VBMsg VBMsg4 
         Height          =   420
         Left            =   6480
         MessageCount    =   CHATROO.FRX:0502
         MessageList     =   CHATROO.FRX:0504
         MessageTypes    =   0  'Selected Messages
         PostDefault     =   0   'False
         Top             =   3960
         Width           =   420
      End
      Begin OptionButton Option2 
         BackColor       =   &H00C0C0C0&
         Caption         =   "&Prompt"
         Height          =   255
         Left            =   6120
         TabIndex        =   51
         Top             =   4680
         Width           =   855
      End
      Begin OptionButton Option1 
         BackColor       =   &H00C0C0C0&
         Caption         =   "&Stop Bot"
         Height          =   255
         Left            =   4920
         TabIndex        =   50
         Top             =   4680
         Value           =   -1  'True
         Width           =   1095
      End
      Begin SSCheck Check3D14 
         Caption         =   "&Guide Detector:"
         Height          =   255
         Left            =   3240
         TabIndex        =   49
         Top             =   4680
         Width           =   1695
      End
      Begin SSCheck Check3D21 
         Caption         =   "&Beavis and Butt-Head talker "
         Height          =   255
         Left            =   360
         TabIndex        =   48
         Top             =   4680
         Width           =   2655
      End
      Begin VBMsg VBMsg3 
         Height          =   420
         Left            =   6240
         MessageCount    =   CHATROO.FRX:0702
         MessageList     =   CHATROO.FRX:0704
         MessageTypes    =   0  'Selected Messages
         PostDefault     =   0   'False
         Top             =   3960
         Width           =   420
      End
      Begin SSCommand Command3D17 
         BevelWidth      =   1
         Caption         =   "Word(s)"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   4560
         Outline         =   0   'False
         TabIndex        =   37
         Top             =   4320
         Width           =   735
      End
      Begin SSCheck Check3D12 
         Caption         =   "Messa&ge me when someone says this/these:"
         Height          =   255
         Left            =   360
         TabIndex        =   36
         Top             =   4320
         Width           =   4095
      End
      Begin SSCommand Command3D16 
         BevelWidth      =   1
         Caption         =   "Person"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   2760
         Outline         =   0   'False
         TabIndex        =   34
         Top             =   3960
         Width           =   735
      End
      Begin SSCheck Check3D11 
         Caption         =   "&Message me when this:                 leaves, or enters the room."
         Height          =   255
         Left            =   360
         TabIndex        =   33
         Top             =   3960
         Width           =   5535
      End
      Begin SSCommand Command3D15 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   31
         Top             =   3240
         Width           =   855
      End
      Begin SSCommand Command3D14 
         BevelWidth      =   1
         Caption         =   "Person"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   1680
         Outline         =   0   'False
         TabIndex        =   29
         Top             =   3240
         Width           =   735
      End
      Begin SSCheck Check3D10 
         Caption         =   "When this:                 leaves the room, respond with this:"
         Height          =   255
         Left            =   360
         TabIndex        =   28
         Top             =   3240
         Width           =   5175
      End
      Begin SSCommand Command3D13 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   27
         Top             =   2880
         Width           =   855
      End
      Begin SSCommand Command3D12 
         BevelWidth      =   1
         Caption         =   "Person"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   1680
         Outline         =   0   'False
         TabIndex        =   25
         Top             =   2880
         Width           =   735
      End
      Begin SSCheck Check3D9 
         Caption         =   "When this:                 enters the room, respond with this:"
         Height          =   255
         Left            =   360
         TabIndex        =   24
         Top             =   2880
         Width           =   5175
      End
      Begin SSCommand Command3D11 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   23
         Top             =   2520
         Width           =   855
      End
      Begin SSCheck Check3D8 
         Caption         =   "When someone &Leaves the room, respond with this:"
         Height          =   255
         Left            =   360
         TabIndex        =   22
         Top             =   2520
         Width           =   4695
      End
      Begin SSCommand Command3D10 
         BevelWidth      =   1
         Caption         =   "Person"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   2640
         Outline         =   0   'False
         TabIndex        =   21
         Top             =   3600
         Width           =   735
      End
      Begin SSCheck Check3D7 
         Caption         =   "Automatically put this:                 on I&gnore when they enter the room."
         Height          =   255
         Left            =   360
         TabIndex        =   20
         Top             =   3600
         Width           =   6255
      End
      Begin SSCommand Command3D9 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   19
         Top             =   2160
         Width           =   855
      End
      Begin SSCommand Command3D8 
         BevelWidth      =   1
         Caption         =   "Word(s)"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   3120
         Outline         =   0   'False
         TabIndex        =   17
         Top             =   2160
         Width           =   735
      End
      Begin SSCheck Check3D6 
         Caption         =   "If someone &Says this/these:                  respond with this:"
         Height          =   255
         Left            =   360
         TabIndex        =   16
         Top             =   2160
         Width           =   5295
      End
      Begin SSCommand Command3D7 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   15
         Top             =   1800
         Width           =   855
      End
      Begin SSCheck Check3D5 
         Caption         =   "&Auto-Greet the person who enters the room with this:"
         Height          =   195
         Left            =   360
         TabIndex        =   14
         Top             =   1800
         Width           =   4815
      End
      Begin SSCommand Command3D6 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   13
         Top             =   1440
         Width           =   855
      End
      Begin SSCheck Check3D4 
         Caption         =   "If someone scrolls the &Gun macro, respond with this:"
         Height          =   255
         Left            =   360
         TabIndex        =   12
         Top             =   1440
         Width           =   4935
      End
      Begin SSCommand Command3D5 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   11
         Top             =   1080
         Width           =   855
      End
      Begin SSCheck Check3D3 
         Caption         =   "If someone scrolls the &Finger macro, respond with this:"
         Height          =   255
         Left            =   360
         TabIndex        =   10
         Top             =   1080
         Width           =   4935
      End
      Begin SSCommand Command3D4 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   9
         Top             =   720
         Width           =   855
      End
      Begin SSCommand Command3D3 
         BevelWidth      =   1
         Caption         =   "Word(s)"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   2880
         Outline         =   0   'False
         TabIndex        =   7
         Top             =   720
         Width           =   735
      End
      Begin SSCommand Command3D2 
         BevelWidth      =   1
         Caption         =   "Person"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   1200
         Outline         =   0   'False
         TabIndex        =   5
         Top             =   720
         Width           =   735
      End
      Begin SSCheck Check3D2 
         Caption         =   "If this:               says this:              then respond with this:"
         Height          =   255
         Left            =   360
         TabIndex        =   4
         Top             =   720
         Width           =   5415
      End
      Begin SSCommand Command3D1 
         BevelWidth      =   1
         Caption         =   "Action"
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   5880
         Outline         =   0   'False
         TabIndex        =   3
         Top             =   360
         Width           =   855
      End
      Begin SSCheck Check3D1 
         Caption         =   "If someone uses Profane &Language, respond with this:"
         Height          =   255
         Left            =   360
         TabIndex        =   2
         Top             =   360
         Width           =   4935
      End
      Begin Line Line1 
         X1              =   3120
         X2              =   3120
         Y1              =   4680
         Y2              =   4920
      End
   End
   Begin Timer Timer2 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   9240
      Top             =   3720
   End
   Begin TextBox Text1 
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontName        =   "Arial"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   5640
      Width           =   9135
   End
   Begin VBMsg VBMsg1 
      Height          =   420
      Left            =   9240
      MessageCount    =   CHATROO.FRX:0902
      MessageList     =   CHATROO.FRX:0904
      MessageTypes    =   0  'Selected Messages
      PostDefault     =   0   'False
      Top             =   4680
      Width           =   420
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      Caption         =   "             By                     Da Chronic"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   12
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000080&
      Height          =   615
      Left            =   7320
      TabIndex        =   46
      Top             =   4440
      Width           =   1935
      WordWrap        =   -1  'True
   End
   Begin Label Label1 
      BackColor       =   &H8000000F&
      Caption         =   "AOHell v3.0"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   18
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000080&
      Height          =   375
      Left            =   7320
      TabIndex        =   45
      Top             =   4080
      Width           =   2055
   End
   Begin Label Label6 
      AutoSize        =   -1  'True
      BackColor       =   &H8000000F&
      Caption         =   "The Last Line Said in the Chat Room:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   -1  'True
      Height          =   225
      Left            =   120
      TabIndex        =   32
      Top             =   5280
      Width           =   3060
   End
End
  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

  Sub Check3D10_Click (Value As Integer)
    If Check3D10.Value = True Then MsgBox "Note: You must have the ""Notify Me When Members Leave"" box *checked* on your AOL chat preferences for this to work."

  End Sub

  Sub Check3D14_Click (Value As Integer)
    If Check3D14.Value = True Then MsgBox "Note: You must have the ""Notify Me When Members Arrive"" box *checked* on your AOL chat preferences for this to work."


  End Sub

  Sub Check3D7_Click (Value As Integer)

  'If Check3D7.Value = True Then
  'MsgBox "Sorry, this event is not ready.  It will be available in an upcoming beta version.", 64, "AI Bot" ' "Note: You must have the ""Notify Me When Members Arrive"" box *checked* on your AOL chat preferences for this to work."
  'Check3D7.Value = False
  'End If

  End Sub

  Sub Check3D8_Click (Value As Integer)

    If Check3D8.Value = True Then MsgBox "Note: You must have the ""Notify Me When Members Leave"" box *checked* on your AOL chat preferences for this to work."

  End Sub

  Sub Check3D9_Click (Value As Integer)
    If Check3D9.Value = True Then MsgBox "Note: You must have the ""Notify Me When Members Arrive"" box *checked* on your AOL chat preferences for this to work."

  End Sub

  Sub Command3D1_Click ()
    MessageNum = 1
    Action.Show

  End Sub

  Sub Command3D1_GotFocus ()
    Command3D1.FontBold = True


  End Sub

  Sub Command3D1_LostFocus ()
    Command3D1.FontBold = False


  End Sub

  Sub Command3D10_Click ()
    Message7 = InputBox$("Please enter the persons Screen Name.", "Screen Name")

    Message7Sp = Message7



  End Sub

  Sub Command3D10_GotFocus ()
    Command3D10.FontBold = True


  End Sub

  Sub Command3D10_LostFocus ()
    Command3D10.FontBold = False


  End Sub

  Sub Command3D11_Click ()
    MessageNum = 8
    Action.Show


  End Sub

  Sub Command3D11_GotFocus ()
    Command3D11.FontBold = True


  End Sub

  Sub Command3D11_LostFocus ()
    Command3D11.FontBold = False


  End Sub

  Sub Command3D12_Click ()
    Person2 = InputBox$("Please enter the persons Screen Name.", "Screen Name")

    Person2Sp = Person2


  End Sub

  Sub Command3D12_GotFocus ()
    Command3D12.FontBold = True


  End Sub

  Sub Command3D12_LostFocus ()
    Command3D12.FontBold = False


  End Sub

  Sub Command3D13_Click ()
    MessageNum = 9
    Action.Show


  End Sub

  Sub Command3D13_GotFocus ()
    Command3D13.FontBold = True


  End Sub

  Sub Command3D13_LostFocus ()
    Command3D13.FontBold = False


  End Sub

  Sub Command3D14_Click ()
    Person3 = InputBox$("Please enter the persons Screen Name.", "Screen Name")

    Person3Sp = Person3

  End Sub

  Sub Command3D14_GotFocus ()
    Command3D14.FontBold = True


  End Sub

  Sub Command3D14_LostFocus ()
    Command3D14.FontBold = False


  End Sub

  Sub Command3D15_Click ()
    MessageNum = 10
    Action.Show


  End Sub

  Sub Command3D15_GotFocus ()
    Command3D15.FontBold = True


  End Sub

  Sub Command3D15_LostFocus ()
    Command3D15.FontBold = False


  End Sub

  Sub Command3D16_Click ()
    Person4 = InputBox$("Please enter the persons Screen Name.", "Screen Name")

    Person4Sp = Person4

  End Sub

  Sub Command3D16_GotFocus ()
    Command3D16.FontBold = True


  End Sub

  Sub Command3D16_LostFocus ()
    Command3D16.FontBold = False


  End Sub

  Sub Command3D17_Click ()
    Word3 = InputBox$("Please enter the word, or words.", "Key Words")

    Word3Sp = Word3

  End Sub

  Sub Command3D17_GotFocus ()
    Command3D17.FontBold = True

  End Sub

  Sub Command3D17_LostFocus ()
    Command3D17.FontBold = False


  End Sub

  Sub Command3D18_Click ()
    Person5 = InputBox$("Please enter the persons Screen Name.", "Screen Name")

    Person5Sp = Person5

  End Sub

  Sub Command3D18_GotFocus ()
    Command3D18.FontBold = True


  End Sub

  Sub Command3D18_LostFocus ()
    Command3D18.FontBold = False


  End Sub

  Sub Command3D19_Click ()
    Timer2.Enabled = True
    Timer1.Enabled = False
    Command3D2.Visible = True
    AIBot.Hide

  End Sub

  Sub Command3D2_Click ()
    Person1 = InputBox$("Please enter the persons Screen Name.", "Screen Name")

    Person1Sp = Person1


  End Sub

  Sub Command3D2_GotFocus ()
    Command3D2.FontBold = True


  End Sub

  Sub Command3D2_LostFocus ()
    Command3D2.FontBold = False


  End Sub

  Sub Command3D20_Click ()
    SendKeys "{F1}"
    DoEvents

  End Sub

  Sub Command3D21_Click ()
    GoTo Begin1

titfuck1:
    Exit Sub

Begin1:
    On Error GoTo titfuck1

    CMDialog1.DialogTitle = "Open AI Bot Settings File"
    CMDialog1.Action = 1

    xfilnam$ = CMDialog1.Filename

    Open xfilnam$ For Input As #1

    Input #1, Check1, Check2, Check3, Check4, Check5, Check6, Check7, Check8, Check9, Check10, Check11, Check12, Check13, Check14, Check15, Check16, Check17, Check18, Check19, Check20, Check21, Message1Sp, Message2Sp, Message3Sp, Message4Sp, Message5Sp, Message6Sp, Message7Sp, Message8Sp, Message9Sp, Message10Sp, Person1Sp, Person2Sp, Person3Sp, Person4Sp, Word1Sp, Word2Sp, Word3Sp, Word4Sp, Event1, Event2, Event3, Event4, Event5, Event6, Event7, Event8, Event9, Event10, SendTo1, SendTo2, SendTo3, SendTo4, SendTo5, SendTo6, SendTo7, SendTo8, SendTo9, SendTo10, MSubject1, MSubject2, MSubject3, MSubject4, MSubject5, MSubject6, MSubsect7, MSubject8, MSubject9, MSubject10, MMessage1, MMessage2, MMessage3, MMessage4, MMessage5, MMessage6, MMessage7, MMessage8, MMessage9, MMessage10, IMTo1, IMTo2, IMTo3, IMTo4, IMTo5, IMTo6, IMTo7, IMTo8, IMTo9, IMTo10, IMess1, IMess2, IMess3, IMess4, IMess5, IMess6, IMess7, IMess8, IMess9, IMess10, RName1, RName2, RName3, RName4, RName5, RName6, RName7, RName8, RName9, RName10
    Close #1

    If Check1 = "1" Then
      Check3D1.Value = True
    Else
      Check3D1.Value = False
    End If
    If Check2 = "1" Then
      Check3D2.Value = True
    Else
      Check3D2.Value = False
    End If
    If Check3 = "1" Then
      Check3D3.Value = True
    Else
      Check3D3.Value = False
    End If
    If Check4 = "1" Then
      Check3D4.Value = True
    Else
      Check3D4.Value = False
    End If
    If Check5 = "1" Then
      Check3D5.Value = True
    Else
      Check3D5.Value = False
    End If
    If Check6 = "1" Then
      Check3D6.Value = True
    Else
      Check3D6.Value = False
    End If
    If Check7 = "1" Then
      Check3D7.Value = True
    Else
      Check3D7.Value = False
    End If
    If Check8 = "1" Then
      Check3D8.Value = True
    Else
      Check3D8.Value = False
    End If
    If Check9 = "1" Then
      Check3D9.Value = True
    Else
      Check3D9.Value = False
    End If
    If Check10 = "1" Then
      Check3D10.Value = True
    Else
      Check3D10.Value = False
    End If
    If Check11 = "1" Then
      Check3D11.Value = True
    Else
      Check3D11.Value = False
    End If
    If Check12 = "1" Then
      Check3D12.Value = True
    Else
      Check3D12.Value = False
    End If
    If Check13 = "1" Then
      Check3D13.Value = True
    Else
      Check3D13.Value = False
    End If
    If Check14 = "1" Then
      Check3D14.Value = True
    Else
      Check3D14.Value = False
    End If
    If Check15 = "1" Then
      Check3D15.Value = True
    Else
      Check3D15.Value = False
    End If
    If Check16 = "1" Then
      Check3D16.Value = True
    Else
      Check3D16.Value = False
    End If
    If Check17 = "1" Then
      Check3D17.Value = True
    Else
      Check3D17.Value = False
    End If
    If Check18 = "1" Then
      Check3D18.Value = True
    Else
      Check3D18.Value = False
    End If
    If Check19 = "1" Then
      Check3D19.Value = True
    Else
      Check3D19.Value = False
    End If
    If Check20 = "1" Then
      Check3D20.Value = True
    Else
      Check3D20.Value = False
    End If

  End Sub

  Sub Command3D22_Click ()
    GoTo begin2

titfuck2:
    Exit Sub


begin2:

    If Check3D1.Value = True Then
      Check1 = "1"
    Else
      Check1 = "0"
    End If
    If Check3D2.Value = True Then
      Check2 = "1"
    Else
      Check2 = "0"
    End If
    If Check3D3.Value = True Then
      Check3 = "1"
    Else
      Check3 = "0"
    End If
    If Check3D4.Value = True Then
      Check4 = "1"
    Else
      Check4 = "0"
    End If
    If Check3D5.Value = True Then
      Check5 = "1"
    Else
      Check5 = "0"
    End If
    If Check3D6.Value = True Then
      Check6 = "1"
    Else
      Check6 = "0"
    End If
    If Check3D7.Value = True Then
      Check7 = "1"
    Else
      Check7 = "0"
    End If
    If Check3D8.Value = True Then
      Check8 = "1"
    Else
      Check8 = "0"
    End If
    If Check3D9.Value = True Then
      Check9 = "1"
    Else
      Check9 = "0"
    End If
    If Check3D10.Value = True Then
      Check10 = "1"
    Else
      Check10 = "0"
    End If
    If Check3D11.Value = True Then
      Check11 = "1"
    Else
      Check11 = "0"
    End If
    If Check3D12.Value = True Then
      Check12 = "1"
    Else
      Check12 = "0"
    End If
    If Check3D13.Value = True Then
      Check13 = "1"
    Else
      Check13 = "0"
    End If
    If Check3D14.Value = True Then
      Check14 = "1"
    Else
      Check14 = "0"
    End If
    If Check3D15.Value = True Then
      Check15 = "1"
    Else
      Check15 = "0"
    End If
    If Check3D16.Value = True Then
      Check16 = "1"
    Else
      Check16 = "0"
    End If
    If Check3D17.Value = True Then
      Check17 = "1"
    Else
      Check17 = "0"
    End If
    If Check3D18.Value = True Then
      Check18 = "1"
    Else
      Check18 = "0"
    End If
    If Check3D19.Value = True Then
      Check19 = "1"
    Else
      Check19 = "0"
    End If
    If Check3D20.Value = True Then
      Check20 = "1"
    Else
      Check20 = "0"
    End If
    If Check3D21.Value = True Then
      Check21 = "1"
    Else
      Check21 = "0"
    End If


    On Error GoTo titfuck2

    CMDialog1.DialogTitle = "Save AI Bot Settings File"
    CMDialog1.Action = 2

    xfilnam$ = CMDialog1.Filename

    Open xfilnam$ For Output As #1
    Write #1, Check1, Check2, Check3, Check4, Check5, Check6, Check7, Check8, Check9, Check10, Check11, Check12, Check13, Check14, Check15, Check16, Check17, Check18, Check19, Check20, Check21, Message1Sp, Message2Sp, Message3Sp, Message4Sp, Message5Sp, Message6Sp, Message7Sp, Message8Sp, Message9Sp, Message10Sp, Person1Sp, Person2Sp, Person3Sp, Person4Sp, Word1Sp, Word2Sp, Word3Sp, Word4Sp, Event1, Event2, Event3, Event4, Event5, Event6, Event7, Event8, Event9, Event10, SendTo1, SendTo2, SendTo3, SendTo4, SendTo5, SendTo6, SendTo7, SendTo8, SendTo9, SendTo10, MSubject1, MSubject2, MSubject3, MSubject4, MSubject5, MSubject6, MSubsect7, MSubject8, MSubject9, MSubject10, MMessage1, MMessage2, MMessage3, MMessage4, MMessage5, MMessage6, MMessage7, MMessage8, MMessage9, MMessage10, IMTo1, IMTo2, IMTo3, IMTo4, IMTo5, IMTo6, IMTo7, IMTo8, IMTo9, IMTo10, IMess1, IMess2, IMess3, IMess4, IMess5, IMess6, IMess7, IMess8, IMess9, IMess10, RName1, RName2, RName3, RName4, RName5, RName6, RName7, RName8, RName9, RName10

    Close #1

  End Sub

  Sub Command3D23_Click ()
    Unload Me

  End Sub

  Sub Command3D3_Click ()
    Word1 = InputBox$("Please enter the word, or words.", "Key Words")

    Word1Sp = Word1

  End Sub

  Sub Command3D3_GotFocus ()
    Command3D3.FontBold = True


  End Sub

  Sub Command3D3_LostFocus ()
    Command3D3.FontBold = False


  End Sub

  Sub Command3D4_Click ()
    MessageNum = 2
    Action.Show


  End Sub

  Sub Command3D4_GotFocus ()
    Command3D4.FontBold = True


  End Sub

  Sub Command3D4_LostFocus ()
    Command3D4.FontBold = False


  End Sub

  Sub Command3D5_Click ()
    MessageNum = 3
    Action.Show


  End Sub

  Sub Command3D5_GotFocus ()
    Command3D5.FontBold = True


  End Sub

  Sub Command3D5_LostFocus ()
    Command3D19.FontBold = False


  End Sub

  Sub Command3D6_Click ()
    MessageNum = 4
    Action.Show


  End Sub

  Sub Command3D6_GotFocus ()
    Command3D6.FontBold = True


  End Sub

  Sub Command3D6_LostFocus ()
    Command3D6.FontBold = False


  End Sub

  Sub Command3D7_Click ()
    MessageNum = 5
    Action.Show
    Action.Label2.Caption = "Put in {SN} in the message to tell AOHell to insert the person's name who entered the room."
    Action.Command3D3.Visible = False
    Action.Command3D4.Visible = False


  End Sub

  Sub Command3D7_GotFocus ()
    Command3D7.FontBold = True


  End Sub

  Sub Command3D7_LostFocus ()
    Command3D7.FontBold = False


  End Sub

  Sub Command3D8_Click ()
    Word2 = InputBox$("Please enter the word, or words.", "Key Words")

    Word2Sp = Word2

  End Sub

  Sub Command3D8_GotFocus ()
    Command3D8.FontBold = True


  End Sub

  Sub Command3D8_LostFocus ()
    Command3D8.FontBold = False


  End Sub

  Sub Command3D9_Click ()
    MessageNum = 6
    Action.Show


  End Sub

  Sub Command3D9_GotFocus ()
    Command3D9.FontBold = True


  End Sub

  Sub Command3D9_LostFocus ()
    Command3D9.FontBold = False


  End Sub

  Sub Form_Load ()
    If AIStatus = 11 Then
      MsgBox "The Multi-Task Chat Room is still active.  You cannot use the AI Bot with the Multi-Task Chat Room still running.  Please close the MT Chat Room and try again.", 16, "MT Chat Room Still Active"
      Unload Me
      Exit Sub
    End If
    If AIStatus = 12 Then
      MsgBox "The Warez Bot is still active.  You cannot use the AI Bot with the Warez Bot still running.  Please stop the Warez Bot and try again.", 16, "Warez Bot Still Active"
      Unload Me
      Exit Sub
    End If


    AIStatus = 1

    Dim Success As Integer

    Success% = SetWindowPos%(AIBot.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)
    GoTo AIBeg

AIErr:
    MsgBox "An error has occured while trying to start the bot.  Please close that Chat Room window, then re-enter the room you are in.  You may then try again.    NOTE: If you have the Warez Bot or Multi-Task Chat Room running, it will cause this error.", 48, "Can't Get Window Lock"
    Unload Me
    Exit Sub


AIBeg:
    On Error GoTo AIErr

  'MsgBox "AOHell needs to get a lock on the chat room window now.  Please click the chat room with the mouse, so it is the top AOL window.  Then hit the OK button to this message.", 64, "Chat Window Lock"

  'thiswin% = FindWindow(0, "America  Online")

    bac = Chr$(13)
    jojo4 = "List" + bac + "Rooms"
    thiswin% = FindWindow(0, "America  Online")
    RoomIcon = FindChildByTitle(thiswin%, jojo4)
    DaRoom = GetParent(RoomIcon)
    If DaRoom = 0 Then
      MsgBox "You must be in a room before you can use this!", 16, "Not In a Room"
      Unload Me
      Exit Sub
    End If

    find% = FindChildByClass(DaRoom, "_AOL_View")
    find1% = FindChildByClass(DaRoom, "_AOL_Edit")
    find2% = FindChildByTitle(DaRoom, "Send")


    AOLViewHandle = find%
    AOLSendHandle = find2%
    AOLEditHandle = find1%


    VBMsg2.SubClasshWnd = find1%
    VBMsg1.SubClasshWnd = find2%
    VBMsg4.SubClasshWnd = AOLViewHandle
    Timer2.Enabled = False
    Timer1.Enabled = True

  End Sub

  Sub Form_Resize ()
    Dim Success As Integer

    Success% = SetWindowPos%(AIBot.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

  End Sub

  Sub Form_Unload (Cancel As Integer)
    If AIStatus = 1 Then AIStatus = 0
    VBMsg1.SubClasshWnd = 0
    VBMsg2.SubClasshWnd = 0
    VBMsg3.SubClasshWnd = 0

  End Sub

  Sub Label1_Click ()
    If Check3D2.Value = False Then
      Check3D2.Value = True
    Else
      Check3D2.Value = False
    End If

  End Sub

  Sub Label2_Click ()
    If Check3D2.Value = False Then
      Check3D2.Value = True
    Else
      Check3D2.Value = False
    End If

  End Sub

  Sub Timer1_Timer ()
    Text1.Text = ChatLine
  End Sub

  Sub Timer2_Timer ()
    If DoGo = 1 Then GoTo Startup

Err2:
    Exit Sub

Startup:
    On Error GoTo Err2
    DoEvents
    DoGo = 0
    
   ' ChatLine = Trim$(ChatLine)
   ' ChatLine = Mid$(ChatLine, 3)
    ChatLineSp = ChatLine
    chat6 = ChatLine
    DoEvents

    colon = ":"

    l% = InStr(1, chat6, colon)
    If l% > 0 Then

      l% = l% - 1
    Else l% = 1
    End If

    SN = Mid$(chat6, 1, l%)
  ' text2.Text = SN
    ChatName = SN
    ChatNameSp = SN
    SaidChat1 = 1
    
 DoEvents
 
    If ChatLine = LastChat Then Exit Sub

    thiswin% = FindWindow(0, "America  Online")

    Destroy1 = FindChildByClass(thiswin%, "_AOL_Listbox")

    If Destroy1 = 0 Then
      MsgBox "AOHell has detected that the AOL chat window has been closed.  ..Shutting down AI Bot", 64, "Room Closed"
      Destroyed = 0
      Unload AIBot
      Exit Sub
    End If

    ChatLine = UCase$(ChatLine)

    If ChatLine = LastChat Then

      Exit Sub

    Else

      If Event1 = 7 Or Event2 = 7 Or Event3 = 7 Or Event4 = 7 Or Event6 = 7 Or Event7 = 7 Or Event8 = 7 Or Event9 = 7 Or Event10 = 7 Then
        ChatNameSp1 = ChatNameSp
        If Check3D5.Value = True Then
          HCame1 = InStr(ChatLineSp, ":")
          HCame2 = HCame1 + 2
          ThisWeird = InStr(ChatLineSp, "has entered")
          ThisWeird = ThisWeird - 2
          HCame3 = Mid$(ChatLineSp, HCame2, ThisWeird)
          HCame4 = InStr(HCame3, "has entered")
          HCame5 = HCame4 - 2
          HCame6 = Mid$(HCame3, 1, HCame5)
          ChatNameSp1 = HCame6
        End If

        YMS1 = ChatNameSp1 + ", Yo momma's so poor, she goes to KFC and licks other people's fingers!"
        YMS2 = ChatNameSp1 + ", Yo momma's so stupid, it takes her an hour to cook minute rice!"
        YMS3 = ChatNameSp1 + ", Yo momma's so fat, she uses a VCR for a pager!"
        YMS4 = ChatNameSp1 + ", Yo momma's so fat, she's protected by Green Peace!"
        YMS5 = ChatNameSp1 + ", Yo momma's so ugly, when she walks into Taco Bell everyone runs for the border!"
        YMS6 = ChatNameSp1 + ", Yo momma's so fat, I saw the back of her neck and thought I was in a library!"
        YMS7 = ChatNameSp1 + ", Yo momma's so stupid, she gave your uncle a blowjob to help his unemployment!"
        YMS8 = ChatNameSp1 + ", Yo momma's so stupid, she tripped over her cordless phone!"
        YMS9 = ChatNameSp1 + ", Yo momma's so short, she gotta cuff her panties!"
        YMS10 = ChatNameSp1 + ", Yo momma's so fat she on both sides of the family!"
        YMS11 = ChatNameSp1 + ", Yo momma's so ugly she had to go trick or treatin' over the phone!"
        YMS12 = ChatNameSp1 + ", Yo momma stink so bad she used Secret and it told!"
        YMS13 = ChatNameSp1 + ", Yo momma's so nasty I had phone sex with her and she gave me an ear infection"
        YMS14 = ChatNameSp1 + ", Yo momma's so fat she got to take her pants off to get her change!"
        YMS15 = ChatNameSp1 + ", Yo momma's is like a door knob, everyone gets a turn!"
        YMS16 = ChatNameSp1 + ", Yo momma stink so bad she used Sure and it got confused!"
        YMS17 = ChatNameSp1 + ", Yo momma's teeth so yellow when she simles you got to slow down!"
        YMS18 = ChatNameSp1 + ", Yo momma's so fat she got more chins than a Chinese telephone book!"
        YMS19 = ChatNameSp1 + ", Yo momma's so fat her blood type is Ragu!"
        YMS20 = ChatNameSp1 + ", Yo momma's so hairy, big foot took a picture of her!"
        YMS21 = ChatNameSp1 + ", Yo momma's so tall she did a cartwheel and kicked god in the chin!"
        YMS22 = ChatNameSp1 + ", Yo momma's so stupid she thought denial was a river in Egypt!"
        YMS23 = ChatNameSp1 + ", Yo momma's so stupid she got stabbed in a gun fight!"
        YMS24 = ChatNameSp1 + ", Yo momma's so old her Social Security Number is 1"
        YMS25 = ChatNameSp1 + ", Yo momma's so stupid she went to the movies with 16 other PPL because she thought under 17 not admitted!"
        YMS26 = ChatNameSp1 + ", Yo momma stink so bad she made Right Guard turn left!"
        YMS27 = ChatNameSp1 + ", Yo momma's like a video game, 3 Men for a quarter!"
        YMS28 = ChatNameSp1 + ", Yo momma's so fat she jumped for joy and got stuck!"
        YMS29 = ChatNameSp1 + ", Yo momma gums so black she spits out YooHoo!"
        YMS30 = ChatNameSp1 + ", Yo momma's teeth so yellow ""I can't believe it's not butter!"""
        YMS31 = ChatNameSp1 + ", Yo momma's so ugly she went into a haunted house and came out with a job application!"
        YMS32 = "Oh yeah, " + ChatNameSp1 + ", tell your mamma I said thanks!"
      End If

      If SInsult1 = 2 Or SInsult2 = 2 Or SInsult3 = 2 Or SInsult4 = 2 Or SInsult5 = 2 Or SInsult6 = 2 Or SInsult7 = 2 Or SInsult8 = 2 Or SInsult9 = 2 Or SInsult10 = 2 Then
        Randomize

        upperbound = 32
        lowerbound = 1

        RandomChoice = Int((upperbound - lowerbound + 1) * Rnd + lowerbound)

        If RandomChoice = 1 Then DaInsult = YMS1
        If RandomChoice = 2 Then DaInsult = YMS2
        If RandomChoice = 3 Then DaInsult = YMS3
        If RandomChoice = 4 Then DaInsult = YMS4
        If RandomChoice = 5 Then DaInsult = YMS5
        If RandomChoice = 6 Then DaInsult = YMS6
        If RandomChoice = 7 Then DaInsult = YMS7
        If RandomChoice = 8 Then DaInsult = YMS8
        If RandomChoice = 9 Then DaInsult = YMS9
        If RandomChoice = 10 Then DaInsult = YMS10
        If RandomChoice = 11 Then DaInsult = YMS11
        If RandomChoice = 12 Then DaInsult = YMS12
        If RandomChoice = 13 Then DaInsult = YMS13
        If RandomChoice = 14 Then DaInsult = YMS14
        If RandomChoice = 15 Then DaInsult = YMS15
        If RandomChoice = 16 Then DaInsult = YMS16
        If RandomChoice = 17 Then DaInsult = YMS17
        If RandomChoice = 18 Then DaInsult = YMS18
        If RandomChoice = 19 Then DaInsult = YMS19
        If RandomChoice = 20 Then DaInsult = YMS20
        If RandomChoice = 21 Then DaInsult = YMS21
        If RandomChoice = 22 Then DaInsult = YMS22
        If RandomChoice = 23 Then DaInsult = YMS23
        If RandomChoice = 24 Then DaInsult = YMS24
        If RandomChoice = 25 Then DaInsult = YMS25
        If RandomChoice = 26 Then DaInsult = YMS26
        If RandomChoice = 27 Then DaInsult = YMS27
        If RandomChoice = 28 Then DaInsult = YMS28
        If RandomChoice = 29 Then DaInsult = YMS29
        If RandomChoice = 30 Then DaInsult = YMS30
        If RandomChoice = 31 Then DaInsult = YMS31
        If RandomChoice = 32 Then DaInsult = YMS32
      End If

      LastChat = ChatLine
      LastChat = UCase$(LastChat)


      Message1 = UCase$(Message1)
      Message2 = UCase$(Message2)
      Message3 = UCase$(Message3)
      Message4 = UCase$(Message4)
      Message5 = UCase$(Message5)
      Message6 = UCase$(Message6)
      Message7 = UCase$(Message7)
      Message8 = UCase$(Message8)
      Message9 = UCase$(Message9)
      Message10 = UCase$(Message10)

      Person1 = UCase$(Person1)
      Person2 = UCase$(Person2)
      Person3 = UCase$(Person3)
      Person4 = UCase$(Person4)
      Person5 = UCase$(Person5)

      Word1 = UCase$(Word1)
      Word2 = UCase$(Word2)
      Word3 = UCase$(Word3)


    'ChatLineSp = ChatLine
    'ChatNameSp = ChatName

      ChatLine = UCase$(ChatLine)
      ChatName = UCase$(ChatName)


      LastChat = ChatLine

    '14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14

      If Check3D14.Value = True Then


        InRoom1 = InStr(ChatLine, "HAS ENTERED THE ROOM.")
        InRoom2 = InStr(ChatLine, "HAS LEFT THE ROOM.")

        If InRoom1 > 0 Then
          HCame1 = InStr(ChatLineSp, ":")
          HCame2 = HCame1 + 2
          ThisWeird = InStr(ChatLineSp, "has entered")
          ThisWeird = ThisWeird - 2
          HCame3 = Mid$(ChatLineSp, HCame2, ThisWeird)
          HCame4 = InStr(HCame3, "has entered")
          HCame5 = HCame4 - 2
          HCame6 = Mid$(HCame3, 1, HCame5)
          DaGuide = HCame6
        End If

        If InRoom2 > 0 Then
          HCame1 = InStr(ChatLineSp, ":")
          HCame2 = HCame1 + 2
          ThisWeird = InStr(ChatLineSp, "has left")
          ThisWeird = ThisWeird - 2
          HCame3 = Mid$(ChatLineSp, HCame2, ThisWeird)
          HCame4 = InStr(HCame3, "has left")
          HCame5 = HCame4 - 2
          HCame6 = Mid$(HCame3, 1, HCame5)
          DaGuide = HCame6
        End If


        If InRoom2 > 0 And Option1.Value = True Then
          InPer2 = InStr(ChatLine, TheGuide)
        End If
        If InPer2 > 0 Then
          If ch1 = 1 Then Check3D1.Value = True
          If ch2 = 1 Then Check3D2.Value = True
          If ch3 = 1 Then Check3D3.Value = True
          If ch4 = 1 Then Check3D4.Value = True
          If ch5 = 1 Then Check3D5.Value = True
          If ch6 = 1 Then Check3D6.Value = True
          If ch7 = 1 Then Check3D7.Value = True
          If ch8 = 1 Then Check3D8.Value = True
          If ch9 = 1 Then Check3D9.Value = True
          If ch10 = 1 Then Check3D10.Value = True
          If ch11 = 1 Then Check3D11.Value = True
          If ch12 = 1 Then Check3D12.Value = True
          If ch13 = 1 Then Check3D13.Value = True
          If ch21 = 1 Then Check3D21.Value = True

        'Timer1.Enabled = True
        'Timer2.Enabled = True
          Unload Attention
        End If

        If InRoom1 > 0 Then
          InPer1 = InStr(ChatLine, "GUIDE") '<---Should be "GUIDE"
        End If

        If InPer1 > 0 Then
          If Option2.Value = True Then
            Response = MsgBox("A Guide (" + DaGuide + ") has entered the room!  Would you like to shut down the AI Bot?", 36, "Guide Alert!")
          'Possible Response values: 6--YES, 7--NO.
            If Response = 6 Then
              Unload Me
            ElseIf Response = 7 Then do1 = 2

            End If

          End If
          If Option1.Value = True Then
            TheGuide = UCase$(DaGuide)
            If Check3D1.Value = True Then ch1 = 1
            If Check3D2.Value = True Then ch2 = 1
            If Check3D3.Value = True Then ch3 = 1
            If Check3D4.Value = True Then ch4 = 1
            If Check3D5.Value = True Then ch5 = 1
            If Check3D6.Value = True Then ch6 = 1
            If Check3D7.Value = True Then ch7 = 1
            If Check3D8.Value = True Then ch8 = 1
            If Check3D9.Value = True Then ch9 = 1
            If Check3D10.Value = True Then c10 = 1
            If Check3D11.Value = True Then c11 = 1
            If Check3D12.Value = True Then ch12 = 1
            If Check3D13.Value = True Then ch13 = 1
            If Check3D21.Value = True Then ch21 = 1
            Check3D1.Value = False
            Check3D2.Value = False
            Check3D3.Value = False
            Check3D4.Value = False
            Check3D5.Value = False
            Check3D6.Value = False
            Check3D7.Value = False
            Check3D8.Value = False
            Check3D9.Value = False
            Check3D10.Value = False
            Check3D11.Value = False
            Check3D12.Value = False
            Check3D13.Value = False
            Check3D21.Value = False

          'Timer1.Enabled = False
          'Timer2.Enabled = False
            Attention.Show
            Attention.Label1.Caption = "A Guide (" + DaGuide + ") has entered the room.  Tempararily pausing the AI Bot until " + DaGuide + " leaves."
            AppActivate "America  Online"
            DoEvents
          End If
        End If
      End If



    '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1


      If Check3D1.Value = True Then
       ' MsgBox ChatLine
       ' MsgBox ChatLineSp

        Said1 = InStr(ChatLine, "FUCK")
        Said2 = InStr(ChatLine, "SHIT")
        Said3 = InStr(ChatLine, "BITCH")
        Said4 = InStr(ChatLine, " ASS ")
        Said5 = InStr(ChatLine, "JACKOFF")
        Said6 = InStr(ChatLine, "COCK")
        Said7 = InStr(ChatLine, "PUSSY")
        Said8 = InStr(ChatLine, "WHORE")
        Said9 = InStr(ChatLine, "FAGGOT")
        Said10 = InStr(ChatLine, "SLUT")
        Said11 = InStr(ChatLine, "ASSHOLE")
        Said12 = InStr(ChatLine, "CUNT")
        Said13 = InStr(ChatLine, "DICKHEAD")
      '  MsgBox Len(ChatLine)
      '  MsgBox Str(Said1) + Str(Said2) + Str(Said3) + Str(Said4) + Str(Said5) + Str(Said6) + Str(Said7) + Str(Said8) + Str(Said9) + Str(Said10) + Str(Said11) + Str(Said12) + Str(Said13)

        Name1 = InStr(Message1, "{SN}")

        If Name1 > 0 Then
          Name3 = Name1 - 1
          Part1 = Mid$(Message1Sp, 1, Name3)
          Name2 = Name1 + 4
          Part2 = Mid$(Message1Sp, Name2)
        End If

   If Said1 > 104 Or Said2 > 104 Or Said3 > 104 Or Said4 > 104 Or Said5 > 104 Or Said6 > 104 Or Said7 > 104 Or Said8 > 104 Or Said9 > 104 Or Said10 > 104 Or Said11 > 104 Or Said12 > 104 Or Said13 > 104 Then GoTo Nect
        If Said1 Or Said2 Or Said3 Or Said4 Or Said5 Or Said6 Or Said7 Or Said8 Or Said9 Or Said10 Or Said11 Or Said12 Or Said13 > 0 Then
          Werd1 = InStr(ChatNameSp, ScreenName)
          DidHostSay = InStr(ChatNameSp, "OnlineHost")
          If Werd1 > 0 Or DidHostSay > 0 Then GoTo Nect



          If Event1 = 1 Then


          '*********************Send Message Beginning

            lint = 2000 '7500
            If Name1 > 0 Then

              lpstring = Part1 + ChatNameSp + Part2
            Else
              lpstring = Message1Sp
            End If

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP


          End If


          If Event1 = 7 Then


            If InsultNum1 = "1" Then DaInsult = YMS1
            If InsultNum1 = "2" Then DaInsult = YMS2
            If InsultNum1 = "3" Then DaInsult = YMS3
            If InsultNum1 = "4" Then DaInsult = YMS4
            If InsultNum1 = "5" Then DaInsult = YMS5
            If InsultNum1 = "6" Then DaInsult = YMS6
            If InsultNum1 = "7" Then DaInsult = YMS7
            If InsultNum1 = "8" Then DaInsult = YMS8
            If InsultNum1 = "9" Then DaInsult = YMS9
            If InsultNum1 = "10" Then DaInsult = YMS10
            If InsultNum1 = "11" Then DaInsult = YMS11
            If InsultNum1 = "12" Then DaInsult = YMS12
            If InsultNum1 = "13" Then DaInsult = YMS13
            If InsultNum1 = "14" Then DaInsult = YMS14
            If InsultNum1 = "15" Then DaInsult = YMS15
            If InsultNum1 = "16" Then DaInsult = YMS16
            If InsultNum1 = "17" Then DaInsult = YMS17
            If InsultNum1 = "18" Then DaInsult = YMS18
            If InsultNum1 = "19" Then DaInsult = YMS19
            If InsultNum1 = "20" Then DaInsult = YMS20
            If InsultNum1 = "21" Then DaInsult = YMS21
            If InsultNum1 = "22" Then DaInsult = YMS22
            If InsultNum1 = "23" Then DaInsult = YMS23
            If InsultNum1 = "24" Then DaInsult = YMS24
            If InsultNum1 = "25" Then DaInsult = YMS25
            If InsultNum1 = "26" Then DaInsult = YMS26
            If InsultNum1 = "27" Then DaInsult = YMS27
            If InsultNum1 = "28" Then DaInsult = YMS28
            If InsultNum1 = "29" Then DaInsult = YMS29
            If InsultNum1 = "30" Then DaInsult = YMS30
            If InsultNum1 = "31" Then DaInsult = YMS31
            If InsultNum1 = "32" Then DaInsult = YMS32

            lint = 2000

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
          End If


          If Event1 = 5 Then
            bac = Chr$(13)
            jojo4 = "List" + bac + "Rooms"
            thiswin% = FindWindow(0, "America  Online")
            RoomIcon = FindChildByTitle(thiswin%, jojo4)
          'MsgBox Str(RoomIcon)
            RoomIcon = RoomIcon + 4

            On Error GoTo Con4
            VBMsg3.SubClasshWnd = RoomIcon
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1)
            SendKeys "{ESC 3}"
            DoEvents
            Call Pause(3)
            DoEvents

            If TypeR1 = 1 Then
              CreateBut = FindChildByTitle(thiswin%, "Create Room")
              VBMsg3.SubClasshWnd = CreateBut
              VBMsg3.SendMessage = WM_LBUTTONDOWN
              VBMsg3.SendMessage = WM_LBUTTONUP
              DoEvents
              Call Pause(2)
              MemWin = FindChildByTitle(thiswin%, "Create a Member Room")
              MemEdit = FindChildByClass(MemWin, "_AOL_Edit")
              lint = 3000
              lpstring = RName1
              SendIM = SendMessageByString(MemEdit, WM_SETTEXT, lint, lpstring)
              DoEvents
              SendKeys "{ENTER}"
            End If

            If TypeR1 = 2 Then
              PrivateBut = FindChildByTitle(thiswin%, "Private Room")
              VBMsg3.SubClasshWnd = PrivateBut
              VBMsg3.SendMessage = WM_LBUTTONDOWN
              VBMsg3.SendMessage = WM_LBUTTONUP
              DoEvents
              Call Pause(2)
              MemWin = FindChildByTitle(thiswin%, "Enter a Private Room")
              MemEdit = FindChildByClass(MemWin, "_AOL_Edit")
              lint = 3000
              lpstring = RName1
              SendIM = SendMessageByString(MemEdit, WM_SETTEXT, lint, lpstring)
              DoEvents
              SendKeys "{ENTER}"
            End If

          End If

Con4:
          On Error GoTo Err2


          If Event1 = 3 Then
            TempName = ChatNameSp

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%B{DOWN 3}{ENTER}"
            DoEvents
            Call Pause(.4)
            lint = 3000
            thiswin% = FindWindow(0, "America  Online")
            InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
            IMEdit1 = VBEnumChildWindows(InstantWin, 2)
            IMEdit = VBEnumChildWindows(InstantWin, 3)

            lpstring = IMTo1
            DidIM = InStr(lpstring, "{SN}")
            If DidIM > 0 Then
              lpstring = TempName
            End If
            SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
            DoEvents
            lpstring = IMess1
            SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
            DoEvents
            SendButton = FindChildByTitle(InstantWin, "Send")
            VBMsg1.SubClasshWnd = SendButton
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1.5)
            MBox = FindWindow(0, "America Online")
            If MBox <> 0 Then
              DoEvents
              SendKeys "{ENTER}"
              DoEvents
            End If
          End If

          If Event1 = 2 Then
            NameTemp = ChatNameSp
            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%MC"
            DoEvents
            Call Pause(.5)
            thiswin% = FindWindow(0, "America  Online")
            ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
            SendButton2 = VBEnumChildWindows(ComposeHand, 2)
            ToField = VBEnumChildWindows(ComposeHand, 10)
            SubField = VBEnumChildWindows(ComposeHand, 14)
            MsgField = VBEnumChildWindows(ComposeHand, 17)
            VBMsg3.SubClasshWnd = SendButton2
            lint = 20000    '7500
            lpstring = SendTo1
            DidName = InStr(SendTo1, "{SN}")
            If DidName > 0 Then lpstring = NameTemp
            ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)   ',lint
            DoEvents
            lpstring = MSubject1
            SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            lpstring = MMessage1

            MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            Call Pause(.3)
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents

            thiswin2% = FindWindow(0, "America Online")
            While thiswin2% = 0
              DoEvents
              thiswin2% = FindWindow(0, "America Online")
            Wend
            DoEvents
            Call Pause(.2)
            SendKeys "{ENTER}"

          End If
        End If
      End If


    '222222222222222222222222222222222222222222222222222222222222

Nect:

    'DidHostSay = InStr(ChatNameSp, "OnlineHost")
    ' If DidHostSay > 0 Then Exit Sub

      If Check3D2.Value = True Then

        ChatName2 = InStr(ChatName, Person1)

        If ChatName2 > 0 Then

          ChatLine2 = InStr(ChatLine, Word1)

          If ChatLine2 > 0 Then


            If Event2 = 3 Then
              TempName = ChatNameSp

              DoEvents
              AppActivate "America  Online"
              DoEvents
              SendKeys "%B{DOWN 3}{ENTER}"
              DoEvents
              Call Pause(.4)
              lint = 3000
              thiswin% = FindWindow(0, "America  Online")
              InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
              IMEdit1 = VBEnumChildWindows(InstantWin, 2)
              IMEdit = VBEnumChildWindows(InstantWin, 3)

              lpstring = IMTo2
              DidIM = InStr(lpstring, "{SN}")
              If DidIM > 0 Then
                lpstring = TempName
              End If
              SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
              DoEvents
              lpstring = IMess2
              SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
              DoEvents
              SendButton = FindChildByTitle(InstantWin, "Send")
              VBMsg1.SubClasshWnd = SendButton
              VBMsg1.SendMessage = WM_LBUTTONDOWN
              VBMsg1.SendMessage = WM_LBUTTONUP
              DoEvents
              Call Pause(1.5)
              MBox = FindWindow(0, "America Online")
              If MBox <> 0 Then
                DoEvents
                SendKeys "{ENTER}"
                DoEvents
              End If
            End If


            If Event2 = 1 Then



              Name1 = InStr(Message2, "{SN}")

              If Name1 > 0 Then
                Name3 = Name1 - 1
                Part1 = Mid$(Message2Sp, 1, Name3)
                Name2 = Name1 + 4
                Part2 = Mid$(Message2Sp, Name2)
              End If


              lint = 2000   '7500
              If Name1 > 0 Then

                lpstring = Part1 + ChatNameSp + Part2
              Else
                lpstring = Message2Sp
              End If


              X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)    ',lint

              If Check3D1.Value = True Then
                DoEvents
                Call Pause(.4)
              End If

              VBMsg1.SendMessage = WM_LBUTTONDOWN
              VBMsg1.SendMessage = WM_LBUTTONUP


            End If

            If Event2 = 7 Then
              If InsultNum2 = "1" Then DaInsult = YMS1
              If InsultNum2 = "2" Then DaInsult = YMS2
              If InsultNum2 = "3" Then DaInsult = YMS3
              If InsultNum2 = "4" Then DaInsult = YMS4
              If InsultNum2 = "5" Then DaInsult = YMS5
              If InsultNum2 = "6" Then DaInsult = YMS6
              If InsultNum2 = "7" Then DaInsult = YMS7
              If InsultNum2 = "8" Then DaInsult = YMS8
              If InsultNum2 = "9" Then DaInsult = YMS9
              If InsultNum2 = "10" Then DaInsult = YMS10
              If InsultNum2 = "11" Then DaInsult = YMS11
              If InsultNum2 = "12" Then DaInsult = YMS12
              If InsultNum2 = "13" Then DaInsult = YMS13
              If InsultNum2 = "14" Then DaInsult = YMS14
              If InsultNum2 = "15" Then DaInsult = YMS15
              If InsultNum2 = "16" Then DaInsult = YMS16
              If InsultNum2 = "17" Then DaInsult = YMS17
              If InsultNum2 = "18" Then DaInsult = YMS18
              If InsultNum2 = "19" Then DaInsult = YMS19
              If InsultNum2 = "20" Then DaInsult = YMS20
              If InsultNum2 = "21" Then DaInsult = YMS21
              If InsultNum2 = "22" Then DaInsult = YMS22
              If InsultNum2 = "23" Then DaInsult = YMS23
              If InsultNum2 = "24" Then DaInsult = YMS24
              If InsultNum2 = "25" Then DaInsult = YMS25
              If InsultNum2 = "26" Then DaInsult = YMS26
              If InsultNum2 = "27" Then DaInsult = YMS27
              If InsultNum2 = "28" Then DaInsult = YMS28
              If InsultNum2 = "29" Then DaInsult = YMS29
              If InsultNum2 = "30" Then DaInsult = YMS30
              If InsultNum2 = "31" Then DaInsult = YMS31
              If InsultNum2 = "32" Then DaInsult = YMS32

              lint = 2000

              X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
              DoEvents
              Call Pause(.3)
              VBMsg1.SendMessage = WM_LBUTTONDOWN
              VBMsg1.SendMessage = WM_LBUTTONUP
            End If



            If Event2 = 2 Then
              NameTemp = ChatNameSp
              DoEvents
              AppActivate "America  Online"
              DoEvents
              SendKeys "%MC"
              DoEvents
              Call Pause(.5)
              thiswin% = FindWindow(0, "America  Online")
              ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
              SendButton2 = VBEnumChildWindows(ComposeHand, 2)
              ToField = VBEnumChildWindows(ComposeHand, 10)
              SubField = VBEnumChildWindows(ComposeHand, 14)
              MsgField = VBEnumChildWindows(ComposeHand, 17)
              VBMsg3.SubClasshWnd = SendButton2
              lint = 20000  '7500
              lpstring = SendTo2
              DidName = InStr(SendTo2, "{SN}")
              If DidName > 0 Then lpstring = NameTemp
              ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring) ',lint
              DoEvents
              lpstring = MSubject2
              SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring)   ',lint
              DoEvents
              lpstring = MMessage2

              MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring)   ',lint
              DoEvents
              Call Pause(.3)
              VBMsg3.SendMessage = WM_LBUTTONDOWN
              VBMsg3.SendMessage = WM_LBUTTONUP
              DoEvents

              thiswin2% = FindWindow(0, "America Online")
              While thiswin2% = 0
                DoEvents
                thiswin2% = FindWindow(0, "America Online")
              Wend
              DoEvents
              Call Pause(.2)
              SendKeys "{ENTER}"
            End If
          End If
        End If
      End If

    '333333333333333333333333333333333333333333333333333333333333

      If Check3D3.Value = True Then
        DidHostSay = InStr(ChatNameSp, "OnlineHost")
        If DidHostSay > 0 Then Exit Sub

        Finger1 = InStr(ChatLine, ".           \")

        If Finger1 > 0 Then

          If Event3 = 1 Then

            Name1 = InStr(Message3, "{SN}")

            If Name1 > 0 Then
              Name3 = Name1 - 1
              Part1 = Mid$(Message3Sp, 1, Name3)
              Name2 = Name1 + 4
              Part2 = Mid$(Message3Sp, Name2)
            End If

          'thiswin% = FindWindow(0, "America  Online")
          'find% = FindChildByClass(thiswin%, "_AOL_Edit")


            lint = 2000 '7500
            If Name1 > 0 Then

              lpstring = Part1 + ChatNameSp + Part2
            Else
              lpstring = Message3Sp
            End If


            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)  ',lint

            If Check3D1.Value = True Or Check3D2.Value = True Then
              DoEvents
              Call Pause(.4)
            End If

            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP

          End If

          If Event3 = 7 Then
            If InsultNum3 = "1" Then DaInsult = YMS1
            If InsultNum3 = "2" Then DaInsult = YMS2
            If InsultNum3 = "3" Then DaInsult = YMS3
            If InsultNum3 = "4" Then DaInsult = YMS4
            If InsultNum3 = "5" Then DaInsult = YMS5
            If InsultNum3 = "6" Then DaInsult = YMS6
            If InsultNum3 = "7" Then DaInsult = YMS7
            If InsultNum3 = "8" Then DaInsult = YMS8
            If InsultNum3 = "9" Then DaInsult = YMS9
            If InsultNum3 = "10" Then DaInsult = YMS10
            If InsultNum3 = "11" Then DaInsult = YMS11
            If InsultNum3 = "12" Then DaInsult = YMS12
            If InsultNum3 = "13" Then DaInsult = YMS13
            If InsultNum3 = "14" Then DaInsult = YMS14
            If InsultNum3 = "15" Then DaInsult = YMS15
            If InsultNum3 = "16" Then DaInsult = YMS16
            If InsultNum3 = "17" Then DaInsult = YMS17
            If InsultNum3 = "18" Then DaInsult = YMS18
            If InsultNum3 = "19" Then DaInsult = YMS19
            If InsultNum3 = "20" Then DaInsult = YMS20
            If InsultNum3 = "21" Then DaInsult = YMS21
            If InsultNum3 = "22" Then DaInsult = YMS22
            If InsultNum3 = "23" Then DaInsult = YMS23
            If InsultNum3 = "24" Then DaInsult = YMS24
            If InsultNum3 = "25" Then DaInsult = YMS25
            If InsultNum3 = "26" Then DaInsult = YMS26
            If InsultNum3 = "27" Then DaInsult = YMS27
            If InsultNum3 = "28" Then DaInsult = YMS28
            If InsultNum3 = "29" Then DaInsult = YMS29
            If InsultNum3 = "30" Then DaInsult = YMS30
            If InsultNum3 = "31" Then DaInsult = YMS31
            If InsultNum3 = "32" Then DaInsult = YMS32

            lint = 2000

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
          End If

          If Event3 = 3 Then
            TempName = ChatNameSp

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%B{DOWN 3}{ENTER}"
            DoEvents
            Call Pause(.4)
            lint = 3000
            thiswin% = FindWindow(0, "America  Online")
            InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
            IMEdit1 = VBEnumChildWindows(InstantWin, 2)
            IMEdit = VBEnumChildWindows(InstantWin, 3)

            lpstring = IMTo3
            DidIM = InStr(lpstring, "{SN}")
            If DidIM > 0 Then
              lpstring = TempName
            End If
            SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
            DoEvents
            lpstring = IMess3
            SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
            DoEvents
            SendButton = FindChildByTitle(InstantWin, "Send")
            VBMsg1.SubClasshWnd = SendButton
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1.5)
            MBox = FindWindow(0, "America Online")
            If MBox <> 0 Then
              DoEvents
              SendKeys "{ENTER}"
              DoEvents
            End If
          End If


          If Event3 = 2 Then
            NameTemp = ChatNameSp

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%MC"
            DoEvents
            Call Pause(.5)
            thiswin% = FindWindow(0, "America  Online")
            ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
            SendButton2 = VBEnumChildWindows(ComposeHand, 2)
            ToField = VBEnumChildWindows(ComposeHand, 10)
            SubField = VBEnumChildWindows(ComposeHand, 14)
            MsgField = VBEnumChildWindows(ComposeHand, 17)
            VBMsg3.SubClasshWnd = SendButton2
            lint = 20000    '7500
            lpstring = SendTo3
            DidName = InStr(SendTo3, "{SN}")
            If DidName > 0 Then lpstring = NameTemp
            ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)   ',lint
            DoEvents
            lpstring = MSubject3
            SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            lpstring = MMessage3

            MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            Call Pause(.3)
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents

            thiswin2% = FindWindow(0, "America Online")
            While thiswin2% = 0
              DoEvents
              thiswin2% = FindWindow(0, "America Online")
            Wend
            DoEvents
            Call Pause(.2)
            SendKeys "{ENTER}"

          End If
        End If
      End If

    '444444444444444444444444444444444444444444444444444444444444

      If Check3D4.Value = True Then
        DidHostSay = InStr(ChatNameSp, "OnlineHost")
        If DidHostSay > 0 Then Exit Sub

        Gun1 = InStr(ChatLine, ".|_______//")

        If Gun1 > 0 Then

          If Event4 = 1 Then

            Name1 = InStr(Message4, "{SN}")

            If Name1 > 0 Then
              Name3 = Name1 - 1
              Part1 = Mid$(Message4Sp, 1, Name3)
              Name2 = Name1 + 4
              Part2 = Mid$(Message4Sp, Name2)
            End If

          'thiswin% = FindWindow(0, "America  Online")
          'find% = FindChildByClass(thiswin%, "_AOL_Edit")


            lint = 2000 '7500
            If Name1 > 0 Then

              lpstring = Part1 + ChatNameSp + Part2
            Else
              lpstring = Message4Sp
            End If


            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)  ',lint

            If Check3D1.Value = True Or Check3D2.Value = True Or Check3D3.Value = True Then
              DoEvents
              Call Pause(.4)
            End If

            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP

          End If

          If Event4 = 7 Then
            If InsultNum4 = "1" Then DaInsult = YMS1
            If InsultNum4 = "2" Then DaInsult = YMS2
            If InsultNum4 = "3" Then DaInsult = YMS3
            If InsultNum4 = "4" Then DaInsult = YMS4
            If InsultNum4 = "5" Then DaInsult = YMS5
            If InsultNum4 = "6" Then DaInsult = YMS6
            If InsultNum4 = "7" Then DaInsult = YMS7
            If InsultNum4 = "8" Then DaInsult = YMS8
            If InsultNum4 = "9" Then DaInsult = YMS9
            If InsultNum4 = "10" Then DaInsult = YMS10
            If InsultNum4 = "11" Then DaInsult = YMS11
            If InsultNum4 = "12" Then DaInsult = YMS12
            If InsultNum4 = "13" Then DaInsult = YMS13
            If InsultNum4 = "14" Then DaInsult = YMS14
            If InsultNum4 = "15" Then DaInsult = YMS15
            If InsultNum4 = "16" Then DaInsult = YMS16
            If InsultNum4 = "17" Then DaInsult = YMS17
            If InsultNum4 = "18" Then DaInsult = YMS18
            If InsultNum4 = "19" Then DaInsult = YMS19
            If InsultNum4 = "20" Then DaInsult = YMS20
            If InsultNum4 = "21" Then DaInsult = YMS21
            If InsultNum4 = "22" Then DaInsult = YMS22
            If InsultNum4 = "23" Then DaInsult = YMS23
            If InsultNum4 = "24" Then DaInsult = YMS24
            If InsultNum4 = "25" Then DaInsult = YMS25
            If InsultNum4 = "26" Then DaInsult = YMS26
            If InsultNum4 = "27" Then DaInsult = YMS27
            If InsultNum4 = "28" Then DaInsult = YMS28
            If InsultNum4 = "29" Then DaInsult = YMS29
            If InsultNum4 = "30" Then DaInsult = YMS30
            If InsultNum4 = "31" Then DaInsult = YMS31
            If InsultNum4 = "32" Then DaInsult = YMS32

            lint = 2000

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
          End If

          If Event4 = 3 Then
            TempName = ChatNameSp

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%B{DOWN 3}{ENTER}"
            DoEvents
            Call Pause(.4)
            lint = 3000
            thiswin% = FindWindow(0, "America  Online")
            InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
            IMEdit1 = VBEnumChildWindows(InstantWin, 2)
            IMEdit = VBEnumChildWindows(InstantWin, 3)

            lpstring = IMTo4
            DidIM = InStr(lpstring, "{SN}")
            If DidIM > 0 Then
              lpstring = TempName
            End If
            SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
            DoEvents
            lpstring = IMess4
            SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
            DoEvents
            SendButton = FindChildByTitle(InstantWin, "Send")
            VBMsg1.SubClasshWnd = SendButton
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1.5)
            MBox = FindWindow(0, "America Online")
            If MBox <> 0 Then
              DoEvents
              SendKeys "{ENTER}"
              DoEvents
            End If
          End If


          If Event4 = 2 Then
            NameTemp = ChatNameSp

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%MC"
            DoEvents
            Call Pause(.5)
            thiswin% = FindWindow(0, "America  Online")
            ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
            SendButton2 = VBEnumChildWindows(ComposeHand, 2)
            ToField = VBEnumChildWindows(ComposeHand, 10)
            SubField = VBEnumChildWindows(ComposeHand, 14)
            MsgField = VBEnumChildWindows(ComposeHand, 17)
            VBMsg3.SubClasshWnd = SendButton2
            lint = 20000    '7500
            lpstring = SendTo4
            DidName = InStr(SendTo4, "{SN}")
            If DidName > 0 Then lpstring = NameTemp
            ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)   ',lint
            DoEvents
            lpstring = MSubject4
            SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            lpstring = MMessage4

            MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            Call Pause(.3)
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents

            thiswin2% = FindWindow(0, "America Online")
            While thiswin2% = 0
              DoEvents
              thiswin2% = FindWindow(0, "America Online")
            Wend
            DoEvents
            Call Pause(.2)
            SendKeys "{ENTER}"

          End If
        End If
      End If


    '555555555555555555555555555555555555555555555555555555555555

      If Check3D5.Value = True Then

        Enters1 = InStr(ChatLine, "HAS ENTERED THE ROOM.")

        If Enters1 > 0 Then


          If Event5 = 1 Then

            Name1 = InStr(Message5, "{SN}")

            If Name1 > 0 Then
              Name3 = Name1 - 1
              Part1 = Mid$(Message5Sp, 1, Name3)
              Name2 = Name1 + 4
              Part2 = Mid$(Message5Sp, Name2)
            End If

          'thiswin% = FindWindow(0, "America  Online")
          'find% = FindChildByClass(thiswin%, "_AOL_Edit")


            lint = 2000 '7500
            If Name1 > 0 Then

              HCame1 = InStr(ChatLineSp, ":")
              HCame2 = HCame1 + 2
              ThisWeird = InStr(ChatLineSp, "has entered")
              ThisWeird = ThisWeird - 2
              HCame3 = Mid$(ChatLineSp, HCame2, ThisWeird)
              HCame4 = InStr(HCame3, "has entered")
              HCame5 = HCame4 - 2
              HCame6 = Mid$(HCame3, 1, HCame5)
              lpstring = Part1 + HCame6 + Part2
            Else
              lpstring = Message5Sp
            End If


            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)  ',lint
            DoEvents
            Call Pause(.4)

            If Check3D1.Value = True Or Check3D2.Value = True Or Check3D3.Value = True Or Check3D4.Value = True Then
              DoEvents
              Call Pause(.4)
            End If

            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP

          End If


          If Event5 = 7 Then
            If InsultNum5 = "1" Then DaInsult = YMS1
            If InsultNum5 = "2" Then DaInsult = YMS2
            If InsultNum5 = "3" Then DaInsult = YMS3
            If InsultNum5 = "4" Then DaInsult = YMS4
            If InsultNum5 = "5" Then DaInsult = YMS5
            If InsultNum5 = "6" Then DaInsult = YMS6
            If InsultNum5 = "7" Then DaInsult = YMS7
            If InsultNum5 = "8" Then DaInsult = YMS8
            If InsultNum5 = "9" Then DaInsult = YMS9
            If InsultNum5 = "10" Then DaInsult = YMS10
            If InsultNum5 = "11" Then DaInsult = YMS11
            If InsultNum5 = "12" Then DaInsult = YMS12
            If InsultNum5 = "13" Then DaInsult = YMS13
            If InsultNum5 = "14" Then DaInsult = YMS14
            If InsultNum5 = "15" Then DaInsult = YMS15
            If InsultNum5 = "16" Then DaInsult = YMS16
            If InsultNum5 = "17" Then DaInsult = YMS17
            If InsultNum5 = "18" Then DaInsult = YMS18
            If InsultNum5 = "19" Then DaInsult = YMS19
            If InsultNum5 = "20" Then DaInsult = YMS20
            If InsultNum5 = "21" Then DaInsult = YMS21
            If InsultNum5 = "22" Then DaInsult = YMS22
            If InsultNum5 = "23" Then DaInsult = YMS23
            If InsultNum5 = "24" Then DaInsult = YMS24
            If InsultNum5 = "25" Then DaInsult = YMS25
            If InsultNum5 = "26" Then DaInsult = YMS26
            If InsultNum5 = "27" Then DaInsult = YMS27
            If InsultNum5 = "28" Then DaInsult = YMS28
            If InsultNum5 = "29" Then DaInsult = YMS29
            If InsultNum5 = "30" Then DaInsult = YMS30
            If InsultNum5 = "31" Then DaInsult = YMS31
            If InsultNum5 = "32" Then DaInsult = YMS32

            lint = 2000

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
          End If

          If Event5 = 3 Then
            HCame1 = InStr(ChatLineSp, ":")
            HCame2 = HCame1 + 2
            ThisWeird = InStr(ChatLineSp, "has entered")
            ThisWeird = ThisWeird - 2
            HCame3 = Mid$(ChatLineSp, HCame2, ThisWeird)
            HCame4 = InStr(HCame3, "has entered")
            HCame5 = HCame4 - 2
            HCame6 = Mid$(HCame3, 1, HCame5)


            TempName = HCame6

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%B{DOWN 3}{ENTER}"
            DoEvents
            Call Pause(.4)
            lint = 3000
            thiswin% = FindWindow(0, "America  Online")
            InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
            IMEdit1 = VBEnumChildWindows(InstantWin, 2)
            IMEdit = VBEnumChildWindows(InstantWin, 3)

            lpstring = IMTo5
            DidIM = InStr(lpstring, "{SN}")
            If DidIM > 0 Then
              lpstring = TempName
            End If
            SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
            DoEvents
            lpstring = IMess5
            SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
            DoEvents
            SendButton = FindChildByTitle(InstantWin, "Send")
            VBMsg1.SubClasshWnd = SendButton
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1.5)
            MBox = FindWindow(0, "America Online")
            If MBox <> 0 Then
              DoEvents
              SendKeys "{ENTER}"
              DoEvents
            End If
          End If


          If Event5 = 2 Then
            HCame1 = InStr(ChatLineSp, ":")
            HCame2 = HCame1 + 2
            ThisWeird = InStr(ChatLineSp, "has entered")
            ThisWeird = ThisWeird - 2
            HCame3 = Mid$(ChatLineSp, HCame2, ThisWeird)
            HCame4 = InStr(HCame3, "has entered")
            HCame5 = HCame4 - 2
            HCame6 = Mid$(HCame3, 1, HCame5)

            NameTemp = HCame6

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%MC"
            DoEvents
            Call Pause(.1)
            thiswin% = FindWindow(0, "America  Online")
            ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
            SendButton2 = VBEnumChildWindows(ComposeHand, 2)
            ToField = VBEnumChildWindows(ComposeHand, 10)
            SubField = VBEnumChildWindows(ComposeHand, 14)
            MsgField = VBEnumChildWindows(ComposeHand, 17)
            VBMsg3.SubClasshWnd = SendButton2
            lint = 20000    '7500
            lpstring = SendTo5
            DidName = InStr(SendTo5, "{SN}")
            If DidName > 0 Then lpstring = NameTemp
            ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)   ',lint
            DoEvents
            lpstring = MSubject5
            SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            lpstring = MMessage5

            MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            Call Pause(.2)
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents

            thiswin2% = FindWindow(0, "America Online")
            While thiswin2% = 0
              DoEvents
              thiswin2% = FindWindow(0, "America Online")
            Wend
            DoEvents
            Call Pause(.2)
            SendKeys "{ENTER}"

          End If
        End If
      End If


    '666666666666666666666666666666666666666666666666666666666666

      If Check3D6.Value = True Then


        Said13 = InStr(ChatLine, Word2)

        If Said13 > 0 Then


          If Event6 = 1 Then

            Name1 = InStr(Message6, "{SN}")

            If Name1 > 0 Then
              Name3 = Name1 - 1
              Part1 = Mid$(Message6Sp, 1, Name3)
              Name2 = Name1 + 4
              Part2 = Mid$(Message6Sp, Name2)
            End If

          'thiswin% = FindWindow(0, "America  Online")
          'find% = FindChildByClass(thiswin%, "_AOL_Edit")


            lint = 2000 '7500
            If Name1 > 0 Then

              lpstring = Part1 + ChatNameSp + Part2
            Else
              lpstring = Message6Sp
            End If


            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)  ',lint
            If Check3D1.Value = True Or Check3D2.Value = True Or Check3D3.Value = True Or Check3D4.Value = True Or Check3D5.Value = True Then
              DoEvents
              Call Pause(.4)
            End If


            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP

          End If

          If Event6 = 7 Then
            If InsultNum6 = "1" Then DaInsult = YMS1
            If InsultNum6 = "2" Then DaInsult = YMS2
            If InsultNum6 = "3" Then DaInsult = YMS3
            If InsultNum6 = "4" Then DaInsult = YMS4
            If InsultNum6 = "5" Then DaInsult = YMS5
            If InsultNum6 = "6" Then DaInsult = YMS6
            If InsultNum6 = "7" Then DaInsult = YMS7
            If InsultNum6 = "8" Then DaInsult = YMS8
            If InsultNum6 = "9" Then DaInsult = YMS9
            If InsultNum6 = "10" Then DaInsult = YMS10
            If InsultNum6 = "11" Then DaInsult = YMS11
            If InsultNum6 = "12" Then DaInsult = YMS12
            If InsultNum6 = "13" Then DaInsult = YMS13
            If InsultNum6 = "14" Then DaInsult = YMS14
            If InsultNum6 = "15" Then DaInsult = YMS15
            If InsultNum6 = "16" Then DaInsult = YMS16
            If InsultNum6 = "17" Then DaInsult = YMS17
            If InsultNum6 = "18" Then DaInsult = YMS18
            If InsultNum6 = "19" Then DaInsult = YMS19
            If InsultNum6 = "20" Then DaInsult = YMS20
            If InsultNum6 = "21" Then DaInsult = YMS21
            If InsultNum6 = "22" Then DaInsult = YMS22
            If InsultNum6 = "23" Then DaInsult = YMS23
            If InsultNum6 = "24" Then DaInsult = YMS24
            If InsultNum6 = "25" Then DaInsult = YMS25
            If InsultNum6 = "26" Then DaInsult = YMS26
            If InsultNum6 = "27" Then DaInsult = YMS27
            If InsultNum6 = "28" Then DaInsult = YMS28
            If InsultNum6 = "29" Then DaInsult = YMS29
            If InsultNum6 = "30" Then DaInsult = YMS30
            If InsultNum6 = "31" Then DaInsult = YMS31
            If InsultNum6 = "32" Then DaInsult = YMS32

            lint = 2000

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
          End If


          If Event6 = 3 Then
            TempName = ChatNameSp

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%B{DOWN 3}{ENTER}"
            DoEvents
            Call Pause(.4)
            lint = 3000
            thiswin% = FindWindow(0, "America  Online")
            InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
            IMEdit1 = VBEnumChildWindows(InstantWin, 2)
            IMEdit = VBEnumChildWindows(InstantWin, 3)

            lpstring = IMTo6
            DidIM = InStr(lpstring, "{SN}")
            If DidIM > 0 Then
              lpstring = TempName
            End If
            SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
            DoEvents
            lpstring = IMess6
            SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
            DoEvents
            SendButton = FindChildByTitle(InstantWin, "Send")
            VBMsg1.SubClasshWnd = SendButton
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1.5)
            MBox = FindWindow(0, "America Online")
            If MBox <> 0 Then
              DoEvents
              SendKeys "{ENTER}"
              DoEvents
            End If
          End If


          If Event6 = 2 Then
            NameTemp = ChatNameSp

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%MC"
            DoEvents
            Call Pause(.5)
            thiswin% = FindWindow(0, "America  Online")
            ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
            SendButton2 = VBEnumChildWindows(ComposeHand, 2)
            ToField = VBEnumChildWindows(ComposeHand, 10)
            SubField = VBEnumChildWindows(ComposeHand, 14)
            MsgField = VBEnumChildWindows(ComposeHand, 17)
            VBMsg3.SubClasshWnd = SendButton2
            lint = 20000    '7500
            lpstring = SendTo6
            DidName = InStr(SendTo6, "{SN}")
            If DidName > 0 Then lpstring = NameTemp
            ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)   ',lint
            DoEvents
            lpstring = MSubject6
            SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            lpstring = MMessage6

            MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            Call Pause(.3)
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents

            thiswin2% = FindWindow(0, "America Online")
            While thiswin2% = 0
              DoEvents
              thiswin2% = FindWindow(0, "America Online")
            Wend
            DoEvents
            Call Pause(.2)
            SendKeys "{ENTER}"

          End If
        End If
      End If


    '777777777777777777777777777777777777777777777777777777777777

      If Check3D7.Value = True Then

        Enters2 = InStr(ChatLine, "HAS ENTERED THE ROOM.")

        If Enters2 > 0 Then

          PerEnter = InStr(ChatLine, Message7)

          If PerEnter > 0 Then

            thiswin1 = FindWindow(0, "America  Online")
            ListB = FindChildByClass(thiswin1, "_AOL_Listbox")
            If ListB <> 0 Then
              SetCur = SendMessage(ListB, LB_SETCURSEL, 0, 0)
              VBMsg2.SubClasshWnd = ListB
              VBMsg2.SendMessage = WM_LBUTTONDBLCLK
              DoEvents
              Call Pause(.5)

              NameWin = FindChildByTitle(thiswin1, "Message7Sp")
              While NameWin = 0
                DoEvents
                NameWin = FindChildByTitle(thiswin1, "Message7Sp")
              Wend
              DoEvents
              SendKeys " "
              VBMsg2.SubClasshWnd = NameWin
              VBMsg2.PostMessage = WM_CLOSE
              DoEvents




            End If
          End If
        End If



      End If


    '888888888888888888888888888888888888888888888888888888888888


      If Check3D8.Value = True Then


        Enters2 = InStr(ChatLine, "HAS LEFT THE ROOM.")

        If Enters2 > 0 Then

           ' If Name1 > 0 Then

              HCame1 = InStr(ChatLineSp, ":")
              HCame2 = HCame1 + 2
              ThisWeird = InStr(ChatLineSp, "has left")
              ThisWeird = ThisWeird - 2
              HCame3 = Mid$(ChatLineSp, HCame2, ThisWeird)
              HCame4 = InStr(HCame3, "has left")
              HCame5 = HCame4 - 2
              HCame6 = Mid$(HCame3, 1, HCame5)
              LeftName = Part1 + HCame6 + Part2
            'Else
            '  LeftName = Message5Sp
            'End If

          If Event8 = 1 Then

            Name1 = InStr(Message8, "{SN}")

            If Name1 > 0 Then
              Name3 = Name1 - 1
              Part1 = Mid$(Message8Sp, 1, Name3)
              Name2 = Name1 + 4
              Part2 = Mid$(Message8Sp, Name2)
            End If

          'thiswin% = FindWindow(0, "America  Online")
          'find% = FindChildByClass(thiswin%, "_AOL_Edit")


            lint = 2000 '7500
            If Name1 > 0 Then

              lpstring = Part1 + LeftName + Part2
            Else
              lpstring = Message8Sp
            End If


            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)  ',lint
            If Check3D1.Value = True Or Check3D2.Value = True Or Check3D3.Value = True Or Check3D4.Value = True Or Check3D5.Value = True Or Check3D6.Value = True Or Check3D7.Value = True Then
              DoEvents
              Call Pause(.4)
            End If


            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP

          End If

          If Event8 = 7 Then
            If InsultNum8 = "1" Then DaInsult = YMS1
            If InsultNum8 = "2" Then DaInsult = YMS2
            If InsultNum8 = "3" Then DaInsult = YMS3
            If InsultNum8 = "4" Then DaInsult = YMS4
            If InsultNum8 = "5" Then DaInsult = YMS5
            If InsultNum8 = "6" Then DaInsult = YMS6
            If InsultNum8 = "7" Then DaInsult = YMS7
            If InsultNum8 = "8" Then DaInsult = YMS8
            If InsultNum8 = "9" Then DaInsult = YMS9
            If InsultNum8 = "10" Then DaInsult = YMS10
            If InsultNum8 = "11" Then DaInsult = YMS11
            If InsultNum8 = "12" Then DaInsult = YMS12
            If InsultNum8 = "13" Then DaInsult = YMS13
            If InsultNum8 = "14" Then DaInsult = YMS14
            If InsultNum8 = "15" Then DaInsult = YMS15
            If InsultNum8 = "16" Then DaInsult = YMS16
            If InsultNum8 = "17" Then DaInsult = YMS17
            If InsultNum8 = "18" Then DaInsult = YMS18
            If InsultNum8 = "19" Then DaInsult = YMS19
            If InsultNum8 = "20" Then DaInsult = YMS20
            If InsultNum8 = "21" Then DaInsult = YMS21
            If InsultNum8 = "22" Then DaInsult = YMS22
            If InsultNum8 = "23" Then DaInsult = YMS23
            If InsultNum8 = "24" Then DaInsult = YMS24
            If InsultNum8 = "25" Then DaInsult = YMS25
            If InsultNum8 = "26" Then DaInsult = YMS26
            If InsultNum8 = "27" Then DaInsult = YMS27
            If InsultNum8 = "28" Then DaInsult = YMS28
            If InsultNum8 = "29" Then DaInsult = YMS29
            If InsultNum8 = "30" Then DaInsult = YMS30
            If InsultNum8 = "31" Then DaInsult = YMS31
            If InsultNum8 = "32" Then DaInsult = YMS32

            lint = 2000

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
          End If

          If Event8 = 3 Then
            TempName = LeftName

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%B{DOWN 3}{ENTER}"
            DoEvents
            Call Pause(.4)
            lint = 3000
            thiswin% = FindWindow(0, "America  Online")
            InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
            IMEdit1 = VBEnumChildWindows(InstantWin, 2)
            IMEdit = VBEnumChildWindows(InstantWin, 3)

            lpstring = IMTo8
            DidIM = InStr(lpstring, "{SN}")
            If DidIM > 0 Then
              lpstring = TempName
            End If
            SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
            DoEvents
            lpstring = IMess8
            SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
            DoEvents
            SendButton = FindChildByTitle(InstantWin, "Send")
            VBMsg1.SubClasshWnd = SendButton
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1.5)
            MBox = FindWindow(0, "America Online")
            If MBox <> 0 Then
              DoEvents
              SendKeys "{ENTER}"
              DoEvents
            End If
          End If


          If Event8 = 2 Then
            NameTemp = LeftName

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%MC"
            DoEvents
            Call Pause(.5)
            thiswin% = FindWindow(0, "America  Online")
            ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
            SendButton2 = VBEnumChildWindows(ComposeHand, 2)
            ToField = VBEnumChildWindows(ComposeHand, 10)
            SubField = VBEnumChildWindows(ComposeHand, 14)
            MsgField = VBEnumChildWindows(ComposeHand, 17)
            VBMsg3.SubClasshWnd = SendButton2
            lint = 20000    '7500
            lpstring = SendTo8
            DidName = InStr(SendTo8, "{SN}")
            If DidName > 0 Then lpstring = NameTemp
            ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)   ',lint
            DoEvents
            lpstring = MSubject8
            SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            lpstring = MMessage8

            MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            Call Pause(.3)
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents

            thiswin2% = FindWindow(0, "America Online")
            While thiswin2% = 0
              DoEvents
              thiswin2% = FindWindow(0, "America Online")
            Wend
            DoEvents
            Call Pause(.2)
            SendKeys "{ENTER}"

          End If
        End If
      End If


    '999999999999999999999999999999999999999999999999999999999999

      If Check3D9.Value = True Then


        InRoom = InStr(ChatLine, "HAS ENTERED THE ROOM.")

        If InRoom > 0 Then
          InPer = InStr(ChatLine, Person2)
        End If

        If InPer > 0 Then

          If Event9 = 1 Then

            Name1 = InStr(Message9, "{SN}")

            If Name1 > 0 Then
              Name3 = Name1 - 1
              Part1 = Mid$(Message9Sp, 1, Name3)
              Name2 = Name1 + 4
              Part2 = Mid$(Message9Sp, Name2)
            End If

          'thiswin% = FindWindow(0, "America  Online")
          'find% = FindChildByClass(thiswin%, "_AOL_Edit")


            lint = 2000 '7500
            If Name1 > 0 Then

              lpstring = Part1 + Person2 + Part2
            Else
              lpstring = Message9Sp
            End If


            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)  ',lint
            If Check3D1.Value = True Or Check3D2.Value = True Or Check3D3.Value = True Or Check3D4.Value = True Or Check3D5.Value = True Or Check3D6.Value = True Or Check3D7.Value = True Or Check3D8.Value = True Then
              DoEvents
              Call Pause(.4)
            End If


            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP

          End If


          If Event9 = 7 Then
            If InsultNum9 = "1" Then DaInsult = YMS1
            If InsultNum9 = "2" Then DaInsult = YMS2
            If InsultNum9 = "3" Then DaInsult = YMS3
            If InsultNum9 = "4" Then DaInsult = YMS4
            If InsultNum9 = "5" Then DaInsult = YMS5
            If InsultNum9 = "6" Then DaInsult = YMS6
            If InsultNum9 = "7" Then DaInsult = YMS7
            If InsultNum9 = "8" Then DaInsult = YMS8
            If InsultNum9 = "9" Then DaInsult = YMS9
            If InsultNum9 = "10" Then DaInsult = YMS10
            If InsultNum9 = "11" Then DaInsult = YMS11
            If InsultNum9 = "12" Then DaInsult = YMS12
            If InsultNum9 = "13" Then DaInsult = YMS13
            If InsultNum9 = "14" Then DaInsult = YMS14
            If InsultNum9 = "15" Then DaInsult = YMS15
            If InsultNum9 = "16" Then DaInsult = YMS16
            If InsultNum9 = "17" Then DaInsult = YMS17
            If InsultNum9 = "18" Then DaInsult = YMS18
            If InsultNum9 = "19" Then DaInsult = YMS19
            If InsultNum9 = "20" Then DaInsult = YMS20
            If InsultNum9 = "21" Then DaInsult = YMS21
            If InsultNum9 = "22" Then DaInsult = YMS22
            If InsultNum9 = "23" Then DaInsult = YMS23
            If InsultNum9 = "24" Then DaInsult = YMS24
            If InsultNum9 = "25" Then DaInsult = YMS25
            If InsultNum9 = "26" Then DaInsult = YMS26
            If InsultNum9 = "27" Then DaInsult = YMS27
            If InsultNum9 = "28" Then DaInsult = YMS28
            If InsultNum9 = "29" Then DaInsult = YMS29
            If InsultNum9 = "30" Then DaInsult = YMS30
            If InsultNum9 = "31" Then DaInsult = YMS31
            If InsultNum9 = "32" Then DaInsult = YMS32

            lint = 2000

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
          End If

          If Event9 = 3 Then
            TempName = Person2

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%B{DOWN 3}{ENTER}"
            DoEvents
            Call Pause(.4)
            lint = 3000
            thiswin% = FindWindow(0, "America  Online")
            InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
            IMEdit1 = VBEnumChildWindows(InstantWin, 2)
            IMEdit = VBEnumChildWindows(InstantWin, 3)

            lpstring = IMTo9
            DidIM = InStr(lpstring, "{SN}")
            If DidIM > 0 Then
              lpstring = TempName
            End If
            SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
            DoEvents
            lpstring = IMess9
            SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
            DoEvents
            SendButton = FindChildByTitle(InstantWin, "Send")
            VBMsg1.SubClasshWnd = SendButton
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1.5)
            MBox = FindWindow(0, "America Online")
            If MBox <> 0 Then
              DoEvents
              SendKeys "{ENTER}"
              DoEvents
            End If
          End If


          If Event9 = 2 Then
            NameTemp = Person2

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%MC"
            DoEvents
            Call Pause(.5)
            thiswin% = FindWindow(0, "America  Online")
            ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
            SendButton2 = VBEnumChildWindows(ComposeHand, 2)
            ToField = VBEnumChildWindows(ComposeHand, 10)
            SubField = VBEnumChildWindows(ComposeHand, 14)
            MsgField = VBEnumChildWindows(ComposeHand, 17)
            VBMsg3.SubClasshWnd = SendButton2
            lint = 20000    '7500
            lpstring = SendTo9
            DidName = InStr(SendTo9, "{SN}")
            If DidName > 0 Then lpstring = NameTemp
            ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)   ',lint
            DoEvents
            lpstring = MSubject9
            SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            lpstring = MMessage9

            MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            Call Pause(.3)
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents

            thiswin2% = FindWindow(0, "America Online")
            While thiswin2% = 0
              DoEvents
              thiswin2% = FindWindow(0, "America Online")
            Wend
            DoEvents
            Call Pause(.2)
            SendKeys "{ENTER}"

          End If
        End If
      End If


    '10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10



      If Check3D10.Value = True Then


        InRoom = InStr(ChatLine, "HAS LEFT THE ROOM.")

        If InRoom > 0 Then
          InPer = InStr(ChatLine, Person3)
        End If

        If InPer > 0 Then


          If Event10 = 1 Then

            Name1 = InStr(Message10, "{SN}")

            If Name1 > 0 Then
              Name3 = Name1 - 1
              Part1 = Mid$(Message10Sp, 1, Name3)
              Name2 = Name1 + 4
              Part2 = Mid$(Message10Sp, Name2)
            End If

          'thiswin% = FindWindow(0, "America  Online")
          'find% = FindChildByClass(thiswin%, "_AOL_Edit")


            lint = 2000 '7500
            If Name1 > 0 Then

              lpstring = Part1 + Person3 + Part2
            Else
              lpstring = Message10Sp
            End If


            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)  ',lint
            If Check3D1.Value = True Or Check3D2.Value = True Or Check3D3.Value = True Or Check3D4.Value = True Or Check3D5.Value = True Or Check3D6.Value = True Or Check3D7.Value = True Or Check3D8.Value = True Or Check3D9.Value = True Then
              DoEvents
              Call Pause(.4)
            End If

            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP

          End If

          If Event10 = 10 Then
            TempName = Person3

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%B{DOWN 3}{ENTER}"
            DoEvents
            Call Pause(.4)
            lint = 3000
            thiswin% = FindWindow(0, "America  Online")
            InstantWin = FindChildByTitle(thiswin%, "Send Instant Message")
            IMEdit1 = VBEnumChildWindows(InstantWin, 2)
            IMEdit = VBEnumChildWindows(InstantWin, 3)

            lpstring = IMTo10
            DidIM = InStr(lpstring, "{SN}")
            If DidIM > 0 Then
              lpstring = TempName
            End If
            SendName = SendMessageByString(IMEdit1, WM_SETTEXT, lint, lpstring)
            DoEvents
            lpstring = IMess10
            SendIM = SendMessageByString(IMEdit, WM_SETTEXT, lint, lpstring)
            DoEvents
            SendButton = FindChildByTitle(InstantWin, "Send")
            VBMsg1.SubClasshWnd = SendButton
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
            DoEvents
            Call Pause(1.5)
            MBox = FindWindow(0, "America Online")
            If MBox <> 0 Then
              DoEvents
              SendKeys "{ENTER}"
              DoEvents
            End If
          End If

          If Event10 = 7 Then
            If InsultNum10 = "1" Then DaInsult = YMS1
            If InsultNum10 = "2" Then DaInsult = YMS2
            If InsultNum10 = "3" Then DaInsult = YMS3
            If InsultNum10 = "4" Then DaInsult = YMS4
            If InsultNum10 = "5" Then DaInsult = YMS5
            If InsultNum10 = "6" Then DaInsult = YMS6
            If InsultNum10 = "7" Then DaInsult = YMS7
            If InsultNum10 = "8" Then DaInsult = YMS8
            If InsultNum10 = "9" Then DaInsult = YMS9
            If InsultNum10 = "10" Then DaInsult = YMS10
            If InsultNum10 = "11" Then DaInsult = YMS11
            If InsultNum10 = "12" Then DaInsult = YMS12
            If InsultNum10 = "13" Then DaInsult = YMS13
            If InsultNum10 = "14" Then DaInsult = YMS14
            If InsultNum10 = "15" Then DaInsult = YMS15
            If InsultNum10 = "16" Then DaInsult = YMS16
            If InsultNum10 = "17" Then DaInsult = YMS17
            If InsultNum10 = "18" Then DaInsult = YMS18
            If InsultNum10 = "19" Then DaInsult = YMS19
            If InsultNum10 = "20" Then DaInsult = YMS20
            If InsultNum10 = "21" Then DaInsult = YMS21
            If InsultNum10 = "22" Then DaInsult = YMS22
            If InsultNum10 = "23" Then DaInsult = YMS23
            If InsultNum10 = "24" Then DaInsult = YMS24
            If InsultNum10 = "25" Then DaInsult = YMS25
            If InsultNum10 = "26" Then DaInsult = YMS26
            If InsultNum10 = "27" Then DaInsult = YMS27
            If InsultNum10 = "28" Then DaInsult = YMS28
            If InsultNum10 = "29" Then DaInsult = YMS29
            If InsultNum10 = "30" Then DaInsult = YMS30
            If InsultNum10 = "31" Then DaInsult = YMS31
            If InsultNum10 = "32" Then DaInsult = YMS32

            lint = 2000

            X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, DaInsult)
            DoEvents
            Call Pause(.3)
            VBMsg1.SendMessage = WM_LBUTTONDOWN
            VBMsg1.SendMessage = WM_LBUTTONUP
          End If

          If Event10 = 2 Then
            NameTemp = Person3

            DoEvents
            AppActivate "America  Online"
            DoEvents
            SendKeys "%MC"
            DoEvents
            Call Pause(.5)
            thiswin% = FindWindow(0, "America  Online")
            ComposeHand = FindChildByTitle(thiswin%, "Compose Mail")
            SendButton2 = VBEnumChildWindows(ComposeHand, 2)
            ToField = VBEnumChildWindows(ComposeHand, 10)
            SubField = VBEnumChildWindows(ComposeHand, 14)
            MsgField = VBEnumChildWindows(ComposeHand, 17)
            VBMsg3.SubClasshWnd = SendButton2
            lint = 20000    '7500
            lpstring = SendTo10
            DidName = InStr(SendTo10, "{SN}")
            If DidName > 0 Then lpstring = NameTemp
            ToText = SendMessageByString(ToField, WM_SETTEXT, lint, lpstring)   ',lint
            DoEvents
            lpstring = MSubject10
            SubText = SendMessageByString(SubField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            lpstring = MMessage10

            MsgText = SendMessageByString(MsgField, WM_SETTEXT, lint, lpstring) ',lint
            DoEvents
            Call Pause(.3)
            VBMsg3.SendMessage = WM_LBUTTONDOWN
            VBMsg3.SendMessage = WM_LBUTTONUP
            DoEvents

            thiswin2% = FindWindow(0, "America Online")
            While thiswin2% = 0
              DoEvents
              thiswin2% = FindWindow(0, "America Online")
            Wend
            DoEvents
            Call Pause(.2)
            SendKeys "{ENTER}"

          End If
        End If
      End If



    '11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11

      If Check3D11.Value = True Then

        InRoom = InStr(ChatLine, "HAS LEFT THE ROOM.")
        InRoom2 = InStr(ChatLine, "HAS ENTERED THE ROOM.")


        If InRoom Or InRoom2 > 0 Then
          InPer = InStr(ChatLine, Person4)
        End If

        If InPer > 0 Then

          MsgBox Person4Sp + " has entered or left the AOL chat room."

        End If
      End If


    '12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12

      If Check3D12.Value = True Then

        DidSay = InStr(ChatLine, Word3)

        If DidSay > 0 Then
          MsgBox ChatNameSp + " said " + Word3Sp
        End If
      End If

    '13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13

      If Check3D13.Value = True Then

        Echo1 = InStr(ChatLine, Person5)

        If Echo1 > 0 Then

          ChatPart = InStr(ChatLineSp, ":")
          ChatPart = ChatPart + 2
          ChatMain = Mid$(ChatLineSp, ChatPart)

          lint = 2000   '7500
          lpstring = ChatMain
          Didbo = UCase$(lpstring)
          DidDo = InStr(Didbo, "{S A: A:")
          DidDo1 = InStr(Didbo, "{S B: B:")
          If DidDo > 0 Then
            lpstring = "=q{S a: a:"
          End If
          If DidDo1 > 0 Then
            lpstring = "=q{S b: b:"
          End If


          X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)    ',lint

          If Check3D1.Value = True Or Check3D2.Value = True Or Check3D3.Value = True Or Check3D4.Value = True Or Check3D5.Value = True Or Check3D6.Value = True Or Check3D7.Value = True Or Check3D8.Value = True Or Check3D9.Value = True Or Check3D10.Value = True Then
            DoEvents
            Call Pause(.4)
          End If

          VBMsg1.SendMessage = WM_LBUTTONDOWN
          VBMsg1.SendMessage = WM_LBUTTONUP

        End If
      End If
    End If


  '21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21
    If Check3D21.Value = True Then
      DidHostSay = InStr(ChatNameSp, "OnlineHost")
      If DidHostSay > 0 Then Exit Sub

      Said1 = InStr(ChatLine, "COME")
      Said2 = InStr(ChatLine, "LOAD")
      Said3 = InStr(ChatLine, "HARD")
      Said4 = InStr(ChatLine, "BUSH")
      Said5 = InStr(ChatLine, "DEEP")
      Said6 = InStr(ChatLine, "ACCESS")
      Said7 = InStr(ChatLine, "SLIP")
      Said8 = InStr(ChatLine, "HEAD")
      Said9 = InStr(ChatLine, "PUSH")
      Said10 = InStr(ChatLine, "BEAT")
      Said11 = InStr(ChatLine, "DUMP")
      Said12 = InStr(ChatLine, "FIT")
      Said13 = InStr(ChatLine, "STUFF")


      If Said1 Or Said2 Or Said3 Or Said4 Or Said5 Or Said6 Or Said7 Or Said8 Or Said9 Or Said10 Or Said11 Or Said12 Or Said13 > 0 Then
        Werd = InStr(ChatNameSp, ScreenName)

        If Werd > 0 Then Exit Sub

        If Said1 > 0 Then lpstring = "Huh, huh, huh-huh, " + ChatNameSp + " said ""come""."
        If Said2 > 0 Then lpstring = "Huh-huh, huh, " + ChatNameSp + " said ""load""."
        If Said3 > 0 Then lpstring = "Heh-heh, heh, heh, " + ChatNameSp + " said ""hard""."
        If Said4 > 0 Then lpstring = "Huh-huh, huh, huh, " + ChatNameSp + " said ""bush""."
        If Said5 > 0 Then lpstring = "Heh, heh, heh-heh, " + ChatNameSp + " said ""deep""."
        If Said6 > 0 Then lpstring = "Huh, huh-huh, huh, " + ChatNameSp + " said ""access""."
        If Said7 > 0 Then lpstring = "Heh-heh, heh, " + ChatNameSp + " said ""slip""."
        If Said8 > 0 Then lpstring = "Huh, huh, huh-huh, huh, " + ChatNameSp + " said ""head""."
        If Said9 > 0 Then lpstring = "Huh, huh-huh, " + ChatNameSp + " said ""push""."
        If Said10 > 0 Then lpstring = "Heh, heh, heh-heh, " + ChatNameSp + " said ""beat""."
        If Said11 > 0 Then lpstring = "Huh, huh-huh, huh, huh, " + ChatNameSp + " said ""dump""."
        If Said12 > 0 Then lpstring = "Heh-heh, heh, " + ChatNameSp + " said ""fit""."
        If Said13 > 0 Then lpstring = "Huh-huh, huh, huh " + ChatNameSp + " said ""stuff""."

        lint = 1000

        X = SendMessageByString(AOLEditHandle, WM_SETTEXT, lint, lpstring)
        DoEvents
        Call Pause(.3)
        VBMsg1.SendMessage = WM_LBUTTONDOWN
        VBMsg1.SendMessage = WM_LBUTTONUP
      End If
    End If

net1:



  End Sub

  Sub VBMsg1_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    Destroy = 1

  End Sub

  Sub VBMsg2_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    Destroyed = 1

  End Sub

  Sub VBMsg4_WindowMessage (hWindow As Integer, Msg As Integer, wParam As Integer, lParam As Long, RetVal As Long, CallDefProc As Integer)
    ChatLine = ptGetStringFromAddress(lParam, 106)
    ChatLine = Trim$(ChatLine)
    ChatLine = Mid$(ChatLine, 3)
    
    DoGo = 1

  End Sub

