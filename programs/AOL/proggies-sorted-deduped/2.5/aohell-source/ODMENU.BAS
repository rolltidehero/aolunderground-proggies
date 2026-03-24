Declare Function GetMenu Lib "User" (ByVal hWnd As Integer) As Integer
Declare Function GetSubMenu Lib "User" (ByVal hMenu As Integer, ByVal nPos As Integer) As Integer
Declare Function ModifyMenu Lib "User" (ByVal hMenu As Integer, ByVal nPosition As Integer, ByVal wFlags As Integer, ByVal wIDNewItem As Integer, ByVal lpString As Any) As Integer
Declare Function GetMenuItemID Lib "User" (ByVal hMenu As Integer, ByVal nPos As Integer) As Integer
Declare Function AppendMenu Lib "User" (ByVal hMenu As Integer, ByVal wFlags As Integer, ByVal wIDNewItem As Integer, ByVal lpNewItem As Any) As Integer
Declare Function RemoveMenu Lib "User" (ByVal hMenu As Integer, ByVal nPosition As Integer, ByVal wFlags As Integer) As Integer
Declare Function CreateMenu Lib "User" () As Integer
Declare Sub DrawMenuBar Lib "User" (ByVal hWnd As Integer)
Global Const MF_SEPARATOR = &H800
Global Const MF_POPUP = &H10
Global Const MF_BYCOMMAND = &H0
Global Const MF_BYPOSITION = &H400
Global DidMen As Integer
Global IsDil As Integer

