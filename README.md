<p align="center">
  <img src="logo.png" alt="brain" width="200">
</p>

# Brain

Turns `~/brain` into a persistent, git-versioned wiki — of your projects, and of how you
work. Two Claude Code skills. Compile it once, keep it current, stop re-deriving context
from scratch every session.

## Why

Stateless agents forget everything between sessions. Ask "have I built this before" and you
get a filesystem re-scan. Every time.

[Karpathy's LLM wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
fixes that: compile what you learn into linked markdown, read it back instead of
re-deriving it.

Most memory tools stop at project facts. A rule file that says "be terse" is a commodity —
every agent ships one, none of them move. Brain remembers working style too: communication,
code philosophy, process discipline. Starts from seeded defaults. Gets sharpened by real
corrections and confirmations. Travels to every project, not just the one you corrected it
in.

Plain markdown. Git-versioned. Obsidian-compatible — `[[wikilinks]]` keep the graph
connected. No database, no embeddings. Not until the index itself stops being enough.

## The loop

Every workflow is one turn of the same loop: check the wiki before acting, act, write back
what's worth keeping. Both halves mandatory. Write without reading it back next session —
that's a diary nobody opens. Read without writing back — you lose what you just learned.
Skip either half, the loop stops compounding.

```
~/brain/
  CLAUDE.md           the wiki's schema — layout, workflows, ground rules
  index.md            every known project — path, category, one-liner, status
  preferences.md      working-style memory — communication, code, process
  log.md              append-only history of every workflow run
  projects/<name>.md  deep pages, written only after real investigation
  concepts/<name>.md  cross-project synthesis
```

**Query** — spans projects. Read `index.md` and relevant `concepts/*.md` first. No re-scan.

**Ingest** — pointed at a project. Read its docs. Write or update its page. Update
`index.md`. Cross-link. Log it. Nothing on disk yet? Ask 2-4 sharp questions instead of
guessing — purpose, what it replaces, explicit non-goals — then write from real answers.

**Lint** — periodic health check. Stale pages, un-cross-linked overlaps, unclassified
entries, bloat. Reports; doesn't restructure without being asked.

**Feedback** — a correction ("no, don't do that") or a confirmation ("yes, exactly") updates
`preferences.md`: the rule and the why, marked `corrected` or `confirmed`. This is what
turns seeded defaults into something earned.

`preferences.md` ships seeded: terse communication, a YAGNI ladder, plan-before-acting,
verify-before-done. Defaults, not laws — meant to be overwritten by real feedback.

Full workflow definitions and ground rules: `skills/brain/SKILL.md`. Bootstrap schema:
`templates/`.

## receipts

The proof mechanism. Ask "what has this actually saved me" and it walks `log.md` for
concrete, still-current evidence — rework avoided, a contradiction caught, a preference
applied without being re-stated. Real numbers only: lines actually read, projects actually
named. Never an invented hours/dollars figure. Nothing distinctive in the log, it says so —
a padded list is worse than an honest one.

Full definition: `skills/receipts/SKILL.md`.

## The tradeoff

Real saving: no redundant re-scanning, no redundant rebuilding. Real cost: reading the wiki
isn't free, and an unbounded one eventually costs more than it saves. That's why `lint`
checks for bloat — a page grown past cheap-to-read gets flagged, not left to grow silently.
Not an optimization engine. An avoided-waste mechanism with a maintenance cost.

## Install

```
/plugin marketplace add adezdev/brain
/plugin install brain@brain
```

Local clone: point the first command at the directory instead.

No plugin system: copy `skills/brain/` and `skills/receipts/` into `.claude/skills/`
(project) or `~/.claude/skills/` (global — recommended, this spans every project on the
machine), `templates/` alongside. Replace `${CLAUDE_PLUGIN_ROOT}` with the real path to
`templates/` in your copy.

## Default wiki location

`~/brain`. `$HOME/brain` on macOS/Linux, `%USERPROFILE%\brain` on Windows. Wiki lives
elsewhere — tell the model where. It follows whatever `CLAUDE.md` it finds there, not the
default path.

## License

MIT. `CHANGELOG.md` for what changed when.
