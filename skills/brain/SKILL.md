---
name: brain
description: A persistent, cross-project knowledge wiki — of project facts and of how the user wants to be worked with. Use when the user references a personal knowledge base or notes spanning multiple projects, asks something that spans multiple projects ("what have I done before", "what already exists", "what did I decide about X"), points you at a project to investigate/remember, corrects or confirms an approach worth remembering, or when you learn something worth keeping past this session. Also use when asked to set up, bootstrap, or check the wiki itself.
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
2. Copy `${CLAUDE_PLUGIN_ROOT}/templates/CLAUDE.md`, `templates/index.md`,
   `templates/log.md`, and `templates/preferences.md` into place, unless a same-named file
   already exists there (never overwrite real content).
3. `git init` if `~/brain` isn't already a repo, then commit the bootstrap
   (`git add -A && git commit -m "bootstrap brain wiki"`).
4. Tell the user this is a fresh wiki and ask what to start with, rather than guessing a
   project catalog out of thin air. Mention that `preferences.md` starts from seeded
   defaults meant to be sharpened by real feedback, not treated as fixed.

## Layout

- `CLAUDE.md` — the wiki's own schema (layout, workflows, ground rules in full).
- `index.md` — catalog of every known project, by category.
- `preferences.md` — working-style memory: communication, code philosophy, process
  discipline. How the user wants to be worked with, not project facts — applies across
  every project, not just the one in front of you.
- `log.md` — append-only history of what's been done in the wiki.
- `projects/<name>.md` — deep pages, written only after real investigation.
- `concepts/<name>.md` — cross-cutting synthesis pages linking multiple projects around a
  shared theme.

## The loop

Every workflow below is one turn of the same loop: **check the wiki before acting, act, then
write back anything worth keeping.** Both halves are mandatory, not optional — a workflow
that writes without ever being read back next session is a diary nobody re-reads; a workflow
that reads without writing back loses whatever it just learned the moment the session ends.
Skip either half and the loop stops compounding: no read means the next session starts from
zero, no write means it repeats the same discovery. Read this section as the check against
every workflow that follows — if one of them seems to only do half the loop, that's a bug in
this file, not a variant to allow.

## The four workflows

**Query** — a question spans projects, or references something that would otherwise need a
filesystem re-scan: read `index.md` and the relevant `concepts/*.md` first (the read half —
this is what makes a query cheap instead of a re-scan). If real digging was needed to answer,
file it back (new project page, or an update to a concept page) and append one line to
`log.md` (the write half — skipping it means the next query pays the same digging cost
again).

**Ingest** — pointed at a project, or asked to properly look into one: first check `index.md`
for an existing row and any relevant `concepts/*.md` pages, so prior context (a cluster it
belongs to, a one-liner already on record) isn't silently re-derived or contradicted. Then
read the project's own README/CLAUDE.md/AGENTS.md and skim its real structure (not just the
one-liner in `index.md`, if it has one). Write or update `projects/<name>.md` with what was
actually found — genuine distinguishing facts and gotchas, not a restatement of the README.
Update its `index.md` row, cross-link it into any relevant `concepts/` page with a
`[[wikilink]]`, and append to `log.md`. Only write a `projects/*.md` page after real
investigation — a project that hasn't been opened gets a one-liner in `index.md` and nothing
more.

*Greenfield branch*: if the target is empty or near-empty on disk, or the user is describing
a project that doesn't exist yet, there's nothing to investigate — don't write a guessed
`projects/<name>.md` from the description alone. Still do the read half first (`index.md`,
relevant `concepts/*.md` — the project may already be on record from an earlier conversation
even with nothing on disk yet). This is the case `preferences.md`'s "interview only when
genuinely uncertain" entry is for: ask a small, bounded set of sharp questions (2-4, not a
full requirements doc) — what it's for, what it's replacing or competing with (if anything),
and any explicit non-goals — then write the page from the real answers, and finish with the
same write half as any other ingest: `index.md` row, `concepts/` cross-link if relevant, and
`log.md`. An existing project with real code or docs still gets investigated, not
interviewed; this branch is specifically for "nothing to read yet."

**Lint** — asked "what's going on across my projects" or run periodically: the scan itself
*is* the read half — stale project pages, overlapping projects not yet cross-linked, entries
still marked unclassified. Report findings, and append a `log.md` entry summarizing what was
found even when nothing gets restructured — a lint pass that finds real gaps but leaves no
trace is exactly the write-back failure this loop exists to avoid. Don't silently fix
structural stuff without saying so; reporting is the deliverable, restructuring only happens
if asked.

Also check for bloat: `index.md`, `preferences.md`, and any `concepts/*.md` page exist to
make reading cheaper than re-deriving — a page that's grown large enough that reading it
stops being cheap relative to what it prevents has inverted its own purpose. Flag one that's
ballooned with repetitive entries, superseded rows never removed, or a `preferences.md`
entry that's been `corrected` multiple times without the earlier versions being folded away.
This is a report-only finding like the rest of lint — note which page and roughly why (a real
observation, e.g. "index.md lists the same project twice under two different category
headings," not a guessed word count or a made-up size threshold); don't prune unprompted.

**Feedback** — the user corrects an approach ("no, don't do that," "stop doing X") or
confirms a non-obvious one worked ("yes, exactly," accepting something unusual without
pushback): read `preferences.md` first to find whether a matching entry already exists — a
correction to something already `confirmed` is itself worth noting, not just overwritten
silently. Then update or add the relevant entry. A correction gets marked `corrected` with
the date and what prompted it; a confirmation gets marked `confirmed`. Capture the *why*, not
just the *what* — that's what lets a future session judge an edge case instead of blindly
pattern-matching a rule. This is the mechanism that turns `preferences.md`'s seeded defaults
into something actually earned. Append one line to `log.md`, same as the other three
workflows.

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
