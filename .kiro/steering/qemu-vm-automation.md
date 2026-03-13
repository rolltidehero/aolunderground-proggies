---
inclusion: always
description: QEMU/KVM Windows VM automation rules. Covers QMP input limitations, guest agent usage, driver signing, silent installs, and file sharing. Prevents blind guessing at UI automation.
---

# QEMU/KVM Windows VM Automation — Mandatory Rules

## ARCHITECTURE OVERVIEW

```
Host (Linux)                          Guest (Windows 10 x86)
  |                                      |
  |-- QMP socket (/tmp/vm-qmp.sock) ---->| QEMU virtual hardware
  |   (screendump, power, input events)  | (keyboard, mouse, display)
  |                                      |
  |-- QGA socket (/tmp/vm-qga.sock) ---->| QEMU Guest Agent service
  |   (guest-exec, file ops, shutdown)   | (runs as SYSTEM, no GUI)
  |                                      |
  |-- C2 socket (/tmp/vm-c2.sock) ------>| Custom agent (agent.py)
  |   (app-level commands, decompile)    | (runs as user, has GUI access)
  |                                      |
  |-- USB share disk (share.img) ------->| D:\ drive (FAT32)
  |   (file transfer, offline only)      | (read/write from guest)
```

## QMP INPUT EVENTS — LIMITATIONS (CRITICAL)

QMP `input-send-event` injects keyboard/mouse at the **virtual hardware level**
(emulated PS/2 or USB HID). This means:

1. **Events go to whatever window has focus on the active desktop.** There is
   no way to target a specific window — it's like physically pressing keys.

2. **Elevated/system dialogs MAY NOT receive QMP input.** Windows Security
   dialogs (driver signing, UAC consent on secure desktop) run at a higher
   integrity level or on a separate desktop. QMP input events are delivered
   to the default desktop and may not reach these dialogs.

3. **Mouse coordinates are absolute (0-32767 range)** mapped to screen
   resolution. The `usb-tablet` device is REQUIRED for absolute positioning.
   Without it, mouse is relative and unusable for automation.

4. **There is no way to read screen content via QMP** other than `screendump`
   (PPM image). No OCR, no window enumeration, no text extraction.

### RULES FOR QMP INPUT

- **NEVER rely on QMP input to dismiss system-level dialogs** (driver signing,
  Windows Security, UAC secure desktop). These MUST be prevented from
  appearing in the first place.
- **NEVER chain Tab/Enter blindly** hoping to hit the right button. If you
  can't see what has focus, you'll activate the wrong thing (e.g., open Edge
  from the taskbar).
- **ALWAYS take a screenshot after every QMP input action** to verify the
  result before proceeding.
- **ALWAYS verify focus** — if a dialog appears over PowerShell, QMP keyboard
  input may go to the dialog OR to PowerShell depending on which has focus.
  Screenshot first, then decide.
- **Use QMP input ONLY for**: opening Run dialog (Win+R), typing commands into
  a known-focused PowerShell/cmd window, basic navigation when no elevated
  dialogs are expected.

## QEMU GUEST AGENT (qemu-ga) — THE RIGHT WAY TO RUN COMMANDS

The QEMU Guest Agent runs as a Windows service inside the guest and accepts
JSON commands over a virtio-serial channel. It can execute arbitrary commands
as SYSTEM — no GUI interaction needed.

### Setup

**Host side** — add a SEPARATE virtio-serial channel for qemu-ga:
```
-chardev socket,path=/tmp/vm-qga.sock,server=on,wait=off,id=qga0
-device virtio-serial-pci
-device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
```

**Guest side** — the QEMU Guest Agent is bundled in `virtio-win-gt-x86.msi`.
After installing the MSI, the `QEMU-GA` service starts automatically and
listens on the `org.qemu.guest_agent.0` virtio-serial port.

### Running commands from host

```bash
# Ping the agent
echo '{"execute":"guest-ping"}' | socat - UNIX-CONNECT:/tmp/vm-qga.sock

# Execute a command (runs as SYSTEM, no GUI)
echo '{"execute":"guest-exec","arguments":{"path":"powershell.exe","arg":["-Command","Get-Volume"],"capture-output":true}}' | socat - UNIX-CONNECT:/tmp/vm-qga.sock

# Check command result (use PID from guest-exec response)
echo '{"execute":"guest-exec-status","arguments":{"pid":1234}}' | socat - UNIX-CONNECT:/tmp/vm-qga.sock
```

### CRITICAL: guest-exec runs as SYSTEM on session 0

- Commands run via `guest-exec` execute as `NT AUTHORITY\SYSTEM` in session 0
- They have FULL admin privileges — no UAC, no elevation needed
- They CANNOT interact with the user's GUI desktop (session 0 isolation)
- They CAN install software, modify registry, import certificates, run MSIs
- For GUI interaction, use the custom agent (agent.py) which runs in the
  user's session

### RULES FOR QEMU GUEST AGENT

- **Use guest-exec for ALL administrative tasks**: installing software, importing
  certificates, modifying registry, running MSIs, file operations
- **NEVER use QMP keyboard input to type PowerShell commands** when guest-exec
  is available — guest-exec is faster, more reliable, and doesn't depend on
  window focus
- **ALWAYS check guest-exec-status** after launching a command to get stdout/stderr
- **guest-exec output is base64-encoded** — decode it before reading

## DRIVER SIGNING — PREVENTING THE DIALOG

The "Windows can't verify the publisher" dialog appears when installing
unsigned or untrusted drivers. It CANNOT be dismissed via QMP input.

### MANDATORY: Import certificate BEFORE installing drivers

The virtio-win ISO contains `cert/Virtio_Win_Red_Hat_CA.cer`. This certificate
MUST be imported into the TrustedPublisher store BEFORE running the MSI:

```powershell
# Via PowerShell (run as admin or via guest-exec)
certutil -addstore TrustedPublisher D:\input\Virtio_Win_Red_Hat_CA.cer

# Or via PowerShell cmdlet
Import-Certificate -FilePath D:\input\Virtio_Win_Red_Hat_CA.cer -CertStoreLocation Cert:\LocalMachine\TrustedPublisher
```

After importing the cert, `msiexec /i virtio-win-gt-x86.msi /quiet /norestart`
will complete silently with NO dialog.

### RULES FOR DRIVER INSTALLATION

- **ALWAYS import the publisher certificate to TrustedPublisher FIRST**
- **NEVER attempt to click through the driver signing dialog via QMP** — it
  will not work
- **NEVER use bcdedit testsigning** as a workaround — it's a sledgehammer
  that adds a watermark and weakens security unnecessarily
- The correct order is: import cert → install MSI silently → verify

## SILENT SOFTWARE INSTALLATION

### Python (32-bit for Win10 x86)

```powershell
# Silent install with PATH and for all users
D:\input\python-3.13.2.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

# Wait for completion (Start-Process -Wait)
Start-Process -FilePath D:\input\python-3.13.2.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1 Include_test=0' -NoNewWindow -Wait
```

- The installer filename for 32-bit is `python-X.Y.Z.exe` (no suffix)
- The 64-bit installer is `python-X.Y.Z-amd64.exe`
- `/quiet` = fully silent, `/passive` = shows progress bar
- `PrependPath=1` adds Python to PATH
- `InstallAllUsers=1` installs to Program Files (not per-user)
- `Include_test=0` skips test suite (saves space)

### pip packages (pywin32)

```powershell
# After Python install, pip is available
python -m pip install pywin32 --quiet
```

### Virtio guest tools

```powershell
# AFTER importing the Red Hat CA cert
msiexec /i D:\input\virtio-win-gt-x86.msi /quiet /norestart
```

This installs: virtio drivers, QEMU Guest Agent service, Spice agent.

## FILE SHARING

Three methods available, in order of preference:

### Method 1: virtiofs (PREFERRED — live shared directory)

Host directory appears as a drive letter in the guest. Files dropped on the
host side are instantly visible in the guest. No VM restart needed.

**Host side:**
```bash
# virtiofsd daemon (started automatically by launch-vm.sh)
/usr/libexec/virtiofsd --socket-path=/tmp/vm-virtiofs.sock --shared-dir ~/malware-lab/share

# QEMU args (added automatically by launch-vm.sh)
-object memory-backend-file,id=mem,size=2G,mem-path=/dev/shm,share=on
-numa node,memdev=mem
-chardev socket,id=virtiofs0,path=/tmp/vm-virtiofs.sock
-device vhost-user-fs-pci,queue-size=1024,chardev=virtiofs0,tag=share
```

**Guest side setup (one-time):**
1. Install WinFSP (download from github.com/winfsp/winfsp/releases, "Core" feature)
2. Install viofs driver: `pnputil /add-driver D:\viofs\w10\x86\viofs.inf /install`
   (driver is on the virtio-win ISO or USB share disk)
3. Copy virtiofs.exe from virtio-win to `C:\Program Files\VirtIO-FS\virtiofs.exe`
4. Register service: `sc create VirtioFsSvc binPath="C:\Program Files\VirtIO-FS\virtiofs.exe" start=auto depend=VirtioFsDrv`
5. Configure mount point via registry at `HKLM\Software\VirtIO-FS`:
   - `MountPoint` (String) = `E:` (or any free letter)
6. Start: `sc start VirtioFsSvc`

**Usage:** Just drop files into `~/malware-lab/share/` on the host. Guest sees
them instantly at `E:\` (or whatever mount point was configured).

### Method 2: QGA guest-file-write (no setup needed)

Push files to the running VM via QEMU Guest Agent. Works immediately with
the existing QGA installation. Good for one-off transfers.

```bash
python3 tools/vm/host/push_file.py ./app.exe 'C:\Users\lab\Desktop\app.exe'
```

### Method 3: USB share disk (LEGACY — requires VM stop)

FAT32 raw disk image mounted as USB storage. **Requires stopping the VM**
to write files from the host. Kept for backward compatibility and for
transferring large installer files during initial setup.

```bash
# VM must be stopped first!
sudo mount -o loop ~/malware-lab/share.img /mnt
sudo cp files /mnt/
sudo umount /mnt
```

**CRITICAL: Do NOT use `if=ide` for the share disk** — breaks boot order.

### RULES FOR FILE SHARING

- **Use virtiofs for all runtime file transfers** — no VM stop needed
- **Use QGA guest-file-write as fallback** if virtiofs isn't set up yet
- **USB share disk requires VM stop** — only use for initial setup or large transfers
- **NEVER use `-virtfs` (9p)** — no Windows driver exists
- **NEVER use `if=ide`** for the share disk — it breaks boot order
- **Use `-boot order=c,strict=on`** to ensure virtio disk boots first

### SECURITY: UNTRUSTED EXECUTABLES (MANDATORY)

When running untrusted/potentially malicious executables (the AOL proggies),
virtiofs is a **host-attack surface**. A malicious exe in the guest has full
read/write access to the shared directory on the host. It could:
- Delete or corrupt files in `~/malware-lab/share/`
- Write malicious files back to the host
- Read other proggies staged for processing

**For untrusted exe execution, use QGA `guest-file-write` instead of virtiofs.**
QGA pushes a copy of the file INTO the guest's local filesystem (e.g.
`C:\Users\lab\Desktop\app.exe`). The guest has no path back to the host
filesystem. This is one-way, host-to-guest only.

**Recommended workflow for proggie screenshots:**
1. Use QGA `guest-file-write` to push the exe into the guest
2. Launch it, screenshot, close it
3. Use QGA `guest-file-read` or QMP screendump to pull results back
4. Revert to snapshot before running the next exe

**virtiofs is safe for:** VM setup, tool installation, driver staging —
anything where the guest is running trusted code (our own scripts, known
installers). Do NOT leave virtiofs mounted while running untrusted exes.
Either stop the VirtioFsSvc service in the guest first, or don't start
virtiofsd on the host for that session.

## BOOT ORDER

SeaBIOS enumerates drives in this order: floppy → IDE → virtio → USB.
The `order=c` flag means "first hard disk" which is the first IDE disk if
one exists.

### RULES

- The Windows boot disk MUST be `if=virtio` (requires virtio storage driver
  loaded during Windows install)
- Additional disks for file sharing MUST use `usb-storage` (not IDE)
- Always include `-boot order=c,strict=on` in run mode
- In install mode, use `-boot d` to boot from CD-ROM

## INSTALLATION SEQUENCE (MANDATORY ORDER)

When setting up a fresh Windows VM, follow this exact sequence:

1. **Import virtio cert** → `certutil -addstore TrustedPublisher <cert.cer>`
2. **Install virtio guest tools** → `msiexec /i virtio-win-gt-x86.msi /quiet /norestart`
3. **Verify QEMU Guest Agent** → test `guest-ping` from host via qga socket
4. **Use guest-exec for all remaining installs** — no more QMP keyboard hacking
5. **Install Python** → `guest-exec` with python installer + silent flags
6. **Install pip packages** → `guest-exec` with `python -m pip install`
7. **Deploy custom agent** → `guest-exec` to copy files and create scheduled task
8. **Reboot** → `guest-exec` or QMP `system_powerdown`
9. **Snapshot** → stop VM, copy qcow2

### WHY THIS ORDER MATTERS

- Step 1 before step 2: prevents the driver signing dialog that QMP cannot dismiss
- Step 2 before step 3: the MSI installs the QEMU Guest Agent service
- Step 3 before step 4: once qemu-ga is running, we never need QMP keyboard
  input again for administrative tasks
- Steps 4-7 via guest-exec: reliable, no focus issues, no dialog surprises

## PREVENTING COMMON WINDOWS DIALOGS

| Dialog | Cause | Prevention |
|--------|-------|------------|
| "Windows can't verify publisher" | Unsigned driver | Import cert to TrustedPublisher BEFORE install |
| UAC consent prompt | Elevated action | Set `EnableLUA=0` in registry + reboot |
| SmartScreen "unknown app" | Unsigned exe | Set `SmartScreenEnabled=Off` in registry |
| Edge first-run | Edge launched | Set `PreventFirstRunPage=1` in registry |
| Windows Update restart | Pending updates | Disable Windows Update service + policy |
| Screen lock/sleep | Inactivity | `powercfg /change monitor-timeout-ac 0` |

**RULE: Every dialog that could appear MUST be prevented via registry/policy
BEFORE the action that triggers it. Never plan to dismiss dialogs via QMP.**

## QEMU LAUNCH CONFIGURATION REFERENCE

```bash
qemu-system-x86_64 \
  -enable-kvm -cpu host -smp 2 \
  # RAM with shared memory (required for virtiofs)
  -m 2G \
  -object memory-backend-file,id=mem,size=2G,mem-path=/dev/shm,share=on \
  -numa node,memdev=mem \
  # Boot disk (virtio — requires driver during install)
  -drive file=$DISK,format=qcow2,if=virtio \
  # No network (isolated malware analysis)
  -nic none \
  # Custom C2 channel (for agent.py)
  -device virtio-serial-pci \
  -chardev socket,path=$C2_SOCK,server=on,wait=off,id=c2chan \
  -device virtserialport,chardev=c2chan,name=c2channel \
  # QEMU Guest Agent channel (for qemu-ga)
  -chardev socket,path=$QGA_SOCK,server=on,wait=off,id=qga0 \
  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 \
  # File sharing: virtiofs (live shared directory, no VM stop needed)
  -chardev socket,id=virtiofs0,path=$VIRTIOFS_SOCK \
  -device vhost-user-fs-pci,queue-size=1024,chardev=virtiofs0,tag=share \
  # File sharing: USB legacy (requires VM stop to write from host)
  -drive file=$SHARE_IMG,format=raw,if=none,id=sharedisk \
  -device usb-storage,drive=sharedisk,removable=on \
  # Boot order (virtio disk first)
  -boot order=c,strict=on \
  # QMP control socket
  -qmp unix:$QMP_SOCK,server,nowait \
  # Display
  -display none -vnc :1 -vga virtio \
  # Absolute mouse positioning
  -usb -device usb-tablet \
  -daemonize
```

**NOTE:** virtiofsd must be started BEFORE qemu. See launch-vm.sh.

## DEBLOAT CHECKLIST

All of these MUST be applied before snapshotting the "debloated" state:

- [ ] Black wallpaper (SystemParametersInfo or registry)
- [ ] Visual effects = best performance (VisualFXSetting=2)
- [ ] Transparency disabled (EnableTransparency=0)
- [ ] Desktop icons hidden (HideIcons=1)
- [ ] Taskbar: search hidden, Task View hidden, Cortana hidden, News disabled
- [ ] Windows Update disabled (service + registry policy)
- [ ] Telemetry disabled (DiagTrack service + AllowTelemetry=0)
- [ ] UAC disabled (EnableLUA=0) — MUST reboot after
- [ ] Lock screen disabled
- [ ] Screen saver disabled (ScreenSaveActive=0)
- [ ] Power timeouts disabled (powercfg monitor/standby/hibernate = 0)
- [ ] Windows Defender disabled (DisableAntiSpyware=1, DisableRealtimeMonitoring=1)
- [ ] SmartScreen disabled (SmartScreenEnabled=Off)
- [ ] Notifications disabled (DisableNotificationCenter=1, ToastEnabled=0)
- [ ] Edge first-run disabled (PreventFirstRunPage=1)
- [ ] OneDrive uninstalled (`$env:SystemRoot\System32\OneDriveSetup.exe /uninstall` on 32-bit)
- [ ] UWP bloatware removed (Get-AppxPackage | Remove-AppxPackage)
