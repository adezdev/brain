# brain — schema

This is the user's cross-project wiki. Pattern: [Karpathy's LLM
wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) — a persistent,
LLM-maintained knowledge base instead of re-scanning raw files every session. You (the model)
maintain this wiki. The human curates sources and asks questions; everything else —
summarizing, cross-linking, flagging contradictions, keeping the index current — is your job.

## Why this exists

Working across many project directories loses continuity jumping between them. This wiki is
the shared long-term memory: when a session touches this repo, or a query spans multiple
projects, you should already know what exists, what it's for, and how it relates to
everything else, without re-deriving it from scratch or being told again.

## Layout

- [[index]] — catalog of every known project: path, category, one-line summary, status. The
  entry point. Read this first when a question references "my projects" broadly.
- [[log]] — append-only. One line per ingest/query/lint event. Never edit past entries, only
  append. Format: `YYYY-MM-DD [ingest|query|lint] short description`.
- `projects/<name>.md` — one page per project the wiki has actually investigated (entity
  pages). Not every project in `index.md` needs one yet — only write one after actually
  looking at the project, not from the one-liner alone.
- `concepts/<name>.md` — cross-cutting synthesis pages that link multiple projects around a
  shared theme, pattern, or piece of infra. This is where the value compounds — write these
  when a real pattern shows up across several projects, not preemptively.

## Workflows

**Ingest** (pointed at a project, or asked to investigate one): read the project's own
docs/README/CLAUDE.md/AGENTS.md and skim its structure, write or update
`projects/<name>.md`, update its line in `index.md`, append to `log.md`, and update any
`concepts/` page it's relevant to.

**Query** (a question spans projects): check `index.md` and relevant `concepts/` pages first
before reading raw project files — that's the whole point of compiling instead of
re-deriving. If the answer required real digging, file it back into the wiki (new project
page, or an update to a concept page) and log it.

**Lint** (run periodically, or when asked "what's going on across my projects"): scan for
stale project pages (referenced dirs that no longer exist), duplicate/overlapping projects
that haven't been cross-linked into a concept page yet, and projects in `index.md` still
marked `unclassified`. Report findings, don't silently fix structural stuff without saying
so.

## Ground rules

- This wiki describes projects living elsewhere on disk. Never copy project source into
  `brain/` — link to the absolute path. Edit the actual projects in place; `brain` is not a
  working copy.
- Keep entries honest. A project that hasn't been opened gets a one-liner in `index.md` and
  nothing more — don't invent a `projects/` page from guesses.
- Plain markdown, git-versioned, human-readable. No database, no embeddings, unless this
  index genuinely stops being enough to navigate (see Karpathy's gist — that point is
  usually further away than it seems).
- Use `[[wikilink]]` syntax (matching the target file's name, without `.md`) for cross-links
  so Obsidian's graph view stays connected. Don't leave a real page as a graph orphan — link
  it from at least `index.md` or one relevant concept.
- Commit after each real update (`git add -A && git commit`, with a real message — no
  content-free shortcuts) so `log.md` and the git history stay in sync.
- Never write secrets, tokens, or credentials into this repo, even when a project being
  ingested has them sitting nearby — note their existence, not their contents.
- If something in a project's own docs turns out to be about a *different* thing than it
  looks (a same-named external product, a clone that isn't the user's own work, etc.),
  correct it plainly rather than leaving the wrong inference standing.
