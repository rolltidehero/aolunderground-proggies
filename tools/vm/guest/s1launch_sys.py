"""Launch a process as SYSTEM in session 1 (interactive desktop).
Run via QGA (which runs as SYSTEM with SeTcbPrivilege)."""
import ctypes, ctypes.wintypes, sys, os

advapi32 = ctypes.windll.advapi32
kernel32 = ctypes.windll.kernel32

TOKEN_ALL_ACCESS = 0xF01FF
SecurityImpersonation = 2
TokenPrimary = 1
TokenSessionId = 12
CREATE_NEW_CONSOLE = 0x10
STARTF_USESHOWWINDOW = 1
SW_SHOW = 5

class STARTUPINFO(ctypes.Structure):
    _fields_ = [("cb", ctypes.wintypes.DWORD), ("lpReserved", ctypes.c_wchar_p),
                ("lpDesktop", ctypes.c_wchar_p), ("lpTitle", ctypes.c_wchar_p),
                ("dwX", ctypes.wintypes.DWORD), ("dwY", ctypes.wintypes.DWORD),
                ("dwXSize", ctypes.wintypes.DWORD), ("dwYSize", ctypes.wintypes.DWORD),
                ("dwXCountChars", ctypes.wintypes.DWORD), ("dwYCountChars", ctypes.wintypes.DWORD),
                ("dwFillAttribute", ctypes.wintypes.DWORD), ("dwFlags", ctypes.wintypes.DWORD),
                ("wShowWindow", ctypes.wintypes.WORD), ("cbReserved2", ctypes.wintypes.WORD),
                ("lpReserved2", ctypes.c_void_p), ("hStdInput", ctypes.c_void_p),
                ("hStdOutput", ctypes.c_void_p), ("hStdError", ctypes.c_void_p)]

class PROCESS_INFORMATION(ctypes.Structure):
    _fields_ = [("hProcess", ctypes.c_void_p), ("hThread", ctypes.c_void_p),
                ("dwProcessId", ctypes.wintypes.DWORD), ("dwThreadId", ctypes.wintypes.DWORD)]

def main():
    cmdline = sys.argv[1]
    # Get current process token (SYSTEM)
    tok = ctypes.c_void_p()
    r = ctypes.windll.kernel32.OpenProcessToken(
        ctypes.windll.kernel32.GetCurrentProcess(), TOKEN_ALL_ACCESS, ctypes.byref(tok))
    print(f"TCB: err={ctypes.GetLastError()}")
    # Duplicate as primary token
    newtok = ctypes.c_void_p()
    r = advapi32.DuplicateTokenEx(tok, TOKEN_ALL_ACCESS, None,
        SecurityImpersonation, TokenPrimary, ctypes.byref(newtok))
    print(f"Dup: ok={r} err={ctypes.GetLastError()}")
    # Set session ID to 1
    sid = ctypes.wintypes.DWORD(1)
    r = advapi32.SetTokenInformation(newtok, TokenSessionId, ctypes.byref(sid), 4)
    print(f"SetSess: ok={r} err={ctypes.GetLastError()}")
    # Create process
    si = STARTUPINFO()
    si.cb = ctypes.sizeof(si)
    si.lpDesktop = "WinSta0\\Default"
    si.dwFlags = STARTF_USESHOWWINDOW
    si.wShowWindow = SW_SHOW
    pi = PROCESS_INFORMATION()
    r = advapi32.CreateProcessAsUserW(newtok, None, cmdline,
        None, None, False, CREATE_NEW_CONSOLE, None, None, ctypes.byref(si), ctypes.byref(pi))
    print(f"Create: ok={r} pid={pi.dwProcessId} err={ctypes.GetLastError()}")

if __name__ == '__main__':
    main()
