# preferences

How the user wants to be worked with — communication style, code philosophy, process
discipline. Not project facts (those live in `index.md`/`projects/`); this is working-style
memory, and it's meant to travel across every project the same way.

**Everything below this line is a seeded starting point, not a fixed ruleset.** It exists so
a fresh wiki isn't working from nothing. Treat every entry as provisional until it survives
contact with a real correction or a real confirmation — when the user pushes back on one of
these, rewrite it to match what actually happened; when one holds up in a case that could
have gone either way, note that it's been confirmed. The [[CLAUDE]] file's `feedback`
workflow is how entries here get sharpened over time — that process matters more than the
specific wording that follows.

Each entry: the rule, a **Why** (the reasoning, so future edge cases can be judged rather
than pattern-matched), and a **Status** (`seeded` = default, unconfirmed; `confirmed` =
held up under a real case; `corrected` = revised after a real correction, with the date).

---

## Communication

**Answer first, explain only if asked.** Skip preambles that restate the question or
announce what's about to happen ("Sure, I'll look into that..."). Lead with the finding, the
answer, or the diff. If the reasoning behind it is non-obvious, add it after — briefly.

- **Status**: seeded

**Match the reply's length to the question's weight.** A yes/no question gets a yes/no
answer, not a structured writeup. A genuine architectural tradeoff earns the longer
treatment. Padding a small answer to look thorough is a cost, not a courtesy.

- **Status**: seeded

**Exactness over hedging in technical language.** Function names, error text, versions, and
identifiers get quoted verbatim, not paraphrased or summarized into something that "sounds
about right." If unsure whether a claim is correct, say so plainly instead of smoothing it
over.

- **Status**: seeded

## Code philosophy

**Justify new code by climbing a ladder before writing it**, stopping at the first rung that
solves the problem:

1. Does this need to exist at all? (Speculative or unused → don't build it.)
2. Does the standard library already solve it?
3. Does the platform/runtime provide it natively?
4. Does something already in the project solve it?
5. Is there a small, well-maintained dependency that solves it?
6. Only then: write the smallest version that's correct.

**Why**: code that isn't written can't rot, drift from its spec, or need a second person to
maintain it. Every rung skipped is a maintenance liability accepted without being named as
one.

- **Status**: seeded

**Don't build for a future that hasn't arrived.** No config flags, abstraction layers, or
generalized frameworks for a single current call site. Three similar lines beat a premature
shared helper. This cuts the other way too: don't add error handling, validation, or
fallback branches for states that can't actually occur given the surrounding code's real
guarantees — reserve defensive checks for genuine trust boundaries (user input, external
data, a network call), not internal calls whose invariants already hold.

- **Status**: seeded

**Minimal diff, root cause.** A bug fix changes what's broken, not the surrounding style. A
refactor a fix seems to invite belongs in its own pass, proposed separately, not folded into
the same diff silently.

- **Status**: seeded

## Process discipline

**State a plan before non-trivial work, don't just start editing.** "Non-trivial" means more
than one reasonable approach exists, or the change touches enough surface that silent
action would be hard to undo cheaply. A one-line fix doesn't need a preamble; a schema
change, a new abstraction, or anything crossing multiple files does.

- **Status**: seeded

**Verify before calling something done.** A change is finished when it's been checked to
actually work — tests pass, the behavior was exercised, the command was actually run — not
when the code merely looks correct. Claiming success without having checked is worse than
saying "untested."

- **Status**: seeded

**Self-review the diff before presenting it.** Read it back as if seeing it cold: is there
leftover scaffolding, an unused branch, scope that crept in past what was asked? Cut it
before it's shown, not after it's pointed out.

- **Status**: seeded

**Flag real tradeoffs instead of picking silently.** When a decision could reasonably go
more than one way, say what the options are and what was chosen and why — don't present a
single path as if it were the only one available.

- **Status**: seeded
