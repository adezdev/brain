# Changelog

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
