  Const ChunkSize = 4096

  Sub ChangeFile (FName$, IdString$, NString$)
    GoTo hangman6

    CFileErr:
    MsgBox "An error has occured, cannot continue. /*CF error - Most likely incorrect AOL directory specified*/"
    Close
    Exit Sub

    hangman6:
    On Error GoTo CFileErr

    Dim PosString As Long, WhereString As Long
    Dim FileNumber As Long, A$, NewString$
    Dim AString As String * ChunkSize


    FileNumber = FreeFile
    PosString = 1
    WhereString = 0
    AString = Space$(ChunkSize)


    If Len(IdString$) > Len(NString$) Then
      NewString$ = NString$ + Space$(Len(IdString$) - Len(NString$))
    Else
      NewString$ = Left$(NString$, Len(IdString$))
    End If

    Open FName$ For Binary As FileNumber
    If LOF(FileNumber) < ChunkSize Then
      A$ = Space$(LOF(FileNumber))
      Get #FileNumber, 1, A$
      WhereString = InStr(1, AString, IdString$)

    Else
      Get #FileNumber, 1, AString
      WhereString = InStr(1, AString, IdString$)

    End If


    If WhereString <> 0 Then
      Put #FileNumber, WhereString, NewString$
    End If
    PosString = ChunkSize + PosString - Len(IdString$)


    Do Until EOF(FileNumber) Or PosString > LOF(FileNumber)
      If PosString + ChunkSize > LOF(FileNumber) Then
        A$ = Space$(LOF(FileNumber) - PosString)
        Get #FileNumber, PosString, A$
        WhereString = InStr(1, AString, IdString$)
      Else
        Get #FileNumber, PosString, AString
        WhereString = InStr(1, AString, IdString$)
      End If
      If WhereString <> 0 Then
        Put #FileNumber, PosString + WhereString - 1, NewString$
      End If
      PosString = ChunkSize + PosString - Len(IdString$)

    Loop
    Close



  End Sub

