# ADR 0002: Virtio-Serial for VM Command & Control

## Status

Accepted

## Context

The decompilation and screenshot pipeline requires executing commands
inside a Windows 10 QEMU/KVM guest: launching executables, automating
VB Decompiler, capturing screenshots, and pulling results back to
the host. The guest runs untrusted 1990s executables — some are trojans,
keyloggers, or other malware. Network connectivity inside the VM is a
security risk.

## Decision

We will use virtio-serial (a paravirtualized character device) for all
host↔guest communication. The guest agent (`agent.py`) listens on the
serial port and executes JSON-encoded commands. QMP (QEMU Machine
Protocol) handles screendumps, input events, and power control. QEMU
Guest Agent handles file push operations.

The VM operates with **no network interface** — NIC disabled in the QEMU
launch configuration.

## Scope

- `tools/vm/host/`
- `tools/vm/guest/`
- `tools/vm/scripts/`
- `tools/c2/`

## Considered Options

1. SSH over NAT — rejected: requires networking inside VM. Malware could
   use the NIC for C2 callbacks, DNS exfiltration, or lateral movement.
2. QEMU Guest Agent only — rejected: QGA is designed for file operations
   and shutdown, not arbitrary command execution or streaming output.
3. Shared folder (9p/virtiofs) — rejected: provides file transfer but
   no command execution or bidirectional messaging. Used as supplement
   only (vm-share.sh).

## Consequences

- (+) Complete network isolation — no NIC, no risk of malware callbacks
- (+) Low latency — virtio-serial is a direct host↔guest channel
- (+) JSON messaging — structured commands, not shell escaping
- (+) Works even when Windows networking stack is broken
- (-) Custom agent required inside VM (agent.py must be pre-installed)
- (-) No remote access to VM — must use QMP screendump for visual debug
- (~) QMP input events work but are fragile for GUI automation
  (timing-dependent, no accessibility API)

## Evidence

- CONFIRMED: batch_decompile.py processes 100+ executables without
  network exposure using this architecture.
- CONFIRMED: malware samples (trojans, keyloggers) run contained — no
  observed network attempts because no NIC exists.

## References

- [QEMU virtio-serial](https://www.qemu.org/docs/master/interop/virtio-serial.html)
- [QMP Protocol](https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html)
- ARCHITECTURE.md — VM Command & Control section
