VERSION 5.00
Begin VB.Form Main
  Caption = "www.mavness.com"
  BackColor = &HC0C0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "Main.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 5415
  ClientHeight = 3915
  StartUpPosition = 3 'Windows Default
  Begin SSTab SSTab1
    Left = 120
    Top = 120
    Width = 5205
    Height = 3735
    TabIndex = 0
    Begin Frame Frame11
      Caption = "Image List"
      Left = -71520
      Top = 3255
      Width = 1575
      Height = 1575
      Visible = 0   'False
      TabIndex = 80
      Begin CommandButton Command14
        Caption = "Remove"
        Left = 790
        Top = 1250
        Width = 735
        Height = 255
        TabIndex = 83
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin CommandButton Command13
        Caption = "Add"
        Left = 50
        Top = 1250
        Width = 735
        Height = 255
        TabIndex = 82
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin ListBox List3
        Left = 50
        Top = 240
        Width = 1455
        Height = 960
        TabIndex = 81
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
    End
    Begin Frame Frame5
      Caption = "Roll Over Efects"
      Left = -74880
      Top = 1560
      Width = 4935
      Height = 1695
      Visible = 0   'False
      TabIndex = 74
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
      Begin Frame Frame10
        Caption = "Options"
        Left = 3240
        Top = 120
        Width = 1575
        Height = 1095
        TabIndex = 78
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
        Begin CheckBox Check1
          Caption = "Preload Images"
          Left = 50
          Top = 240
          Width = 1455
          Height = 255
          TabIndex = 79
          BeginProperty Font
            Name = "Arial"
            Size = 8.25
            Charset = 0
            Weight = 400
            Underline = 0 'False
            Italic = 0 'False
            Strikethrough = 0 'False
          EndProperty
        End
      End
      Begin CommandButton Command12
        Caption = "On Image"
        Left = 1680
        Top = 1200
        Width = 1215
        Height = 255
        TabIndex = 77
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin CommandButton Command11
        Caption = "Off Image"
        Left = 120
        Top = 1200
        Width = 1215
        Height = 255
        TabIndex = 76
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin CommandButton Command9
        Caption = "Create Code"
        Left = 3840
        Top = 1320
        Width = 975
        Height = 255
        TabIndex = 75
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Image Image6
        Left = 1680
        Top = 240
        Width = 1215
        Height = 495
      End
      Begin Image Image5
        Left = 120
        Top = 240
        Width = 1215
        Height = 495
      End
    End
    Begin Timer Timer2
      Enabled = 0   'False
      Interval = 100
      Left = -70320
      Top = 3240
    End
    Begin Timer Timer1
      Interval = 100
      Left = -70320
      Top = 3240
    End
    Begin Frame Frame9
      Left = -74400
      Top = 2640
      Width = 855
      Height = 735
      TabIndex = 64
      BorderStyle = 0 'None
      Begin TextBox Text20
        Left = 0
        Top = 480
        Width = 735
        Height = 195
        TabIndex = 67
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text18
        Left = 0
        Top = 240
        Width = 735
        Height = 195
        TabIndex = 66
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text17
        Left = 0
        Top = 0
        Width = 735
        Height = 195
        TabIndex = 65
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
    End
    Begin Timer Timer3
      Enabled = 0   'False
      Interval = 10
      Left = -70320
      Top = 3240
    End
    Begin Frame Frame8
      Left = -73320
      Top = 1920
      Width = 495
      Height = 735
      TabIndex = 59
      BorderStyle = 0 'None
      Begin TextBox Text14
        Left = 0
        Top = 0
        Width = 375
        Height = 195
        TabIndex = 62
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text16
        Left = 0
        Top = 480
        Width = 375
        Height = 195
        TabIndex = 61
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text15
        Left = 0
        Top = 240
        Width = 375
        Height = 195
        TabIndex = 60
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
    End
    Begin Frame Frame7
      BackColor = &HC0C0C0&
      ForeColor = &H80000008&
      Left = -74400
      Top = 2640
      Width = 855
      Height = 615
      TabIndex = 55
      Appearance = 0 'Flat
      BorderStyle = 0 'None
    End
    Begin PictureBox Picture2
      Left = -72840
      Top = 1920
      Width = 1215
      Height = 735
      TabIndex = 52
      ScaleMode = 1
      AutoRedraw = False
      FontTransparent = True
    End
    Begin HScrollBar HScroll1
      Index = 2
      Left = -74760
      Top = 2400
      Width = 1335
      Height = 135
      TabIndex = 51
      Max = 255
      LargeChange = 10
    End
    Begin HScrollBar HScroll1
      Index = 1
      Left = -74760
      Top = 2160
      Width = 1335
      Height = 135
      TabIndex = 50
      Max = 255
      LargeChange = 10
    End
    Begin HScrollBar HScroll1
      Index = 0
      Left = -74760
      Top = 1920
      Width = 1335
      Height = 135
      TabIndex = 49
      Max = 255
      LargeChange = 10
    End
    Begin Frame Frame6
      Left = -74880
      Top = 480
      Width = 4935
      Height = 1095
      TabIndex = 37
      Begin TextBox Text19
        Left = 2640
        Top = 240
        Width = 375
        Height = 195
        TabIndex = 58
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text13
        Left = 2640
        Top = 720
        Width = 375
        Height = 195
        TabIndex = 48
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text12
        Left = 2640
        Top = 480
        Width = 375
        Height = 195
        TabIndex = 47
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text11
        Left = 1080
        Top = 720
        Width = 1095
        Height = 195
        TabIndex = 46
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text10
        Left = 1080
        Top = 480
        Width = 1095
        Height = 195
        TabIndex = 45
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text9
        Left = 1080
        Top = 240
        Width = 1095
        Height = 195
        TabIndex = 44
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin PictureBox Picture1
        BackColor = &HC0C0C0&
        Left = 3480
        Top = 240
        Width = 1335
        Height = 735
        TabIndex = 38
        ScaleMode = 1
        AutoRedraw = False
        FontTransparent = True
      End
      Begin Label Label26
        Caption = "Red"
        Left = 2280
        Top = 240
        Width = 495
        Height = 135
        TabIndex = 57
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label21
        Caption = "Color"
        Left = 600
        Top = 720
        Width = 495
        Height = 135
        TabIndex = 56
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label23
        Caption = "Blue"
        Left = 2280
        Top = 720
        Width = 495
        Height = 135
        TabIndex = 43
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label22
        Caption = "Green"
        Left = 2280
        Top = 480
        Width = 495
        Height = 135
        TabIndex = 42
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label20
        Caption = "Html"
        Left = 600
        Top = 480
        Width = 495
        Height = 135
        TabIndex = 41
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label17
        Caption = "Hex"
        Left = 600
        Top = 240
        Width = 495
        Height = 135
        TabIndex = 40
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Image Image4
        Picture = "Main.frx":30A
        Left = 120
        Top = 360
        Width = 480
        Height = 480
      End
    End
    Begin Frame Frame4
      Left = -74880
      Top = 360
      Width = 4935
      Height = 3255
      TabIndex = 31
      Begin CommandButton Command5
        Caption = "API Basics"
        Left = 1200
        Top = 1320
        Width = 2295
        Height = 255
        TabIndex = 33
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin CommandButton Command4
        Caption = "What you need In your module"
        Left = 1200
        Top = 1080
        Width = 2295
        Height = 255
        TabIndex = 32
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin CommandButton Command10
        Caption = "Check for updates"
        Left = 1200
        Top = 720
        Width = 2295
        Height = 255
        TabIndex = 39
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label19
        Caption = "Main.frx":468
        Left = 120
        Top = 1800
        Width = 4695
        Height = 530
        TabIndex = 36
        Alignment = 2 'Center
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label16
        Caption = "Tko's site, he taught me findwindow, and findwindowex, he is a great friend. Check out his site."
        Left = 120
        Top = 2520
        Width = 4695
        Height = 375
        TabIndex = 35
        Alignment = 2 'Center
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label14
        Caption = "My site  Mavness.com, Check for updates and other good stuff"
        Left = 120
        Top = 240
        Width = 4695
        Height = 255
        TabIndex = 34
        Alignment = 2 'Center
        BeginProperty Font
          Name = "Arial"
          Size = 8.25
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
    End
    Begin TextBox Text8
      Left = -74880
      Top = 3360
      Width = 3255
      Height = 1455
      Visible = 0   'False
      Text = "Main.frx":507
      TabIndex = 30
      MultiLine = -1  'True
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin CommandButton Command8
      Caption = "HELP!"
      Left = 3960
      Top = 480
      Width = 975
      Height = 255
      TabIndex = 29
    End
    Begin CommandButton Command7
      Caption = "Options"
      Left = 2280
      Top = 480
      Width = 1455
      Height = 255
      TabIndex = 28
    End
    Begin CommandButton Command6
      Caption = "Re-Enable Mouse"
      Left = -74880
      Top = 420
      Width = 1335
      Height = 375
      TabIndex = 27
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin Frame Frame3
      Left = -74880
      Top = 2400
      Width = 4815
      Height = 1215
      TabIndex = 17
      Begin TextBox Text7
        Left = 2160
        Top = 240
        Width = 2535
        Height = 855
        Text = "Main.frx":518
        TabIndex = 24
        MultiLine = -1  'True
        ScrollBars = 2
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
        ToolTipText = "Double click to enlarge"
      End
      Begin TextBox Text6
        Left = 1200
        Top = 840
        Width = 855
        Height = 255
        TabIndex = 23
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text5
        Left = 1200
        Top = 540
        Width = 855
        Height = 270
        TabIndex = 22
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text4
        Left = 1200
        Top = 240
        Width = 855
        Height = 270
        TabIndex = 21
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin CommandButton Command3
        Caption = "Make Code"
        Left = 120
        Top = 840
        Width = 975
        Height = 255
        TabIndex = 20
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin CommandButton Command2
        Caption = "Get Info"
        Left = 120
        Top = 600
        Width = 975
        Height = 255
        TabIndex = 19
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text3
        Left = 120
        Top = 240
        Width = 975
        Height = 285
        Text = "Enter Handle"
        TabIndex = 18
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
    End
    Begin Frame Frame2
      Left = -74880
      Top = 840
      Width = 4815
      Height = 2535
      TabIndex = 9
      Begin TextBox APItxt
        Index = 5
        Left = 2160
        Top = 2160
        Width = 2415
        Height = 225
        TabIndex = 73
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox APItxt
        Index = 4
        Left = 2160
        Top = 1800
        Width = 2415
        Height = 225
        TabIndex = 72
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox APItxt
        Index = 3
        Left = 2160
        Top = 1440
        Width = 2415
        Height = 225
        TabIndex = 71
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox APItxt
        Index = 2
        Left = 2160
        Top = 960
        Width = 2415
        Height = 225
        TabIndex = 70
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox APItxt
        Index = 1
        Left = 2160
        Top = 600
        Width = 2415
        Height = 225
        TabIndex = 69
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox APItxt
        Index = 0
        Left = 2160
        Top = 240
        Width = 2415
        Height = 225
        TabIndex = 68
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label6
        Caption = "Parent Window Caption:"
        Left = 120
        Top = 2160
        Width = 1800
        Height = 255
        TabIndex = 15
      End
      Begin Label Label5
        Caption = "Parent Window Class:"
        Index = 1
        Left = 120
        Top = 1800
        Width = 1575
        Height = 255
        TabIndex = 14
      End
      Begin Label Label4
        Caption = "Parent Window Handle:"
        Index = 1
        Left = 120
        Top = 1440
        Width = 1695
        Height = 255
        TabIndex = 13
      End
      Begin Label Label3
        Caption = "Window Caption:"
        Index = 1
        Left = 120
        Top = 960
        Width = 1215
        Height = 255
        TabIndex = 12
      End
      Begin Label Label2
        Caption = "Window Class:"
        Index = 1
        Left = 120
        Top = 600
        Width = 1215
        Height = 255
        TabIndex = 11
      End
      Begin Label Label1
        Caption = "Window Handle:"
        Left = 120
        Top = 240
        Width = 1335
        Height = 255
        TabIndex = 10
      End
    End
    Begin Frame Frame1
      Left = -74880
      Top = 360
      Width = 4815
      Height = 2055
      TabIndex = 2
      Begin ListBox List2
        Left = 120
        Top = 1200
        Width = 975
        Height = 420
        TabIndex = 26
        List = "Main.frx":529
        ItemData = "Main.frx":541
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin ListBox List1
        Index = 2
        Left = 3480
        Top = 240
        Width = 1215
        Height = 1500
        TabIndex = 8
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin ListBox List1
        Index = 1
        Left = 2160
        Top = 240
        Width = 1215
        Height = 1500
        TabIndex = 7
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin ListBox List1
        Index = 0
        Left = 1200
        Top = 240
        Width = 855
        Height = 1500
        TabIndex = 6
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin CommandButton Command1
        Caption = "Display"
        Left = 120
        Top = 1680
        Width = 975
        Height = 255
        TabIndex = 5
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin TextBox Text2
        Left = 120
        Top = 840
        Width = 975
        Height = 285
        Text = "Enter Handle"
        TabIndex = 3
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Label Label18
        Caption = "Drag For Handle"
        Index = 0
        Left = 120
        Top = 240
        Width = 1095
        Height = 135
        TabIndex = 4
        BeginProperty Font
          Name = "Arial"
          Size = 6.75
          Charset = 0
          Weight = 400
          Underline = 0 'False
          Italic = 0 'False
          Strikethrough = 0 'False
        EndProperty
      End
      Begin Image Image3
        Picture = "Main.frx":54B
        Left = 480
        Top = 360
        Width = 480
        Height = 480
      End
    End
    Begin TextBox Text1
      Left = 120
      Top = 840
      Width = 4935
      Height = 2655
      Text = "Main.frx":6A9
      TabIndex = 1
      MultiLine = -1  'True
      ScrollBars = 2
      BeginProperty Font
        Name = "Arial"
        Size = 8.25
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
      ToolTipText = "Double click to enlarge"
    End
    Begin Label Label7
      Caption = "Next version, go to www.mavness.com for updates"
      Left = -74880
      Top = 720
      Width = 5055
      Height = 255
      TabIndex = 84
      Alignment = 2 'Center
    End
    Begin Label Label27
      Caption = "Color"
      Left = -74760
      Top = 3120
      Width = 495
      Height = 135
      TabIndex = 63
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin Label Label25
      Caption = "Html"
      Left = -74760
      Top = 2880
      Width = 375
      Height = 135
      TabIndex = 54
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin Label Label24
      Caption = "Hex"
      Left = -74760
      Top = 2640
      Width = 255
      Height = 135
      TabIndex = 53
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin Label Label15
      Caption = "Use to make code  --->"
      Left = 240
      Top = 480
      Width = 1575
      Height = 255
      TabIndex = 25
      BeginProperty Font
        Name = "Arial"
        Size = 6.75
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
    End
    Begin Label Label13
      Caption = "Move mouse or drag and drop this-->"
      Left = -73440
      Top = 480
      Width = 2655
      Height = 255
      TabIndex = 16
    End
    Begin Image Image2
      Picture = "Main.frx":6C0
      Left = -70440
      Top = 360
      Width = 480
      Height = 480
    End
    Begin Image Image1
      Picture = "Main.frx":81E
      Left = 1800
      Top = 360
      Width = 480
      Height = 480
    End
  End
End

Attribute VB_Name = "Main"

Private Declare Function ReleaseCapture Lib "user32" Alias "ReleaseCapture" () As Long
Private Declare Function ShowWindow Lib "user32" Alias "ShowWindow" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function ScreenToClient Lib "user32" Alias "ScreenToClient" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Private Declare Function ReleaseDC Lib "user32" Alias "ReleaseDC" (ByVal hwnd As Long, ByVal hdc As Long) As Long
Private Declare Function BitBlt Lib "gdi32" Alias "BitBlt" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function GetDC Lib "user32" Alias "GetDC" (ByVal hwnd As Long) As Long
Private Declare Function GetPixel Lib "gdi32" Alias "GetPixel" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function GetWindowPlacement Lib "user32" Alias "GetWindowPlacement" (ByVal hwnd As Long, lpwndpl As WINDOWPLACEMENT) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function SetWindowPos Lib "user32" Alias "SetWindowPos" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Declare Function GetCursorPos Lib "user32" Alias "GetCursorPos" (lpPoint As POINTAPI) As Long
Private Declare Function LoadCursorFromFile Lib "user32" Alias "LoadCursorFromFileA" (ByVal lpFileName As String) As Long
Private Declare Function SetSystemCursor Lib "user32" Alias "SetSystemCursor" (ByVal hcur As Long, ByVal id As Long) As Long
Private Declare Function CopyIcon Lib "user32" Alias "CopyIcon" (ByVal hIcon As Long) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Private Declare Function GetCursorPos Lib "user32" Alias "GetCursorPos" (lpPoint As POINTAPI) As Long
Private Declare Function GetWindowWord Lib "user32" Alias "GetWindowWord" (ByVal hwnd As Long, ByVal nIndex As Long) As Integer
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function GetClassWord Lib "user32" Alias "GetClassWord" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Declare Function GetClassLong Lib "user32" Alias "GetClassLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function GetClassInfo Lib "user32" Alias "GetClassInfoA" (ByVal hInstance As Long, ByVal lpClassName As String, lpWndClass As WNDCLASS) As Long
Private Declare Function WindowFromPoint Lib "user32" Alias "WindowFromPoint" (ByVal xPoint As Long, ByVal yPoint As Long) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function GetParent Lib "user32" Alias "GetParent" (ByVal hwnd As Long) As Long
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long


Private Sub Command1_Click()
  Dim var_1C As Variant
  var_A4 = List2.ListIndex
  If eax = 0 Then GoTo loc_0040E045
  var_18 = Text2.Text
  GoTo loc_0040DF89
  If eax <> 0 Then GoTo loc_0040E21D
  var_18 = Text2.Text
  call __vbaCastObj(Me, var_00407424, var_1C, Me, Me, var_1C, eax, Me, var_1C, eax, Me, esi, Me, Set %StkVar1 = %StkVar2 'Ignore this)
  call Proc_3_5_415230(var_B0, var_20, var_20)
  GoTo loc_0040E21D
  var_A4 = List2.ListIndex
  If edx = 0 Then GoTo loc_0040E1B4
  var_18 = Text2.Text
  GoTo loc_0040E0FB
  If eax <> 0 Then GoTo loc_0040E21D
  var_18 = Text2.Text
  call __vbaCastObj(Me, var_00407424, var_1C, eax, Me, var_1C, Me, Me, var_1C, var_1C)
  call Proc_3_6_415800(var_B0, var_20, var_20)
  GoTo loc_0040E21D
  var_30 = "Please select what to display in the listbox"
  Exit Sub
End Sub

Private Sub Timer1_Timer()
  Dim var_24 As TextBox
  Dim var_58 As TextBox
  Dim var_2C As TextBox
  var_38 = call Proc_414D10(edi, Me, ebx)
  call Proc_414D40(var_20, %StkVar1 = CheckObj(%StkVar2, %StkVar3, %StkVar4), var_24)
  var_34 = (vtable)
  var_30 = var_38
  call Proc_414D70(var_30, var_34, var_20)
  APItxt.Text = CStr(call Proc_414D70(var_30, var_34, var_20))
  var_58 = var_2C
  var_18 = APItxt.Text
  var_30 = var_18
  call GetClass(var_30, var_20, 0)
  APItxt.Text = call GetClass(var_30, var_20, 0)
  var_18 = APItxt.Text
  var_30 = var_18
  var_1C = call GetCaption(var_30, var_20, 0)
  If (var_1C = vbNullString) + 1 = 0 Then GoTo loc_00411E2C
  APItxt.Text = "VbNullString"
  GoTo loc_00411F34
  var_58 = var_2C
  var_18 = APItxt.Text
  var_30 = var_18
  call GetCaption(var_30, Me, 0)
  APItxt.Text = call GetCaption(var_30, Me, 0)
  var_3C = call Proc_414D10(var_20, Me, )
  call Proc_414D40(call Proc_414D10(var_20, Me, ), 3, var_24)
  var_34 = call Proc_414D40(call Proc_414D10(var_20, Me, ), 3, var_24)
  var_30 = var_3C
  var_38 = call Proc_414D70(var_30, var_34, var_20)
  call Proc_414DA0(var_38, call Proc_414D10(var_20, Me, ), Me)
  APItxt.Text = CStr(call Proc_414DA0(var_38, call Proc_414D10(var_20, Me, ), Me))
  var_58 = var_2C
  var_18 = APItxt.Text
  var_30 = var_18
  call GetClass(var_30, var_20, 3)
  APItxt.Text = call GetClass(var_30, var_20, 3)
  var_18 = APItxt.Text
  var_30 = var_18
  var_1C = call GetCaption(var_30, var_20, 3)
  If (var_1C = vbNullString) + 1 = 0 Then GoTo loc_00412222
  APItxt.Text = "VbNullString"
  GoTo loc_0041231B
  var_18 = APItxt.Text
  var_30 = var_18
  var_1C = call GetCaption(var_30, var_20, 3)
  APItxt.Text = var_1C
  Exit Sub
End Sub

Private Sub List1_Click()
  Dim var_44 As ListBox
  Dim var_24 As ListBox
  var_44 = var_24
  var_28 = List1.ListIndex
  List1.ListIndex = var_28
  var_44 = var_24
  var_28 = List1.ListIndex
  List1.ListIndex = var_28
  var_28 = List1.ListIndex
  List1.ListIndex = var_28
  Exit Sub
End Sub

Private Sub Timer2_Timer()
  Dim var_1C As TextBox
  call Proc_414D10(edi, Me, ebx)
  call Proc_414D40(var_1C, call Proc_414D10(edi, Me, ebx), Me)
  var_24 = call Proc_414D40(var_1C, call Proc_414D10(edi, Me, ebx), Me)
  var_20 = call Proc_414D10(edi, Me, ebx)
  call Proc_414D70(var_20, var_24, )
  var_18 = CStr(call Proc_414D70(var_20, var_24, ))
  Text2.Text = var_18
  call Proc_414D10(, , )
  var_24 = call Proc_414D40(var_1C, esi, Me)
  var_20 = call Proc_414D10(, , )
  call Proc_414D70(var_20, var_24, )
  var_18 = CStr(call Proc_414D70(var_20, var_24, ))
  Text3.Text = var_18
  Exit Sub
End Sub

Private Sub Image4_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  Dim var_28 As Image
  If eax <> 0 Then GoTo loc_00410257
  var_28 = Image1.Picture
  var_38 = var_28._Default
  var_ret_1 = var_28
  If esi+&h00000034 = 0 Then GoTo loc_00410257
  GetCursorPos()
  CopyIcon(GetCursorPos())
  SetSystemCursor(esi+&h00000034, 32512)
  Timer3.Enabled = True
  Exit Sub
End Sub

Private Sub Image4_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
  If eax = 0 Then GoTo loc_00410340
  SetSystemCursor(Me.GetPalette, 32512)
  Timer3.Enabled = edi
  Exit Sub
End Sub

Private Sub Label14_Click()
  Dim var_2C As App
  var_30 = Me.hWnd
  var_2C = Global.App
  var_18 = Global.Path
  ShellExecute(var_30, "Open", "http://www.mavness.com", vbNullString, var_18, 1)
  Exit Sub
End Sub

Private Sub Label14_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
  Exit Sub
End Sub

Private Sub Image3_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  Dim var_28 As Image
  If eax <> 0 Then GoTo loc_0040FFF7
  var_28 = Image1.Picture
  var_38 = var_28._Default
  var_ret_1 = var_28
  If esi+&h00000034 = 0 Then GoTo loc_0040FFF7
  GetCursorPos()
  CopyIcon(GetCursorPos())
  SetSystemCursor(esi+&h00000034, 32512)
  Timer2.Enabled = True
  Exit Sub
End Sub

Private Sub Image3_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
  If eax = 0 Then GoTo loc_004100E0
  SetSystemCursor(Me.GetPalette, 32512)
  Timer2.Enabled = edi
  Exit Sub
End Sub

Private Sub Image2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  Dim var_28 As Image
  If eax <> 0 Then GoTo loc_0040FD97
  var_28 = Image1.Picture
  var_38 = var_28._Default
  var_ret_1 = var_28
  If esi+&h00000034 = 0 Then GoTo loc_0040FD97
  GetCursorPos()
  CopyIcon(GetCursorPos())
  SetSystemCursor(esi+&h00000034, 32512)
  Timer1.Enabled = True
  Exit Sub
End Sub

Private Sub Image2_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
  If eax = 0 Then GoTo loc_0040FE80
  SetSystemCursor(Me.GetPalette, 32512)
  Timer1.Enabled = edi
  Exit Sub
End Sub

Private Sub Label16_Click()
  Dim var_2C As App
  var_30 = Me.hWnd
  var_2C = Global.App
  var_18 = Global.Path
  ShellExecute(var_30, "Open", "http://www.vbfx.com", vbNullString, var_18, 1)
  Exit Sub
End Sub

Private Sub Label16_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
  Exit Sub
End Sub

Private Sub Label19_Click()
  Dim var_2C As App
  var_30 = Me.hWnd
  var_2C = Global.App
  var_18 = Global.Path
  ShellExecute(var_30, "Open", "http://www.patorjk.com", vbNullString, var_18, 1)
  Exit Sub
End Sub

Private Sub Label19_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
  Exit Sub
End Sub

Private Sub Command7_Click()
  var_eax = Options.Show var_18
End Sub

Private Sub Command2_Click()
  Dim var_24 As TextBox
  Dim var_34 As TextBox
  Dim var_20 As TextBox
  var_34 = var_24
  var_18 = Text3.Text
  var_28 = CLng(Val(var_18))
  var_1C = call GetClass(var_28, var_20, var_24)
  Text3.Text = var_1C
  var_34 = var_20
  var_18 = Text3.Text
  var_28 = CLng(Val(var_18))
  var_1C = call GetCaption(var_28, var_20, Me)
  Text3.Text = var_1C
  var_18 = Text3.Text
  GetParent(CLng(Val(var_18)))
  var_1C = CStr(GetParent(CLng(Val(var_18))))
  Text3.Text = var_1C
  Exit Sub
End Sub

Private Sub Command3_Click()
  var_18 = Text3.Text
  call Proc_3_8_415E30(var_20, FFFFFFFFh, CLng(Val(var_18)))
  Exit Sub
End Sub

Private Sub Command4_Click()
  var_eax = APIcalls.Show var_18
End Sub

Private Sub Command5_Click()
  var_eax = Basic.Show var_18
End Sub

Private Sub Command6_Click()
  Timer1.Enabled = True
  Exit Sub
End Sub

Private Sub Image1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  Dim var_28 As Image
  If eax <> 0 Then GoTo loc_0040F9A7
  var_28 = Image1.Picture
  var_38 = var_28._Default
  var_ret_1 = var_28
  If esi+&h00000034 = 0 Then GoTo loc_0040F9A7
  GetCursorPos()
  CopyIcon(GetCursorPos())
  SetSystemCursor(esi+&h00000034, 32512)
  Exit Sub
End Sub

Private Sub Image1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
  If eax = 0 Then GoTo loc_0040FA7B
  SetSystemCursor(Me.GetPalette, 32512)
  var_24 = SetSystemCursor(Me.GetPalette, 32512)
  call Proc_3_8_415E30(var_28, var_40, var_44)
  Exit Sub
End Sub

Private Sub Frame4_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
  Exit Sub
End Sub

Private Sub Timer3_Timer()
  Dim var_9C As Variant
  Dim var_A0 As TextBox
  Dim var_A4 As PictureBox
  On Error Resume Next
  GetCursorPos(var_40)
  var_ret_1 = var_3C
  var_ret_2 = var_40
  WindowFromPoint(var_ret_2, var_ret_1)
  var_24 = WindowFromPoint(var_ret_2, var_ret_1)
  GetDC(var_24)
  var_28 = GetDC(var_24)
  ScreenToClient(var_24, var_40)
  GetPixel(var_28, var_40, var_3C)
  var_64 = GetPixel(var_28, var_40, var_3C)
  If var_64 <> -1 Then GoTo loc_004127EE
  var_98 = Picture1.hDC
  var_A0 = var_98
  BitBlt(var_98, 0, 0, 1, 1, var_28, var_40, var_3C, var_00CC0020)
  var_eax = Picture1.Point 0, 0
  var_A0 = Picture1.Point 0, 0
  var_64 = var_98
  GoTo loc_0041287E
  var_eax = Picture1.PSet (0, 0), var_64
  var_A0 = Picture1.PSet (0, 0), var_64
  ReleaseDC(var_24, var_28)
  var_9C = var_70
  Picture1.BackColor = var_64
  var_A0 = var_9C
  var_9C = var_70
  var_8C = var_64
  Text9.Text = CStr(Hex(var_64))
  var_A0 = var_9C
  var_A0 = var_70
  var_6C = Main.ColorToHTML(var_64)
  var_9C = var_6C
  Text10.Text = var_6C
  var_A4 = var_A0
  var_98 = Picture1.BackColor
  var_A0 = var_98
  Picture1.MousePointer = var_98
  var_A8 = var_A4
  var_9C = var_70
  var_6C = Text11.Text
  var_A0 = var_6C
  call Proc_415C00(var_B4, CLng(Val(var_6C)), var_70)
  call __vbaCopyBytes(&h0000000C, var_34, var_B4, var_B4, Me, var_74, Me, Me, var_70, var_B4, Me, var_70, Me, Me)
  Text19.Text = var_34
  var_A0 = var_9C
  var_9C = var_70
  Text12.Text = var_30
  var_A0 = var_9C
  var_9C = var_70
  Text13.Text = var_2C
  var_A0 = var_9C
  Exit Sub
End Sub

Private Sub Text14_KeyPress(KeyAscii As Integer)
  On Error Resume Next
  If KeyAscii <> 13 Then GoTo loc_00411277
  If IsNumeric(Me) = 0 Then GoTo loc_00411277
  var_20 = Text14.Text
  Text14.FontBold = CInt(Val(var_20))
  GoTo loc_00411277
  var_3C = var_A8 & ", " & var_24
  Exit Sub
  Exit Sub
End Sub

Private Sub Text15_KeyPress(KeyAscii As Integer)
  On Error Resume Next
  If KeyAscii <> 13 Then GoTo loc_00411583
  If IsNumeric(Me) = 0 Then GoTo loc_00411583
  var_20 = Text15.Text
  Text15.FontBold = CInt(Val(var_20))
  GoTo loc_00411583
  var_3C = var_A8 & ", " & var_24
  Exit Sub
  Exit Sub
End Sub

Private Sub Text16_KeyPress(KeyAscii As Integer)
  On Error Resume Next
  If KeyAscii <> 13 Then GoTo loc_00411898
  If IsNumeric(Me) = 0 Then GoTo loc_00411898
  var_20 = Text16.Text
  Text16.FontBold = CInt(Val(var_20))
  GoTo loc_00411898
  var_3C = var_A8 & ", " & var_24
  Exit Sub
  Exit Sub
End Sub

Private Sub Text7_DblClick()
  var_eax = Enlarge.Show var_24
  var_18 = Text7.Text
  Text7.Text = var_18
  Exit Sub
End Sub

Private Sub Text1_DblClick()
  var_eax = Enlarge.Show var_24
  var_18 = Text1.Text
  Text1.Text = var_18
  Exit Sub
End Sub

Private Sub HScroll1_Change()
  Dim var_20 As Variant
  Dim var_8C As HScrollBar
  Dim var_84 As PictureBox
  Dim var_88 As PictureBox
  var_68 = HScroll1.Value
  var_6C = HScroll1.Value
  var_AC = var_34
  var_70 = HScroll1.Value
  var_BC = var_68
  var_8C = var_24
  var_68 = HScroll1.Value
  var_18 = var_68
  HScroll1.Max = var_18
  var_8C = var_24
  var_68 = HScroll1.Value
  var_18 = var_68
  HScroll1.Max = var_18
  var_8C = var_24
  var_68 = HScroll1.Value
  var_18 = var_68
  HScroll1.Max = var_18
  var_84 = var_20
  var_74 = Picture2.BackColor
  var_3C = var_74
  var_18 = CStr(Hex(var_74))
  Picture2.MousePointer = var_18
  var_88 = var_44
  var_74 = Picture2.BackColor
  var_18 = Main.ColorToHTML(var_74)
  Picture2.MousePointer = var_18
  var_74 = Picture2.BackColor
  var_18 = var_74
  Picture2.MousePointer = var_18
  Exit Sub
End Sub

Private Sub Form_Load()
  call __vbaCastObj(Me, var_00407424, __vbaCastObj, Me, ebx)
  call Proc_3_0_414910(var_18, var_18, __vbaCastObj(Me, var_00407424, __vbaCastObj, Me, ebx))
  call __vbaCastObj(Me, var_00407424)
  call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424))
  Exit Sub
End Sub

Private Sub Form_Resize()
  var_18 = Me.WindowState
  If var_18 <> 2 Then GoTo loc_0040EC72
  Me.WindowState = 0
  If var_18 >= 0 Then GoTo loc_0040ECDE
  GoTo loc_0040ECD5
  var_18 = Me.WindowState
  If var_18 = 1 Then GoTo loc_0040ECDE
  Me.Width = var_45AD7000
  Me.Height = var_45870000
  If var_18 >= 0 Then GoTo loc_0040ECDE
End Sub

Private Sub Form_Unload(Cancel As Integer)
  Dim var_40 As Timer
  var_40 = "                         Leaving already?"
  If MsgBox(var_40, 4, var_50, var_60, var_70) <> 0 Then GoTo loc_0040EFC1
  Timer1.Enabled = ebx
  Timer2.Enabled = ebx
  End
  Set var_30 = Me
  var_eax = Global.Unload var_30
  call __vbaVarSetObjAddref(var_24, ebx, Me, var_30, var_40, Me, var_30, var_40, Me, 0, Me, ebx)
  End
  GoTo loc_0040EFC9
  Exit Sub
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  call GetListText(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  Exit Sub
End Sub

Private Sub Form_Terminate()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Public Function Check_Function()
  GetWindowPlacement(%x1 = Me.Caption, 5)
  If esi <> 0 Then GoTo loc_0040FC40
  Text1.Text = vbNullString
  var_40 = "Code cannot be created for this."
  Exit Sub
End Function

Public Function ColorToHTML(clr)
  call __vbaCopyBytes(&h00000004, var_20, var_20, edi, esi, ebx)
  var_3C = var_20
  var_2C = Trim$(Hex$(var_20))
  If Len(var_2C) <> 1 Then GoTo loc_00412FF0
  var_2C = var_004078A8 & var_2C
  var_3C = var_1F
  var_18 = Trim$(Hex$(var_1F))
  If Len(var_18) <> 1 Then GoTo loc_00413042
  var_18 = var_004078A8 & var_18
  var_3C = var_1E
  var_28 = Trim$(Hex$(var_1E))
  If Len(var_28) <> 1 Then GoTo loc_00413098
  var_28 = var_004078A8 & var_28
  GoTo loc_0041309E
  var_1C = var_004078B0 & var_2C & var_18 & var_28
  GoTo loc_00413109
  If var_4 = 0 Then GoTo loc_004130F5
  Exit Sub
End Function
