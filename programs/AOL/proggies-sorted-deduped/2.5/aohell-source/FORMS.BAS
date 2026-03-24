'****************************************************
'* FORMS.BAS Version 2.1 Date: 06/01/95             *
'* VB Tips & Tricks                                 *
'* 8430-D Summerdale Road San Diego CA 92126-5415   *
'* Compuserve: 74227,1557                           *
'* America On-Line: DPMCS                           *
'* InterNet: DPMCS@AOL.COM                          *
'*==================================================*
'*This module contains common functions for use with*
'*forms.                                            *
'****************************************************
Option Explicit

'Declare Sub SetWindowPos Lib "User" (ByVal hWnd As Integer, ByVal hWndInsertAfter As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal wFlags As Integer)

Const SWP_NOMOVE = 2
Const SWP_NOSIZE = 1
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

'*******************************************************
'* Procedure Name: CenterChild                         *
'*-----------------------------------------------------*
'* Created: 2/10/94   By: VB Programmers Journal       *
'* Modified: 3/24/94  By: D. McCarter                  *
'* Modified: 5/20/95  By: K. Primeaux                  *
'*=====================================================*
'* Centers a child form within a parent form. To use,  *
'* call the sub and pass it the parent form name       *
'* and the child form name [CenterChild form1 form2].  *
'* Centers your About dialog boxes nicely.             *
'*******************************************************
Sub CenterChild (Parent As Form, Child As Form)
Dim iTop As Integer, iLeft As Integer

If Parent.WindowState <> 0 Then Exit Sub

iTop = ((Parent.Height - Child.Height) \ 2) + Parent.Top
iLeft = ((Parent.Width - Child.Width) \ 2) + Parent.Left

Child.Move iLeft, iTop

End Sub

'*******************************************************
'* Procedure Name: CenterForm                          *
'*-----------------------------------------------------*
'* Created: 2/10/94   By: VB Programmers Journal       *
'* Modified: 4/24/94  By: David McCarter               *
'*=====================================================*
'*This code will center a form in the center of the    *
'*screen. To use it, just call the sub and pass it the *
'*form name [Call CenterForm main]                     *
'*******************************************************
Sub CenterForm (frmIn As Form)
Dim iTop As Integer, iLeft As Integer

    If frmIn.WindowState <> 0 Then Exit Sub

    iTop = (Screen.Height - frmIn.Height) \ 2
    iLeft = (Screen.Width - frmIn.Width) \ 2

    frmIn.Move iLeft, iTop

End Sub

'*******************************************************
'* Procedure Name: CenterMDIChild                      *
'*-----------------------------------------------------*
'* Created: 2/10/94   By: VB Programmers Journal       *
'* Modified: 3/24/94  By: D. McCarter                  *
'*=====================================================*
'* Centers a child form within a parent MDI form. To   *
'* use, call the sub and pass it the parent form name  *
'* and the child form name [CenterMDIChild form1 form2]*
'*******************************************************
Sub CenterMDIChild (frmParent As Form, frmChild As Form)
Dim iTop As Integer, iLeft As Integer

    If frmParent.WindowState <> 0 Or frmChild.WindowState <> 0 Then Exit Sub

    iTop = (frmParent.ScaleHeight - frmChild.Height) \ 2
    iLeft = (frmParent.ScaleWidth - frmChild.Width) \ 2

    frmChild.Move iLeft, iTop

End Sub

'*******************************************************
'* Procedure Name: FormWaid                            *
'*-----------------------------------------------------*
'* Created: 08/01/95  By: Barth Riely                  *
'* Modified:          By:                              *
'*=====================================================*
'* Waits for a form to become inactive.                *
'*******************************************************
Sub FormWait (frmIn As Form)

     Do While frmIn Is Screen.ActiveForm
        DoEvents
     Loop
             
End Sub

'*******************************************************
'* Procedure Name: KeepOnTop                           *
'*-----------------------------------------------------*
'* Created: 4/18/94   By: KeepOnTop                    *
'* Modified:          By:                              *
'*=====================================================*
'*Keep form on top. Note that this is switched off if  *
'*form is minimised, so place in resize event as well. *
'*******************************************************
Sub KeepOnTop (frmIn As Form)
'Keep form on top. Note that this is switched off if form is
'minimised, so place in resize event as well.
Const wFlags = SWP_NOMOVE Or SWP_NOSIZE

   ' SetWindowPos frmIn.hWnd, HWND_TOPMOST, 0, 0, 0, 0, wFlags    'Window will stay on top

    DoEvents

End Sub

'*******************************************************
'* Procedure Name: PaintBackGround                     *
'*-----------------------------------------------------*
'* Created:           By: KARL M. GARAND               *
'* Modified: 3/01/95  By: David McCarter               *
'*=====================================================*
'*This code paint the backgound of a form from black   *
'*to blue.                                             *
'*******************************************************
Sub PaintBackGround (frmIn As Form)
Dim I As Integer
Dim Y As Integer

    frmIn.AutoRedraw = True
    frmIn.DrawStyle = 6
    frmIn.DrawMode = 13
    frmIn.DrawWidth = 2
    frmIn.ScaleMode = 3
    frmIn.ScaleHeight = (256 * 2)
    For I = 0 To 255
        frmIn.Line (0, Y)-(frmIn.Width, Y + 2), RGB(0, 0, I), BF
        Y = Y + 2
    Next I

End Sub

'*******************************************************
'* Procedure Name: RemoveOnTop                         *
'*-----------------------------------------------------*
'* Created: 4/18/94   By:                              *
'* Modified:          By:                              *
'*=====================================================*
'*Removes the form from being on top.                  *
'*******************************************************
Sub RemoveOnTop (frmIn As Form)
Const wFlags = SWP_NOMOVE Or SWP_NOSIZE

 '   SetWindowPos frmIn.hWnd, HWND_NOTOPMOST, 0, 0, 0, 0, wFlags

    DoEvents

End Sub

