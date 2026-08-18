# Brain

A Claude Code skill that turns `~/brain` into a persistent, git-versioned cross-project
knowledge wiki — compile what you learn about a project once, keep it current, and stop
re-deriving context from raw files every session.

## Why

- A stateless agent re-scans your filesystem from zero every session. Ask it "what have I
  built before" or "what did I decide about X" and it either doesn't know or has to re-read
  everything to find out.
- [Karpathy's LLM wiki
  pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) fixes this:
  instead of RAG-over-raw-files, an LLM compiles what it learns into linked markdown pages
  once, and reads that back next time instead of re-deriving it.
- `brain` packages that pattern as a skill: a fixed schema (`index.md`, `log.md`,
  `projects/`, `concepts/`), three workflows (query / ingest / lint), and a set of ground
  rules that keep the wiki honest — no copied source, no invented pages, no silent
  restructuring.
- Plain markdown, git-versioned, Obsidian-compatible (`[[wikilink]]` syntax keeps the graph
  view connected). No database, no embeddings — the gist's own argument is that this scales
  further than it looks before either is needed.

## What it does

Once installed, the `brain` skill auto-surfaces whenever a request references multiple
projects, asks what already exists or what you decided before, or hands the model something
worth remembering past the current session. On first use it bootstraps a wiki at `~/brain`
from the templates in this plugin; on every later use it reads `~/brain/CLAUDE.md` — the
wiki's own schema, which may have evolved past the bootstrap defaults — and follows it.

```
~/brain/
  CLAUDE.md          the wiki's schema: layout, workflows, ground rules
  index.md           catalog of every known project — path, category, one-liner, status
  log.md             append-only history of ingest/query/lint events
  projects/<name>.md deep pages, written only after real investigation
  concepts/<name>.md cross-project synthesis pages
```

**Query** — a question spans projects: read `index.md` and relevant `concepts/*.md` first,
instead of re-scanning the filesystem.

**Ingest** — pointed at a project: read its own docs, write or update its `projects/` page,
update `index.md`, cross-link relevant `concepts/` pages, log it.

**Lint** — periodic health check: stale pages, un-cross-linked overlaps, unclassified
entries.

See `skills/brain/SKILL.md` for the full workflow definitions and ground rules, and
`templates/CLAUDE.md` for the schema a fresh wiki bootstraps with.

## Install

```
/plugin marketplace add adezdev/brain
/plugin install brain@brain
```

From a local clone, point the first command at the directory instead.

Manual alternative, no plugin system involved: copy `skills/brain/` into
`.claude/skills/brain/` (project-level) or `~/.claude/skills/brain/` (global — recommended,
since this is meant to span every project on the machine), and `templates/` alongside it so
the bootstrap step can find `${CLAUDE_PLUGIN_ROOT}/templates/*` — when installed manually
outside the plugin system, replace that variable with the actual path to `templates/` in
your copy.

## Default wiki location

`~/brain` — `$HOME/brain` on macOS/Linux, `%USERPROFILE%\brain` on Windows. If you already
keep a wiki somewhere else, tell the model where it lives; the skill follows whatever
`CLAUDE.md` it finds there rather than assuming the default path is authoritative.

## License

MIT. See [CHANGELOG.md](CHANGELOG.md) for what changed when.
