"""Tests for tools/static_loader.py — CSS/JS asset loading utility."""
import pytest
from pathlib import Path


# Import from tools directory
import sys
sys.path.insert(0, str(Path(__file__).resolve().parent.parent / 'tools'))
from static_loader import load_css, load_js, css_tag, js_tag, STATIC_DIR


class TestLoadCss:
    """Tests for load_css()."""

    def test_loads_existing_css(self):
        """load_css should return content of a known CSS file."""
        content = load_css('analysis.css')
        assert isinstance(content, str)
        assert len(content) > 100
        assert 'body' in content
        assert '{' in content  # has CSS rules

    def test_loads_app_simulator_css(self):
        content = load_css('app-simulator.css')
        assert '.app-sim' in content
        assert '.app-label' in content

    def test_loads_tab_explorer_css(self):
        content = load_css('tab-explorer.css')
        assert '.walkthrough-explorer' in content
        assert '.wt-tab' in content

    def test_loads_aohell_css(self):
        content = load_css('aohell.css')
        assert '.kw' in content  # syntax highlighting class
        assert 'Courier New' in content

    def test_loads_slipstream_css(self):
        content = load_css('slipstream.css')
        assert '#00ccff' in content  # cyan theme

    def test_loads_index_css(self):
        content = load_css('index.css')
        assert '.chip' in content

    def test_raises_on_missing_file(self):
        """load_css should raise FileNotFoundError for nonexistent file."""
        with pytest.raises(FileNotFoundError, match='nonexistent'):
            load_css('nonexistent.css')

    def test_raises_on_empty_name(self):
        with pytest.raises((FileNotFoundError, IsADirectoryError)):
            load_css('')

    def test_no_path_traversal(self):
        """Pathlib resolves traversal but the file won't exist."""
        with pytest.raises(FileNotFoundError):
            load_css('../../etc/passwd')

    def test_returns_string_not_bytes(self):
        content = load_css('analysis.css')
        assert isinstance(content, str)
        assert not isinstance(content, bytes)


class TestLoadJs:
    """Tests for load_js()."""

    def test_loads_existing_js(self):
        content = load_js('app-simulator.js')
        assert isinstance(content, str)
        assert 'function' in content

    def test_loads_tab_explorer_js(self):
        content = load_js('tab-explorer.js')
        assert 'wtTab' in content
        assert 'wtShow' in content

    def test_loads_index_js(self):
        content = load_js('index.js')
        assert 'doFilter' in content
        assert 'proggies' in content

    def test_raises_on_missing_file(self):
        with pytest.raises(FileNotFoundError, match='nonexistent'):
            load_js('nonexistent.js')


class TestCssTag:
    """Tests for css_tag()."""

    def test_default_rel_path(self):
        tag = css_tag('analysis.css')
        assert tag == '<link rel="stylesheet" href="static/css/analysis.css">'

    def test_custom_rel_path(self):
        tag = css_tag('analysis.css', rel_path='../../../../static')
        assert 'href="../../../../static/css/analysis.css"' in tag

    def test_is_valid_html(self):
        tag = css_tag('test.css')
        assert tag.startswith('<link')
        assert 'rel="stylesheet"' in tag


class TestJsTag:
    """Tests for js_tag()."""

    def test_default_rel_path(self):
        tag = js_tag('app-simulator.js')
        assert tag == '<script src="static/js/app-simulator.js"></script>'

    def test_custom_rel_path(self):
        tag = js_tag('index.js', rel_path='../static')
        assert 'src="../static/js/index.js"' in tag


class TestStaticDir:
    """Tests for STATIC_DIR constant."""

    def test_static_dir_exists(self):
        assert STATIC_DIR.exists()
        assert STATIC_DIR.is_dir()

    def test_static_dir_has_css_subdir(self):
        assert (STATIC_DIR / 'css').exists()

    def test_static_dir_has_js_subdir(self):
        assert (STATIC_DIR / 'js').exists()

    def test_css_files_present(self):
        """All expected CSS files must exist."""
        expected = ['analysis.css', 'app-simulator.css', 'tab-explorer.css',
                    'aohell.css', 'slipstream.css', 'index.css']
        for name in expected:
            assert (STATIC_DIR / 'css' / name).exists(), f'Missing: {name}'

    def test_js_files_present(self):
        """All expected JS files must exist."""
        expected = ['app-simulator.js', 'tab-explorer.js', 'index.js']
        for name in expected:
            assert (STATIC_DIR / 'js' / name).exists(), f'Missing: {name}'


class TestCssContent:
    """Validate CSS files don't have obvious issues."""

    @pytest.mark.parametrize('name', [
        'analysis.css', 'app-simulator.css', 'tab-explorer.css',
        'aohell.css', 'slipstream.css', 'index.css',
    ])
    def test_no_python_artifacts(self, name):
        """CSS should not contain Python f-string artifacts like {load_css(...)}."""
        content = load_css(name)
        assert 'load_css' not in content, f'{name} contains Python reference'
        assert 'load_js' not in content, f'{name} contains Python reference'
        assert 'f"' not in content, f'{name} contains Python f-string'

    @pytest.mark.parametrize('name', [
        'analysis.css', 'app-simulator.css', 'tab-explorer.css',
        'aohell.css', 'slipstream.css', 'index.css',
    ])
    def test_balanced_braces(self, name):
        """CSS should have balanced braces."""
        content = load_css(name)
        assert content.count('{') == content.count('}'), f'{name} has unbalanced braces'


class TestJsContent:
    """Validate JS files don't have obvious issues."""

    @pytest.mark.parametrize('name', ['app-simulator.js', 'tab-explorer.js', 'index.js'])
    def test_no_python_escaping(self, name):
        content = load_js(name)
        # JS can have template literals with ${} but not Python {load_css(...)}
        assert 'load_css' not in content, f'{name} contains Python reference'
        assert 'load_js' not in content, f'{name} contains Python reference'

    @pytest.mark.parametrize('name', ['app-simulator.js', 'tab-explorer.js', 'index.js'])
    def test_has_function_keyword(self, name):
        """JS files should contain actual JavaScript."""
        content = load_js(name)
        assert 'function' in content, f'{name} does not look like JavaScript'
