VERSION 5.00
Begin VB.Form ipchat
  Caption = "bodini ip chatroom settings"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 1 'Fixed Single
  Icon = "ipchat.frx":0
  LinkTopic = "Form1"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 3795
  ClientTop = 3840
  ClientWidth = 3795
  ClientHeight = 1605
  Begin CommandButton Command2
    Caption = "Listen"
    Left = 2040
    Top = 1200
    Width = 1575
    Height = 255
    TabIndex = 21
    BeginProperty Font
      Name = "Verdana"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Listen for incoming connections"
  End
  Begin CommandButton Command1
    Caption = "Connect"
    Left = 240
    Top = 1200
    Width = 1575
    Height = 255
    TabIndex = 20
    BeginProperty Font
      Name = "Verdana"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Connect to a remote computer"
  End
  Begin TextBox txtIP
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 120
    Width = 1575
    Height = 285
    TabIndex = 15
    MaxLength = 15
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Remote Computer's IP Address"
  End
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 480
    Width = 1575
    Height = 285
    Text = "spek"
    TabIndex = 13
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin CommandButton cmdSend
    Caption = "&Send"
    Left = 3840
    Top = 2400
    Width = 975
    Height = 375
    Enabled = 0   'False
    TabIndex = 3
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Send Information"
  End
  Begin TextBox txtSend
    Left = 840
    Top = 2400
    Width = 2895
    Height = 285
    Enabled = 0   'False
    TabIndex = 4
    MaxLength = 1024
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Information to Send"
  End
  Begin Timer Timer1
    Interval = 100
    Left = 6720
    Top = 1560
  End
  Begin CommandButton cmdConnect
    Caption = "Connect"
    Left = 240
    Top = 2880
    Width = 1575
    Height = 255
    TabIndex = 2
    BeginProperty Font
      Name = "Verdana"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Connect to a remote computer"
  End
  Begin CommandButton cmdListen
    Caption = "Listen"
    Left = 2040
    Top = 2880
    Width = 1575
    Height = 255
    TabIndex = 1
    BeginProperty Font
      Name = "Verdana"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Listen for incoming connections"
  End
  Begin Frame Frame2
    Caption = "Remote Information:"
    Left = 5760
    Top = 3000
    Width = 3615
    Height = 1455
    TabIndex = 7
  End
  Begin Frame Frame1
    Caption = "Local Information:"
    Left = 5280
    Top = 360
    Width = 3615
    Height = 975
    TabIndex = 0
    Begin Label ListenStatus
      Caption = "..."
      Left = 2760
      Top = 360
      Width = 1215
      Height = 255
      TabIndex = 10
      Alignment = 1 'Right Justify
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
    Begin Label lab
      Caption = "Winsock Listening Status:"
      Index = 1
      Left = 0
      Top = 600
      Width = 1935
      Height = 255
      TabIndex = 9
      BackStyle = 0 'Transparent
      BeginProperty Font
        Name = "Arial"
        Size = 8.25
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
      ToolTipText = "The Listening Control's Status"
    End
    Begin Label Label1
      Caption = "Port: 554"
      Left = 2760
      Top = 360
      Width = 735
      Height = 255
      TabIndex = 8
      Alignment = 1 'Right Justify
      BeginProperty Font
        Name = "Arial"
        Size = 8.25
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
      ToolTipText = "Port: 554 -> cuz I wanted it that way!"
    End
    Begin Label labLocalIP
      Caption = "..."
      Left = 600
      Top = 360
      Width = 1695
      Height = 255
      TabIndex = 6
      Alignment = 1 'Right Justify
      BeginProperty Font
        Name = "Arial"
        Size = 8.25
        Charset = 0
        Weight = 400
        Underline = 0 'False
        Italic = 0 'False
        Strikethrough = 0 'False
      EndProperty
      ToolTipText = "Your computer's IP Address... click to Copy to Clipboard"
    End
    Begin Label lab
      Caption = "IP:"
      Index = 0
      Left = 240
      Top = 360
      Width = 255
      Height = 255
      TabIndex = 5
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
  Begin Winsock sckListen
  End
  Begin Winsock sckSend
  End
  Begin Label SendStatus
    Caption = "..."
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 2400
    Top = 840
    Width = 1215
    Height = 255
    TabIndex = 19
    Alignment = 1 'Right Justify
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
  Begin Label lab
    Caption = "Winsock Connecting Status:"
    Index = 2
    ForeColor = &HFFFFFF&
    Left = 240
    Top = 840
    Width = 2175
    Height = 255
    TabIndex = 18
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "The Connecting Control's Status"
  End
  Begin Label Label2
    Caption = "Port: 554"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 2880
    Top = 120
    Width = 735
    Height = 255
    Visible = 0   'False
    TabIndex = 17
    Alignment = 1 'Right Justify
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Port: 554 -> cuz I wanted it that way!"
  End
  Begin Label Label3
    Caption = "Handle:"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 240
    Top = 480
    Width = 855
    Height = 255
    TabIndex = 16
  End
  Begin Label lab
    Caption = "Remote IP:"
    Index = 3
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 240
    Top = 120
    Width = 855
    Height = 255
    TabIndex = 14
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
  Begin Label labMsg
    Caption = "[ no messages to display ]"
    Left = 600
    Top = 1800
    Width = 4695
    Height = 735
    TabIndex = 12
    Alignment = 2 'Center
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
    ToolTipText = "Last recieved message"
  End
  Begin Label lab
    Caption = "Send:"
    Index = 4
    Left = 240
    Top = 2400
    Width = 495
    Height = 255
    TabIndex = 11
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

Attribute VB_Name = "ipchat"

