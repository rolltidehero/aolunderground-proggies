# C2 — In-Process Command & Control for VB Decompiler under Wine

DLL injection-based C2 agent for automating VB Decompiler Pro v9.8 running under Wine 9.0.

## Why

Wine does not marshal `WM_SETTEXT` string pointers across process boundaries. Any cross-process attempt to set text in an Edit control silently fails. The only workaround is to run inside the target process via DLL injection.

## Components

- `c2dll.c` — C2 DLL that gets injected into VB Decompiler. Spawns a background thread that polls `C:\c2_cmd.txt` for commands, executes Win32 API calls in-process, writes results to `C:\c2_res.txt`.
- `inject.c` — Injector that finds VB Decompiler by process name and injects `c2dll.dll` via `CreateRemoteThread` + `LoadLibraryA`.
- `c2` — Bash wrapper for sending commands from Linux.

## Build

```bash
i686-w64-mingw32-gcc -shared -O2 -o c2dll.dll c2dll.c -luser32 -lgdi32
i686-w64-mingw32-gcc -O2 -o inject.exe inject.c -luser32
```

## Usage

```bash
# 1. VB Decompiler must be running
# 2. Deploy and inject
sudo cp c2dll.dll inject.exe /home/wineuser/.wine/drive_c/
sudo chown wineuser:nonet /home/wineuser/.wine/drive_c/{c2dll.dll,inject.exe}
nohup sudo -u wineuser DISPLAY=:99 wine "C:\inject.exe" < /dev/null > /tmp/inject.log 2>&1 &
sleep 5; sudo cat /home/wineuser/.wine/drive_c/c2_res.txt
# Should show: C2 INJECTED pid=...

# 3. Send commands
sudo python3 -c "
with open('/home/wineuser/.wine/drive_c/c2_cmd.txt','w') as f:
    f.write('PING\n')
import os; os.chown('/home/wineuser/.wine/drive_c/c2_cmd.txt', 994, 1005)"
sleep 1; sudo cat /home/wineuser/.wine/drive_c/c2_res.txt
```

## Commands

| Command | Args | Description |
|---------|------|-------------|
| PING | | Returns PONG with PID |
| FINDWINDOW | class title | FindWindowA (* = NULL) |
| FINDWINDOWEX | parent after class title | FindWindowExA (* = NULL) |
| GETTEXT | hwnd | GetWindowTextW (UTF-8) |
| GETCLASS | hwnd | GetClassNameW (UTF-8) |
| SETTEXT | hwnd text | SendMessageW WM_SETTEXT (in-process!) |
| SENDMSG | hwnd msg wp lp | SendMessageA |
| POSTMSG | hwnd msg wp lp | PostMessageA |
| GETDLGITEM | hwnd id | GetDlgItem |
| CLICK | hwnd | PostMessage BM_CLICK |
| LCLICK | hwnd | PostMessage WM_LBUTTONDOWN+UP |
| ENUMCHILDREN | hwnd | EnumChildWindows |
| WMCOMMAND | hwnd id | PostMessage WM_COMMAND |
| SLEEP | ms | Sleep |
| EXIT | | Terminate C2 thread |
