#!/usr/bin/env python3
"""Extract embedded images (FRX resources) from VB5/VB6 executables.

Scans for BMP, PNG, JPEG, GIF, ICO signatures in the exe and extracts
valid images. No Wine or VB Decompiler needed — pure Python.

Usage:
    python3 extract_frx.py [--one <exe>] [--stats] [--dry-run] [--reset-errors]

Outputs: <name>.frx_0.png, <name>.frx_1.png, ... next to each exe.
Checkpoint: frx_checkpoint.json
"""
import sys, os, struct, json, argparse, logging, re, subprocess
from datetime import datetime

REPO_ROOT = '/home/braker/git/aolunderground-proggies'
PROGRAMS_DIR = os.path.join(REPO_ROOT, 'programs')
CHECKPOINT_FILE = os.path.join(REPO_ROOT, 'tools/c2/frx_checkpoint.json')
LOG_FILE = os.path.join(REPO_ROOT, 'tools/c2/extract_frx.log')

# Minimum image size to extract (skip tiny stubs)
MIN_IMAGE_BYTES = 200
# Skip images larger than 5MB (corrupt/false positive)
MAX_IMAGE_BYTES = 5 * 1024 * 1024
# Upscale images smaller than this width
MIN_WIDTH = 400

logger = logging.getLogger('extract_frx')

def setup_logging():
    logger.setLevel(logging.DEBUG)
    fh = logging.FileHandler(LOG_FILE)
    fh.setLevel(logging.DEBUG)
    fh.setFormatter(logging.Formatter('%(asctime)s %(levelname)s %(message)s'))
    ch = logging.StreamHandler()
    ch.setLevel(logging.INFO)
    ch.setFormatter(logging.Formatter('%(message)s'))
    logger.addHandler(fh)
    logger.addHandler(ch)

# ── Image extraction ──

def find_images(data):
    """Find all embedded images in raw exe data. Returns [(offset, size, fmt), ...]"""
    images = []
    length = len(data)

    # BMP: 'BM' + 4-byte file size
    pos = 0
    while True:
        pos = data.find(b'BM', pos)
        if pos == -1: break
        if pos + 14 <= length:
            size = struct.unpack_from('<I', data, pos + 2)[0]
            if MIN_IMAGE_BYTES <= size <= MAX_IMAGE_BYTES and pos + size <= length:
                # Validate: check DIB header size at offset 14
                if pos + 18 <= length:
                    dib_size = struct.unpack_from('<I', data, pos + 14)[0]
                    if dib_size in (12, 40, 56, 108, 124):  # known DIB header sizes
                        images.append((pos, size, 'bmp'))
        pos += 2

    # PNG: 89 50 4E 47 0D 0A 1A 0A ... IEND chunk
    pos = 0
    png_sig = b'\x89PNG\r\n\x1a\n'
    iend = b'IEND'
    while True:
        pos = data.find(png_sig, pos)
        if pos == -1: break
        # Find IEND to determine size
        end = data.find(iend, pos + 8)
        if end != -1:
            size = end + 12 - pos  # IEND chunk = 4 len + 4 type + 4 crc
            if MIN_IMAGE_BYTES <= size <= MAX_IMAGE_BYTES:
                images.append((pos, size, 'png'))
        pos += 8

    # JPEG: FF D8 FF ... FF D9
    pos = 0
    while True:
        pos = data.find(b'\xff\xd8\xff', pos)
        if pos == -1: break
        # Find end marker FF D9
        end = data.find(b'\xff\xd9', pos + 3)
        if end != -1:
            size = end + 2 - pos
            if MIN_IMAGE_BYTES <= size <= MAX_IMAGE_BYTES:
                images.append((pos, size, 'jpg'))
        pos += 3

    # GIF: GIF87a or GIF89a ... trailer byte 0x3B
    pos = 0
    while True:
        pos = data.find(b'GIF8', pos)
        if pos == -1: break
        if pos + 6 <= length and data[pos+4:pos+6] in (b'7a', b'9a'):
            end = data.find(b'\x3b', pos + 6)
            if end != -1:
                size = end + 1 - pos
                if MIN_IMAGE_BYTES <= size <= MAX_IMAGE_BYTES:
                    images.append((pos, size, 'gif'))
        pos += 4

    # ICO: 00 00 01 00 + count (skip if count is unreasonable)
    pos = 0
    while True:
        pos = data.find(b'\x00\x00\x01\x00', pos)
        if pos == -1: break
        if pos + 6 <= length:
            count = struct.unpack_from('<H', data, pos + 4)[0]
            if 1 <= count <= 20:
                # Calculate total size from directory entries
                dir_end = pos + 6 + count * 16
                if dir_end <= length:
                    max_end = dir_end
                    valid = True
                    for i in range(count):
                        entry_off = pos + 6 + i * 16
                        img_size = struct.unpack_from('<I', data, entry_off + 8)[0]
                        img_off = struct.unpack_from('<I', data, entry_off + 12)[0]
                        end = pos + img_off + img_size
                        if end > length or img_size > MAX_IMAGE_BYTES:
                            valid = False
                            break
                        max_end = max(max_end, end)
                    if valid:
                        size = max_end - pos
                        if MIN_IMAGE_BYTES <= size <= MAX_IMAGE_BYTES:
                            images.append((pos, size, 'ico'))
        pos += 4

    # Deduplicate overlapping regions — keep larger
    images.sort(key=lambda x: x[0])
    filtered = []
    for img in images:
        off, sz, fmt = img
        # Skip if overlaps with previous
        if filtered:
            prev_off, prev_sz, _ = filtered[-1]
            if off < prev_off + prev_sz:
                # Keep the larger one
                if sz > prev_sz:
                    filtered[-1] = img
                continue
        filtered.append(img)

    return filtered


def extract_one(exe_path, output_dir):
    """Extract all images from one exe. Returns list of output paths."""
    with open(exe_path, 'rb') as f:
        data = f.read()

    # Quick check: is it a PE?
    if data[:2] != b'MZ':
        return []

    images = find_images(data)
    if not images:
        return []

    basename = os.path.splitext(os.path.basename(exe_path))[0]
    outputs = []

    for i, (offset, size, fmt) in enumerate(images):
        raw = data[offset:offset + size]
        tmp_path = os.path.join(output_dir, f'{basename}.frx_{i}.{fmt}')
        png_path = os.path.join(output_dir, f'{basename}.frx_{i}.png')

        # Write raw image
        with open(tmp_path, 'wb') as f:
            f.write(raw)

        # Convert to PNG (and upscale if small)
        if fmt == 'png':
            # Already PNG, just check if needs upscale
            r = subprocess.run(['identify', '-format', '%w', tmp_path],
                             capture_output=True, text=True)
            w = int(r.stdout.strip()) if r.stdout.strip().isdigit() else MIN_WIDTH
            if w < MIN_WIDTH and w > 0:
                scale = max(2, (MIN_WIDTH + w - 1) // w) * 100
                subprocess.run(['convert', tmp_path, '-filter', 'Point',
                              '-resize', f'{scale}%', png_path], capture_output=True)
            else:
                os.rename(tmp_path, png_path)
        else:
            # Convert to PNG
            r = subprocess.run(['identify', '-format', '%w', tmp_path],
                             capture_output=True, text=True)
            w = int(r.stdout.strip()) if r.stdout.strip().isdigit() else MIN_WIDTH
            if w < MIN_WIDTH and w > 0:
                scale = max(2, (MIN_WIDTH + w - 1) // w) * 100
                subprocess.run(['convert', tmp_path, '-filter', 'Point',
                              '-resize', f'{scale}%', png_path], capture_output=True)
            else:
                subprocess.run(['convert', tmp_path, png_path], capture_output=True)
            if os.path.isfile(png_path):
                os.remove(tmp_path)
            else:
                # convert failed, keep original
                png_path = tmp_path

        if os.path.isfile(png_path) and os.path.getsize(png_path) > 0:
            outputs.append(png_path)
        else:
            # Cleanup failed conversion
            for p in [tmp_path, png_path]:
                if os.path.isfile(p):
                    os.remove(p)

    return outputs


# ── Checkpoint ──

def load_checkpoint():
    if os.path.exists(CHECKPOINT_FILE):
        with open(CHECKPOINT_FILE) as f:
            return json.load(f)
    return {'files': {}, 'started': datetime.now().isoformat()}

def save_checkpoint(ckpt):
    ckpt['updated'] = datetime.now().isoformat()
    with open(CHECKPOINT_FILE, 'w') as f:
        json.dump(ckpt, f, indent=2)

def _walk_exes():
    for root, dirs, files in os.walk(PROGRAMS_DIR):
        for f in sorted(files):
            if f.lower().endswith('.exe'):
                yield os.path.join(root, f)

def print_stats(ckpt):
    files = ckpt['files']
    ok = sum(1 for v in files.values() if v['status'] == 'ok')
    err = sum(1 for v in files.values() if v['status'] == 'error')
    skip = sum(1 for v in files.values() if v['status'] == 'skipped')
    total_imgs = sum(v.get('count', 0) for v in files.values() if v['status'] == 'ok')
    all_count = sum(1 for _ in _walk_exes())
    print(f'\n{"="*60}')
    print(f'Total: {all_count}  Processed: {len(files)}  OK: {ok}  Err: {err}  Skip: {skip}  Remaining: {all_count - len(files)}')
    print(f'Images extracted: {total_imgs}')
    print(f'{"="*60}')

# ── Main ──

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--one', type=str, help='Extract from one exe')
    parser.add_argument('--stats', action='store_true')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--reset-errors', action='store_true')
    args = parser.parse_args()

    ckpt = load_checkpoint()

    if args.reset_errors:
        removed = sum(1 for v in ckpt['files'].values() if v['status'] == 'error')
        ckpt['files'] = {k: v for k, v in ckpt['files'].items() if v['status'] != 'error'}
        save_checkpoint(ckpt)
        print(f'Cleared {removed}')
        return

    if args.stats:
        print_stats(ckpt)
        return

    setup_logging()

    if args.one:
        if not os.path.isfile(args.one):
            print(f'Not found: {args.one}'); sys.exit(1)
        out_dir = os.path.dirname(args.one)
        outputs = extract_one(args.one, out_dir)
        print(f'Extracted {len(outputs)} images:')
        for p in outputs:
            print(f'  {p}')
        return

    all_exes = list(_walk_exes())
    todo = [e for e in all_exes if os.path.relpath(e, REPO_ROOT) not in ckpt['files']]
    logger.info(f'Total: {len(all_exes)}, Remaining: {len(todo)}')

    if args.dry_run:
        for p in todo[:20]:
            print(f'  {os.path.relpath(p, REPO_ROOT)}')
        if len(todo) > 20: print(f'  ... and {len(todo)-20} more')
        return

    if not todo:
        logger.info('Nothing to do.'); return

    for i, exe_path in enumerate(todo):
        rel = os.path.relpath(exe_path, REPO_ROOT)
        out_dir = os.path.dirname(exe_path)
        logger.info(f'[{i+1}/{len(todo)}] {rel}')

        try:
            outputs = extract_one(exe_path, out_dir)
        except Exception as e:
            ckpt['files'][rel] = {'status': 'error', 'detail': str(e),
                                  'timestamp': datetime.now().isoformat()}
            save_checkpoint(ckpt)
            logger.info(f'  ERROR: {e}')
            continue

        if outputs:
            ckpt['files'][rel] = {
                'status': 'ok', 'count': len(outputs),
                'images': [os.path.relpath(p, REPO_ROOT) for p in outputs],
                'timestamp': datetime.now().isoformat()
            }
            logger.info(f'  OK ({len(outputs)} images)')
        else:
            ckpt['files'][rel] = {'status': 'skipped', 'detail': 'no images found',
                                  'timestamp': datetime.now().isoformat()}
            logger.info(f'  SKIP (no images)')

        save_checkpoint(ckpt)

    logger.info('Done.')
    print_stats(ckpt)

if __name__ == '__main__':
    main()
