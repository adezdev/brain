---
name: brain
description: A persistent, cross-project knowledge wiki. Use when the user references a personal knowledge base or notes spanning multiple projects, asks something that spans multiple projects ("what have I done before", "what already exists", "what did I decide about X"), points you at a project to investigate/remember, or when you learn something about a project worth keeping past this session. Also use when asked to set up, bootstrap, or check the wiki itself.
---

# brain — cross-project knowledge wiki

A git-versioned, Obsidian-compatible markdown wiki following [Karpathy's LLM wiki
pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f): compile
knowledge about the user's projects once, keep it current, and stop re-deriving it from raw
files every session.

## Locating the wiki

Default location: `~/brain` (i.e. `$HOME/brain`, `%USERPROFILE%\brain` on Windows). If the
user has told you it lives somewhere else, use that path instead for the rest of this skill.

If `~/brain/CLAUDE.md` already exists, that file is the actual schema for this wiki —
**read it in full before doing real work** and follow it; it may have evolved past what's
described below (e.g. a standing decision about which projects are in active focus). This
file is the trigger and the bootstrap; `~/brain/CLAUDE.md` is the manual once the wiki
exists.

If `~/brain` doesn't exist yet (or exists but has no `CLAUDE.md`), bootstrap it:

1. Create `~/brain/` (and `~/brain/projects/`, `~/brain/concepts/`) if missing.
2. Copy `${CLAUDE_PLUGIN_ROOT}/templates/CLAUDE.md`, `templates/index.md`, and
   `templates/log.md` into place, unless a same-named file already exists there (never
   overwrite real content).
3. `git init` if `~/brain` isn't already a repo, then commit the bootstrap
   (`git add -A && git commit -m "bootstrap brain wiki"`).
4. Tell the user this is a fresh wiki and ask what to start with, rather than guessing a
   project catalog out of thin air.

## Layout

- `CLAUDE.md` — the wiki's own schema (layout, workflows, ground rules in full).
- `index.md` — catalog of every known project, by category.
- `log.md` — append-only history of what's been done in the wiki.
- `projects/<name>.md` — deep pages, written only after real investigation.
- `concepts/<name>.md` — cross-cutting synthesis pages linking multiple projects around a
  shared theme.

## The three workflows

**Query** — a question spans projects, or references something that would otherwise need a
filesystem re-scan: read `index.md` and the relevant `concepts/*.md` first. If real digging
was needed to answer, file it back (new project page, or an update to a concept page) and
append one line to `log.md`.

**Ingest** — pointed at a project, or asked to properly look into one: read its own
README/CLAUDE.md/AGENTS.md and skim its real structure (not just the one-liner in
`index.md`, if it has one). Write or update `projects/<name>.md` with what was actually
found — genuine distinguishing facts and gotchas, not a restatement of the README. Update
its `index.md` row, cross-link it into any relevant `concepts/` page with a `[[wikilink]]`,
and append to `log.md`. Only write a `projects/*.md` page after real investigation — a
project that hasn't been opened gets a one-liner in `index.md` and nothing more.

**Lint** — asked "what's going on across my projects" or run periodically: scan for stale
project pages (dirs that no longer exist), overlapping projects not yet cross-linked into a
concept page, and entries still marked unclassified. Report findings; don't silently
restructure without saying so.

## Working conventions

- Never copy project source into `brain/` — link to the real absolute path. `brain` is
  memory, not a working copy; edit projects in place.
- Use `[[wikilink]]` syntax (the target file's name, without `.md`) for cross-links so
  Obsidian's graph view stays connected. Don't leave a real page as a graph orphan — link it
  from at least `index.md` or one relevant concept.
- Commit after each real update (`git add -A && git commit`, with a real message) — this
  keeps `log.md` and the git history in sync. Don't push anywhere unless explicitly asked;
  treat this repo as local-only by default.
- Never write secrets, tokens, or credentials into this repo, even when a project being
  ingested has them sitting nearby — note their existence, not their contents.
- If something in a project's own docs turns out to be about a *different* thing than it
  looks (a same-named external product, a clone that isn't the user's own work, etc.),
  correct it plainly rather than leaving the wrong inference standing.
- Keep entries honest. Don't invent a `projects/` page, or embellish one, from guesses.
