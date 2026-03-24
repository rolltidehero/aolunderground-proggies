"""High-level UI automation via QMP input events."""
import time, logging

log = logging.getLogger(__name__)


class InputController:
    def __init__(self, qmp_client):
        self.qmp = qmp_client

    def click(self, x, y):
        self.qmp.send_mouse_click(x, y)

    def double_click(self, x, y):
        self.qmp.send_mouse_click(x, y)
        time.sleep(0.1)
        self.qmp.send_mouse_click(x, y)

    def right_click(self, x, y):
        self.qmp.send_mouse_click(x, y, "right")

    def type_text(self, text):
        self.qmp.send_text(text)

    def press_key(self, key):
        self.qmp.send_key([key])

    def hotkey(self, *keys):
        """Send key combo: all down, then all up."""
        events = []
        for k in keys:
            events.append({"type": "key", "data": {"down": True, "key": {"type": "qcode", "data": k}}})
        for k in reversed(keys):
            events.append({"type": "key", "data": {"down": False, "key": {"type": "qcode", "data": k}}})
        self.qmp.execute("input-send-event", events=events)

    def open_run_dialog(self):
        self.hotkey("meta_l", "r")
        time.sleep(0.5)

    def run_command(self, cmd):
        self.open_run_dialog()
        time.sleep(0.5)
        self.type_text(cmd)
        time.sleep(0.2)
        self.press_key("ret")

    def wait(self, seconds):
        time.sleep(seconds)

    def execute_script(self, script):
        """Execute a list of action dicts."""
        for step in script:
            action = step["action"]
            log.debug("Step: %s", step)
            if action == "wait":
                time.sleep(step.get("seconds", 1))
            elif action == "click":
                self.click(step["x"], step["y"])
            elif action == "double_click":
                self.double_click(step["x"], step["y"])
            elif action == "right_click":
                self.right_click(step["x"], step["y"])
            elif action == "type":
                self.type_text(step["text"])
            elif action == "key":
                self.press_key(step["key"])
            elif action == "hotkey":
                self.hotkey(*step["keys"])
            elif action == "run_command":
                self.run_command(step["command"])
            else:
                log.warning("Unknown action: %s", action)
            time.sleep(step.get("delay", 0.3))
