param(
  [Parameter(Mandatory=$true)][string]$Html,
  [Parameter(Mandatory=$true)][string]$Out,
  [int]$Width = 1440,
  [int]$Height = 900,
  [int]$WaitMs = 2500
)

# Chrome headless clamps the OS window to a minimum width (~500px), so
# `--window-size=390,844` silently renders at 500 CSS px and scales the capture
# down. To get a TRUE narrow layout viewport we render the page inside an
# iframe of the requested CSS width, inside a window that is at least the clamp
# minimum, then crop the iframe region out of the capture.

$chrome = @(
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $chrome) { Write-Error "No Chrome/Edge found"; exit 1 }

$htmlPath = (Resolve-Path $Html).Path
$uri = "file:///" + ($htmlPath -replace '\\','/')

$minWindow = 520
$winW = [Math]::Max($Width, $minWindow)
$winH = $Height

$work = Join-Path $env:TEMP ("shot2-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $work | Out-Null
$wrapper = Join-Path $work "wrapper.html"
$raw = Join-Path $work "raw.png"
$profile = Join-Path $work "profile"

$wrapperHtml = @"
<!doctype html>
<meta charset="utf-8">
<style>
  html, body { margin: 0; padding: 0; background: #000; }
  iframe { display: block; border: 0; width: ${Width}px; height: ${Height}px; }
</style>
<iframe src="$uri" scrolling="no"></iframe>
"@
Set-Content -LiteralPath $wrapper -Value $wrapperHtml -Encoding UTF8

$wuri = "file:///" + ($wrapper -replace '\\','/')
& $chrome --headless=new --disable-gpu --hide-scrollbars --no-sandbox `
  --allow-file-access-from-files --force-device-scale-factor=1 `
  "--user-data-dir=$profile" "--virtual-time-budget=$WaitMs" `
  "--screenshot=$raw" "--window-size=$winW,$winH" $wuri 2>$null | Out-Null
Start-Sleep -Milliseconds 600

if (-not (Test-Path $raw)) { Write-Error "screenshot failed"; exit 1 }

$outPath = if ([System.IO.Path]::IsPathRooted($Out)) { $Out } else { Join-Path (Get-Location) $Out }
$outDir = Split-Path $outPath -Parent
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

Add-Type -AssemblyName System.Drawing
$src = [System.Drawing.Bitmap]::FromFile($raw)
$cropW = [Math]::Min($Width, $src.Width)
$cropH = [Math]::Min($Height, $src.Height)
$dst = New-Object System.Drawing.Bitmap($cropW, $cropH)
$g = [System.Drawing.Graphics]::FromImage($dst)
$g.DrawImage($src, (New-Object System.Drawing.Rectangle(0, 0, $cropW, $cropH)),
             (New-Object System.Drawing.Rectangle(0, 0, $cropW, $cropH)),
             [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$dst.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$dst.Dispose(); $src.Dispose()

Write-Output ("OK {0} ({1} bytes, {2}x{3} CSS viewport via iframe)" -f `
  $outPath, (Get-Item $outPath).Length, $cropW, $cropH)

Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
