Declare Function GetWindowsDirectory Lib "Kernel" (ByVal WD As String, ByVal nWSize As Integer) As Integer
Declare Function GetSystemDirectory Lib "Kernel" (ByVal WSD As String, ByVal nSSize As Integer) As Integer
Declare Function GetPrivateProfileString Lib "Kernel" (ByVal lpApplication As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal FileStr As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer

