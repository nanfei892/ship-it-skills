# measure.ps1 — report the real computed layout of a page at any viewport width,
# without taking or reading a screenshot.
#
# Why this exists: headless Chrome clamps an OS window to a minimum width (~500px),
# so `--window-size=390,844` lays the page out at 500 CSS px and scales the capture
# down. Every narrow-width media query below 500px therefore stays inactive while
# the PNG still measures 390px. This script avoids the problem by embedding the
# page in a fixed-width iframe, which gets a true layout viewport of its own, and
# reads measurements back out of the DOM instead of out of pixels.
#
# usage:
#   pwsh -File measure.ps1 -Html path\to\index.html -Width 390
#   pwsh -File measure.ps1 -Html path\to\index.html -Width 390 -Height 844

param(
  [Parameter(Mandatory = $true)][string]$Html,
  [int]$Width = 390,
  [int]$Height = 844,
  [int]$WaitMs = 5000
)

$chrome = @(
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $chrome) { Write-Error "No Chrome or Edge found"; exit 1 }

$work = Join-Path $env:TEMP ("measure-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $work | Out-Null

# --- the probe, injected into the page and posting its report to the parent ---
$probe = @'
(function () {
  function mq(q) { return window.matchMedia(q).matches ? 'MATCH' : 'no'; }
  function box(sel) {
    var e = document.querySelector(sel);
    if (!e) return null;
    var b = e.getBoundingClientRect(), cs = getComputedStyle(e);
    return sel + ' x=' + Math.round(b.x) + ' y=' + Math.round(b.y) +
      ' w=' + Math.round(b.width) + ' h=' + Math.round(b.height) +
      ' pos=' + cs.position + ' disp=' + cs.display;
  }
  function run() {
    var L = [];
    L.push('VIEWPORT ' + window.innerWidth + 'x' + window.innerHeight +
           '  (devicePixelRatio ' + window.devicePixelRatio + ')');
    L.push('document scrollWidth=' + document.documentElement.scrollWidth +
           '  horizontal overflow=' +
           (document.documentElement.scrollWidth - window.innerWidth) + 'px');
    L.push('document scrollHeight=' + document.documentElement.scrollHeight);
    L.push('media (max-width:500px): ' + mq('(max-width:500px)') +
           '   (max-width:400px): ' + mq('(max-width:400px)'));
    L.push('');
    ['body','header','nav','main','footer','.app','.workspace','.rail','.filtersheet',
     '.station','.queue','.panel','.detail','.rail-sel','.page','.wrap','.hero','.card',
     'article','.log','.sheet'].forEach(function (s) {
      var line = box(s);
      if (line) L.push(line);
    });
    var ws = document.querySelector('.workspace');
    if (ws) L.push('workspace grid-template-columns: ' +
                   getComputedStyle(ws).gridTemplateColumns);

    var over = [];
    document.querySelectorAll('*').forEach(function (e) {
      var b = e.getBoundingClientRect();
      if (b.width > 0 && (b.right > window.innerWidth + 0.5 || b.left < -0.5)) {
        over.push(e.tagName.toLowerCase() + '.' + (e.className || '-') +
                  ' left=' + Math.round(b.left) + ' right=' + Math.round(b.right));
      }
    });
    L.push('');
    L.push('ELEMENTS OVERFLOWING HORIZONTALLY: ' + over.length);
    over.slice(0, 15).forEach(function (o) { L.push('   ' + o); });

    var small = null;
    document.querySelectorAll('p,span,li,td,th,label,a,button,div,h1,h2,h3').forEach(function (e) {
      if (!e.textContent.trim()) return;
      var fs = parseFloat(getComputedStyle(e).fontSize);
      if (!small || fs < small.fs) small = { fs: fs, t: e.textContent.trim().slice(0, 24) };
    });
    L.push('');
    L.push('smallest rendered text: ' + (small ? small.fs + 'px  "' + small.t + '"' : 'n/a'));

    var minHit = null;
    document.querySelectorAll('button,a,input,select,textarea,[role=button]').forEach(function (e) {
      var b = e.getBoundingClientRect();
      if (b.width === 0 || b.height === 0) return;
      var m = Math.min(b.width, b.height);
      if (!minHit || m < minHit.m) {
        minHit = { m: Math.round(m), t: (e.textContent.trim() || e.tagName).slice(0, 24) };
      }
    });
    L.push('smallest interactive dimension: ' +
           (minHit ? minHit.m + 'px  "' + minHit.t + '"' : 'n/a'));

    var allCount = 0, declared = 0;
    document.querySelectorAll('*').forEach(function (e) {
      var cs = getComputedStyle(e);
      if (cs.transitionProperty === 'all' && parseFloat(cs.transitionDuration) > 0) allCount++;
    });
    L.push('elements with an ACTIVE transition:all: ' + allCount);

    var fixed = 0;
    document.querySelectorAll('*').forEach(function (e) {
      if (getComputedStyle(e).position === 'fixed') fixed++;
    });
    L.push('position:fixed elements: ' + fixed);

    try { parent.postMessage('@@REPORT@@' + L.join('\n'), '*'); } catch (e) {}
  }
  if (document.readyState === 'complete') setTimeout(run, 900);
  else window.addEventListener('load', function () { setTimeout(run, 900); });
})();
'@

# --- patch a copy of the page with the probe ---
$src = Get-Content -LiteralPath $Html -Raw
$patched = if ($src -match '(?i)</body>') { $src -replace '(?i)</body>', "<script>$probe</script></body>" }
           else { $src + "<script>$probe</script>" }
$patchedPath = Join-Path $work 'target.html'
Set-Content -LiteralPath $patchedPath -Value $patched -Encoding UTF8

$targetUri = "file:///" + ($patchedPath -replace '\\', '/')

# --- wrapper: fixed-width iframe + a <pre> the parent fills from postMessage ---
$wrapperPath = Join-Path $work 'wrapper.html'
$wrapper = @"
<!doctype html>
<meta charset="utf-8">
<title>measure</title>
<style>
  html, body { margin: 0; background: #fff; }
  iframe { display: block; border: 0; width: ${Width}px; height: ${Height}px; }
  #REPORT { font: 12px/1.45 monospace; white-space: pre-wrap; margin: 0; padding: 6px; }
</style>
<pre id="REPORT">pending…</pre>
<iframe src="$targetUri" scrolling="no"></iframe>
<script>
  window.addEventListener('message', function (e) {
    var d = String(e.data || '');
    if (d.indexOf('@@REPORT@@') === 0) {
      document.getElementById('REPORT').textContent = d.slice(10);
    }
  });
</script>
"@
Set-Content -LiteralPath $wrapperPath -Value $wrapper -Encoding UTF8

$wrapperUri = "file:///" + ($wrapperPath -replace '\\', '/')
$dump = Join-Path $work 'dom.txt'

& $chrome --headless=new --disable-gpu --no-sandbox --allow-file-access-from-files `
  "--user-data-dir=$(Join-Path $work 'profile')" "--window-size=900,$Height" `
  "--virtual-time-budget=$WaitMs" --dump-dom $wrapperUri 2>$null |
  Out-File -LiteralPath $dump -Encoding utf8

$dom = if (Test-Path $dump) { Get-Content -LiteralPath $dump -Raw } else { '' }
$m = [regex]::Match($dom, '(?s)<pre id="REPORT"[^>]*>(.*?)</pre>')
if ($m.Success) {
  $m.Groups[1].Value -replace '&lt;', '<' -replace '&gt;', '>' -replace '&amp;', '&' -replace '&quot;', '"'
} else {
  Write-Output "Could not read the report back (DOM was $($dom.Length) chars)."
}

Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
