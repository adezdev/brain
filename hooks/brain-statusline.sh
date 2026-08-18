#!/bin/bash
# brain — statusline badge script for Claude Code
# Shows [BRAIN] when a wiki is found at the resolved location, plus a real
# project count read from the wiki at render time. Renders nothing (exit 0)
# when no wiki exists yet — safe on fresh installs, same as caveman's
# pre-/caveman-stats behavior.
#
# Usage in ~/.claude/settings.json:
#   "statusLine": { "type": "command", "command": "bash /path/to/brain-statusline.sh" }
#
# Plugin users: Claude will offer to set this up on first session.
# Standalone users: add the line above to settings.json yourself.

# Wiki location: same default as the brain skill (~/brain). Override with
# BRAIN_WIKI_DIR if your wiki lives elsewhere — the skill itself is told in
# conversation, this script has no conversation, so it only has the env var.
WIKI="${BRAIN_WIKI_DIR:-$HOME/brain}"
SCHEMA="$WIKI/CLAUDE.md"

# Refuse symlinks on the wiki root and its schema file — a local attacker
# could point either at an arbitrary path and have this script read it.
# We never echo file contents (only numbers we compute ourselves), but the
# read itself must still refuse to follow a symlink out of the wiki.
[ -L "$WIKI" ] && exit 0
[ -L "$SCHEMA" ] && exit 0
[ -f "$SCHEMA" ] || exit 0

# Hard-cap the schema read. We don't render its bytes, but capping avoids a
# slow read if something huge ever lands at that path.
head -c 65536 "$SCHEMA" > /dev/null 2>&1 || exit 0

printf '\033[38;5;110m[BRAIN]\033[0m'

# Optional project count: a real, cheap count of projects/*.md, taken fresh
# every render — never a cached or estimated number (same discipline the
# receipts skill holds). Skipped entirely, not shown as 0, if the directory
# is missing, symlinked, or the count doesn't come back as a clean integer.
PROJECTS_DIR="$WIKI/projects"
if [ -d "$PROJECTS_DIR" ] && [ ! -L "$PROJECTS_DIR" ]; then
  COUNT=$(find "$PROJECTS_DIR" -maxdepth 1 -type f -name '*.md' 2>/dev/null | wc -l | tr -d '[:space:]')
  case "$COUNT" in
    ''|*[!0-9]*) ;;  # not a clean integer — say nothing rather than guess
    *) [ "$COUNT" -gt 0 ] && printf ' \033[38;5;110m%s projects\033[0m' "$COUNT" ;;
  esac
fi

exit 0
