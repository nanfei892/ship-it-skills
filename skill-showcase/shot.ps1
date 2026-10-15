param(
  [Parameter(Mandatory=$true)][string]$Html,
  [Parameter(Mandatory=$true)][string]$Out,
  [int]$Width = 1440,
  [int]$Height = 900,
  [switch]$FullPage
)

$chrome = @(
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $chrome) { Write-Error "No Chrome/Edge found"; exit 1 }

$htmlPath = (Resolve-Path $Html).Path
$outDir = Split-Path $Out -Parent
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
$outPath = if ([System.IO.Path]::IsPathRooted($Out)) { $Out } else { Join-Path (Get-Location) $Out }

$uri = "file:///" + ($htmlPath -replace '\\','/')
$size = "$Width,$Height"

$args = @(
  "--headless=new", "--disable-gpu", "--hide-scrollbars",
  "--force-device-scale-factor=1",
  "--virtual-time-budget=4000",
  "--screenshot=$outPath", "--window-size=$size"
)
if ($FullPage) { $args += "--screenshot-format=png" }

& $chrome @args $uri 2>$null | Out-Null
Start-Sleep -Milliseconds 800

if (Test-Path $outPath) {
  $len = (Get-Item $outPath).Length
  Write-Output "OK $outPath ($len bytes, ${Width}x${Height})"
} else {
  Write-Error "screenshot failed: $outPath"
  exit 1
}
