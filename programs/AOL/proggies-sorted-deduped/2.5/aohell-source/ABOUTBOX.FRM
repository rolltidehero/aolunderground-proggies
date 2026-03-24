VERSION 2.00
Begin Form AboutBox 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "About Shuffle CD Player"
   ClientHeight    =   2895
   ClientLeft      =   2865
   ClientTop       =   2190
   ClientWidth     =   4335
   ControlBox      =   0   'False
   FontBold        =   -1  'True
   FontItalic      =   0   'False
   FontName        =   "System"
   FontSize        =   9.75
   FontStrikethru  =   0   'False
   FontUnderline   =   0   'False
   Height          =   3300
   Left            =   2805
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2895
   ScaleWidth      =   4335
   Top             =   1845
   Width           =   4455
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "OK"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1680
      TabIndex        =   11
      Top             =   2400
      Width           =   975
   End
   Begin Image Image1 
      Height          =   480
      Left            =   480
      Picture         =   ABOUTBOX.FRX:0000
      Top             =   240
      Width           =   480
   End
   Begin Label Label11 
      BackColor       =   &H8000000F&
      Caption         =   " Windows Version:"
      Height          =   225
      Left            =   240
      TabIndex        =   10
      Top             =   1520
      Width           =   1890
   End
   Begin Label Label10 
      BackColor       =   &H8000000F&
      BackStyle       =   0  'Transparent
      Height          =   225
      Left            =   2685
      TabIndex        =   9
      Top             =   1515
      Width           =   1200
   End
   Begin Label Label9 
      BackColor       =   &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Modified by Da Chronic"
      Height          =   255
      Left            =   1320
      TabIndex        =   8
      Top             =   600
      Width           =   2775
   End
   Begin Label Label8 
      BackColor       =   &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Seater Bros."
      Height          =   255
      Left            =   1320
      TabIndex        =   7
      Top             =   840
      Width           =   1935
   End
   Begin Label Label7 
      BackColor       =   &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright © 1994 Larry Seater"
      Height          =   255
      Left            =   1320
      TabIndex        =   6
      Top             =   360
      Width           =   3255
   End
   Begin Label Label6 
      BackColor       =   &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Shuffle CD Player"
      Height          =   255
      Left            =   1320
      TabIndex        =   5
      Top             =   120
      Width           =   2295
   End
   Begin Label Label4 
      BackColor       =   &H8000000F&
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   2760
      TabIndex        =   4
      Top             =   1770
      Width           =   1455
   End
   Begin Label Label3 
      BackColor       =   &H8000000F&
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   2010
      Width           =   1935
   End
   Begin Label Label2 
      BackColor       =   &H8000000F&
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   1770
      Width           =   1935
   End
   Begin Line Line2 
      X1              =   120
      X2              =   4200
      Y1              =   2250
      Y2              =   2250
   End
   Begin Line Line1 
      X1              =   120
      X2              =   4200
      Y1              =   1215
      Y2              =   1215
   End
   Begin Label Label5 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   2700
      TabIndex        =   0
      Top             =   2010
      Width           =   1455
   End
   Begin Label Label1 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   1260
      Width           =   2055
   End
End
'============================================
' SHUFFLE CD PLAYER EXAMPLE
' Copyright(c) 1994 Larry Robert Seater
'============================================
' Disclaimer of Warranty:

' This software and the accompanying files are 'as is'
' and without warranties as to performance of the
' software and the accompanying files or any other
' warranties whether expressed or implied.
' No warranty of fitness for a particular purpose
' is offered.
'
' You may not sell this software or it's source code.
' You may use this code in any way you find useful.
' Enough said!
'
' This is an example of some things I've learned
' about the MCI.VBX custom control from the Visual
' Basic Professional Edition.  This is written in
' VB Pro 3.0 and needs to be run (I think) on the
' same.  There may be a few bugs, but I knocked it
' out in a couple of hours.  There are a few other
' tricks(?) in the code too.
'
' Please if you have any comments (good or bad) or
' any suggestions, or want to trade code write me or
' E-Mail me at:
' AOL: LarryS8302
'
' Land Mail: Larry Seater
'            2124 NE 36th Av.
'            Portland, OR 97212
'
' Thanks!
DefInt A-Z
Declare Function GetFreeSystemResources Lib "User" (ByVal fuSysResource As Integer) As Integer
Declare Function GetFreeSpace Lib "Kernel" (ByVal wFlags) As Long
Declare Function GetWinFlags Lib "Kernel" () As Long
Declare Function GetVersion Lib "kernel" () As Integer
Const WF_STANDARD = &H10
Const WF_ENHANCED = &H20
Const GFSR_SYSTEMRESOURCES = 0


Sub BTN_OK_Click ()
    Unload AboutBox
End Sub

Sub BTN_OK_KeyPress (KeyAscii As Integer)
    ' Entering any key has the same effect as clicking
    ' on the OK button.
    BTN_OK_Click
End Sub

Sub Command3D1_Click ()
Call BTN_OK_Click

End Sub

Sub Form_Load ()
Dim WinFlags As Long
Dim Mode As String, Processor As String
    
    ' Center form on screen.
    Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2
    
    ' Get system info.
    WinFlags = GetWinFlags()
    If WinFlags And WF_ENHANCED Then Mode = "386 Enhanced Mode" Else Mode = "Standard Mode    "
    Label1 = " " + Mode
    Label2 = " Free Memory:"
    Label3 = " System Resources"
    Label4 = Format$(GetFreeSpace(0) \ 1024) + " KB Free"
    X% = GetFreeSystemResources(GFSR_SYSTEMRESOURCES)
          Label5 = Str$(X%) + "%" + " Free"
    
    ' Get windows version.
    i% = GetVersion()
    
    ' Lowbyte is derived by masking off high byte.
    lowbyte$ = Str$(i% And &HFF)
    
    ' Highbyte is derived by masking off low byte and shifting.
    highbyte$ = LTrim$(Str$((i% And &HFF00) / 256))
    
    ' Assign Windows version to label caption.
    Label10 = lowbyte$ + "." + highbyte$
End Sub

