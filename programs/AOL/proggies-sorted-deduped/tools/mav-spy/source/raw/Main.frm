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

'VA: 40734C
Private Declare Function ReleaseCapture Lib "user32" Alias "ReleaseCapture" () As Long
'VA: 407304
Private Declare Function ShowWindow Lib "user32" Alias "ShowWindow" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
'VA: 4072C0
Private Declare Function ScreenToClient Lib "user32" Alias "ScreenToClient" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
'VA: 407278
Private Declare Function ReleaseDC Lib "user32" Alias "ReleaseDC" (ByVal hwnd As Long, ByVal hdc As Long) As Long
'VA: 407234
Private Declare Function BitBlt Lib "gdi32" Alias "BitBlt" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
'VA: 4071F4
Private Declare Function GetDC Lib "user32" Alias "GetDC" (ByVal hwnd As Long) As Long
'VA: 4071B4
Private Declare Function GetPixel Lib "gdi32" Alias "GetPixel" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long) As Long
'VA: 407150
Private Declare Function GetWindowPlacement Lib "user32" Alias "GetWindowPlacement" (ByVal hwnd As Long, lpwndpl As WINDOWPLACEMENT) As Long
'VA: 40710C
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
'VA: 4070C4
Private Declare Function SetWindowPos Lib "user32" Alias "SetWindowPos" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
'VA: 40707C
Private Declare Function GetCursorPos Lib "user32" Alias "GetCursorPos" (lpPoint As POINTAPI) As Long
'VA: 407038
Private Declare Function LoadCursorFromFile Lib "user32" Alias "LoadCursorFromFileA" (ByVal lpFileName As String) As Long
'VA: 406FEC
Private Declare Function SetSystemCursor Lib "user32" Alias "SetSystemCursor" (ByVal hcur As Long, ByVal id As Long) As Long
'VA: 406F94
Private Declare Function CopyIcon Lib "user32" Alias "CopyIcon" (ByVal hIcon As Long) As Long
'VA: 406F50
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
'VA: 406F08
Private Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
'VA: 406EB8
Private Declare Function GetCursorPos Lib "user32" Alias "GetCursorPos" (lpPoint As POINTAPI) As Long
'VA: 406E70
Private Declare Function GetWindowWord Lib "user32" Alias "GetWindowWord" (ByVal hwnd As Long, ByVal nIndex As Long) As Integer
'VA: 406E28
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
'VA: 406DE0
Private Declare Function GetClassWord Lib "user32" Alias "GetClassWord" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
'VA: 406D98
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
'VA: 406D50
Private Declare Function GetClassLong Lib "user32" Alias "GetClassLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
'VA: 406D08
Private Declare Function GetClassInfo Lib "user32" Alias "GetClassInfoA" (ByVal hInstance As Long, ByVal lpClassName As String, lpWndClass As WNDCLASS) As Long
'VA: 406CC0
Private Declare Function WindowFromPoint Lib "user32" Alias "WindowFromPoint" (ByVal xPoint As Long, ByVal yPoint As Long) As Long
'VA: 406C78
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
'VA: 406C30
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
'VA: 406BEC
Private Declare Function GetParent Lib "user32" Alias "GetParent" (ByVal hwnd As Long) As Long
'VA: 406A6C
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long


Private Sub Command1_Click() '40DE60
  Dim var_1C As Variant
  loc_0040DEEB: var_A4 = List2.ListIndex
  loc_0040DF16: setz al
  loc_0040DF29: If eax = 0 Then GoTo loc_0040E045
  loc_0040DF45: var_18 = Text2.Text
  loc_0040DF73: fcomp real8 ptr [004011A0h]
  loc_0040DF85: GoTo loc_0040DF89
  loc_0040DF89: 'Referenced from: 0040DF85
  loc_0040DFA2: If eax <> 0 Then GoTo loc_0040E21D
  loc_0040DFC1: var_18 = Text2.Text
  loc_0040DFF5: call __vbaCastObj(Me, var_00407424, var_1C, Me, Me, var_1C, eax, Me, var_1C, eax, Me, esi, Me, Set %StkVar1 = %StkVar2 'Ignore this)
  loc_0040E01F: var_eax = call Proc_3_5_415230(CLng(var_B0), var_20, var_20)
  loc_0040E040: GoTo loc_0040E21D
  loc_0040E05E: var_A4 = List2.ListIndex
  loc_0040E088: setz dl
  loc_0040E098: If edx = 0 Then GoTo loc_0040E1B4
  loc_0040E0B7: var_18 = Text2.Text
  loc_0040E0E5: fcomp real8 ptr [004011A0h]
  loc_0040E0F7: GoTo loc_0040E0FB
  loc_0040E0FB: 'Referenced from: 0040E0F7
  loc_0040E114: If eax <> 0 Then GoTo loc_0040E21D
  loc_0040E133: var_18 = Text2.Text
  loc_0040E167: call __vbaCastObj(Me, var_00407424, var_1C, eax, Me, var_1C, Me, Me, var_1C, var_1C)
  loc_0040E191: var_eax = call Proc_3_6_415800(CLng(var_B0), var_20, var_20)
  loc_0040E1B2: GoTo loc_0040E21D
  loc_0040E1B4: 'Referenced from: 0040E098
  loc_0040E1E4: var_30 = "Please select what to display in the listbox"
  loc_0040E21D: 'Referenced from: 0040DFA2
  loc_0040E22A: GoTo loc_0040E261
  loc_0040E260: Exit Sub
  loc_0040E261: 'Referenced from: 0040E22A
End Sub

Private Sub Timer1_Timer() '411AE0
  Dim var_24 As TextBox
  Dim var_58 As TextBox
  Dim var_2C As TextBox
  loc_00411B3D: var_eax = call Proc_414D10(edi, Me, ebx)
  loc_00411B45: var_38 = call Proc_414D10(edi, Me, ebx)
  loc_00411B63: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_00411B8B: call Proc_414D40(var_20, %StkVar1 = CheckObj(%StkVar2, %StkVar3, %StkVar4), var_24)
  loc_00411B90: var_34 = Unknown_VTable_Call[ecx+00000040h]
  loc_00411B9D: var_30 = var_38
  loc_00411BA3: var_eax = call Proc_414D70(var_30, var_34, var_20)
  loc_00411BBA: var_68 = edi
  loc_00411BC5: APItxt.Text = CStr(call Proc_414D70(var_30, var_34, var_20))
  loc_00411C1A: var_eax = Unknown_VTable_Call[edx+00000040h]
  loc_00411C34: var_58 = var_2C
  loc_00411C53: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_00411C73: var_18 = APItxt.Text
  loc_00411C9D: var_30 = CLng(var_18)
  loc_00411CA3: var_eax = call Proc_3_3_414DC0(var_30, var_20, 0)
  loc_00411CBE: APItxt.Text = call Proc_3_3_414DC0(var_30, var_20, 0)
  loc_00411D22: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_00411D42: var_18 = APItxt.Text
  loc_00411D66: var_30 = CLng(var_18)
  loc_00411D6D: var_eax = call Proc_3_2_414BF0(var_30, var_20, 0)
  loc_00411D77: var_1C = call Proc_3_2_414BF0(var_30, var_20, 0)
  loc_00411D96: edi = (var_1C = vbNullString) + 1
  loc_00411DB8: If (var_1C = vbNullString) + 1 = 0 Then GoTo loc_00411E2C
  loc_00411DD9: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_00411DFA: APItxt.Text = "VbNullString"
  loc_00411E27: GoTo loc_00411F34
  loc_00411E2C: 'Referenced from: 00411DB8
  loc_00411E4B: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_00411E65: var_58 = var_2C
  loc_00411E84: var_eax = Unknown_VTable_Call[edx+00000040h]
  loc_00411EA4: var_18 = APItxt.Text
  loc_00411ECE: var_30 = CLng(var_18)
  loc_00411ED4: var_eax = call Proc_3_2_414BF0(var_30, Me, 0)
  loc_00411EEF: APItxt.Text = call Proc_3_2_414BF0(var_30, Me, 0)
  loc_00411F34: 'Referenced from: 00411E27
  loc_00411F34: var_eax = call Proc_414D10(var_20, Me, )
  loc_00411F3C: var_3C = call Proc_414D10(var_20, Me, )
  loc_00411F5B: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_00411F75: var_eax = call Proc_414D40(call Proc_414D10(var_20, Me, ), 3, var_24)
  loc_00411F7D: var_34 = call Proc_414D40(call Proc_414D10(var_20, Me, ), 3, var_24)
  loc_00411F88: var_30 = var_3C
  loc_00411F8B: var_eax = call Proc_414D70(var_30, var_34, var_20)
  loc_00411F93: var_38 = call Proc_414D70(var_30, var_34, var_20)
  loc_00411F99: var_eax = call Proc_414DA0(var_38, call Proc_414D10(var_20, Me, ), Me)
  loc_00411FB0: var_74 = edi
  loc_00411FBB: APItxt.Text = CStr(call Proc_414DA0(var_38, call Proc_414D10(var_20, Me, ), Me))
  loc_00412010: var_eax = Unknown_VTable_Call[edx+00000040h]
  loc_0041202A: var_58 = var_2C
  loc_00412049: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_00412069: var_18 = APItxt.Text
  loc_00412093: var_30 = CLng(var_18)
  loc_00412099: var_eax = call Proc_3_3_414DC0(var_30, var_20, 3)
  loc_004120B4: APItxt.Text = call Proc_3_3_414DC0(var_30, var_20, 3)
  loc_00412118: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_00412138: var_18 = APItxt.Text
  loc_0041215C: var_30 = CLng(var_18)
  loc_00412163: var_eax = call Proc_3_2_414BF0(var_30, var_20, 3)
  loc_0041216D: var_1C = call Proc_3_2_414BF0(var_30, var_20, 3)
  loc_0041218C: edi = (var_1C = vbNullString) + 1
  loc_004121AE: If (var_1C = vbNullString) + 1 = 0 Then GoTo loc_00412222
  loc_004121CF: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_004121F0: APItxt.Text = "VbNullString"
  loc_0041221D: GoTo loc_0041231B
  loc_00412222: 'Referenced from: 004121AE
  loc_00412241: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_00412277: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_00412297: var_18 = APItxt.Text
  loc_004122BE: var_30 = CLng(var_18)
  loc_004122C4: var_eax = call Proc_3_2_414BF0(var_30, var_20, 3)
  loc_004122CE: var_1C = call Proc_3_2_414BF0(var_30, var_20, 3)
  loc_004122D6: APItxt.Text = var_1C
  loc_0041231B: 'Referenced from: 0041221D
  loc_00412327: GoTo loc_00412355
  loc_00412354: Exit Sub
  loc_00412355: 'Referenced from: 00412327
End Sub

Private Sub List1_Click() '410AE0
  Dim var_44 As ListBox
  Dim var_24 As ListBox
  loc_00410B4F: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_00410B77: var_44 = var_24
  loc_00410B9B: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_00410BBB: var_28 = List1.ListIndex
  loc_00410BDF: List1.ListIndex = var_28
  loc_00410C33: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_00410C4D: var_44 = var_24
  loc_00410C71: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_00410C91: var_28 = List1.ListIndex
  loc_00410CB5: List1.ListIndex = var_28
  loc_00410D09: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_00410D44: var_eax = Unknown_VTable_Call[edx+00000040h]
  loc_00410D64: var_28 = List1.ListIndex
  loc_00410D85: List1.ListIndex = var_28
  loc_00410DC6: GoTo loc_00410DE4
  loc_00410DE3: Exit Sub
  loc_00410DE4: 'Referenced from: 00410DC6
End Sub

Private Sub Timer2_Timer() '412380
  Dim var_1C As TextBox
  loc_004123CE: var_eax = call Proc_414D10(edi, Me, ebx)
  loc_004123EB: var_eax = call Proc_414D40(var_1C, call Proc_414D10(edi, Me, ebx), Me)
  loc_004123F7: var_24 = call Proc_414D40(var_1C, call Proc_414D10(edi, Me, ebx), Me)
  loc_004123FA: var_20 = call Proc_414D10(edi, Me, ebx)
  loc_00412400: var_eax = call Proc_414D70(var_20, var_24, )
  loc_00412411: var_18 = CStr(call Proc_414D70(var_20, var_24, ))
  loc_00412419: Text2.Text = var_18
  loc_0041244B: var_eax = call Proc_414D10(, , )
  loc_00412468: var_eax = call Proc_414D40(var_1C, esi, Me)
  loc_0041246D: var_24 = call Proc_414D40(var_1C, esi, Me)
  loc_00412477: var_20 = call Proc_414D10(, , )
  loc_0041247D: var_eax = call Proc_414D70(var_20, var_24, )
  loc_0041248E: var_18 = CStr(call Proc_414D70(var_20, var_24, ))
  loc_00412496: Text3.Text = var_18
  loc_004124CE: GoTo loc_004124E3
  loc_004124E2: Exit Sub
  loc_004124E3: 'Referenced from: 004124CE
End Sub

Private Sub Image4_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single) '410160
  Dim var_28 As Image
  loc_004101B0: If eax <> 0 Then GoTo loc_00410257
  loc_004101D3: var_28 = Image1.Picture
  loc_004101F5: var_38 = var_28._Default
  loc_004101FF: var_ret_1 = CLng(var_28)
  loc_00410227: If esi+00000034h = 0 Then GoTo loc_00410257
  loc_00410229: var_eax = GetCursorPos()
  loc_00410239: var_eax = CopyIcon(GetCursorPos())
  loc_0041024E: var_eax = SetSystemCursor(esi+00000034h, 32512)
  loc_00410257: 'Referenced from: 004101B0
  loc_00410272: Timer3.Enabled = True
  loc_0041029B: GoTo loc_004102BA
  loc_004102B9: Exit Sub
  loc_004102BA: 'Referenced from: 0041029B
End Sub

Private Sub Image4_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) '4102E0
  loc_0041032A: If eax = 0 Then GoTo loc_00410340
  loc_00410335: var_eax = SetSystemCursor(Me.GetPalette, 32512)
  loc_00410340: 'Referenced from: 0041032A
  loc_0041035D: Timer3.Enabled = edi
  loc_00410386: GoTo loc_00410392
  loc_00410391: Exit Sub
  loc_00410392: 'Referenced from: 00410386
End Sub

Private Sub Label14_Click() '4103C0
  Dim var_2C As App
  loc_0041041E: var_30 = Me.hWnd
  loc_00410465: var_2C = Global.App
  loc_00410485: var_18 = Global.Path
  loc_004104D4: var_eax = ShellExecute(var_30, "Open", "http://www.mavness.com", vbNullString, var_18, 1)
  loc_0041050F: GoTo loc_0041053A
  loc_00410539: Exit Sub
  loc_0041053A: 'Referenced from: 0041050F
End Sub

Private Sub Label14_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single) '410560
  loc_004105C3: var_eax = Unknown_VTable_Call[ecx+0000006Ch]
  loc_004105EC: GoTo loc_004105F8
  loc_004105F7: Exit Sub
  loc_004105F8: 'Referenced from: 004105EC
End Sub

Private Sub Image3_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single) '40FF00
  Dim var_28 As Image
  loc_0040FF50: If eax <> 0 Then GoTo loc_0040FFF7
  loc_0040FF73: var_28 = Image1.Picture
  loc_0040FF95: var_38 = var_28._Default
  loc_0040FF9F: var_ret_1 = CLng(var_28)
  loc_0040FFC7: If esi+00000034h = 0 Then GoTo loc_0040FFF7
  loc_0040FFC9: var_eax = GetCursorPos()
  loc_0040FFD9: var_eax = CopyIcon(GetCursorPos())
  loc_0040FFEE: var_eax = SetSystemCursor(esi+00000034h, 32512)
  loc_0040FFF7: 'Referenced from: 0040FF50
  loc_00410012: Timer2.Enabled = True
  loc_0041003B: GoTo loc_0041005A
  loc_00410059: Exit Sub
  loc_0041005A: 'Referenced from: 0041003B
End Sub

Private Sub Image3_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) '410080
  loc_004100CA: If eax = 0 Then GoTo loc_004100E0
  loc_004100D5: var_eax = SetSystemCursor(Me.GetPalette, 32512)
  loc_004100E0: 'Referenced from: 004100CA
  loc_004100FD: Timer2.Enabled = edi
  loc_00410126: GoTo loc_00410132
  loc_00410131: Exit Sub
  loc_00410132: 'Referenced from: 00410126
End Sub

Private Sub Image2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single) '40FCA0
  Dim var_28 As Image
  loc_0040FCF0: If eax <> 0 Then GoTo loc_0040FD97
  loc_0040FD13: var_28 = Image1.Picture
  loc_0040FD35: var_38 = var_28._Default
  loc_0040FD3F: var_ret_1 = CLng(var_28)
  loc_0040FD67: If esi+00000034h = 0 Then GoTo loc_0040FD97
  loc_0040FD69: var_eax = GetCursorPos()
  loc_0040FD79: var_eax = CopyIcon(GetCursorPos())
  loc_0040FD8E: var_eax = SetSystemCursor(esi+00000034h, 32512)
  loc_0040FD97: 'Referenced from: 0040FCF0
  loc_0040FDB2: Timer1.Enabled = True
  loc_0040FDDB: GoTo loc_0040FDFA
  loc_0040FDF9: Exit Sub
  loc_0040FDFA: 'Referenced from: 0040FDDB
End Sub

Private Sub Image2_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) '40FE20
  loc_0040FE6A: If eax = 0 Then GoTo loc_0040FE80
  loc_0040FE75: var_eax = SetSystemCursor(Me.GetPalette, 32512)
  loc_0040FE80: 'Referenced from: 0040FE6A
  loc_0040FE9D: Timer1.Enabled = edi
  loc_0040FEC6: GoTo loc_0040FED2
  loc_0040FED1: Exit Sub
  loc_0040FED2: 'Referenced from: 0040FEC6
End Sub

Private Sub Label16_Click() '410620
  Dim var_2C As App
  loc_0041067E: var_30 = Me.hWnd
  loc_004106C5: var_2C = Global.App
  loc_004106E5: var_18 = Global.Path
  loc_00410734: var_eax = ShellExecute(var_30, "Open", "http://www.vbfx.com", vbNullString, var_18, 1)
  loc_0041076F: GoTo loc_0041079A
  loc_00410799: Exit Sub
  loc_0041079A: 'Referenced from: 0041076F
End Sub

Private Sub Label16_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single) '4107C0
  loc_00410823: var_eax = Unknown_VTable_Call[ecx+0000006Ch]
  loc_0041084C: GoTo loc_00410858
  loc_00410857: Exit Sub
  loc_00410858: 'Referenced from: 0041084C
End Sub

Private Sub Label19_Click() '410880
  Dim var_2C As App
  loc_004108DE: var_30 = Me.hWnd
  loc_00410925: var_2C = Global.App
  loc_00410945: var_18 = Global.Path
  loc_00410994: var_eax = ShellExecute(var_30, "Open", "http://www.patorjk.com", vbNullString, var_18, 1)
  loc_004109CF: GoTo loc_004109FA
  loc_004109F9: Exit Sub
  loc_004109FA: 'Referenced from: 004109CF
End Sub

Private Sub Label19_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single) '410A20
  loc_00410A83: var_eax = Unknown_VTable_Call[ecx+0000006Ch]
  loc_00410AAC: GoTo loc_00410AB8
  loc_00410AB7: Exit Sub
  loc_00410AB8: 'Referenced from: 00410AAC
End Sub

Private Sub Command7_Click() '40E970
  loc_0040EA0F: var_eax = Options.Show var_18
End Sub

Private Sub Command2_Click() '40E290
  Dim var_24 As TextBox
  Dim var_34 As TextBox
  Dim var_20 As TextBox
  loc_0040E2FA: var_34 = var_24
  loc_0040E313: var_18 = Text3.Text
  loc_0040E341: var_28 = CLng(Val(var_18))
  loc_0040E34D: var_eax = call Proc_3_3_414DC0(var_28, var_20, var_24)
  loc_0040E357: var_1C = call Proc_3_3_414DC0(var_28, var_20, var_24)
  loc_0040E364: Text3.Text = var_1C
  loc_0040E3B5: var_34 = var_20
  loc_0040E3D1: var_18 = Text3.Text
  loc_0040E402: var_28 = CLng(Val(var_18))
  loc_0040E40B: var_eax = call Proc_3_2_414BF0(var_28, var_20, Me)
  loc_0040E415: var_1C = call Proc_3_2_414BF0(var_28, var_20, Me)
  loc_0040E422: Text3.Text = var_1C
  loc_0040E48E: var_18 = Text3.Text
  loc_0040E4BD: var_eax = GetParent(CLng(Val(var_18)))
  loc_0040E4DC: var_1C = CStr(GetParent(CLng(Val(var_18))))
  loc_0040E4E4: Text3.Text = var_1C
  loc_0040E532: GoTo loc_0040E558
  loc_0040E557: Exit Sub
  loc_0040E558: 'Referenced from: 0040E532
End Sub

Private Sub Command3_Click() '40E580
  loc_0040E603: var_18 = Text3.Text
  loc_0040E654: var_eax = call Proc_3_8_415E30(var_20, FFFFFFFFh, CLng(Val(var_18)))
  loc_0040E682: GoTo loc_0040E6A5
  loc_0040E6A4: Exit Sub
  loc_0040E6A5: 'Referenced from: 0040E682
End Sub

Private Sub Command4_Click() '40E6D0
  loc_0040E76F: var_eax = APIcalls.Show var_18
End Sub

Private Sub Command5_Click() '40E7C0
  loc_0040E85F: var_eax = Basic.Show var_18
End Sub

Private Sub Command6_Click() '40E8B0
  loc_0040E910: Timer1.Enabled = True
  loc_0040E939: GoTo loc_0040E945
  loc_0040E944: Exit Sub
  loc_0040E945: 'Referenced from: 0040E939
End Sub

Private Sub Image1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single) '40F8B0
  Dim var_28 As Image
  loc_0040F900: If eax <> 0 Then GoTo loc_0040F9A7
  loc_0040F923: var_28 = Image1.Picture
  loc_0040F945: var_38 = var_28._Default
  loc_0040F94F: var_ret_1 = CLng(var_28)
  loc_0040F977: If esi+00000034h = 0 Then GoTo loc_0040F9A7
  loc_0040F979: var_eax = GetCursorPos()
  loc_0040F989: var_eax = CopyIcon(GetCursorPos())
  loc_0040F99E: var_eax = SetSystemCursor(esi+00000034h, 32512)
  loc_0040F9A7: 'Referenced from: 0040F900
  loc_0040F9AF: GoTo loc_0040F9CE
  loc_0040F9CD: Exit Sub
  loc_0040F9CE: 'Referenced from: 0040F9AF
End Sub

Private Sub Image1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) '40F9F0
  loc_0040FA49: If eax = 0 Then GoTo loc_0040FA7B
  loc_0040FA54: var_eax = SetSystemCursor(Me.GetPalette, 32512)
  loc_0040FA75: var_24 = SetSystemCursor(Me.GetPalette, 32512)
  loc_0040FA7B: 'Referenced from: 0040FA49
  loc_0040FAB3: var_eax = call Proc_3_8_415E30(var_28, var_40, var_44)
  loc_0040FAD3: GoTo loc_0040FAE9
  loc_0040FAE8: Exit Sub
  loc_0040FAE9: 'Referenced from: 0040FAD3
End Sub

Private Sub Frame4_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single) '40F030
  loc_0040F094: var_eax = Unknown_VTable_Call[ecx+0000006Ch]
  loc_0040F0CC: var_eax = Unknown_VTable_Call[ecx+0000006Ch]
  loc_0040F106: var_eax = Unknown_VTable_Call[ecx+0000006Ch]
  loc_0040F12F: GoTo loc_0040F13B
  loc_0040F13A: Exit Sub
  loc_0040F13B: 'Referenced from: 0040F12F
End Sub

Private Sub Timer3_Timer() '412510
  Dim var_9C As Variant
  Dim var_A0 As TextBox
  Dim var_A4 As PictureBox
  loc_00412575: On Error Resume Next
  loc_00412586: var_eax = GetCursorPos(var_40)
  loc_004125EE: var_ret_1 = CLng(var_3C)
  loc_004125F9: var_ret_2 = CLng(var_40)
  loc_00412600: var_eax = WindowFromPoint(var_ret_2, var_ret_1)
  loc_00412617: var_24 = WindowFromPoint(var_ret_2, var_ret_1)
  loc_00412625: var_eax = GetDC(var_24)
  loc_0041263C: var_28 = GetDC(var_24)
  loc_0041264E: var_eax = ScreenToClient(var_24, var_40)
  loc_0041266C: var_eax = GetPixel(var_28, var_40, var_3C)
  loc_00412683: var_64 = GetPixel(var_28, var_40, var_3C)
  loc_00412691: If var_64 <> -1 Then GoTo loc_004127EE
  loc_004126D4: var_98 = Picture1.hDC
  loc_004126DC: var_A0 = var_98
  loc_0041273B: var_eax = BitBlt(var_98, 0, 0, 1, 1, var_28, var_40, var_3C, var_00CC0020)
  loc_00412790: var_eax = Picture1.Point 0, 0
  loc_00412798: var_A0 = Picture1.Point 0, 0
  loc_004127DD: var_64 = var_98
  loc_004127E9: GoTo loc_0041287E
  loc_004127EE: 'Referenced from: 00412691
  loc_0041282E: var_eax = Picture1.PSet (0, 0), var_64
  loc_00412836: var_A0 = Picture1.PSet (0, 0), var_64
  loc_0041288D: var_eax = ReleaseDC(var_24, var_28)
  loc_004128B9: var_9C = var_70
  loc_004128D2: Picture1.BackColor = var_64
  loc_004128D7: var_A0 = var_9C
  loc_0041293D: var_9C = var_70
  loc_00412946: var_8C = var_64
  loc_0041298B: Text9.Text = CStr(Hex(var_64))
  loc_00412993: var_A0 = var_9C
  loc_00412A11: var_A0 = var_70
  loc_00412A28: var_6C = Main.ColorToHTML(var_64)
  loc_00412A2E: var_9C = var_6C
  loc_00412A7D: Text10.Text = var_6C
  loc_00412A85: var_A4 = var_A0
  loc_00412B33: var_98 = Picture1.BackColor
  loc_00412B38: var_A0 = var_98
  loc_00412B9C: Picture1.MousePointer = CStr(var_98)
  loc_00412BA4: var_A8 = var_A4
  loc_00412C20: var_9C = var_70
  loc_00412C39: var_6C = Text11.Text
  loc_00412C41: var_A0 = var_6C
  loc_00412C98: var_eax = call Proc_415C00(var_B4, CLng(Val(var_6C)), var_70)
  loc_00412CAA: call __vbaCopyBytes(0000000Ch, var_34, var_B4, var_B4, Me, var_74, Me, Me, var_70, var_B4, Me, var_70, Me, Me)
  loc_00412D0E: Text19.Text = CStr(var_34)
  loc_00412D16: var_A0 = var_9C
  loc_00412D88: var_9C = var_70
  loc_00412DB3: Text12.Text = CStr(var_30)
  loc_00412DBB: var_A0 = var_9C
  loc_00412E2D: var_9C = var_70
  loc_00412E58: Text13.Text = CStr(var_2C)
  loc_00412E60: var_A0 = var_9C
  loc_00412EBE: GoTo loc_00412EE9
  loc_00412EE8: Exit Sub
  loc_00412EE9: 'Referenced from: 00412EBE
End Sub

Private Sub Text14_KeyPress(KeyAscii As Integer) '410FE0
  loc_0041104E: On Error Resume Next
  loc_0041105B: If KeyAscii <> 13 Then GoTo loc_00411277
  loc_0041108D: If IsNumeric(Me) = 0 Then GoTo loc_00411277
  loc_004110B1: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_004110E9: var_20 = Text14.Text
  loc_0041111B: Text14.FontBold = CInt(Val(var_20))
  loc_00411159: GoTo loc_00411277
  loc_00411199: var_eax = Unknown_VTable_Call[eax+0000001Ch]
  loc_004111C9: var_eax = Unknown_VTable_Call[eax+0000002Ch]
  loc_00411217: var_3C = CStr(var_A8) & ", " & var_24
  loc_00411277: 'Referenced from: 0041105B
  loc_00411277: Exit Sub
  loc_00411283: GoTo loc_004112C9
  loc_004112C8: Exit Sub
  loc_004112C9: 'Referenced from: 00411283
End Sub

Private Sub Text15_KeyPress(KeyAscii As Integer) '4112F0
  loc_0041135E: On Error Resume Next
  loc_0041136B: If KeyAscii <> 13 Then GoTo loc_00411583
  loc_0041139D: If IsNumeric(Me) = 0 Then GoTo loc_00411583
  loc_004113C4: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_004113F8: var_20 = Text15.Text
  loc_0041142A: Text15.FontBold = CInt(Val(var_20))
  loc_00411468: GoTo loc_00411583
  loc_004114AA: var_eax = Unknown_VTable_Call[eax+0000001Ch]
  loc_004114D4: var_eax = Unknown_VTable_Call[eax+0000002Ch]
  loc_00411522: var_3C = CStr(var_A8) & ", " & var_24
  loc_00411583: 'Referenced from: 0041136B
  loc_00411583: Exit Sub
  loc_0041158F: GoTo loc_004115D5
  loc_004115D4: Exit Sub
  loc_004115D5: 'Referenced from: 0041158F
End Sub

Private Sub Text16_KeyPress(KeyAscii As Integer) '411600
  loc_0041166E: On Error Resume Next
  loc_0041167B: If KeyAscii <> 13 Then GoTo loc_00411898
  loc_004116AD: If IsNumeric(Me) = 0 Then GoTo loc_00411898
  loc_004116D2: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_0041170A: var_20 = Text16.Text
  loc_0041173C: Text16.FontBold = CInt(Val(var_20))
  loc_0041177A: GoTo loc_00411898
  loc_004117BA: var_eax = Unknown_VTable_Call[eax+0000001Ch]
  loc_004117EA: var_eax = Unknown_VTable_Call[eax+0000002Ch]
  loc_00411838: var_3C = CStr(var_A8) & ", " & var_24
  loc_00411898: 'Referenced from: 0041167B
  loc_00411898: Exit Sub
  loc_004118A4: GoTo loc_004118EA
  loc_004118E9: Exit Sub
  loc_004118EA: 'Referenced from: 004118A4
End Sub

Private Sub Text7_DblClick() '411910
  loc_004119BB: var_eax = Enlarge.Show var_24
  loc_00411A35: var_18 = Text7.Text
  loc_00411A56: Text7.Text = var_18
  loc_00411A98: GoTo loc_00411AB7
  loc_00411AB6: Exit Sub
  loc_00411AB7: 'Referenced from: 00411A98
End Sub

Private Sub Text1_DblClick() '410E10
  loc_00410EBB: var_eax = Enlarge.Show var_24
  loc_00410F35: var_18 = Text1.Text
  loc_00410F56: Text1.Text = var_18
  loc_00410F98: GoTo loc_00410FB7
  loc_00410FB6: Exit Sub
  loc_00410FB7: 'Referenced from: 00410F98
End Sub

Private Sub HScroll1_Change() '40F160
  Dim var_20 As Variant
  Dim var_8C As HScrollBar
  Dim var_84 As PictureBox
  Dim var_88 As PictureBox
  loc_0040F1F3: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_0040F21E: var_68 = HScroll1.Value
  loc_0040F261: var_eax = Unknown_VTable_Call[edx+00000040h]
  loc_0040F28F: var_6C = HScroll1.Value
  loc_0040F2C6: var_AC = var_34
  loc_0040F2E4: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_0040F308: var_70 = HScroll1.Value
  loc_0040F340: var_BC = var_68
  loc_0040F354: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_0040F3A6: var_8C = var_24
  loc_0040F3C4: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_0040F3E8: var_68 = HScroll1.Value
  loc_0040F41D: var_18 = CStr(var_68)
  loc_0040F42D: HScroll1.Max = var_18
  loc_0040F47E: var_8C = var_24
  loc_0040F49C: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_0040F4C0: var_68 = HScroll1.Value
  loc_0040F4F5: var_18 = CStr(var_68)
  loc_0040F505: HScroll1.Max = var_18
  loc_0040F556: var_8C = var_24
  loc_0040F574: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_0040F598: var_68 = HScroll1.Value
  loc_0040F5CD: var_18 = CStr(var_68)
  loc_0040F5DD: HScroll1.Max = var_18
  loc_0040F62E: var_84 = var_20
  loc_0040F64A: var_74 = Picture2.BackColor
  loc_0040F66D: var_3C = var_74
  loc_0040F68D: var_18 = CStr(Hex(var_74))
  loc_0040F69D: Picture2.MousePointer = var_18
  loc_0040F6F7: var_88 = var_44
  loc_0040F716: var_74 = Picture2.BackColor
  loc_0040F73F: var_18 = Main.ColorToHTML(var_74)
  loc_0040F768: Picture2.MousePointer = var_18
  loc_0040F7CD: var_74 = Picture2.BackColor
  loc_0040F7F6: var_18 = CStr(var_74)
  loc_0040F7FE: Picture2.MousePointer = var_18
  loc_0040F844: GoTo loc_0040F887
  loc_0040F886: Exit Sub
  loc_0040F887: 'Referenced from: 0040F844
End Sub

Private Sub Form_Load() '40EA60
  loc_0040EAB3: call __vbaCastObj(Me, var_00407424, __vbaCastObj, Me, ebx)
  loc_0040EAC6: var_eax = call Proc_3_0_414910(var_18, var_18, __vbaCastObj(Me, var_00407424, __vbaCastObj, Me, ebx))
  loc_0040EADA: call __vbaCastObj(Me, var_00407424)
  loc_0040EAE7: var_eax = call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424))
  loc_0040EB01: GoTo loc_0040EB0D
  loc_0040EB0C: Exit Sub
  loc_0040EB0D: 'Referenced from: 0040EB01
End Sub

Private Sub Form_Resize() '40EBE0
  loc_0040EC2C: var_18 = Me.WindowState
  loc_0040EC59: If var_18 <> 2 Then GoTo loc_0040EC72
  loc_0040EC5F: Me.WindowState = 0
  loc_0040EC69: If var_18 >= 0 Then GoTo loc_0040ECDE
  loc_0040EC70: GoTo loc_0040ECD5
  loc_0040EC72: 'Referenced from: 0040EC59
  loc_0040EC79: var_18 = Me.WindowState
  loc_0040EC98: If var_18 = 1 Then GoTo loc_0040ECDE
  loc_0040ECA2: Me.Width = var_45AD7000
  loc_0040ECC4: Me.Height = var_45870000
  loc_0040ECCE: If var_18 >= 0 Then GoTo loc_0040ECDE
  loc_0040ECD5: 'Referenced from: 0040EC70
  loc_0040ECDC: var_18 = CheckObj(Me, var_00406518, 140)
  loc_0040ECDE: 'Referenced from: 0040EC98
End Sub

Private Sub Form_Unload(Cancel As Integer) '40EDD0
  Dim var_40 As Timer
  loc_0040EE5A: var_40 = "                         Leaving already?"
  loc_0040EE98: If MsgBox(var_40, 4, var_50, var_60, var_70) <> 0 Then GoTo loc_0040EFC1
  loc_0040EEB8: Timer1.Enabled = ebx
  loc_0040EEF3: Timer2.Enabled = ebx
  loc_0040EF2D: End
  loc_0040EF36: var_eax = Unknown_VTable_Call[edx+000002B4h]
  loc_0040EF7F: Set var_30 = Me
  loc_0040EF8D: var_eax = Global.Unload var_30
  loc_0040EFB3: call __vbaVarSetObjAddref(var_24, ebx, Me, var_30, var_40, Me, var_30, var_40, Me, 0, Me, ebx)
  loc_0040EFB9: End
  loc_0040EFBF: GoTo loc_0040EFC9
  loc_0040EFC1: 'Referenced from: 0040EE98
  loc_0040EFC9: 'Referenced from: 0040EFBF
  loc_0040EFD1: GoTo loc_0040EFF8
  loc_0040EFF7: Exit Sub
  loc_0040EFF8: 'Referenced from: 0040EFD1
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single) '40EB30
  loc_0040EB7B: call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  loc_0040EB90: var_eax = call Proc_3_1_414B30(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  loc_0040EBA6: GoTo loc_0040EBB2
  loc_0040EBB1: Exit Sub
  loc_0040EBB2: 'Referenced from: 0040EBA6
End Sub

Private Sub Form_Terminate() '40ED00
  loc_0040ED6E: Set var_18 = Me
  loc_0040ED79: var_eax = Global.Unload var_18
  loc_0040EDA2: GoTo loc_0040EDAE
  loc_0040EDAD: Exit Sub
  loc_0040EDAE: 'Referenced from: 0040EDA2
End Sub

Public Function Check_Function() '40FB20
  loc_0040FB77: GetWindowPlacement(%x1 = Me.Caption, 5)
  loc_0040FB86: If esi <> 0 Then GoTo loc_0040FC40
  loc_0040FBAA: Text1.Text = vbNullString
  loc_0040FC01: var_40 = "Code cannot be created for this."
  loc_0040FC40: 'Referenced from: 0040FB86
  loc_0040FC45: GoTo loc_0040FC6C
  loc_0040FC6B: Exit Sub
  loc_0040FC6C: 'Referenced from: 0040FC45
End Function

Public Function ColorToHTML(clr) '412F20
  loc_00412F86: call __vbaCopyBytes(00000004h, var_20, var_20, edi, esi, ebx)
  loc_00412F99: var_3C = var_20
  loc_00412FC0: var_2C = Trim$(Hex$(var_20))
  loc_00412FD8: If Len(var_2C) <> 1 Then GoTo loc_00412FF0
  loc_00412FEE: var_2C = var_004078A8 & var_2C
  loc_00412FF0: 'Referenced from: 00412FD8
  loc_00412FF7: var_3C = var_1F
  loc_00413012: var_18 = Trim$(Hex$(var_1F))
  loc_0041302A: If Len(var_18) <> 1 Then GoTo loc_00413042
  loc_00413040: var_18 = var_004078A8 & var_18
  loc_00413042: 'Referenced from: 0041302A
  loc_00413049: var_3C = var_1E
  loc_00413064: var_28 = Trim$(Hex$(var_1E))
  loc_0041307C: If Len(var_28) <> 1 Then GoTo loc_00413098
  loc_00413094: var_28 = var_004078A8 & var_28
  loc_00413096: GoTo loc_0041309E
  loc_00413098: 'Referenced from: 0041307C
  loc_0041309E: 'Referenced from: 00413096
  loc_004130CA: var_1C = var_004078B0 & var_2C & var_18 & var_28
  loc_004130E4: GoTo loc_00413109
  loc_004130EA: If var_4 = 0 Then GoTo loc_004130F5
  loc_004130F5: 'Referenced from: 004130EA
  loc_00413108: Exit Sub
  loc_00413109: 'Referenced from: 004130E4
End Function
