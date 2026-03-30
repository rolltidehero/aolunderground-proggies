#!/usr/bin/env python3
"""Clean Kagi assistant HTML artifacts from review/fix output files.

Usage:
    python3 tools/clean_kagi_output.py kagi-reviews/fix1-raw.txt -o kagi-reviews/fix1-clean.txt
    python3 tools/clean_kagi_output.py kagi-reviews/*.txt          # in-place
    python3 tools/clean_kagi_output.py kagi-reviews/ --all         # all .txt in dir
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


def clean_kagi_text(text: str) -> str:
    """Strip Kagi chat UI artifacts from text, return clean output."""
    # Strip thinking block (appears at start of reviewer responses)
    text = re.sub(
        r'^Thinking\n.*?\n(?=F\d|CRITICAL|HIGH|MEDIUM|START|File:|def |class )',
        '', text, flags=re.DOTALL,
    )

    # Strip HTML tags
    text = re.sub(r'<[^>]+>', '', text)

    # Strip "Copied to clipboard" noise
    text = re.sub(r'\n\s*Copied to clipboard\s*\n', '\n', text)

    # Fix "Pythondef" / "Pythonclass" / "Pythonimport" etc — Kagi prepends language label
    text = re.sub(
        r'^\s*Python(def |class |import |from |@|if |else|elif|try|except|finally|return|raise|for |while |with |async )',
        r'\1', text, flags=re.MULTILINE,
    )

    # Fix inline "  Pythondef" (indented code blocks)
    text = re.sub(r'(?<=\n)\s{2,}Python(?=def |class |import |from )', '', text)

    # Strip Kagi's copy button artifacts (various formats)
    text = re.sub(r'\n\s*Copy code\s*\n', '\n', text)
    text = re.sub(r'\n\s*Copy\s*\n', '\n', text)

    # Collapse excessive blank lines (4+ → 2)
    text = re.sub(r'\n{4,}', '\n\n\n', text)

    # Strip leading/trailing whitespace
    text = text.strip() + '\n'

    return text


def main() -> int:
    parser = argparse.ArgumentParser(description='Clean Kagi HTML artifacts from output files.')
    parser.add_argument('paths', nargs='+', type=Path, help='Files or directories to clean')
    parser.add_argument('-o', '--output', type=Path, help='Output file (single input only)')
    parser.add_argument('--all', action='store_true', help='Process all .txt files in directory')
    parser.add_argument('--suffix', default='-clean', help='Suffix for output files (default: -clean)')
    parser.add_argument('--in-place', '-i', action='store_true', help='Overwrite input files')
    args = parser.parse_args()

    files: list[Path] = []
    for p in args.paths:
        if p.is_dir():
            files.extend(sorted(p.glob('*.txt')))
        elif p.is_file():
            files.append(p)
        else:
            print(f'Warning: {p} not found, skipping', file=sys.stderr)

    if not files:
        print('No files to process', file=sys.stderr)
        return 1

    if args.output and len(files) > 1:
        print('Error: -o can only be used with a single input file', file=sys.stderr)
        return 1

    for f in files:
        raw = f.read_text(encoding='utf-8')
        cleaned = clean_kagi_text(raw)

        if args.in_place:
            out = f
        elif args.output:
            out = args.output
        else:
            out = f.with_stem(f.stem + args.suffix)

        out.write_text(cleaned, encoding='utf-8')
        pct = (1 - len(cleaned) / len(raw)) * 100 if raw else 0
        print(f'{f.name} → {out.name}  ({len(raw)} → {len(cleaned)} chars, {pct:.0f}% stripped)')

    return 0


if __name__ == '__main__':
    sys.exit(main())
