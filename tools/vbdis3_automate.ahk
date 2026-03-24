; VBDIS3 automation script — handles dialogs during command-line decompilation
; Dialog sequence (from source analysis):
;   1. frm_CtrlNames (modal) — 0+ times per form with missing FrmRes2. Dismiss with Escape.
;   2. "Project created" MsgBox (vbYesNoCancel) — click Cancel to quit.

SetTitleMatchMode, 2

Loop {
    ; Check if VBDIS3 is still running
    Process, Exist, VBDIS3.exe
    if (ErrorLevel = 0)
        break

    ; Dismiss frm_CtrlNames dialog (title contains "Wups someone deleted Control names")
    IfWinExist, deleted Control names
    {
        WinActivate
        Send {Escape}
        Sleep 200
        continue
    }

    ; Dismiss "Project created" MsgBox — Cancel button to quit
    IfWinExist, Project created
    {
        WinActivate
        Send {Escape}
        Sleep 200
        continue
    }

    Sleep 500
}
