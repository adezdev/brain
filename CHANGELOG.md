# Changelog

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
