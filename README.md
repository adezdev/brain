# Brain

A pair of Claude Code skills that turn `~/brain` into a persistent, git-versioned
cross-project knowledge wiki — of what your projects are, and of how you want to be worked
with. Compile each once, keep both current, and stop re-deriving context from raw files
every session.

## Why

- A stateless agent re-scans your filesystem from zero every session. Ask it "what have I
  built before" or "what did I decide about X" and it either doesn't know or has to re-read
  everything to find out.
- [Karpathy's LLM wiki
  pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) fixes this:
  instead of RAG-over-raw-files, an LLM compiles what it learns into linked markdown pages
  once, and reads that back next time instead of re-deriving it.
- Most "memory" tools stop at project facts. A rule file that just says "be terse" or "apply
  YAGNI" is a commodity — every agent ships one, and it never moves. The differentiator here
  is that `brain` remembers working style too — communication, code philosophy, process
  discipline — starting from sensible defaults and getting sharpened by real corrections and
  confirmations, the same way project knowledge compounds. That memory travels to every
  project, not just the one you happened to correct it in.
- `brain` packages both halves as a skill: a fixed schema (`index.md`, `preferences.md`,
  `log.md`, `projects/`, `concepts/`), four workflows (query / ingest / lint / feedback), and
  a set of ground rules that keep the wiki honest — no copied source, no invented pages, no
  silent restructuring.
- A second skill, `receipts`, is the proof mechanism: it audits `log.md` for concrete moments
  the wiki actually paid off — a rebuild avoided, a contradiction caught, a preference
  applied without being re-stated — instead of just asserting the wiki is useful.
- Plain markdown, git-versioned, Obsidian-compatible (`[[wikilink]]` syntax keeps the graph
  view connected). No database, no embeddings — the gist's own argument is that this scales
  further than it looks before either is needed.

## What it does

Once installed, the `brain` skill auto-surfaces whenever a request references multiple
projects, asks what already exists or what you decided before, corrects or confirms an
approach worth remembering, or hands the model something worth keeping past the current
session. On first use it bootstraps a wiki at `~/brain` from the templates in this plugin; on
every later use it reads `~/brain/CLAUDE.md` — the wiki's own schema, which may have evolved
past the bootstrap defaults — and follows it.

Every workflow below is one turn of the same loop: check the wiki before acting, act, then
write back anything worth keeping. Both halves are mandatory — a workflow that only writes is
a diary nobody re-reads, and one that only reads loses whatever it just learned the moment
the session ends. That read-before-act, write-back-after shape is the whole mechanism; it's
what turns this into compounding memory instead of notes nobody revisits.

```
~/brain/
  CLAUDE.md           the wiki's schema: layout, workflows, ground rules
  index.md            catalog of every known project — path, category, one-liner, status
  preferences.md      working-style memory — communication, code philosophy, process
  log.md              append-only history of ingest/query/lint/feedback events
  projects/<name>.md  deep pages, written only after real investigation
  concepts/<name>.md  cross-project synthesis pages
```

**Query** — a question spans projects: read `index.md` and relevant `concepts/*.md` first,
instead of re-scanning the filesystem.

**Ingest** — pointed at a project: read its own docs, write or update its `projects/` page,
update `index.md`, cross-link relevant `concepts/` pages, log it.

**Lint** — periodic health check: stale pages, un-cross-linked overlaps, unclassified
entries.

**Feedback** — a correction ("no, don't do that") or a confirmation ("yes, exactly") updates
`preferences.md` with the rule *and* the why behind it, marked `corrected` or `confirmed` so
a later session can judge an edge case instead of blindly pattern-matching. This is what
turns `preferences.md`'s seeded defaults into something actually earned rather than a static
list.

`preferences.md` ships seeded with a starting ruleset — terse, answer-first communication; a
YAGNI ladder for new code; plan-before-acting and verify-before-declaring-done process
discipline — written explicitly as defaults meant to be overwritten by real feedback, not
followed blindly forever.

**`receipts`** (a second skill in this plugin) — ask "what has this actually saved me" and it
walks `log.md` for verifiable, still-current evidence: rework avoided because the wiki
already knew, a contradiction it caught, a preference it applied correctly without being
re-told. No invented metrics — a concrete, sourced list, or an honest "nothing distinctive
yet" if the log doesn't support one.

The honest tradeoff: the wiki avoids redundant re-scanning and redundant rebuilding — that's
the real saving, and `receipts` only ever states it in real terms (lines actually read,
projects actually named), never an invented hours/dollars figure. But reading the wiki isn't
free, and an unbounded one eventually costs more to read than it saves — this isn't an
optimization engine, it's an avoided-waste mechanism with an ordinary maintenance cost. That's
why `lint` includes a bloat check: a page that's grown large enough that reading it stops
being cheap relative to what it prevents gets flagged, not silently left to grow.

See `skills/brain/SKILL.md` and `skills/receipts/SKILL.md` for the full workflow definitions
and ground rules, and `templates/` for the schema a fresh wiki bootstraps with.

## Install

```
/plugin marketplace add adezdev/brain
/plugin install brain@brain
```

From a local clone, point the first command at the directory instead.

Manual alternative, no plugin system involved: copy `skills/brain/` and `skills/receipts/`
into `.claude/skills/` (project-level) or `~/.claude/skills/` (global — recommended, since
this is meant to span every project on the machine), and `templates/` alongside them so the
bootstrap step can find `${CLAUDE_PLUGIN_ROOT}/templates/*` — when installed manually outside
the plugin system, replace that variable with the actual path to `templates/` in your copy.

## Default wiki location

`~/brain` — `$HOME/brain` on macOS/Linux, `%USERPROFILE%\brain` on Windows. If you already
keep a wiki somewhere else, tell the model where it lives; the skill follows whatever
`CLAUDE.md` it finds there rather than assuming the default path is authoritative.

## License

MIT. See [CHANGELOG.md](CHANGELOG.md) for what changed when.
