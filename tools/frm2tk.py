#!/usr/bin/env python3
"""Parse a VB3 .FRM file and render it with tkinter, then screenshot."""
import re, sys, tkinter as tk
from tkinter import ttk
from pathlib import Path

TWIPS_PER_PX = 15

def parse_frm(path):
    """Parse VB3 .FRM into nested control tree."""
    lines = Path(path).read_text(encoding='latin-1').splitlines()
    stack = []
    root = None
    for raw in lines:
        line = raw.strip()
        m = re.match(r'Begin\s+(\S+)\s+(\S+)', line)
        if m:
            ctrl = {'type': m.group(1), 'name': m.group(2), 'props': {}, 'children': []}
            if stack:
                stack[-1]['children'].append(ctrl)
            else:
                root = ctrl
            stack.append(ctrl)
            continue
        if line == 'End' and stack:
            stack.pop()
            continue
        m = re.match(r'(\w+)\s*=\s*(.*)', line)
        if m and stack:
            key = m.group(1).strip()
            val = m.group(2).strip()
            # Strip trailing comments like 'True or 'False
            val = re.sub(r"\s*'.*$", '', val)
            # Strip quotes
            if val.startswith('"') and val.endswith('"'):
                val = val[1:-1]
            stack[-1]['props'][key] = val
    return root

def t2p(twips_str):
    """Twips string to pixels."""
    try:
        return int(int(twips_str) / TWIPS_PER_PX)
    except (ValueError, TypeError):
        return 0

def vb_color(s):
    """Convert VB color like &H00C0C0C0& or &H8000000F& to hex."""
    if not s:
        return None
    s = s.strip().rstrip('&').lstrip('&H')
    try:
        v = int(s, 16)
    except ValueError:
        return None
    if v & 0x80000000:  # system color
        return '#c0c0c0'  # default to button face
    r = (v >> 0) & 0xFF
    g = (v >> 8) & 0xFF
    b = (v >> 16) & 0xFF
    return f'#{r:02x}{g:02x}{b:02x}'

def render_ctrl(parent, ctrl, ox=0, oy=0):
    """Render a VB3 control as a tkinter widget."""
    p = ctrl['props']
    x = t2p(p.get('Left', '0')) + ox
    y = t2p(p.get('Top', '0')) + oy
    w = t2p(p.get('Width', '0'))
    h = t2p(p.get('Height', '0'))
    cap = p.get('Caption', '').replace('&', '')
    text = p.get('Text', '')
    ct = ctrl['type']

    widget = None
    child_ox, child_oy = 0, 0

    if ct == 'Form':
        # Form is the root — already created
        parent.title(cap)
        cw = t2p(p.get('ClientWidth', p.get('Width', '0')))
        ch = t2p(p.get('ClientHeight', p.get('Height', '0')))
        parent.geometry(f'{cw}x{ch}')
        parent.resizable(False, False)
        bg = vb_color(p.get('BackColor'))
        if bg:
            parent.configure(bg=bg)
        for child in ctrl['children']:
            render_ctrl(parent, child)
        return

    if ct in ('SSCommand', 'CommandButton'):
        widget = tk.Button(parent, text=cap, font=('Times New Roman', 8, 'bold'),
                          relief='raised', bd=2)
    elif ct == 'SSOption':
        val = p.get('Value', '0')
        selected = val.startswith('-1')
        widget = tk.Radiobutton(parent, text=cap, font=('Times New Roman', 8, 'bold'),
                               bg='#c0c0c0', anchor='w', indicatoron=True,
                               selectcolor='white')
        if selected:
            widget.select()
    elif ct == 'SSCheck':
        widget = tk.Checkbutton(parent, text=cap, font=('Times New Roman', 8, 'bold'),
                               bg='#c0c0c0', anchor='w')
    elif ct == 'SSFrame':
        widget = tk.LabelFrame(parent, text=cap, font=('Times New Roman', 8, 'bold'),
                              bg='#c0c0c0', bd=2, relief='groove')
        child_ox, child_oy = 0, 0
    elif ct == 'TextBox':
        ml = p.get('MultiLine', '0').startswith('-1')
        if ml:
            widget = tk.Text(parent, font=('Times New Roman', 7, 'bold'),
                           wrap='word', bd=2, relief='sunken')
            if text:
                widget.insert('1.0', text)
        else:
            widget = tk.Entry(parent, font=('Times New Roman', 8), bd=2, relief='sunken')
            if text:
                widget.insert(0, text)
    elif ct == 'Label':
        fs = int(float(p.get('FontSize', '8')))
        bold = 'bold' if p.get('FontBold', '0').startswith('-1') else ''
        italic = 'italic' if p.get('FontItalic', '0').startswith('-1') else ''
        ul = True if p.get('FontUnderline', '0').startswith('-1') else False
        font_style = f'{bold} {italic}'.strip() or 'normal'
        fg = vb_color(p.get('ForeColor')) or 'black'
        bg = vb_color(p.get('BackColor')) or '#c0c0c0'
        widget = tk.Label(parent, text=cap, font=('Times New Roman', fs, font_style),
                         fg=fg, bg=bg, anchor='w')
        if ul:
            widget.configure(font=('Times New Roman', fs, font_style + ' underline'))
    elif ct == 'SSPanel':
        bg = vb_color(p.get('BackColor')) or '#c0c0c0'
        widget = tk.Frame(parent, bg=bg, bd=1, relief='sunken')
        if cap:
            lbl = tk.Label(widget, text=cap, font=('Arial', 7), bg=bg, anchor='w')
            lbl.place(x=2, y=2, relwidth=0.95)
    elif ct in ('Timer', 'VBMsg', 'CommonDialog', 'MCI', 'InvisibleIcon'):
        # Non-visual controls — skip
        return
    else:
        # Unknown — render as gray frame
        widget = tk.Frame(parent, bg='#c0c0c0', bd=1, relief='ridge')

    if widget:
        widget.place(x=x, y=y, width=w, height=h)
        for child in ctrl['children']:
            render_ctrl(widget, child, child_ox, child_oy)

def main():
    frm_path = sys.argv[1]
    out_path = sys.argv[2] if len(sys.argv) > 2 else '/tmp/frm_render.png'

    root_ctrl = parse_frm(frm_path)
    if not root_ctrl:
        print("Failed to parse FRM", file=sys.stderr)
        return 1

    win = tk.Tk()
    render_ctrl(win, root_ctrl)
    win.update_idletasks()
    win.update()

    # Screenshot after brief delay
    win.after(200, lambda: _screenshot(win, out_path))
    win.mainloop()

def _screenshot(win, out_path):
    import subprocess
    x = win.winfo_rootx()
    y = win.winfo_rooty()
    w = win.winfo_width()
    h = win.winfo_height()
    # Use import (ImageMagick) to capture the window
    subprocess.run(['import', '-window', 'root', '-crop', f'{w+8}x{h+30}+{x-4}+{y-25}',
                   '+repage', out_path], check=True)
    print(f'Saved {out_path} ({w}x{h})')
    win.destroy()

if __name__ == '__main__':
    main()
