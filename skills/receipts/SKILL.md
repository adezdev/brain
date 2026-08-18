---
name: receipts
description: Show concrete, sourced proof that the brain wiki has actually paid off — not "memory is useful" as an assertion, but specific moments pulled from log.md where it prevented rework, caught a contradiction, or correctly applied a preference. Use when the user asks "what has this actually saved me", "has brain been worth it", "show me receipts", or wants evidence rather than a summary of what the wiki contains.
---

# brain: receipts

`brain`'s other workflows build the wiki. This one audits whether it did anything —
the proof mechanism, not another way to describe the schema.

## Locate the wiki

Same resolution as the `brain` skill: default `~/brain`, or wherever the user says it lives.
Read `log.md` in full. If it doesn't exist, or has fewer than a handful of entries, say so
plainly — there isn't enough history to draw a receipt from yet, and inventing one from a
thin log defeats the point of this skill.

## What counts as a receipt

Not every log line is one. A receipt is a moment where the wiki's memory changed what
happened, not just a record that an ingest occurred. Look for:

- **Rework avoided** — a query entry where an existing `projects/` or `concepts/` page
  answered a question that would otherwise have required re-reading a project from scratch,
  especially if the entry notes something like "already exists" or "already decided."
- **A contradiction caught** — an entry (often a `lint` or `ingest` correction) where new
  information conflicted with something the wiki already held, and the wiki flagged it
  instead of silently drifting between two inconsistent stories across sessions.
- **A preference correctly applied without being re-stated** — a `feedback` entry marked
  `confirmed`, or any later session where a `preferences.md` rule visibly shaped an answer
  or a diff without the user having to repeat the correction that produced it.
- **A correction that stuck** — a `feedback` entry marked `corrected`, paired with evidence
  (a later log entry, or the user's own account this session) that the corrected behavior
  held on a subsequent, different occasion — one correction followed by silence isn't yet a
  receipt, it's just a rule that hasn't been tested again.

A plain `ingest` entry that just describes a project getting written up is not a receipt on
its own — it's the wiki doing its baseline job, not proof that the baseline job paid off.

## Reporting

Walk `log.md` chronologically, pull out candidates against the criteria above, and verify
each one before reporting it: check that the project page, concept page, or preference entry
it depends on still exists and still says what the log claims. A receipt that cites a page
that's since been rewritten or removed doesn't get reported as current proof.

Report plainly, most concrete first. No score, no percentage, no "brain has saved you N
hours" — that number would be invented. State what happened and let it speak for itself.

```
receipts — 4 found (from 23 log entries, 2026-08-17 to present)

  rework avoided     query on "have I built a Rust TUI before" answered directly from
                      index.md — 6 existing projects surfaced, no re-scan needed
                      (log: 2026-08-17 query)

  contradiction caught   ingest of <project> found its docs described a different,
                      external product than the one already on record — corrected
                      rather than left standing (log: 2026-08-17 ingest)

  preference applied    feedback entry "stop restating the question" (corrected,
                      2026-08-17) — no session since has restated a question back
                      before answering

  correction held      feedback entry on YAGNI ladder application (confirmed,
                      2026-08-17) — cited again without being re-explained in a
                      later ingest

  1 log entry referenced a projects/ page that no longer exists — excluded, not
  reported as current proof.
```

If nothing in the log rises above routine ingest/query activity, say that directly instead
of stretching a routine entry into a receipt — an honest "nothing distinctive yet" is more
useful than a padded list.

Don't write anything back to the wiki — this skill is read-only, same as `lean` is for
`marshal`.
