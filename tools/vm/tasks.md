# VM Isolation Pipeline — Task Tracker

## Phase 1: Host Dependencies
- [x] Write install-host-deps.sh
- [ ] **RUN**: `bash tools/vm/scripts/install-host-deps.sh`
- [ ] Enable SVM in BIOS (reboot → DEL → Advanced → CPU Config → SVM Mode → Enabled → F10)
- [ ] Verify: `ls /dev/kvm` returns the device

## Phase 2: Download ISOs
- [x] Write download-win10-iso.sh
- [x] Write download-virtio-drivers.sh
- [ ] **RUN**: `bash tools/vm/scripts/download-win10-iso.sh`
- [ ] **RUN**: `bash tools/vm/scripts/download-virtio-drivers.sh`

## Phase 3: Create VM Disk
- [x] Write create-vm-disk.sh
- [ ] **RUN**: `bash tools/vm/scripts/create-vm-disk.sh`

## Phase 4: Install Windows
- [x] Write launch-vm.sh (install + run modes)
- [x] Write stop-vm.sh
- [x] Write snapshot-vm.sh
- [ ] **RUN**: `bash tools/vm/scripts/launch-vm.sh install`
- [ ] Connect VNC: `vncviewer localhost:5900`
- [ ] Install Windows (load virtio storage driver from 2nd CDROM during install)
- [ ] **SNAPSHOT**: `bash tools/vm/scripts/stop-vm.sh && bash tools/vm/scripts/snapshot-vm.sh create fresh-windows`
- [ ] Boot again: `bash tools/vm/scripts/launch-vm.sh run`
- [ ] In guest via VNC:
  - [ ] Install virtio-win-gt-x86.msi (from D:\ or E:\ CDROM)
  - [ ] Install Python 3.x (copy installer to share/input/ first, access from guest)
  - [ ] `pip install pywin32`
  - [ ] Copy VB Decompiler Pro to C:\Tools\VBDecompiler\ (via share folder)
  - [ ] Copy agent.py + setup_agent.bat to C:\Tools\ (via share folder)
  - [ ] Run setup_agent.bat as admin
  - [ ] Verify agent starts (check C:\Tools\agent.log)
- [ ] **SNAPSHOT**: `bash tools/vm/scripts/stop-vm.sh && bash tools/vm/scripts/snapshot-vm.sh create tools-installed`

## Phase 5: Verify Agent Communication
- [ ] Boot VM: `bash tools/vm/scripts/launch-vm.sh run`
- [ ] Test from host: `python3 -c "from host.virtio_serial_client import *; c=VirtioSerialClient(); c.wait_for_agent(); print(c.ping())"`
- [ ] Test shell: `c.shell('dir C:\\')`
- [ ] **SNAPSHOT**: `bash tools/vm/scripts/stop-vm.sh && bash tools/vm/scripts/snapshot-vm.sh create clean`

## Phase 6: Code Written (all done)
- [x] host/config.py
- [x] host/qmp_client.py
- [x] host/virtio_serial_client.py
- [x] host/screen_recorder.py
- [x] host/input_controller.py
- [x] host/orchestrator.py
- [x] guest/agent.py
- [x] guest/setup_agent.bat
- [x] guest/requirements.txt
- [x] All Python compiles clean
- [x] All bash scripts parse clean

## Phase 7: End-to-End Test
- [ ] Copy 5 test exes to ~/malware-lab/share/input/
- [ ] Run: `cd tools/vm && python3 -m host.orchestrator --limit 5 --no-snapshot-restore`
- [ ] Verify decompiled output in share/output/
- [ ] Verify screenshots in share/recordings/
- [ ] Get user approval on output quality

## Phase 8: Integration with Existing Pipeline
- [ ] Port VBD form layout extraction to guest agent (decompile → .frm files)
- [ ] Generate per-app interaction scripts from nav_graphs + form layouts
- [ ] Batch all 2,152 exes with snapshot restore

## Execution Order (tell kiro "execute the plan")
```
1. Enable SVM in BIOS (manual — reboot, DEL, Advanced, CPU Config, SVM, F10)
2. bash tools/vm/scripts/install-host-deps.sh
3. bash tools/vm/scripts/download-win10-iso.sh
4. bash tools/vm/scripts/download-virtio-drivers.sh
5. bash tools/vm/scripts/create-vm-disk.sh
6. bash tools/vm/scripts/launch-vm.sh install
7. VNC install Windows (manual)
8. snapshot fresh-windows
9. Install tools in guest (manual via VNC)
10. snapshot tools-installed
11. Deploy agent, verify comms
12. snapshot clean
13. Test 5 exes
14. Batch run
```
