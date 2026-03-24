#!/usr/bin/env python3
"""
Orchestrator: batch-process VB exes in the isolated Windows VM.
Decompile, run, interact, record — all headless, no network.
"""
import argparse, glob, json, logging, os, subprocess, sys, time

sys.path.insert(0, os.path.dirname(__file__))
from config import *
from qmp_client import QMPClient
from virtio_serial_client import VirtioSerialClient
from screen_recorder import ScreenRecorder
from input_controller import InputController

logging.basicConfig(level=logging.INFO,
                    format="%(asctime)s %(levelname)s %(message)s")
log = logging.getLogger("orchestrator")

SCRIPTS_DIR = os.path.join(os.path.dirname(__file__), "..", "scripts")


def vm_is_running():
    return os.path.exists(QMP_SOCK)


def vm_start(mode="run"):
    script = os.path.join(SCRIPTS_DIR, "launch-vm.sh")
    subprocess.run(["bash", script, mode], check=True)
    time.sleep(3)


def vm_stop():
    script = os.path.join(SCRIPTS_DIR, "stop-vm.sh")
    subprocess.run(["bash", script], check=True)
    time.sleep(2)


def vm_snapshot(action, name):
    script = os.path.join(SCRIPTS_DIR, "snapshot-vm.sh")
    subprocess.run(["bash", script, action, name], check=True)


def process_one(exe_path, args, qmp, c2, recorder, controller):
    basename = os.path.splitext(os.path.basename(exe_path))[0]
    guest_exe = GUEST_INPUT + "\\" + os.path.basename(exe_path)
    guest_out = GUEST_OUTPUT + "\\" + basename
    log.info("Processing: %s", basename)

    # Decompile
    if not args.no_decompile:
        log.info("  Decompiling...")
        r = c2.decompile(guest_exe, guest_out)
        log.info("  Decompile result: %s", r.get("status"))

    # Run the exe
    log.info("  Launching...")
    r = c2.run_exe(guest_exe)
    pid = r.get("pid")
    if not pid:
        log.error("  Failed to launch: %s", r)
        return False

    time.sleep(2)  # Let it render

    # Interaction script (if provided per-app or global)
    script_path = os.path.join(args.interaction_dir, basename + ".json") if args.interaction_dir else None
    if script_path and os.path.exists(script_path):
        with open(script_path) as f:
            script = json.load(f)
        log.info("  Running interaction script (%d steps)", len(script))
        controller.execute_script(script)

    # Record
    if not args.no_record:
        vid = os.path.join(RECORDINGS_DIR, basename + ".mp4")
        log.info("  Recording %ds...", args.record_duration)
        recorder.record(vid, duration=args.record_duration, fps=args.record_fps)

    # Screenshot
    shot = os.path.join(RECORDINGS_DIR, basename + ".png")
    recorder.screenshot(shot)

    # Kill
    if pid:
        c2.kill_process(pid)

    log.info("  Done: %s", basename)
    return True


def main():
    p = argparse.ArgumentParser(description="VM-based exe analysis pipeline")
    p.add_argument("--input-dir", default=INPUT_DIR)
    p.add_argument("--record-duration", type=int, default=30)
    p.add_argument("--record-fps", type=int, default=2)
    p.add_argument("--interaction-dir", default=None,
                   help="Dir with per-app JSON interaction scripts")
    p.add_argument("--no-decompile", action="store_true")
    p.add_argument("--no-record", action="store_true")
    p.add_argument("--snapshot", default="clean",
                   help="Snapshot to restore between samples")
    p.add_argument("--no-snapshot-restore", action="store_true")
    p.add_argument("--limit", type=int, default=0, help="Max exes to process (0=all)")
    args = p.parse_args()

    exes = sorted(glob.glob(os.path.join(args.input_dir, "*.exe")))
    if args.limit:
        exes = exes[:args.limit]
    log.info("Found %d exe files", len(exes))

    ok, fail, skip = 0, 0, 0

    for i, exe in enumerate(exes):
        log.info("=== [%d/%d] %s ===", i + 1, len(exes), os.path.basename(exe))

        # Snapshot restore
        if not args.no_snapshot_restore:
            if vm_is_running():
                vm_stop()
            vm_snapshot("restore", args.snapshot)
            vm_start()

        # Ensure VM is running
        if not vm_is_running():
            vm_start()

        try:
            # Wait for agent
            c2 = VirtioSerialClient(C2_SOCK)
            c2.wait_for_agent(timeout=180)

            qmp = QMPClient(QMP_SOCK).connect()
            recorder = ScreenRecorder(qmp, RECORDINGS_DIR)
            controller = InputController(qmp)

            if process_one(exe, args, qmp, c2, recorder, controller):
                ok += 1
            else:
                fail += 1

            c2.close()
            qmp.close()

        except Exception as e:
            log.error("FAILED: %s — %s", os.path.basename(exe), e)
            fail += 1

    log.info("=== DONE: %d ok, %d failed, %d skipped of %d ===", ok, fail, skip, len(exes))


if __name__ == "__main__":
    main()
