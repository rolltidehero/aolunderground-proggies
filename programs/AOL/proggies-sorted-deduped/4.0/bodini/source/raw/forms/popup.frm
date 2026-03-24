VERSION 5.00
Begin VB.Form popup
  Caption = "bodini pop up menus"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 1 'Fixed Single
  Icon = "popup.frx":0
  LinkTopic = "Form1"
  MaxButton = 0   'False
  ClientLeft = 150
  ClientTop = 435
  ClientWidth = 4560
  ClientHeight = 1425
  StartUpPosition = 2 'CenterScreen
  Begin Menu Main
    Caption = "Main"
    Begin Menu mnuExit
      Caption = "Exit"
    End
    Begin Menu mnuAbout
      Caption = "About"
    End
    Begin Menu mnuClearHistory
      Caption = "Clear History"
    End
    Begin Menu mnuCredits
      Caption = "Credits"
    End
    Begin Menu mnuDisclaimer
      Caption = "Disclaimer"
    End
    Begin Menu mnuGreets
      Caption = "Greets"
    End
    Begin Menu mnuIMOn
      Caption = "IM On"
    End
    Begin Menu mnuIMOff
      Caption = "IM Off"
    End
    Begin Menu mnuMinimize
      Caption = "Minimize"
    End
    Begin Menu mnuSecretArea
      Caption = "Secret Area"
    End
    Begin Menu mnuSignOff
      Caption = "Sign Off"
    End
    Begin Menu mnuUpchat
      Caption = "Upchat"
    End
    Begin Menu mnuUnUpchat
      Caption = "UnUpchat"
    End
  End
  Begin Menu Chat
    Caption = "Chat"
    Begin Menu mnueightballbot
      Caption = "8-Ball Bot"
    End
    Begin Menu mnuAFKBot
      Caption = "AFK Bot"
    End
    Begin Menu mnuAttention
      Caption = "Attention"
    End
    Begin Menu mnuChatFader
      Caption = "Chat Fader"
    End
    Begin Menu mnuChatLinkSender
      Caption = "Chat Link Sender"
    End
    Begin Menu mnuChatManipulator
      Caption = "Chat Manipulator"
    End
    Begin Menu mnuClearChat
      Caption = "Clear Chat"
    End
    Begin Menu mnuCloseChat
      Caption = "Close Chat"
    End
    Begin Menu mnuEchoBot
      Caption = "Echo Bot"
    End
    Begin Menu mnuIdleBot
      Caption = "Idle Bot"
    End
    Begin Menu mnuMultitaskChat
      Caption = "Multitask Chat"
    End
    Begin Menu mnuProfiler
      Caption = "Profiler"
    End
    Begin Menu mnuRequestBot
      Caption = "Request Bot"
    End
    Begin Menu mnuRoomBuster
      Caption = "Room Buster"
    End
    Begin Menu mnuScramblerBot
      Caption = "Scrambler Bot"
    End
    Begin Menu mnuServerHelper
      Caption = "Server Helper"
    End
    Begin Menu mnuSupBot
      Caption = "Sup Bot"
    End
    Begin Menu mnuVoterBot
      Caption = "Voter Bot"
    End
  End
  Begin Menu Mail
    Caption = "Mail"
    Begin Menu mnuCountNew
      Caption = "Count New"
    End
    Begin Menu mnuJunoMailBomb
      Caption = "Juno Mail Bomb"
    End
    Begin Menu mnuMailBomb
      Caption = "Mail Bomb"
    End
    Begin Menu mnuMailSpammer
      Caption = "Mail Spammer"
    End
    Begin Menu mnuMailMe
      Caption = "Mail Me"
    End
    Begin Menu mnuMassMailer
      Caption = "Mass Mailer"
    End
    Begin Menu mnuSendMail
      Caption = "Send Mail"
    End
    Begin Menu mnuServer
      Caption = "Server"
    End
  End
  Begin Menu IM
    Caption = "IM"
    Begin Menu mnuIMAnswer
      Caption = "IM Answer"
    End
    Begin Menu mnuIMBomb
      Caption = "IM Bomb"
    End
    Begin Menu mnuIMChatroom
      Caption = "IM Chatroom"
    End
    Begin Menu mnuIMFader
      Caption = "IM Fader"
    End
    Begin Menu mnuIMLinkSender
      Caption = "IM Link Sender"
    End
    Begin Menu mnuIMManager
      Caption = "IM Manager"
    End
    Begin Menu mnuIMManipulator
      Caption = "IM Manipulator"
    End
    Begin Menu mnuIMOn2
      Caption = "IM On"
    End
    Begin Menu mnuIMOff2
      Caption = "IM Off"
    End
    Begin Menu mnuMassIM
      Caption = "Mass IM"
    End
    Begin Menu mnuPhisher
      Caption = "Phisher"
    End
    Begin Menu mnuQuadIM
      Caption = "Quad IM"
    End
    Begin Menu mnuSendIM
      Caption = "Send IM"
    End
  End
  Begin Menu Other
    Caption = "Other"
    Begin Menu kills
      Caption = "Kills"
      Begin Menu mnuHideAOL
        Caption = "Hide AOL"
      End
      Begin Menu mnuKillAOL
        Caption = "Kill AOL"
      End
      Begin Menu mnuKillGlyph
        Caption = "Kill Glyph"
      End
      Begin Menu mnuKillModal
        Caption = "Kill Modal"
      End
      Begin Menu mnuKillWait
        Caption = "Kill Wait"
      End
      Begin Menu mnuKillWelcome
        Caption = "Kill Welcome"
      End
      Begin Menu mnuShowAOL
        Caption = "Show AOL"
      End
      Begin Menu mnuShowWelcome
        Caption = "Show Welcome"
      End
    End
    Begin Menu mnu45MinuteKiller
      Caption = "45 Minute Killer"
    End
    Begin Menu mnuADriveBomber
      Caption = "A Drive Bomber"
    End
    Begin Menu mnuBPad
      Caption = "B-Pad"
    End
    Begin Menu mnuCalculator
      Caption = "Calculator"
    End
    Begin Menu mnuChangeAOLCaption
      Caption = "Change AOL Caption"
    End
    Begin Menu mnuClock
      Caption = "Clock"
    End
    Begin Menu mnuDecompilerShield
      Caption = "Decompiler Shield"
    End
    Begin Menu mnuDeltreeScanner
      Caption = "Deltree Scanner"
    End
    Begin Menu mnuEncrypter
      Caption = "Encrypter"
    End
    Begin Menu mnuFindHexID
      Caption = "Find Hex ID"
    End
    Begin Menu mnuHelp
      Caption = "Help"
    End
    Begin Menu mnuHTMLFader
      Caption = "HTML Fader"
    End
    Begin Menu mnuIconExtractor
      Caption = "Icon Extactor"
    End
    Begin Menu mnuIPChatroom
      Caption = "IP Chatroom"
    End
    Begin Menu mnuKeyword
      Caption = "Keyword"
    End
    Begin Menu mnuMediaPlayer
      Caption = "Media Player"
    End
    Begin Menu mnuMyWebSite
      Caption = "My Web Site"
    End
    Begin Menu mnuPasswordCracker
      Caption = "Password Cracker"
    End
    Begin Menu mnuPWSD
      Caption = "PWSD"
    End
    Begin Menu mnuSNRevealer
      Caption = "SN Revealer"
    End
    Begin Menu mnuVerifyMe
      Caption = "Verify Me"
    End
    Begin Menu OtherWindowsCAD
      Caption = "Windows CAD"
      Begin Menu mnuEnableCAD
        Caption = "Enable CAD"
      End
      Begin Menu mnuDisableCAD
        Caption = "Disable CAD"
      End
    End
  End
End

Attribute VB_Name = "popup"

