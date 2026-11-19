param(
    [string]$Target = "resume"
)

$ErrorActionPreference = "Stop"

$RootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SrcDir = Join-Path $RootDir "src"
$BuildDir = Join-Path $RootDir ".build"
$TexFile = "$Target.tex"
$BuiltPdf = Join-Path $BuildDir "$Target.pdf"
$OutPdf = Join-Path $SrcDir "$Target.pdf"

if (-not (Test-Path (Join-Path $SrcDir $TexFile))) {
    Write-Error "File not found: src/$TexFile"
    exit 1
}

$LuaCmd = Get-Command lualatex -ErrorAction SilentlyContinue
if ($LuaCmd) {
    $LuaLatex = $LuaCmd.Source
} elseif (Test-Path "$env:APPDATA\TinyTeX\bin\windows\lualatex.exe") {
    $LuaLatex = "$env:APPDATA\TinyTeX\bin\windows\lualatex.exe"
} else {
    Write-Error "lualatex not found in PATH or $env:APPDATA\TinyTeX\bin\windows\lualatex.exe"
    exit 1
}

New-Item -ItemType Directory -Force -Path $BuildDir | Out-Null

Push-Location $SrcDir
try {
    for ($pass = 1; $pass -le 2; $pass++) {
        & $LuaLatex -interaction=nonstopmode -halt-on-error "-output-directory=$BuildDir" $TexFile
        if ($LASTEXITCODE -ne 0) {
            throw "LuaLaTeX pass $pass failed (exit code $LASTEXITCODE)."
        }
    }

    if (-not (Test-Path $BuiltPdf)) {
        throw "Expected compiled PDF at $BuiltPdf, but it was not generated."
    }

    try {
        Copy-Item -Force -Path $BuiltPdf -Destination $OutPdf -ErrorAction Stop
    } catch {
        throw "Could not update src/$Target.pdf (close it in Adobe Acrobat / PDF viewer and retry)."
    }
} finally {
    Pop-Location
    if (Test-Path $BuildDir) {
        Remove-Item -Recurse -Force $BuildDir -ErrorAction SilentlyContinue
    }
}

Write-Host "Built cleanly: src/$Target.pdf (zero temp files left in src/)" -ForegroundColor Green
