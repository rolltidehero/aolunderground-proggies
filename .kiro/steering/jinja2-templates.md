---
inclusion: always
description: Jinja2 templating rules for static site generation. Covers standalone usage, template inheritance, autoescaping, and project conventions.
---

# Jinja2 Templating — Mandatory Rules

## SETUP (Standalone, No Flask)

```python
from jinja2 import Environment, FileSystemLoader, select_autoescape

env = Environment(
    loader=FileSystemLoader('tools/templates'),
    autoescape=select_autoescape(['html']),
    trim_blocks=True,
    lstrip_blocks=True,
)
```

- `FileSystemLoader` points to `tools/templates/` directory
- `autoescape` MUST be enabled for all `.html` templates — prevents XSS
- `trim_blocks=True` — removes first newline after block tags (cleaner output)
- `lstrip_blocks=True` — strips leading whitespace before block tags

## TEMPLATE INHERITANCE (MANDATORY)

All HTML pages MUST extend a base layout:

```
tools/templates/
  base.html          # Base layout: <html>, <head>, CSS, nav, footer
  index.html         # Landing page (extends base.html)
  detail.html        # Per-proggie analysis page (extends base.html)
  macros/
    cards.html       # Reusable card components
    badges.html      # Badge rendering macros
```

### base.html pattern

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>{% block title %}AOL Proggies{% endblock %}</title>
  {% block head %}{% endblock %}
  <style>{% block css %}/* shared CSS */{% endblock %}</style>
</head>
<body>
  <div class="container">
    {% block nav %}{% endblock %}
    {% block content %}{% endblock %}
    {% block footer %}{% endblock %}
  </div>
</body>
</html>
```

### Child template pattern

```html
{% extends "base.html" %}
{% block title %}{{ proggie.name }} — Analysis{% endblock %}
{% block content %}
  {# page-specific content #}
{% endblock %}
```

## RENDERING TO FILE

```python
template = env.get_template('detail.html')
html = template.render(proggie=proggie, strings=strings)
Path(output_path).write_text(html, encoding='utf-8')
```

Never use `print()` or stdout for HTML output. Always write to file.

## RULES

### Autoescaping
- ALWAYS use `{{ variable }}` for user-derived data — Jinja2 autoescapes it
- Use `{{ html_content|safe }}` ONLY for pre-sanitized HTML you generated yourself
- NEVER use `|safe` on data from the database or user input
- Pre-rendered HTML blocks (like SVG form layouts) should be marked `|safe`

### Logic in templates
- Templates are for PRESENTATION only
- Complex logic (string classification, frequency counting, decompile data parsing)
  belongs in Python, passed to the template as pre-computed variables
- OK in templates: loops, conditionals, simple filters (`|length`, `|default`, `|sort`)
- NOT OK in templates: database queries, file I/O, regex, complex computation

### Macros for reusable components

```html
{# macros/badges.html #}
{% macro version_badge(version) %}
  <span class="badge badge-ver">AOL {{ version }}</span>
{% endmacro %}

{% macro vb_badge(vb_version) %}
  <span class="badge badge-vb">{{ vb_version }}</span>
{% endmacro %}
```

Import in templates:
```html
{% from "macros/badges.html" import version_badge, vb_badge %}
{{ version_badge(proggie.aol_version) }}
```

### Whitespace control
- Use `{%- ... -%}` to strip whitespace around block tags when needed
- `trim_blocks` and `lstrip_blocks` handle most cases automatically
- For inline elements (badges, tags), use `{%- -%}` to prevent unwanted gaps

### Comments
- Use `{# comment #}` for template comments (not rendered in output)
- Document non-obvious template logic with comments
- Never use HTML comments `<!-- -->` for dev notes (they ship to users)

### Filters reference (commonly used)
- `{{ s|e }}` — explicit HTML escape (redundant with autoescape, but explicit)
- `{{ s|safe }}` — mark as safe (skip autoescaping)
- `{{ s|default('Unknown') }}` — fallback value
- `{{ items|length }}` — count
- `{{ items|sort(attribute='name') }}` — sort by attribute
- `{{ s|truncate(80) }}` — truncate with ellipsis
- `{{ n|int }}` — cast to integer
- `{{ path|urlencode }}` — URL-encode for href attributes

### Custom filters
Register in Python, not in templates:
```python
def format_size(bytes):
    for unit in ['B', 'KB', 'MB']:
        if bytes < 1024: return f"{bytes:.0f} {unit}"
        bytes /= 1024
    return f"{bytes:.1f} GB"

env.filters['filesize'] = format_size
```

Then in template: `{{ file.size|filesize }}`

## STATIC SITE GENERATION PATTERN

The site generator script (`generate_analysis.py` or successor) should:

1. Set up Jinja2 `Environment` with `FileSystemLoader`
2. Query both databases (proggie_db.sqlite + exe_strings.db)
3. Pre-compute all template data in Python (not in templates)
4. Render each template to a file
5. Auto-detect featured proggies (has screenshots + decompiled source)
6. Generate landing page (`index.html`) with featured items
7. Generate all detail pages with consistent nav + download links
8. Report counts: generated, skipped, errors

## URL CONVENTIONS

- Landing page: `index.html` (repo root)
- Search/browse: `proggie-index.html` (repo root)
- Detail pages: `programs/AOL/proggies-sorted-deduped/<version>/<stem>.html`
- Assets: `programs/AOL/proggies-sorted-deduped/<version>/<stem>/` (screenshots, source)
- Zip downloads: GitHub raw URL `https://github.com/ssstonebraker/aolunderground-proggies/raw/reorganize/<zip_path>`
- Relative path from detail page to root: `../../../../`
