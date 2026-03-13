"""QMP-based screen recording. Screendumps → ffmpeg → video."""
import os, time, tempfile, subprocess, logging

log = logging.getLogger(__name__)


class ScreenRecorder:
    def __init__(self, qmp_client, output_dir):
        self.qmp = qmp_client
        self.output_dir = output_dir
        os.makedirs(output_dir, exist_ok=True)

    def capture_frame(self, path):
        self.qmp.screendump(filename=path)

    def screenshot(self, output_path):
        with tempfile.NamedTemporaryFile(suffix=".ppm", delete=False) as f:
            ppm = f.name
        self.capture_frame(ppm)
        time.sleep(0.2)
        subprocess.run(["ffmpeg", "-y", "-i", ppm, output_path],
                       capture_output=True, check=True)
        os.unlink(ppm)
        return output_path

    def record(self, output_path, duration=60, fps=2):
        tmpdir = tempfile.mkdtemp(prefix="vmrec_")
        interval = 1.0 / fps
        total = int(duration * fps)
        log.info("Recording %d frames at %d fps to %s", total, fps, output_path)
        for i in range(total):
            frame = os.path.join(tmpdir, f"frame_{i:06d}.ppm")
            try:
                self.capture_frame(frame)
            except Exception as e:
                log.warning("Frame %d failed: %s", i, e)
            time.sleep(interval)
        # Stitch
        subprocess.run([
            "ffmpeg", "-y", "-framerate", str(fps),
            "-i", os.path.join(tmpdir, "frame_%06d.ppm"),
            "-c:v", "libx264", "-pix_fmt", "yuv420p",
            "-vf", "pad=ceil(iw/2)*2:ceil(ih/2)*2",
            output_path
        ], capture_output=True, check=True)
        # Cleanup
        for f in os.listdir(tmpdir):
            os.unlink(os.path.join(tmpdir, f))
        os.rmdir(tmpdir)
        log.info("Saved %s", output_path)
        return output_path
