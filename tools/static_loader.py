"""Load static CSS/JS assets for HTML generators.

Single utility for all generators to load CSS and JS files from static/.
Avoids hardcoded CSS/JS strings in Python (separation of concerns).

Usage:
    from static_loader import load_css, load_js, css_tag, js_tag

    # Inline the CSS into the page:
    html = f'<style>{load_css("analysis.css")}</style>'

    # Or link to external file (for pages that can reference static/):
    html = css_tag("analysis.css", rel_path="../../../../static")
"""
from pathlib import Path

__all__ = ['load_css', 'load_js', 'css_tag', 'js_tag', 'STATIC_DIR']

STATIC_DIR = Path(__file__).resolve().parent.parent / 'static'
_CSS_DIR = STATIC_DIR / 'css'
_JS_DIR = STATIC_DIR / 'js'


def load_css(name: str) -> str:
    """Load a CSS file from static/css/ and return its content.

    Args:
        name: Filename (e.g., 'analysis.css').

    Returns:
        CSS content as a string.

    Raises:
        FileNotFoundError: If the CSS file doesn't exist.
    """
    path = _CSS_DIR / name
    if not path.exists():
        raise FileNotFoundError(f"CSS file not found: {path}")
    return path.read_text(encoding='utf-8')


def load_js(name: str) -> str:
    """Load a JS file from static/js/ and return its content.

    Args:
        name: Filename (e.g., 'app-simulator.js').

    Returns:
        JS content as a string.

    Raises:
        FileNotFoundError: If the JS file doesn't exist.
    """
    path = _JS_DIR / name
    if not path.exists():
        raise FileNotFoundError(f"JS file not found: {path}")
    return path.read_text(encoding='utf-8')


def css_tag(name: str, rel_path: str = 'static') -> str:
    """Generate an HTML <link> tag for a CSS file.

    Args:
        name: CSS filename (e.g., 'analysis.css').
        rel_path: Relative path from HTML output to static/ directory.

    Returns:
        HTML link tag string.
    """
    return f'<link rel="stylesheet" href="{rel_path}/css/{name}">'


def js_tag(name: str, rel_path: str = 'static') -> str:
    """Generate an HTML <script> tag for a JS file.

    Args:
        name: JS filename (e.g., 'app-simulator.js').
        rel_path: Relative path from HTML output to static/ directory.

    Returns:
        HTML script tag string.
    """
    return f'<script src="{rel_path}/js/{name}"></script>'
