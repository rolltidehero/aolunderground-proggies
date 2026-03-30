"""Bezier mouse movement via QMP — natural cursor motion with deceleration and jitter."""
import math, random, time, logging

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


def bezier_move(qmp_move_fn, sx, sy, dx, dy, capture_fn=None):
    """Move cursor from (sx,sy) to (dx,dy) via cubic Bezier curve.

    Args:
        qmp_move_fn: callable(x, y) that moves the QMP cursor
        sx, sy: start position
        dx, dy: destination position
        capture_fn: optional callable() to capture a frame during movement
    """
    distance = math.sqrt((dx - sx) ** 2 + (dy - sy) ** 2)
    if distance < 2:
        qmp_move_fn(dx, dy)
        return

    # Random control points for natural curve
    offset = distance * 0.15
    cx1 = sx + (dx - sx) * 0.3 + random.uniform(-offset, offset)
    cy1 = sy + (dy - sy) * 0.3 + random.uniform(-offset, offset)
    cx2 = sx + (dx - sx) * 0.7 + random.uniform(-offset, offset)
    cy2 = sy + (dy - sy) * 0.7 + random.uniform(-offset, offset)

    steps = random.randint(30, 50) if distance < 500 else random.randint(60, 90)
    capture_interval = max(steps // 6, 1)  # ~6 frames during movement

    for i in range(steps + 1):
        t = i / steps
        # Cubic Bezier
        x = int((1 - t) ** 3 * sx + 3 * (1 - t) ** 2 * t * cx1 +
                3 * (1 - t) * t ** 2 * cx2 + t ** 3 * dx)
        y = int((1 - t) ** 3 * sy + 3 * (1 - t) ** 2 * t * cy1 +
                3 * (1 - t) * t ** 2 * cy2 + t ** 3 * dy)

        qmp_move_fn(x, y)

        # Capture frames at intervals for animation
        if capture_fn and i % capture_interval == 0 and i > 0:
            capture_fn()

        # Speed: decelerate at start/end, jitter
        base = 0.001
        decel = math.sin(t * math.pi) * 0.005
        jitter = random.uniform(0, 0.003)
        if random.random() < 0.01:
            time.sleep(random.uniform(0.01, 0.03))
        time.sleep(base + decel + jitter)

    # Final snap
    qmp_move_fn(dx, dy)
