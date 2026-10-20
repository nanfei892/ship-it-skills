# preflight.ps1 — check that this repository is ready to publish, before you publish.
#
# Everything here is a fact that can be verified, not an opinion. It answers:
#   - is the working tree clean and in sync with origin?
#   - does every SKILL.md have valid frontmatter, and is the description a sane length?
#   - what users install from the marketplace (raw master SKILL.md) actually the file here?
#   - do all relative links in the docs resolve, and are all referenced images present?
#   - is any scratch/verification leftover about to be committed?
#   - what does the marketplace record currently say, vs. what we intend to submit?
#
# usage:  pwsh -File preflight.ps1
#         pwsh -File preflight.ps1 -SkipRemote      (offline: skip GitHub/registry checks)

param([switch]$SkipRemote)

$ErrorActionPreference = 'Continue'
$fail = 0
$warn = 0

function Ok   ($m) { Write-Host "  [ok]   $m" }
function Bad  ($m) { Write-Host "  [FAIL] $m" -ForegroundColor Red;    $script:fail++ }
function Warn ($m) { Write-Host "  [warn] $m" -ForegroundColor Yellow; $script:warn++ }
function Head ($m) { Write-Host ""; Write-Host "== $m ==" }

# ---------------------------------------------------------------- git state
Head 'git'
$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) { Ok 'working tree clean' } else { Bad "uncommitted changes:`n$status" }

$local = git rev-parse HEAD
$remote = git rev-parse origin/master 2>$null
if ($local -eq $remote) {
    Ok "in sync with origin/master ($($local.Substring(0,7)))"
} else {
    Bad "local $($local.Substring(0,7)) != origin/master $($remote.Substring(0,7)) - push or pull first"
}

# ---------------------------------------------------------------- frontmatter
Head 'SKILL.md frontmatter'
$skills = Get-ChildItem -Directory | Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }
Write-Host "  found $($skills.Count) skills: $(($skills.Name) -join ', ')"
foreach ($s in $skills) {
    $path = Join-Path $s.FullName 'SKILL.md'
    $raw = Get-Content -LiteralPath $path -Raw
    $fm = [regex]::Match($raw, '(?s)\A---\r?\n(.*?)\r?\n---')
    if (-not $fm.Success) { Bad "$($s.Name): no YAML frontmatter block at the top"; continue }

    $block = $fm.Groups[1].Value
    $name = [regex]::Match($block, '(?m)^name:\s*(.+)$').Groups[1].Value.Trim()
    $desc = [regex]::Match($block, '(?ms)^description:\s*(.+?)(?=\r?\n[a-zA-Z_]+:|\z)').Groups[1].Value.Trim()

    if (-not $name) { Bad "$($s.Name): frontmatter has no name" }
    elseif ($name -ne $s.Name) { Bad "$($s.Name): name '$name' does not match directory" }
    if (-not $desc) { Bad "$($s.Name): frontmatter has no description" }

    if ($desc.Length -gt 1024) { Bad "$($s.Name): description is $($desc.Length) chars, over the 1024 convention limit" }
    elseif ($desc.Length -lt 60) { Warn "$($s.Name): description is only $($desc.Length) chars - may under-trigger" }
    else { Ok "$($s.Name): name ok, description $($desc.Length) chars" }
}

# line endings / BOM on the skill people install
$mi = Join-Path 'make-ui-not-ai' 'SKILL.md'
$bytes = [System.IO.File]::ReadAllBytes($mi)
$bom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
$crlf = 0; $lf = 0
for ($i = 0; $i -lt $bytes.Length; $i++) {
    if ($bytes[$i] -eq 10) { if ($i -gt 0 -and $bytes[$i - 1] -eq 13) { $crlf++ } else { $lf++ } }
}
if ($bom) { Warn 'make-ui-not-ai/SKILL.md starts with a UTF-8 BOM' } else { Ok 'no BOM' }
if ($crlf -gt 0 -and $lf -gt 0) { Warn "mixed line endings ($crlf CRLF, $lf bare LF)" }
else { Ok "consistent line endings (CRLF $crlf / bare LF $lf)" }
Write-Host "  make-ui-not-ai/SKILL.md: $($bytes.Length) bytes, $((Get-Content $mi).Count) lines"

# ---------------------------------------------------------------- docs links
Head 'documentation links and images'
$mdFiles = Get-ChildItem -Recurse -File -Filter '*.md' | Where-Object { $_.FullName -notmatch '\\\.git\\' }
$badLinks = 0
foreach ($f in $mdFiles) {
    $md = Get-Content -LiteralPath $f.FullName -Raw
    $base = $f.Directory.FullName
    # relative link targets only; skip in-page anchors and absolute URLs
    foreach ($m in [regex]::Matches($md, '\]\((?!https?:|mailto:|#)([^)#\s]+)')) {
        $rel = $m.Groups[1].Value
        $target = Join-Path $base $rel
        if (-not (Test-Path -LiteralPath $target)) {
            Bad "$($f.Name): broken relative link -> $rel"
            $badLinks++
        }
    }
}
if ($badLinks -eq 0) { Ok "all relative links resolve across $($mdFiles.Count) markdown files" }

# images can also be referenced with raw HTML, which the markdown link pattern misses
$badImg = 0
foreach ($f in $mdFiles) {
    $md = Get-Content -LiteralPath $f.FullName -Raw
    $base = $f.Directory.FullName
    foreach ($m in [regex]::Matches($md, '(?i)<img\s[^>]*src="(?!https?:)([^"]+)"')) {
        $rel = $m.Groups[1].Value
        if (-not (Test-Path -LiteralPath (Join-Path $base $rel))) {
            Bad "$($f.Name): broken image src -> $rel"
            $badImg++
        }
    }
}
if ($badImg -eq 0) { Ok 'all inline HTML image sources resolve' }

# ---------------------------------------------------------------- leftovers
Head 'scratch artifacts'
$patterns = @('_probe*', '_m-*', '_clamp*', '_vp*', '_frame-*', 'own-*.png', '_shots', '_verify', 'lab3', 'showcase-lab-b', 'skill-showcase-lab')
$found = @()
foreach ($p in $patterns) {
    $hits = Get-ChildItem -Recurse -Force -Filter $p -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -notmatch '\\\.git\\' }
    foreach ($h in $hits) { $found += $h.FullName.Replace((Get-Location).Path + '\', '') }
}
if ($found.Count -eq 0) { Ok 'no verification scratch files present' }
else { Bad "scratch files present:`n    $($found -join "`n    ")" }

# ---------------------------------------------------------------- family install sources
if (-not $SkipRemote) {
    Head 'family install sources'
    $ua0 = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'
    function Normalize([string]$s) { ($s -replace "`r`n", "`n").TrimEnd() }
    function ShaOf([string]$s) {
        $b = [System.Text.Encoding]::UTF8.GetBytes($s)
        (([System.Security.Cryptography.SHA256]::Create().ComputeHash($b)) | ForEach-Object { $_.ToString('x2') }) -join ''
    }
    foreach ($s in $skills) {
        $url = "https://raw.githubusercontent.com/nanfei892/ship-it-skills/master/$($s.Name)/SKILL.md"
        try {
            $live = Normalize (Invoke-WebRequest -Uri $url -Headers @{ 'User-Agent' = $ua0 } -UseBasicParsing).Content
            $mineTxt = Normalize (Get-Content -LiteralPath (Join-Path $s.FullName 'SKILL.md') -Raw)
            if ((ShaOf $live) -eq (ShaOf $mineTxt)) {
                Ok "$($s.Name): install source matches this repo"
            } else {
                Warn "$($s.Name): install source differs from this repo ($($live.Length) vs $($mineTxt.Length) chars) - the registry may be serving a stale copy"
            }
        } catch {
            Bad "$($s.Name): install source unreachable ($url)"
        }
    }

    # a package may be registered under a different handle or a renamed repo; GitHub
    # redirects, so installs still work, but it is untidy and worth knowing about
    try {
        $pkgs = (Invoke-RestMethod -Uri 'https://crash.reasonix.io/v1/packages?kind=skill&limit=100' `
                   -Headers @{ 'User-Agent' = $ua0 }).packages
        $ours = $pkgs | Where-Object { $_.handle -in @('nanfei892', '1981094442') }
        foreach ($p in $ours) {
            $det = Invoke-RestMethod -Uri "https://crash.reasonix.io/v1/packages/$($p.handle)/$($p.name)" `
                     -Headers @{ 'User-Agent' = $ua0 }
            $v = $det.versions | Where-Object { $_.version -eq $p.latestVersion } | Select-Object -First 1
            $src = if ($v) { $v.source } else { $det.versions[0].source }
            $issues = @()
            if ($p.handle -ne 'nanfei892') { $issues += "handle is '$($p.handle)'" }
            if ($src -notmatch '/ship-it-skills/') { $issues += "source uses an old repo path" }
            if ($issues.Count -eq 0) {
                Ok "$($p.name): registered under nanfei892, source current"
            } else {
                Warn "$($p.name) [$($p.installCount) installs]: $($issues -join '; ') - installs still resolve via GitHub redirect, so this is tidiness, not breakage"
            }
        }
    } catch {
        Warn "could not list registry packages: $($_.Exception.Message)"
    }
}

# ---------------------------------------------------------------- marketplace
if (-not $SkipRemote) {
    Head 'marketplace and install source'
    $ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'
    try {
        $pkg = (Invoke-RestMethod -Uri 'https://crash.reasonix.io/v1/packages/nanfei892/make-ui-not-ai' `
                 -Headers @{ 'User-Agent' = $ua }).package
        Write-Host "  installs=$($pkg.installCount)  stars=$($pkg.starCount)  score=$([Math]::Round($pkg.score,3))  status=$($pkg.status)"
        Write-Host "  summary: $($pkg.summary.Length) chars, tags: $($pkg.tags.Count), latestVersion: $($pkg.latestVersion)"
        if ($pkg.summary.Length -lt 100) { Warn "summary is only $($pkg.summary.Length) chars - the prepared copy in skill-showcase/MARKET-LISTING.md is 133" }
        if ($pkg.tags.Count -lt 8)       { Warn "only $($pkg.tags.Count) tags - the prepared set is 10" }

        # does what users install match the file in this repo?
        $live = (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/nanfei892/ship-it-skills/master/make-ui-not-ai/SKILL.md' `
                   -Headers @{ 'User-Agent' = $ua } -UseBasicParsing).Content
        $mine = Get-Content -LiteralPath $mi -Raw
        if ($live -eq $mine) {
            Ok "install source serves exactly this repo's SKILL.md ($($live.Length) chars)"
        } elseif ($pkg.source -match 'make-ui-not-ai/SKILL\.md$') {
            Bad "install source differs from the local file (live $($live.Length) chars vs local $($mine.Length)) - push, or the registry is serving a snapshot"
        } else {
            Warn "install source points elsewhere: $($pkg.source)"
        }
    } catch {
        Warn "could not reach the marketplace: $($_.Exception.Message)"
    }
}

# ---------------------------------------------------------------- verdict
Head 'verdict'
if ($fail -eq 0) {
    Write-Host "  READY: no blocking problems." -ForegroundColor Green
    if ($warn -gt 0) { Write-Host "  $warn warning(s) above are advisory, not blockers." -ForegroundColor Yellow }
    exit 0
} else {
    Write-Host "  NOT READY: $fail blocking problem(s), $warn warning(s)." -ForegroundColor Red
    exit 1
}
