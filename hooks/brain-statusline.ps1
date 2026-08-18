# brain — statusline badge script for Claude Code (Windows)
# Shows [BRAIN] when a wiki is found at the resolved location, plus a real
# project count read from the wiki at render time. Renders nothing (exit 0)
# when no wiki exists yet — safe on fresh installs.
#
# Usage in %USERPROFILE%\.claude\settings.json:
#   "statusLine": { "type": "command", "command": "powershell -ExecutionPolicy Bypass -File C:\path\to\brain-statusline.ps1" }
#
# Plugin users: Claude will offer to set this up on first session.
# Standalone users: add the line above to settings.json yourself.

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Wiki location: same default as the brain skill (~/brain). Override with
# $env:BRAIN_WIKI_DIR if your wiki lives elsewhere.
$WikiDir = if ($env:BRAIN_WIKI_DIR) { $env:BRAIN_WIKI_DIR } else { Join-Path $HOME "brain" }
$Schema = Join-Path $WikiDir "CLAUDE.md"

# Refuse reparse points (symlinks/junctions) on the wiki root and its schema
# file — a local attacker could point either at an arbitrary path. We never
# echo file contents (only numbers we compute ourselves), but the read
# itself must still refuse to follow a reparse point out of the wiki.
try {
    $WikiItem = Get-Item -LiteralPath $WikiDir -Force -ErrorAction Stop
    if ($WikiItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) { exit 0 }
} catch {
    exit 0
}

try {
    $SchemaItem = Get-Item -LiteralPath $Schema -Force -ErrorAction Stop
    if ($SchemaItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) { exit 0 }
    if ($SchemaItem.Length -gt 65536) { exit 0 }
} catch {
    exit 0
}

$Esc = [char]27
[Console]::Write("${Esc}[38;5;110m[BRAIN]${Esc}[0m")

# Optional project count: a real, cheap count of projects/*.md, taken fresh
# every render — never a cached or estimated number. Skipped entirely, not
# shown as 0, if the directory is missing, a reparse point, or empty.
$ProjectsDir = Join-Path $WikiDir "projects"
try {
    if (Test-Path -LiteralPath $ProjectsDir) {
        $ProjectsItem = Get-Item -LiteralPath $ProjectsDir -Force -ErrorAction Stop
        if (-not ($ProjectsItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
            $Count = (Get-ChildItem -LiteralPath $ProjectsDir -Filter '*.md' -File -ErrorAction Stop | Measure-Object).Count
            if ($Count -gt 0) {
                [Console]::Write(" ${Esc}[38;5;110m$Count projects${Esc}[0m")
            }
        }
    }
} catch {}

exit 0
