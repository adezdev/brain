# Changelog

## 0.5.1 — 2026-08-18

Bug fix.

- `hooks/brain-statusline-nudge.js` — the suggested Windows command was
  `powershell -ExecutionPolicy Bypass -File "<path>"`, which loads the
  user's PowerShell profile. On a machine with a profile that calls
  `Set-PSReadLineOption -PredictionSource History`, that throws a
  `Set-PSReadLineOption` error to stderr on every single statusline
  render — the script's own output was correct underneath it, but the
  noise polluted every render. Fixed by adding `-NoProfile`. Reproduced
  both before and after locally: the old command prints the PSReadLine
  error, the new one is clean.
- `hooks/brain-statusline.ps1` and `README.md` had the same stale command
  in their own documentation/example snippets — fixed both so the docs and
  the nudge agree.

## 0.5.0 — 2026-08-18

- `hooks/brain-statusline.sh` / `.ps1` — new statusline scripts, modeled on
  the caveman and ponytail plugins' hardening pattern: refuse symlinks on
  the wiki root and its schema file, hard-cap bytes read, never echo file
  contents (only numbers computed locally get rendered), exit 0 with empty
  output when no wiki exists yet. Shows `[BRAIN]` when a wiki is found at
  the resolved location (`~/brain`, or `$BRAIN_WIKI_DIR` if set), plus a
  real `projects/*.md` count taken fresh on every render — no cached or
  estimated number, same discipline `receipts` already holds.
- `hooks/brain-statusline-nudge.js` — SessionStart hook, wired into
  `.claude-plugin/plugin.json`. Claude Code plugins can't declare
  `statusLine` directly, so this is the same one-shot nudge pattern
  caveman/ponytail use: if no `statusLine` is configured yet, tell the
  model to offer setting one up. Never writes `settings.json` itself.
- `README.md` — new Statusline section documenting the manual
  `~/.claude/settings.json` wiring for both platforms, for non-plugin-system
  installs.

## 0.4.4 — 2026-08-18

- `README.md` — added a one-line disclaimer under License: direction is
  adezdev's, implementation is Claude's, and the project is maintained that
  way.

## 0.4.3 — 2026-08-18

- `README.md` — restructured to match the README conventions of two public
  Claude Code skills (`caveman` by Julius Brussee, `ponytail` by Dietrich
  Gebert): a centered logo, a one-line tagline under it, a license badge, an
  anchor-link nav row, an `---` divider, sentence-case section headers, a
  collapsible `<details>` block for the manual-install path, and a short
  docs footer. Content unchanged — same pitch, same loop, same workflows,
  same install instructions and default wiki location.

## 0.4.2 — 2026-08-18

- `README.md` — logo path fixed to the real file (`assets/brain.png`), not
  the placeholder `logo.png` at the repo root.

## 0.4.1 — 2026-08-18

- `README.md` — rewritten in a terser, more declarative voice. Content
  unchanged (Karpathy pitch, the loop, `preferences.md`, `receipts`, install,
  default wiki location) — cut the hedging and over-explaining. Added a
  centered logo slot at the top pointing at `logo.png` (not included; drop
  the file in to render it).

## 0.4.0 — 2026-08-18

- `skills/receipts` — "rework avoided" findings now state the concrete size
  comparison where it's available: real line counts of the pages actually
  read against a re-scan's real project/file count, both measured at report
  time. Never a guessed token/dollar/hour figure — omitted entirely when the
  comparison can't be made from real numbers.
- `skills/brain` — `lint` gained a bloat check: flags `index.md`,
  `preferences.md`, or a `concepts/*.md` page that's grown large enough that
  reading it is no longer cheap relative to what it prevents (repetitive or
  superseded entries, duplicate rows). Report-only, same as the rest of
  lint — no auto-pruning.
- `README.md` — new paragraph stating the honest tradeoff: real savings from
  avoided re-scanning/rebuilding, but reading the wiki isn't free and an
  unbounded one eventually costs more than it saves — not sold as an
  optimization engine, an avoided-waste mechanism with a maintenance cost.

## 0.3.0 — 2026-08-17

- `skills/brain` — named the mechanic that was previously only implicit: every
  workflow is one turn of a read-before-act, write-back-after loop, and both
  halves are mandatory. New "The loop" section states this up front, before
  the workflow list. Fixed workflows that were missing one half: `ingest` now
  explicitly checks `index.md`/`concepts/*.md` before investigating a
  project (including the greenfield branch, which previously skipped the
  read and didn't spell out its own write-back); `lint` now appends a
  `log.md` entry summarizing findings even when nothing gets restructured;
  `feedback` now explicitly reads `preferences.md` first to check for an
  existing matching entry before updating it.
- `README.md` — "What it does" section states the same loop in one short
  paragraph.

## 0.2.1 — 2026-08-17

- `skills/brain` — `ingest` now branches on greenfield targets (empty/near-empty
  directory, or a project described but not yet on disk): instead of writing a
  guessed `projects/<name>.md`, ask a small, bounded set of sharp questions
  (2-4 — purpose, what it replaces/competes with, explicit non-goals) and write
  the page from real answers. An existing project with real code/docs is still
  investigated, not interviewed.
- `templates/preferences.md` — new process-discipline entry, "interview only
  when genuinely uncertain, not as a routine step," which the greenfield
  branch cites — keeps the new branch from becoming a reason to interview on
  every ingest.

## 0.2.0 — 2026-08-17

- `templates/preferences.md` — new wiki-root file for working-style memory
  (communication, code philosophy, process discipline), separate from
  project facts. Seeded with defaults explicitly marked as starting points,
  not fixed rules.
- `skills/brain` — added a fourth workflow, `feedback`: a correction or a
  confirmation updates the relevant `preferences.md` entry (`corrected` /
  `confirmed`, with the why), and logs the event to `log.md` like the other
  three workflows. Bootstrap step now also seeds `preferences.md`. Layout
  section documents the new file.
- `templates/CLAUDE.md` — schema updated to match: `preferences.md` in the
  layout, `feedback` workflow, `log.md` format extended to include it.
- `skills/receipts` — new skill. Audits `log.md` for concrete, still-current
  evidence that the wiki paid off (rework avoided, a contradiction caught, a
  preference applied without being re-stated) instead of asserting the wiki
  is useful. Read-only.
- `README.md` — expanded pitch: memory of projects *and* of working style,
  with `receipts` as the proof mechanism.

## 0.1.0 — 2026-08-17

Initial version.

- `skills/brain` — query/ingest/lint workflows, wiki-location resolution, and
  first-use bootstrap from `templates/`.
- `templates/` — generic `CLAUDE.md` schema plus empty `index.md`/`log.md`
  skeletons for bootstrapping a fresh `~/brain`.
