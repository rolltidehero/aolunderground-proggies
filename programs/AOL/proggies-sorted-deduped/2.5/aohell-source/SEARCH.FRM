VERSION 2.00
Begin Form Setupwh 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Double
   Caption         =   "-==AOHell==-   Member Search   -==AOHell==-"
   ClientHeight    =   6585
   ClientLeft      =   1635
   ClientTop       =   480
   ClientWidth     =   6300
   Height          =   6990
   Left            =   1575
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6585
   ScaleWidth      =   6300
   Top             =   135
   Width           =   6420
   Begin SSCommand Command3D4 
      BevelWidth      =   3
      Caption         =   "S&ave"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   3360
      TabIndex        =   18
      Top             =   6120
      Width           =   1095
   End
   Begin SSCommand Command3D3 
      BevelWidth      =   3
      Caption         =   "&Refresh"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   1920
      TabIndex        =   17
      Top             =   6120
      Width           =   1095
   End
   Begin SSCommand Command3D2 
      BevelWidth      =   3
      Caption         =   "&Search"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   480
      TabIndex        =   16
      Top             =   6120
      Width           =   1095
   End
   Begin SSCommand Command3D1 
      BevelWidth      =   3
      Caption         =   "&Cancel"
      Font3D          =   3  'Inset w/light shading
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Height          =   375
      Left            =   4800
      TabIndex        =   15
      Top             =   6120
      Width           =   1095
   End
   Begin ListBox List3 
      Height          =   810
      Left            =   960
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   1440
      Visible         =   0   'False
      Width           =   4215
   End
   Begin CommandButton Delete_btn 
      Caption         =   "Delete"
      Height          =   252
      Left            =   5280
      TabIndex        =   13
      Top             =   2160
      Width           =   756
   End
   Begin CommandButton Edit_btn 
      Caption         =   "Edit"
      Height          =   252
      Left            =   5295
      TabIndex        =   12
      Top             =   1800
      Width           =   756
   End
   Begin ListBox List2 
      Height          =   1005
      Left            =   345
      TabIndex        =   10
      Top             =   1440
      Width           =   4800
   End
   Begin CommandButton Add_btn 
      Caption         =   "Add"
      Height          =   252
      Left            =   5295
      TabIndex        =   9
      Top             =   1440
      Width           =   756
   End
   Begin TextBox Text2 
      Height          =   876
      Left            =   360
      MaxLength       =   500
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   7
      Top             =   5160
      Width           =   5688
   End
   Begin CommandButton Refresh_btn 
      Caption         =   "Refresh"
      Height          =   396
      Left            =   6120
      TabIndex        =   6
      Top             =   4320
      Width           =   852
   End
   Begin CommandButton Close_Btn 
      Caption         =   "Close"
      Height          =   372
      Left            =   6120
      TabIndex        =   4
      Top             =   4800
      Visible         =   0   'False
      Width           =   876
   End
   Begin CommandButton Search_Btn 
      Caption         =   "Search"
      Height          =   372
      Left            =   6120
      TabIndex        =   3
      Top             =   4560
      Visible         =   0   'False
      Width           =   972
   End
   Begin TextBox Text1 
      Height          =   588
      Left            =   360
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Text            =   "Compunik"
      Top             =   480
      Width           =   5652
   End
   Begin ListBox List1 
      Height          =   1590
      Left            =   360
      TabIndex        =   1
      Top             =   2880
      Width           =   5640
   End
   Begin Label Label4 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Search Groups (Double-click to start search):"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   240
      Left            =   120
      TabIndex        =   11
      Top             =   1080
      Width           =   5385
   End
   Begin Label Label3 
      BackColor       =   &H00C0C0C0&
      Caption         =   "After a search, type in IM Message here (500 Chars. Max.), then double-click name in Search Results above to send IM:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   435
      Left            =   120
      TabIndex        =   8
      Top             =   4560
      Width           =   5700
   End
   Begin Label Label2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Search Results:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   240
      Left            =   120
      TabIndex        =   5
      Top             =   2520
      Width           =   1695
   End
   Begin Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Type In Screen Names To Search For And Then Click Search Button:"
      FontBold        =   -1  'True
      FontItalic      =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   9.75
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      ForeColor       =   &H00000000&
      Height          =   225
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5775
      WordWrap        =   -1  'True
   End
End
'Option Explicit
Declare Function FINDWINDOW Lib "User" (ByVal p1$, ByVal p2$) As Integer
Declare Function getnextwindow Lib "User" (ByVal p1%, ByVal p2%) As Integer
Declare Function GetWindow Lib "User" (ByVal p1%, ByVal p2%) As Integer
Declare Function GetWindowText Lib "User" (ByVal p1%, ByVal p2$, ByVal p3%) As Integer
Declare Function GetWindowTextLength Lib "User" (ByVal p1%) As Integer
Declare Function FINDWINDOW Lib "User" (ByVal p1$, ByVal p2&) As Integer



Dim m0028 As String
Dim m00AC As Integer
Const c00C6 = 14 ' &HE%
Const c00CA = 1042 ' &H412%

Sub Add_btn_Click ()
gv0234 = 1
Setupgroup.Text1.Text = ""
Setupgroup.Text2.Text = ""
Setupgroup.Show

End Sub

Sub Close_Btn_Click ()
Setupwho.Hide
End Sub

Sub Command3D1_Click ()
Call Close_Btn_Click

End Sub

Sub Command3D2_Click ()
Call Search_Btn_Click

End Sub

Sub Command3D3_Click ()
Call Refresh_btn_Click


End Sub

Sub Delete_btn_Click ()
Dim l003C As Variant
Dim l004A As Variant
Dim l004E As Variant
l003C = List2.ListIndex
If l003C = -1 Then Exit Sub
List2.RemoveItem l003C
List3.RemoveItem l003C
l004A = App.Path & "\sweetalk.who"
Open l004A For Output As #1
For l004E = 0 To Setupwho.List2.ListCount - 1
Write #1, Setupwho.List2.List(l004E) + Chr(170) + Setupwho.List3.List(l004E)
Next l004E
Close #1

End Sub

Sub Edit_btn_Click ()
If List2.ListIndex = -1 Then Exit Sub
Setupgroup.Text1.Text = List2.List(List2.ListIndex)
Setupgroup.Text2.Text = List3.List(List2.ListIndex)
Setupgroup.Show

End Sub

Function fn1678 () As Variant
Dim l0082 As String * 72
Dim l0084 As Variant
Dim l0088 As Variant
Dim l008C As Variant
Dim l0090 As Variant
Dim l0094 As Integer
l0084 = FINDWINDOW(ByVal "#32770", ByVal "America Online")
l0088 = GetWindow(l0084, 5)
l008C = getnextwindow(l0088, 2)
l008C = getnextwindow(l008C, 2)
l0090 = GetWindowText(l008C, l0082, 73)
l0094 = GetWindowTextLength(l008C)
fn1678 = Left(l0082, l0094)
Debug.Print l0084; l0088; l008C, l0082
End Function

Function fn16B0 () As Variant
Dim l009A As Variant
Dim l009E As Integer
l009A = Timer
Do
DoEvents
l009E% = FINDWINDOW(ByVal "#32770", ByVal "America Online")
Debug.Print "#classwin", l009E%
If l009E% <> 0 Then Exit Do
If Timer > l009A + 20 Then
fn16B0 = 0
Exit Function
End If
Loop
fn16B0 = 1
Exit Function
End Function

Sub List1_DblClick ()
Dim l00A0 As String
Dim l00A2 As String
Dim l00A4 As Integer
Dim l00A8 As Integer
Dim l00AA As Integer
Static m00AC As Integer
' Const c00C6 = 14 ' &HE%
' Const c00CA = 1042 ' &H412%
Dim l00CC As Variant
Dim l00D2 As Variant
Dim l00D8 As Variant
l00A0$ = List1.List(List1.ListIndex)
l00A4% = InStr(l00A0$, " is ")
l00A2$ = RTrim(Text2.Text)
Debug.Print "Pullname", l00A4%
If l00A4% > 0 And l00A4% < 20 Then
         l00A0$ = Left(l00A0$, l00A4% - 1)
         Debug.Print l00A0$
Else
          MsgBox "Select A Valid Name To Send IM To", 48, "Sweetalk"
          Exit Sub
End If
Setupwho.Hide
sub4B8
If gv0192 = 1 Then
  If gv0194 <> 1 Then
  m00AC% = 1
     subC8
     SendKeys "^i", True
     'If fn1E0("&Yes") <> 1 Then GoTo L974A
     sub3D8 500
L9276:
             l00AA = getfocus()
             l00A8 = sendmessage(l00AA, c00C6, 0, 0)
             Debug.Print l00AA, l00A8
   If l00A8 = 0 Then
      SendKeys "{tab}", True
      l00AA = getfocus()
      l00A8 = sendmessage(l00AA, c00C6, 0, 0)
      End If
   If l00A8 = 0 Then
      SendKeys "+{tab}", True
      SendKeys l00A0$, True
      SendKeys "{TAB}", True
       l00AA% = getfocus()
       l00AA% = sendmessage(l00AA%, c00CA, 0, ByVal l00A2$)
      Debug.Print "sent"
      SendKeys "{tab} ", True
       GoTo L94A4:
       Exit Sub
  Else
    SendKeys "^{F4}", True
    SendKeys "^i", True
    sub3D8 (300)
    SendKeys l00A0$, True
    SendKeys "{tab}", True
     l00AA% = getfocus()
     l00AA% = sendmessage(l00AA%, c00CA, 0, ByVal l00A2$)
    Debug.Print "sent"
    SendKeys "{tab} ", True
L94A4:
    If m00AC% = 1 Then
    m00AC% = 0
         l00CC = Timer
         Do
         DoEvents
         If fn288("OK") = 1 Then l00D2 = 1
         SendKeys "%b~", True
         If fn288("&Yes") = 1 Then Exit Do
         If Timer > l00CC + 15 Then GoTo L974A: Exit Do
         Loop
    Debug.Print "there"
    If fn2F8("member services") <> 1 Then GoTo L974A
    SendKeys "^{F4}", True
     If l00D2 = 1 Then
        Beep
         l00D8 = MsgBox("Member is no longer online" & Chr(10) & "Or Member has turned off IMs", 48, "Sweetalk")
         subC8
         Exit Sub
     End If
     subC8
     Exit Sub
    Exit Sub
    Else
    Exit Sub
    End If
   End If
Else
     subC8
     SendKeys "^i", True
     sub3D8 (200)
     GoTo L9276
     Exit Sub
End If
Else
Beep
MsgBox "You Must Be Online To Use This Function", 48, "Sweetalk"
End If
Exit Sub
L974A:
Beep
l00D8 = MsgBox("WAOL did not respond in 15 seconds. NOTE: YOU MAY BE IN """"PAY"""" AREA", 48, "Sweetalk")

End Sub

Sub List2_Click ()
Text1.Text = List3.List(List2.ListIndex)
End Sub

Sub List2_DblClick ()
Text1.Text = List3.List(List2.ListIndex)
Search_Btn_Click

End Sub

Sub Refresh_btn_Click ()
Unload Setupwho
Load Setupwho
Setupwho.Show

End Sub

Sub Save_Btn_Click ()
Dim l00DC As Variant
Dim l00E0 As Variant
Dim l00E4 As Variant
Dim l00E8 As Integer
Dim l00EA As String
Dim l00EC As String
Dim l00EE As String
On Error GoTo L9A76
gv0052$ = App.Path & "\SWEETALK.INI"
gv0056$ = App.Path & "\SWEETINI.TMP"
Open gv0052$ For Input As #1
Input #1, l00DC
Input #1, l00E0
Input #1, l00E4
Input #1, gv01D6
Input #1, gv01E6
Close #1
Open gv0052$ For Input As #1
l00EA$ = Input(LOF(1), #1)
l00E8 = InStr(1, l00EA$, "[FILEPATHS]")
l00EE = Mid(l00EA$, l00E8, LOF(1))
Close #1
l00EC$ = Trim(Text1.Text)
Open gv0056$ For Output As #1
Print #1, l00DC
Print #1, l00E0
Print #1, l00E4
Print #1, gv01D6
Print #1, gv01E6
Print #1, "[WHOSENAMES]"
Write #1, l00EC$
Print #1, l00EE
Close #1
Kill gv0052$
Name gv0056$ As gv0052$
Exit Sub
L9A76:
Beep
MsgBox "Error occurred. Report error number= " & Err, 48
Resume L9AC8
L9AC8:

End Sub

Sub Search_Btn_Click ()
Dim l00F6 As Variant
Dim l00FA As Variant
Dim l00FE As Variant
Dim l0102 As Variant
Dim l010A As Integer
Dim l010C As Variant
Dim l0110 As Variant
Dim l0114 As String
Dim l0118 As Variant
sub4B8
If gv0190 = 1 Then
If gv0192 = 1 Then
If gv01E6 = 1 Then gv01E6 = 0: l0118 = 1
List1.AddItem Now
l00F6 = Len(Text1.Text)
l00FA = InStr(Text1.Text, ",")
If l00FA = 0 Then
l010C = Trim(Text1.Text)
subC8
sub3D8 (1000)
SendKeys "^f", True
sub3D8 (1000)
AppActivate "America  Online"
SendKeys l010C + "~", True
If fn16B0() = 0 Then GoTo LA480: Exit Sub
l0110 = fn1678()
If InStr(l0110, "online") <> 0 Or InStr(l0110, "is in") <> 0 Then
List1.AddItem l0110
l0102 = l0102 + 1
End If
Debug.Print " I have a  " + l0110
l00FE = getfocus()
SendKeys "~", True
SendKeys "^{F4}", True
If l0102 = 0 Then
l0110 = "Sorry, none of the members on your list is currently online"
List1.AddItem l0110
End If
l0110 = "**********************************************************"
List1.AddItem l0110
If l0118 = 1 Then gv01E6 = 1
Setupwho.Show
Exit Sub
Else
l010C = Trim(Mid(Text1.Text, 1, l00FA - 1))
subC8
SendKeys "^f", True
SendKeys l010C + "~", True
If fn16B0() = 0 Then GoTo LA480: Exit Sub
l0110 = fn1678()
If InStr(l0110, "online") <> 0 Or InStr(l0110, "is in") <> 0 Then
List1.AddItem l0110
l0102 = l0102 + 1
End If
End If
Do
l010A = InStr(l00FA + 1, Text1.Text, ",")
If l010A = 0 Then
l010C = Trim(Mid(Text1.Text, l00FA + 1, l00F6 - l00FA))
l00FE = getfocus()
SendKeys "~", True
SendKeys "+{HOME}", True
SendKeys l010C + "~", True
If fn16B0() = 0 Then GoTo LA480: Exit Sub
l0110 = fn1678()
If InStr(l0110, "online") <> 0 Or InStr(l0110, "is in") <> 0 Then
List1.AddItem l0110
l0102 = l0102 + 1
End If
l00FE = getfocus()
SendKeys "~", True
SendKeys "^{F4}", True
If l0102 = 0 Then
l0110 = "Sorry, none of the members on your list is currently online"
List1.AddItem l0110
End If
l0110 = "**********************************************************"
List1.AddItem l0110
If l0118 = 1 Then gv01E6 = 1
Setupwho.Show
Exit Sub
Else
l010C = Trim(Mid(Text1.Text, l00FA + 1, l010A - l00FA - 1))
l00FA = l010A
l00FE = getfocus()
SendKeys "~", True
SendKeys "+{HOME}", True
SendKeys l010C + "~", True
If fn16B0() = 0 Then GoTo LA480: Exit Sub
l0110 = fn1678()
If InStr(l0110, "online") <> 0 Or InStr(l0110, "is in") <> 0 Then
List1.AddItem l0110
l0102 = l0102 + 1
End If
End If
Loop
Else
       Beep
       l0114 = "You Must Be Online To Use This Feature."
       MsgBox l0114, 48, "Sweetalk"
       Exit Sub
End If
Else
       Beep
       l0114 = "You Must Have WAOL Running To Use This Feature."
       MsgBox l0114, 48, "Sweetalk"
       Exit Sub
End If
Exit Sub
LA480:
MsgBox "Sorry Sweetalk timed out waiting for AOL to respond", 48, "Sweetalk"
If l0118 = 1 Then gv01E6 = 1

End Sub

