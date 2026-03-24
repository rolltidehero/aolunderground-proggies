import os

LAB = os.path.expanduser("~/malware-lab")
SHARE_DIR = os.path.join(LAB, "share")
INPUT_DIR = os.path.join(SHARE_DIR, "input")
OUTPUT_DIR = os.path.join(SHARE_DIR, "output")
RECORDINGS_DIR = os.path.join(SHARE_DIR, "recordings")
TASKS_DIR = os.path.join(SHARE_DIR, "tasks")
QMP_SOCK = "/tmp/vm-qmp.sock"
C2_SOCK = "/tmp/vm-c2.sock"
QGA_SOCK = "/tmp/vm-qga.sock"
GUEST_SHARE = "D:"  # USB share disk in guest
GUEST_INPUT = GUEST_SHARE + "\\input"
GUEST_OUTPUT = GUEST_SHARE + "\\output"
SCREEN_WIDTH = 1024
SCREEN_HEIGHT = 768
VB_DECOMPILER_PATH = r"C:\Tools\VBDecompiler\VB Decompiler.exe"
