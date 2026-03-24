VERSION 2.00
Begin Form WarezBot 
   BackColor       =   &H8000000F&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "--==AOHell==--   WaReZ Bot   -==AOHell==-"
   ClientHeight    =   4050
   ClientLeft      =   120
   ClientTop       =   1110
   ClientWidth     =   9390
   Height          =   4455
   HelpContextID   =   37
   Icon            =   WAREZBOT.FRX:0000
   Left            =   60
   LinkTopic       =   "Form1"
   ScaleHeight     =   4050
   ScaleWidth      =   9390
   Top             =   765
   Width           =   9510
   Begin CommonDialog CMDialog1 
      DefaultExt      =   "WB"
      DialogTitle     =   "Open a saved Warez Bot file"
      Filter          =   "Warez Bot Files (*.WB)|*.WB"
      Left            =   5280
      Top             =   3840
   End
   Begin SSCheck Check3D2 
      Caption         =   " Pack 2"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   360
      TabIndex        =   30
      Top             =   1320
      Width           =   855
   End
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "&Help"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      HelpContextID   =   37
      Left            =   8520
      TabIndex        =   41
      Top             =   3480
      Width           =   735
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&Save"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   6600
      TabIndex        =   40
      Top             =   3480
      Width           =   855
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Load"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   7560
      TabIndex        =   39
      Top             =   3480
      Width           =   855
   End
   Begin SSCommand Command3D1 
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
      Left            =   5760
      TabIndex        =   38
      Top             =   3480
      Width           =   735
   End
   Begin SSOption Option3D8 
      Caption         =   "Mass Mail List"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   7560
      TabIndex        =   29
      TabStop         =   0   'False
      Top             =   3120
      Width           =   1575
   End
   Begin SSOption Option3D7 
      Caption         =   "Warez Offers"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   255
      Left            =   6000
      TabIndex        =   28
      Top             =   3120
      Value           =   -1  'True
      Width           =   1455
   End
   Begin SSFrame Frame3D3 
      Caption         =   "Warez Offerings"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   3735
      Left            =   120
      TabIndex        =   27
      Top             =   120
      Width           =   5535
      Begin SSOption Option3D11 
         Caption         =   "Nev."
         Height          =   255
         Left            =   4800
         TabIndex        =   48
         TabStop         =   0   'False
         Top             =   3000
         Width           =   615
      End
      Begin TextBox Text15 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   5040
         TabIndex        =   47
         Text            =   "2"
         Top             =   3360
         Width           =   255
      End
      Begin SSOption Option3D10 
         Caption         =   "10 mins."
         Height          =   255
         Left            =   3720
         TabIndex        =   45
         TabStop         =   0   'False
         Top             =   3000
         Width           =   975
      End
      Begin SSOption Option3D6 
         Caption         =   "2 mins."
         Height          =   255
         Left            =   1800
         TabIndex        =   44
         TabStop         =   0   'False
         Top             =   3000
         Width           =   855
      End
      Begin SSOption Option3D9 
         Caption         =   "5 mins."
         Height          =   255
         Left            =   2760
         TabIndex        =   43
         Top             =   3000
         Value           =   -1  'True
         Width           =   855
      End
      Begin SSCheck Check3D5 
         Caption         =   " Pack 5"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   195
         Left            =   240
         TabIndex        =   34
         Top             =   2640
         Width           =   975
      End
      Begin SSCheck Check3D4 
         Caption         =   " Pack 4"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   240
         TabIndex        =   35
         Top             =   2160
         Width           =   975
      End
      Begin SSCheck Check3D3 
         Caption         =   " Pack 3"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   195
         Left            =   240
         TabIndex        =   36
         Top             =   1680
         Width           =   855
      End
      Begin SSCheck Check3D1 
         Caption         =   " Pack 1"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   240
         TabIndex        =   37
         Top             =   720
         Width           =   855
      End
      Begin TextBox Text14 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   2640
         TabIndex        =   14
         Text            =   "15"
         Top             =   3360
         Width           =   375
      End
      Begin TextBox Text13 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   4920
         MaxLength       =   2
         TabIndex        =   10
         Text            =   "1"
         Top             =   2640
         Width           =   375
      End
      Begin TextBox Text12 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   4920
         MaxLength       =   2
         TabIndex        =   8
         Text            =   "1"
         Top             =   2160
         Width           =   375
      End
      Begin TextBox Text11 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   4920
         MaxLength       =   2
         TabIndex        =   6
         Text            =   "1"
         Top             =   1680
         Width           =   375
      End
      Begin TextBox Text10 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   4920
         MaxLength       =   2
         TabIndex        =   4
         Text            =   "1"
         Top             =   1200
         Width           =   375
      End
      Begin TextBox Text9 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   1320
         MaxLength       =   70
         TabIndex        =   9
         Top             =   2640
         Width           =   3375
      End
      Begin TextBox Text8 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   1320
         MaxLength       =   70
         TabIndex        =   7
         Top             =   2160
         Width           =   3375
      End
      Begin TextBox Text7 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   1320
         MaxLength       =   70
         TabIndex        =   5
         Top             =   1680
         Width           =   3375
      End
      Begin TextBox Text6 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   1320
         MaxLength       =   70
         TabIndex        =   3
         Top             =   1200
         Width           =   3375
      End
      Begin TextBox Text5 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   4920
         MaxLength       =   2
         TabIndex        =   2
         Text            =   "1"
         Top             =   720
         Width           =   375
      End
      Begin TextBox Text4 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   1320
         MaxLength       =   70
         TabIndex        =   1
         Top             =   720
         Width           =   3375
      End
      Begin Label Label9 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000F&
         Caption         =   "Leech Limit:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   225
         Left            =   3840
         TabIndex        =   46
         Top             =   3360
         Width           =   1050
      End
      Begin Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000F&
         Caption         =   "Notify Room Every:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   225
         Left            =   120
         TabIndex        =   42
         Top             =   3000
         Width           =   1560
      End
      Begin Label Label14 
         BackColor       =   &H8000000F&
         Caption         =   "mins."
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   3120
         TabIndex        =   21
         Top             =   3360
         Width           =   495
      End
      Begin Label Label13 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000F&
         Caption         =   "Send Requested Warez Every:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   225
         Left            =   120
         TabIndex        =   22
         Top             =   3360
         Width           =   2445
      End
      Begin Label Label8 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000F&
         Caption         =   "# of Files"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   225
         Left            =   4680
         TabIndex        =   33
         Top             =   360
         Width           =   750
      End
      Begin Label Label7 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000F&
         Caption         =   "Pack Number"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   -1  'True
         Height          =   225
         Left            =   240
         TabIndex        =   32
         Top             =   360
         Width           =   1125
      End
      Begin Label Label6 
         BackColor       =   &H8000000F&
         Caption         =   "Description"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   -1  'True
         Height          =   255
         Left            =   2400
         TabIndex        =   31
         Top             =   360
         Width           =   1095
      End
   End
   Begin SSFrame Frame3D1 
      Caption         =   "Mass Mail List"
      Enabled         =   0   'False
      Height          =   2895
      Left            =   5760
      TabIndex        =   0
      Top             =   120
      Width           =   3495
      Begin SSCommand Command3D5 
         BevelWidth      =   1
         Caption         =   "Comments"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   1320
         Outline         =   0   'False
         TabIndex        =   20
         Top             =   1440
         Width           =   1095
      End
      Begin SSFrame Frame3D2 
         Caption         =   "Notify Room Every"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         ForeColor       =   &H00000000&
         Height          =   615
         Left            =   240
         TabIndex        =   23
         Top             =   2040
         Width           =   3015
         Begin SSOption Option3D5 
            Caption         =   "5 mins."
            Height          =   255
            Left            =   2040
            TabIndex        =   26
            Top             =   240
            Value           =   -1  'True
            Width           =   855
         End
         Begin SSOption Option3D4 
            Caption         =   "2 mins."
            Height          =   255
            Left            =   1080
            TabIndex        =   25
            TabStop         =   0   'False
            Top             =   240
            Width           =   855
         End
         Begin SSOption Option3D3 
            Caption         =   "1 min."
            Height          =   255
            Left            =   240
            TabIndex        =   24
            TabStop         =   0   'False
            Top             =   240
            Width           =   855
         End
      End
      Begin TextBox Text3 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Serif"
         FontSize        =   6.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   2880
         TabIndex        =   13
         Text            =   "50"
         Top             =   2280
         Visible         =   0   'False
         Width           =   375
      End
      Begin SSOption Option3D2 
         Caption         =   "Copy names on list to clipboard"
         Height          =   255
         Left            =   240
         TabIndex        =   19
         TabStop         =   0   'False
         Top             =   1680
         Width           =   3015
      End
      Begin SSOption Option3D1 
         Caption         =   "&Auto MM when Time Limit expires"
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   1200
         Value           =   -1  'True
         Width           =   3135
      End
      Begin TextBox Text2 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   1560
         TabIndex        =   12
         Text            =   "15"
         Top             =   840
         Width           =   495
      End
      Begin TextBox Text1 
         FontBold        =   0   'False
         FontItalic      =   0   'False
         FontName        =   "MS Sans Serif"
         FontSize        =   8.25
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   285
         Left            =   1560
         MaxLength       =   19
         TabIndex        =   11
         Top             =   360
         Width           =   1575
      End
      Begin Label Label4 
         BackColor       =   &H8000000F&
         Caption         =   "(In minutes)"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   2160
         TabIndex        =   17
         Top             =   840
         Width           =   1095
      End
      Begin Label Label3 
         BackColor       =   &H8000000F&
         Caption         =   "Time Limit:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   240
         TabIndex        =   16
         Top             =   840
         Width           =   1095
      End
      Begin Label Label2 
         BackColor       =   &H8000000F&
         Caption         =   "Trigger word:"
         FontBold        =   -1  'True
         FontItalic      =   0   'False
         FontName        =   "Times New Roman"
         FontSize        =   9.75
         FontStrikethru  =   0   'False
         FontUnderline   =   0   'False
         Height          =   255
         Left            =   240
         TabIndex        =   15
         Top             =   360
         Width           =   1215
      End
   End
End
  Const SWP_NOMOVE = 2
  Const SWP_NOSIZE = 1
  Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
  Const HWND_TOPMOST = -1
  Const HWND_NOTOPMOST = -2

  Sub Command3D1_Click ()
    If Option3D8.Value = True Then
      If Text1.Text = "" Or Text2.Text = "" Then
        MsgBox "You have not completely filled out this form."
        Exit Sub
      End If
      If Option3D1.Value = True And Text3.Text = "" Then
        MsgBox "You must enter how many warez you want it to send"
        Exit Sub
      End If

      TriggerWord = Text1.Text
      TriggerWordSp = TriggerWord

      GoTo Beg2

Err2:
      MsgBox "Must enter a number for the time limit!"
      Exit Sub

Beg2:
      On Error GoTo Err2

      TimeLimit = Text2.Text
      TimeLimit2 = TimeLimit

      NWarez = Text3.Text

      If Option3D1.Value = True Then DoMM = 1
      If Option3D2.Value = True Then DoMM = 2
      If Option3D3.Value = True Then NotifyRoom = 1
      If Option3D4.Value = True Then NotifyRoom = 2
      If Option3D5.Value = True Then NotifyRoom = 5
      NotifyRoom2 = NotifyRoom
      ListStatus.Show
      WarezBot.Hide
    End If

    If Option3D7.Value = True Then
      PTime = Text14.Text
      PTime1 = PTime
      If Check3D1.Value = False Then
        MsgBox "You must offer at least 1 pack to use the Pack Offer portion of this bot!  PLEASE click the HELP button NOW to learn how to use this thing!"
        Exit Sub
      End If
      If Check3D5.Value = True And Check3D4.Value = False Then
        MsgBox "You can't offer Pack 5 if you haven't offered the packs before it!"
        Exit Sub
      End If
      If Check3D4.Value = True And Check3D3.Value = False Then
        MsgBox "You can't offer Pack 4 if you haven't offered the packs before it!"
        Exit Sub
      End If
      If Check3D3.Value = True And Check3D2.Value = False Then
        MsgBox "You can't offer Pack 3 if you haven't offered the packs before it!"
        Exit Sub
      End If


      If Check3D2.Value = True Then Pk2 = 1 Else Pk2 = 0
      If Check3D3.Value = True Then Pk3 = 1 Else Pk3 = 0
      If Check3D4.Value = True Then Pk4 = 1 Else Pk4 = 0
      If Check3D5.Value = True Then Pk5 = 1 Else Pk5 = 0
      P1D = Text4.Text
      P2D = Text6.Text
      P3D = Text7.Text
      P4D = Text8.Text
      P5D = Text9.Text
      P1F = Text5.Text
      P2F = Text10.Text
      P3F = Text11.Text
      P4F = Text12.Text
      P5F = Text13.Text
      LeechLimit = Text15.Text

      If LeechLimit <= 0 Or LeechLimit > 5 Then
        MsgBox "You must enter a number between 1 and 5 for the Leech Limit!"
        Exit Sub
      End If


      If Option3D6.Value = True Then PackNotify = 2
      If Option3D9.Value = True Then PackNotify = 5
      If Option3D10.Value = True Then PackNotify = 10
      If Option3D11.Value = True Then PackNotify = 600
      PackNotify1 = PackNotify
      GoTo stu

Errstu:
      Exit Sub

stu:
      On Error GoTo Errstu

      WarezBot.Hide
      PackStatus.Show
    End If

  End Sub

  Sub Command3D2_Click ()
    GoTo Begin1

titfuck1:
    Close #1
    Exit Sub

Begin1:
  On Error GoTo titfuck1

  'CMDialog1.DialogTitle = "Open AI Bot Settings File"
    CMDialog1.Action = 1

    xfilnam$ = CMDialog1.Filename
  
    Open xfilnam$ For Input As #1
    Input #1, Tex1, Tex2, Tex3, Tex4, Tex5, Tex6, Tex7, Tex8, Tex9, Tex10, Tex11, Tex12, Tex13, Tex14, Check1, Check2, Check3, Check4, Check5, Option1, Option2, Option3, Option4, Option5, Option6, Option7, Option8, Option9, Option10, Tex15
    Close #1

    Text1.Text = Tex1
    Text2.Text = Tex2
    Text3.Text = Tex3
    Text4.Text = Tex4
    Text5.Text = Tex5
    Text6.Text = Tex6
    Text7.Text = Tex7
    Text8.Text = Tex8
    Text9.Text = Tex9
    Text10.Text = Tex10
    Text11.Text = Tex11
    Text12.Text = Tex12
    Text13.Text = Tex13
    Text14.Text = Tex14
    Text15.Text = Tex15

    If Check1 = 1 Then Check3D1.Value = True
    If Check2 = 1 Then Check3D2.Value = True
    If Check3 = 1 Then Check3D3.Value = True
    If Check4 = 1 Then Check3D4.Value = True
    If Check5 = 1 Then Check3D5.Value = True

    If Option1 = 1 Then Option3D1.Value = True
    If Option2 = 1 Then Option3D2.Value = True
    If Option3 = 1 Then Option3D3.Value = True
    If Option4 = 1 Then Option3D4.Value = True
    If Option5 = 1 Then Option3D5.Value = True
    If Option6 = 1 Then Option3D8.Value = True
    If Option7 = 1 Then Option3D7.Value = True
    If Option8 = 1 Then Option3D6.Value = True
    If Option9 = 1 Then Option3D9.Value = True
    If Option10 = 1 Then Option3D10.Value = True

  End Sub

  Sub Command3D3_Click ()
    GoTo begin2

titfuck2:
    Exit Sub


begin2:
    On Error GoTo titfuck2

    CMDialog1.Action = 2
    Shit = CMDialog1.Filetitle
    xfilnam$ = CMDialog1.Filename
    If Check3D1.Value = True Then Check1 = 1
    If Check3D2.Value = True Then Check2 = 1
    If Check3D3.Value = True Then Check3 = 1
    If Check3D4.Value = True Then Check4 = 1
    If Check3D5.Value = True Then Check5 = 1
    If Option3D1.Value = True Then Option1 = 1
    If Option3D2.Value = True Then Option2 = 1
    If Option3D3.Value = True Then Option3 = 1
    If Option3D4.Value = True Then Option4 = 1
    If Option3D5.Value = True Then Option5 = 1
    If Option3D8.Value = True Then Option6 = 1
    If Option3D7.Value = True Then Option7 = 1
    If Option3D6.Value = True Then Option8 = 1
    If Option3D9.Value = True Then Option9 = 1
    If Option3D10.Value = True Then Option10 = 1
    Tex1 = Text1.Text
    Tex2 = Text2.Text
    Tex3 = Text3.Text
    Tex4 = Text4.Text
    Tex5 = Text5.Text
    Tex6 = Text6.Text
    Tex7 = Text7.Text
    Tex8 = Text8.Text
    Tex9 = Text9.Text
    Tex10 = Text10.Text
    Tex11 = Text11.Text
    Tex12 = Text12.Text
    Tex13 = Text13.Text
    Tex14 = Text14.Text
    Tex15 = Text15.Text

    Open xfilnam$ For Output As 1
    Write #1, Tex1, Tex2, Tex3, Tex4, Tex5, Tex6, Tex7, Tex8, Tex9, Tex10, Tex11, Tex12, Tex13, Tex14, Check1, Check2, Check3, Check4, Check5, Option1, Option2, Option3, Option4, Option5, Option6, Option7, Option8, Option9, Option10, Tex15
    Close #1

  End Sub

  Sub Command3D4_Click ()
    SendKeys "{F1}"

  End Sub

Sub Command3D5_Click ()
MMCom.Show
WarezBot.Hide

End Sub

  Sub Form_Load ()

    If AIStatus = 1 Then
      MsgBox "The AI Bot is still active.  You cannot use the Warez Bot with the AI Bot still running.  Please bring up the AI Bot window and choose ""Unload AI Bot"", then try again.", 16, "AI Bot Still Active"
      Unload Me
      Exit Sub
    End If

    Dim Success As Integer

    Success% = SetWindowPos%(WarezBot.hWnd, HWND_TOPMOST, 0, 0, 0, 0, FLAGS)

  End Sub

  Sub Option3D1_Click (Value As Integer)
    If Option3D1.Value = True Then
    '  Label5.Enabled = True
      Text3.Enabled = True
    End If

  End Sub

  Sub Option3D2_Click (Value As Integer)
    If Option3D1.Value = False Then
   '   Label5.Enabled = False
      Text3.Enabled = False
    End If

  End Sub

  Sub Option3D7_Click (Value As Integer)
    If Option3D7.Value = True Then
      Frame3D1.Enabled = False
      Frame3D3.Enabled = True
    End If

  End Sub

  Sub Option3D8_Click (Value As Integer)
    If Option3D7.Value = False Then
      Frame3D1.Enabled = True
      Frame3D3.Enabled = False
    End If

  End Sub

