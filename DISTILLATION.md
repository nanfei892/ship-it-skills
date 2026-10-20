# Distillation record — where `make-ui-not-ai` came from

The skill was built by distilling the local reference corpus at
`E:\AI-default-work\frontend-design-resources` (80 files, ~728 KB, snapshot 2026-10-20), which is the
Opus 4.5/5.5-era frontend design material the skill was asked to learn from.

This file records, for every content file in that corpus, whether it was absorbed or deliberately left out,
and where the absorbed material landed in [`make-ui-not-ai/SKILL.md`](make-ui-not-ai/SKILL.md).

**Why a record at all:** the marketplace installs a *single* `SKILL.md`, so none of these reference files
ship with the skill. Everything worth keeping had to be compressed into that one file. That makes "did we
distill the whole thing?" a real question with a checkable answer, rather than a claim.

Method: two distiller subagents worked the corpus in parallel (one on the design-system prompt and its 14
skills, one on interaction/motion/surfaces/typography/icons/performance plus the Opus 5.5 briefs), then the
intake was verified against the two most important files read directly — `anthropics-frontend-design/SKILL.md`
and `make-interfaces-feel-better/SKILL.md` — and against a coverage probe that asks an agent to quote the
instruction for each question or say `NOT COVERED`.

## Absorbed

| Source file | Taken into the skill | Landed in |
| --- | --- | --- |
| `anthropics-frontend-design/SKILL.md` | the five default clusters; ground the direction in subject matter; two passes then build; spend boldness in one place; the hero should open with the most characteristic thing in the subject's world; a stat-strip hero is a default; ASCII wireframes to compare candidate compositions; serif needs more line-height and can take a longer measure; class/element selectors cancelling each other; writing rules (CTA names the action, errors don't apologise, empty states invite action) | §2, §3, §4, §6, §7 |
| `make-interfaces-feel-better/SKILL.md` | concentric radius; optical alignment; shadows for elevation, borders for structure; interruptible transitions vs keyframes; stagger and exit rules; the icon cross-fade values; `scale(0.96)`; tabular-nums; `text-wrap`; image outline colour; 44/40 hit areas; icon stroke weights; `transition: all`; `will-change`; motion restraint; **the review output protocol** — coverage table with `not reviewed`, severity, before/after, considered-but-rejected, and a ship gate | §6, §7 |
| `make-interfaces-feel-better/skills/animations.md` | the exact motion numbers in the canonical table (durations, offsets, stagger, spring `duration 0.3`/`bounce 0`, `cubic-bezier(0.2,0,0,1)`) | §6 Canonical values, Motion craft |
| `…/surfaces.md` | concentric-radius formula and the 24px escape hatch; the three-layer light shadow and dark single ring; image-outline rules; hit-area pseudo-element and the no-overlap rule | §6 Surfaces and geometry |
| `…/typography.md` | font smoothing at the root; `text-wrap: balance` vs `pretty` and their line limits; tabular-nums scope | §6 Typography craft |
| `…/icons.md` | `currentColor`; outline default, fill for active; sizing on the set's grid; RTL flipping exceptions; accessible names | §6 Icons |
| `…/performance.md` | `transition: all` cost; `will-change` discipline | §6 Performance hygiene |
| `claude-design-system-prompt/system-prompt.md` | review dimensions; weak vs reversed hierarchy; the verdict enum; severity tiers; coverage over filtering | §7 |
| `…/skills/ai-slop-check.md` | the AI-tell catalogue and the "name the property, not the hex" discipline | §2 |
| `…/skills/frontend-aesthetic-direction.md` | commit on every axis; dials; distinctive move | §3 |
| `…/skills/discovery-questions.md` | ask once, and only when it pays | §1 |
| `…/skills/generate-variations.md` | four candidates, no shared palette family, one deliberately off-distribution | §3 |
| `…/skills/polish-pass.md` | the polish checklist behind the canonical values | §6 |
| `…/skills/accessibility-audit.md` | contrast ratios, colour-alone, focus, forms, motion guards | §6 Accessibility |
| `…/skills/hierarchy-rhythm-review.md` | hierarchy as the first review dimension; structural before cosmetic | §7 |
| `…/skills/interaction-states-pass.md` | default/hover/active/focus/disabled/loading coverage | §6, Product Interface Reference |
| `…/skills/component-extract.md`, `…/design-system-extract.md` | reuse the project's existing tokens and system rather than adding a second one | §6 |
| `…/skills/wireframe.md` | sketch candidates before writing CSS, and annotate them | §3 |
| `…/skills/make-a-prototype.md` | declare what is real and what is simulated in the hand-off | Hand Off |
| `使用指南.md` | the reconciled motion and hit-area numbers; the 10%-speed review technique | §6, §8 |
| `opus-55-official-and-muzli-briefs.md` | brief not wish; name banned defaults and grow the list; ask for options then remix; spend boldness in one place; name the tools; let it look; raise effort but don't max; define done | §3, §7, §8 |
| `README.md` (corpus root) | cross-check only: it confirms the same doctrine (naming specific patterns beats "avoid AI look"), and its motion cheat-sheet matches the numbers already in the table | — |

## Deliberately excluded

| Source | Why not absorbed |
| --- | --- |
| `anthropics-theme-factory/SKILL.md`, `themes/*.md` (10 themes), `theme-showcase.pdf` | A menu of pre-made named palettes (desert-rose, golden-hour, midnight-galaxy…). The skill's whole argument is that a direction must be derived from the subject; shipping an aesthetic menu would contradict §2 and §3. The useful part — commit to a token set and reuse it — is already §3 *Commit on every axis*. |
| `anthropics-web-artifacts-builder/SKILL.md`, `scripts/init-artifact.sh`, `scripts/bundle-artifact.sh`, `scripts/shadcn-components.tar.gz`, `anthropics-web-artifacts-builder.zip` | Build tooling for producing single-file artifacts (bash scaffolding, a vendored component tarball), specific to one host environment. Not design guidance, and it would date the skill. |
| `claude-design-system-prompt/skills/make-tweakable.md` | An in-design tweak-panel feature plus a host message protocol — a product capability, not a visual judgement. |
| `claude-design-system-prompt/skills/make-a-deck.md` | HTML slide decks. A different deliverable from a product interface, with its own layout logic. |
| `make-interfaces-feel-better-repo/AGENTS.md`, `CLAUDE.md`, `README.md`, `LICENSE`, `.gitattributes`, `.git/**` | Repository meta: install instructions, licence, git internals. No design content. |
| `LICENSE.txt` files, `.zip` archives | Not content. |

## What is checked, and how

The distillation is not assumed to be correct. Three checks exist:

1. `preflight.ps1` validates the shipped file (frontmatter, description length, links, line endings, and
   that the marketplace install source is byte-identical to this repo).
2. Three **coverage probes** asked a fresh agent to quote the instruction for each of a set of questions or
   answer `NOT COVERED`. They found 7 real gaps in form and flow guidance, which produced the
   `Forms and destructive actions` section, and then found 4 defects inside the new text.
3. Five showcase pages exercise every section of the skill, including a full form-and-states flow, and each
   was rendered at a real viewport and inspected.
