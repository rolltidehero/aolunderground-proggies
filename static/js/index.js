/* Proggie index — filter, sort, and render the proggies table.
 * Expects: GITHUB_RAW (string) and proggies (array) defined before this script loads.
 */
const versions = new Set();
proggies.forEach(function(p) { versions.add(p.primary); });
const vf = document.getElementById('version-filter');
Array.from(versions).sort().forEach(function(v) { var o = document.createElement('option'); o.value = v; o.textContent = v; vf.appendChild(o); });

var sortCol = null, sortAsc = true;
var chipSrc = false, chipImg = false;

function toggleChip(which) {
  if (which === 'src') { chipSrc = !chipSrc; document.getElementById('chip-src').classList.toggle('active-src'); }
  if (which === 'img') { chipImg = !chipImg; document.getElementById('chip-img').classList.toggle('active-img'); }
  doFilter();
}

function render(list) {
  var tb = document.getElementById('results');
  tb.innerHTML = '';
  list.forEach(function(p) {
    var r = tb.insertRow();
    var nc = r.insertCell(0);
    if (p.html) { var na = document.createElement('a'); na.href = p.html; na.textContent = p.name; nc.appendChild(na); }
    else { nc.textContent = p.name; }
    if (p.has_source) { var b = document.createElement('span'); b.className='badge badge-src'; b.textContent='src'; nc.appendChild(b); }
    if (p.has_screenshot) { var b = document.createElement('span'); b.className='badge badge-img'; b.textContent='img'; nc.appendChild(b); }
    r.insertCell(1).textContent = p.author;
    var pc = r.insertCell(2); pc.textContent = p.platform; if(p.platform==='AIM') pc.className='aim';
    r.insertCell(3).textContent = p.primary;
    var vc = r.insertCell(4); vc.textContent = p.vb_version; if(p.vb_version && p.vb_version !== 'unknown') { vc.innerHTML = '<span class="badge badge-vb">' + p.vb_version + '</span>'; }
    var fc = r.insertCell(5); var a = document.createElement('a'); a.href = GITHUB_RAW + p.file; a.textContent = p.file.split('/').pop(); a.className='dl'; fc.appendChild(a);
    var pw = r.insertCell(6); pw.textContent = p.password; if(p.password) pw.className='password';
  });
  document.getElementById('showing').textContent = list.length;
}

function doFilter() {
  var s = document.getElementById('search').value.toLowerCase();
  var pf = document.getElementById('platform-filter').value;
  var vfv = document.getElementById('version-filter').value;
  var list = proggies.filter(function(p) {
    return (!s || p.name.toLowerCase().includes(s) || p.author.toLowerCase().includes(s) || p.file.toLowerCase().includes(s)) &&
      (!pf || p.platform === pf) &&
      (!vfv || p.primary === vfv) &&
      (!chipSrc || p.has_source) &&
      (!chipImg || p.has_screenshot);
  });
  if (sortCol) {
    list = list.slice().sort(function(a, b) {
      var va = (a[sortCol] || '').toString().toLowerCase();
      var vb = (b[sortCol] || '').toString().toLowerCase();
      if (va < vb) return sortAsc ? -1 : 1;
      if (va > vb) return sortAsc ? 1 : -1;
      return 0;
    });
  }
  render(list);
}

document.querySelectorAll('th[data-col]').forEach(function(th) {
  th.addEventListener('click', function() {
    var col = th.dataset.col;
    if (sortCol === col) { sortAsc = !sortAsc; } else { sortCol = col; sortAsc = true; }
    document.querySelectorAll('th .arrow').forEach(function(a) { a.textContent = ''; });
    th.querySelector('.arrow').textContent = sortAsc ? ' \u25B2' : ' \u25BC';
    doFilter();
  });
});

document.getElementById('search').addEventListener('input', doFilter);
document.getElementById('platform-filter').addEventListener('change', doFilter);
document.getElementById('version-filter').addEventListener('change', doFilter);
doFilter();
