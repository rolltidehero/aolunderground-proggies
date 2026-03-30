"""Ensure the GUI C2 agent is running in the VM's session 1.

The gold image only auto-starts the SYSTEM agent (c2channel).
The GUI agent (c2guichannel) must be launched via SYSTEM C2 + s1launch_sys.py.
This module provides a single function that any pipeline script can call.

Usage:
    from ensure_gui_agent import ensure_gui_agent
    ensure_gui_agent()  # blocks until c2gui responds to ping, or raises
"""
import logging
import time

from virtio_serial_client import VirtioSerialClient

# Hunter deep tracing — always on, timestamped per-run, file only
import hunter
from pathlib import Path as _Path
from datetime import datetime, timezone
_hunter_log = (_Path.home() / 'traces' / _Path(__file__).stem
               / datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
               / 'hunter.log')
_hunter_log.parent.mkdir(parents=True, exist_ok=True)
hunter.trace(stdlib=False, action=hunter.CallPrinter(
    stream=open(_hunter_log, 'a')))

log = logging.getLogger(__name__)

C2_SOCK = '/tmp/vm-c2.sock'
C2GUI_SOCK = '/tmp/vm-c2gui.sock'
S1LAUNCH_CMD = r'pythonw.exe C:\Tools\agent.py c2guichannel'
S1LAUNCH_SCRIPT = r'C:\Tools\s1launch_sys.py'
POLL_MAX = 300  # ~30s with free_process(100) per iteration


def _free_process(n=100):
    for _ in range(n):
        time.sleep(0)


def _ping_gui_agent():
    """Try to ping the GUI agent. Returns True if alive, False otherwise."""
    c2g = VirtioSerialClient(C2GUI_SOCK)
    try:
        c2g.connect()
        c2g.sock.settimeout(5)
        r = c2g.ping()
        alive = r.get('status') == 'pong'
        log.debug('_ping_gui_agent: ping response=%r alive=%s', r, alive)
        return alive
    except Exception as exc:
        log.debug('_ping_gui_agent: failed exc=%s', exc)
        return False
    finally:
        c2g.close()


def ensure_gui_agent(timeout=120):
    """Ensure GUI agent is responding on c2gui socket. Start it if needed.

    1. Ping c2gui — if pong, return immediately.
    2. Connect to SYSTEM C2, send shell command to launch GUI agent via s1launch.
    3. Poll c2gui until it responds to ping or timeout.

    Raises TimeoutError if the agent doesn't come online.
    """
    _t0 = time.monotonic()
    log.debug('ensure_gui_agent: ENTER timeout=%d', timeout)

    # Already running?
    if _ping_gui_agent():
        log.info('GUI agent already online (%.1fs)', time.monotonic() - _t0)
        return

    # Launch via SYSTEM C2
    log.info('GUI agent not responding, launching via SYSTEM C2...')
    log.debug('ensure_gui_agent: connecting to SYSTEM C2 at %s', C2_SOCK)
    c2 = VirtioSerialClient(C2_SOCK)
    try:
        c2.connect()
        c2.sock.settimeout(30)
        r = c2.ping()
        log.debug('ensure_gui_agent: SYSTEM C2 ping response=%r', r)
        if r.get('status') != 'pong':
            raise ConnectionError(f'SYSTEM C2 not responding: {r}')
    except Exception as exc:
        c2.close()
        elapsed = time.monotonic() - _t0
        log.error('ensure_gui_agent: SYSTEM C2 unreachable exc=%s elapsed=%.1fs', exc, elapsed)
        raise ConnectionError(f'Cannot reach SYSTEM C2 at {C2_SOCK}: {exc}') from exc

    launch_cmd = f'python {S1LAUNCH_SCRIPT} "{S1LAUNCH_CMD}"'
    log.debug('ensure_gui_agent: sending shell command=%r', launch_cmd)
    try:
        r = c2.send_command('shell', command=launch_cmd)
        log.debug('ensure_gui_agent: shell response=%r', r)
    except Exception as exc:
        log.error('ensure_gui_agent: shell command failed exc=%s', exc)
        raise
    finally:
        c2.close()

    # Poll for GUI agent to come online
    deadline = time.monotonic() + timeout
    attempt = 0
    while time.monotonic() < deadline:
        _free_process(100)
        attempt += 1
        if _ping_gui_agent():
            elapsed = time.monotonic() - _t0
            log.info('GUI agent online after %d attempts (%.1fs)', attempt, elapsed)
            return
        if attempt % 50 == 0:
            log.debug('ensure_gui_agent: still waiting, attempt=%d elapsed=%.1fs',
                       attempt, time.monotonic() - _t0)

    elapsed = time.monotonic() - _t0
    log.error('ensure_gui_agent: TIMEOUT after %d attempts elapsed=%.1fs', attempt, elapsed)
    raise TimeoutError(f'GUI agent not online after {timeout}s ({attempt} attempts)')
