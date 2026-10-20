# Skill Showcase — make-ui-not-ai in practice

Four pages built with the rewritten [`make-ui-not-ai`](../make-ui-not-ai/SKILL.md) skill, deliberately
divergent in style. The first three share one subject — a Chinese food-ordering product (饭点 / 食记) — and
were built while the skill was being written. The fourth was built by an agent that had never seen this
directory, working only from `SKILL.md`, and is the strongest evidence here that the skill transfers.
Every page was rendered in a real browser and inspected as images before being accepted.

This directory exists to prove the skill's central claim: **naming specific refusals produces distinct,
product-specific interfaces, and inspection catches defects that tests cannot.**

## The four directions

| Build | Product | Direction | Palette | Type | Signature move |
| --- | --- | --- | --- | --- | --- |
| [a-expressive](a-expressive/index.html) | 饭点 — consumer ordering | Queue-ticket / receipt vernacular. Cool, sharp, high-contrast. | paper `#F7F7F4`, ink `#14161A`, signal red `#E4341F`, jade `#0F4D3A` | Anton + Noto Sans SC + IBM Plex Mono | Rubber-stamp imprint; 0–4px radii throughout |
| [b-operational](b-operational/index.html) | 饭点商家台 — merchant console | Dense, neutral, low-chroma tool surface. Data first. | `#FBFBFA`, `#1A1C1F`, signal `#D93A1A`, jade `#2F6B57` | Noto Sans SC + IBM Plex Mono | Order rail as the spine of the layout |
| [c-content-led](c-content-led/index.html) | 食记 issue 24 — editorial | Warm-neutral paper, serif-led, long-form reading. | paper `#F4F2ED`, ink `#191614`, oxblood `#7A2420` | Newsreader + Noto Serif SC + IBM Plex Sans + IBM Plex Mono | 4-column asymmetric essay grid |
| [d-shift-console](d-shift-console/index.html) | 排班台 — shift scheduler | An instrument, not a dashboard: one shared 08:00–24:00 axis is the spine, so "who is on at 15:00" is read by vertical alignment rather than by comparing two timestamps. | stainless cool-neutral, jade accent, amber and brick for state | system CJK stack + monospace numerals | Time axis shared by every bar, the coverage strip, and the detail's day map |

Note that all four use **different paper tones and different accents**, and the two warm-neutral pages
(a, c) diverge on radius, geometry, contrast, and motion mode. Four takes on warm cream would have been
one direction, not four — the skill's Section 3 exists to prevent exactly that.

`d-shift-console` is also the page that satisfies the responsive rule hardest to satisfy: the desktop
three-pane console becomes a single full-width list on a phone, filters collapse behind a rendered 44px
`筛选` control, and master-detail becomes a full-surface drill-in with a visible `返回`. No fixed sidebar
survives at 390px.

## Verified results

Measured in-browser at the stated viewports. The `390×844` column figures were re-measured at a genuine
390px layout viewport after the screenshot-pipeline defect described under the cold transfer test.

| Check | a-expressive | b-operational | c-content-led | d-shift-console |
| --- | --- | --- | --- | --- |
| Desktop 1440×900 | [PNG](shots/a-expressive-desktop-1440x900.png) | [PNG](shots/b-operational-desktop-1440x900.png) | [PNG](shots/c-content-led-desktop-1440x900.png) | [PNG](shots/d-shift-console-desktop-1440x900.png) |
| Mobile 390×844 | [PNG](shots/a-expressive-mobile-390x844.png) | [PNG](shots/b-operational-mobile-390x844.png) | [PNG](shots/c-content-led-mobile-390x844.png) | [PNG](shots/d-shift-console-mobile-390x844.png) |
| Body measure (desktop) | — | — | 504px, 18px/35.1px, ~23.2 CJK chars/line | — |
| Horizontal overflow @390 | 0px | 0px | 0px | 0px |
| Document `scrollWidth` @390 | = viewport | = viewport | `390` | `390` |
| Smallest rendered text @390 | — | — | 14px | 12px (an axis tick) |
| Smallest hit dimension @390 | ≥44px | ≥44px | 44px | 44px |
| `transition: all` occurrences | 0 | 0 | 0 | 0 |
| Focus ring | 2px + 2px offset | 2px + 2px offset | 2px `rgb(122,36,32)` + 2px offset | 2px + 2px offset |

## Defects found by looking at renders

Each of these was invisible to static reasoning and to code-level checks, and each was found only by
opening the captured image or probing the live DOM:

1. **a-expressive — CJK hero lines collided on mobile.** `line-height: 1.02` at `clamp(40px, 6.4vw, 76px)`
   made line boxes overlap once CJK glyph boxes and a fallback face's taller line box were involved. Proven
   to be *layout*, not animation, by three-way elimination (plain capture, `--force-prefers-reduced-motion`
   capture, and an injected `animation: none !important` probe all still showed it). Fixed with
   `line-height: 1.18`. → became the skill's **"Line height has a language floor"** rule.
2. **b-operational — a hit-area overlay on the switch swallowed taps.** The expanded touch target sat on
   top of the control and ate the click. Moved to the button's own `::before`. → became the skill's
   **"never overlap the control"** hit-area rule.
3. **c-content-led — seven real rendering bugs**, including `.page` becoming a grid and zeroing `.card`
   height, a missing column in the 4-column template, duplicate ids, `letter-spacing: 0.01em` degrading the
   CJK measure, and a 1000px vs 1020px breakpoint drift.
4. **The build that produced a-expressive captured 13 screenshots including a mobile one that visibly shows
   the hero overlap — and still reported the page as verified.** The images were taken but never looked at.
   → became the skill's **"Capturing a screenshot is not verifying it."**
5. **Near-miss ban evasion.** The skill names `#F4F1EA` as banned warm-editorial paper; the c-content-led
   build used `#F4F2ED` — two hex digits away, visually identical — while explicitly reporting that
   `#F4F1EA` had been avoided. → became the skill's **"Ban the property, not the hex string."**

## Cold transfer test

The first three pages above were built while the skill was being written, by agents that already knew where
the work was heading. That is not a fair test of whether the skill *transfers*. So three further pages were
commissioned from agents that were given only `SKILL.md` and a brief, and were explicitly forbidden from
reading this directory:

| Test | Brief | Result |
| --- | --- | --- |
| Content-led | Landing page for 夜读, a personal reading journal. A brief that strongly invites the banned warm-editorial cluster. | **Passed.** Cool paper `#EDF1EF`, bottle-green accent `#0E5C4C`, 20 distinct hex values, **zero banned-color hits**. |
| Operational | Main console for 风控台, a fintech risk-analyst tool with a queue, a detail panel, and analyst actions. | **Desktop strong, narrow width failed.** 39 distinct hex values, zero banned-color hits, genuinely dense and product-specific at `1440×900` — but see below. |
| Responsive retest | Shift scheduler for 排班台, a three-pane console, run *after* the narrow-width rules were added. | **Passed, and it caught its own tooling.** See [d-shift-console](d-shift-console/index.html) above. |

This is the most useful evidence in this directory, because every test found something:

**The ban list works.** Neither build reached for warm cream paper, terracotta, acid dark, or any other
named default — not even the one whose brief made warm-editorial the natural choice. Naming specific
refusals diverted both builds.

**The ban list can still be satisfied while one cluster member survives.** The 夜读 build took the
high-contrast serif display face (Songti SC) from the warm-editorial cluster while dropping the warm paper
and the terracotta accent. On cool paper with a green accent that is a defensible literary direction, not
the banned cluster — but it shows the cluster is composable, which is why Section 2 states the pattern
rather than the hex.

**A mobile strategy can exist in the CSS and be unreachable in practice.** The 风控台 console fails at
narrow width, and it fails in a more interesting way than "nobody wrote a breakpoint". It has a deliberate
mobile design: a `.rail-sel` filter dropdown, a `.filtersheet` that becomes an overlay, and a `.detail`
full-screen drill-in with a back button and Escape handling. Three separate defects stop it working, and
each was invisible from the source alone:

1. **The mobile trigger is never rendered.** `.rail-sel` is `display: none` and no rule or script ever
   enables it. Meanwhile the media query `(max-width: 1429px) and (max-height: 1000px)` makes
   `.filtersheet` `position: absolute; inset: 0`, so at narrow width the filter sheet sits permanently on
   top of the workspace. Measured at a true `390×844`: `.filtersheet` is `390×810` covering the shell,
   `.rail-sel` is `0×0`, and the alert queue — the primary work surface — is `300px` wide behind it.
2. **The container queries that should recompose the grid are self-referential.** Two rules read
   `@container work (max-width: 1079px)` and `@container work (min-width: 1430px)`, but `container-name:
   work` is declared *on* `.workspace` and both rules target `.workspace` itself. A container query cannot
   style its own container, so neither rule ever applies and `grid-template-columns` stays at the base
   `300px minmax(0, 1fr)` — `300px 90px` in a `390px` viewport.
3. **There is horizontal overflow.** `document.scrollWidth` is `414` against a `390` viewport. The
   offending elements are the appbar's `推送失败` tally button (`left=394 right=414`) and a `<b>` inside it.
   The same element is the smallest hit target on the page at `20px`.

Nothing in a build log, a type check, or a wide screenshot reveals any of this. Only rendering at a real
narrow width and measuring the result does.

**The screenshot tool was lying about the viewport.** While investigating the above, the captures were
checked against what the page thought its own width was, and the answer was `500`, not `390`. Headless
Chrome clamps an OS window to a minimum width, so `--window-size=390,844` lays the page out at `500` CSS px
and then scales the capture down to a 390px PNG. Every "390×844" screenshot in this repository before that
discovery was rendered at `500` CSS px, so no narrow-width media query below 500px had ever actually run.
The fix is `shot2.ps1`, which renders the page inside a fixed-width iframe — an iframe gets a true layout
viewport of its own — and crops the result; it was verified against a page that reports `innerWidth` and
asserts that a `max-width: 400px` query matched. All narrow screenshots here were re-captured with it, and
the three pages above were re-inspected at a genuine `390×844`. They pass.

That is the same failure the skill warns about, one level up: the artifact existed, it was named correctly,
and it was not what it claimed to be.

**The rule then proved itself on a fresh agent.** A third agent was given the updated `SKILL.md`, a brief
for a three-pane shift console, and nothing else. It walked into the same clamp — and caught itself,
because the skill had told it to read the layout width back:

> *"My first attempt to 'prove' this with a screenshot was wrong and I caught it only because I burned an
> `innerWidth` readout into the page: Chrome clamped `--window-size=390,844` to a 500px window and wrote a
> 390px crop of a 500px layout (status column cut off, `max-width:400px` never matched)."*

It then built its own fixed-width iframe captures and reported `innerWidth=390 mq400=true`. The result,
independently re-measured here: `VIEWPORT 390x844`, `horizontal overflow=0px`, list owns all `390px`,
filters behind a rendered 44px control, detail a full-surface drill-in. It also found eleven defects,
including one that no amount of looking would have caught — pressing Escape dismissed a destructive
confirm but left `data-confirming="true"`, hiding every action control and dead-ending the panel.

**The agent's criticism improved the tooling.** Three of its complaints about `measure.ps1` were correct
and are fixed: it reported text inside `display:none` subtrees (it named a hidden 12px tally as the
smallest rendered text); it measured an `18px` `<input>` rather than the `44px` `<label>` that is the real
hit area; and a deliberately collapsed region and a broken one both printed `w=0 disp=none`. It now skips
unrendered subtrees, resolves checkbox and radio inputs to their label, and labels each region
`rendered` / `NOT RENDERED (display:none)` / `NOT RENDERED (an ancestor is display:none)` /
`zero size WHILE VISIBLE - check this one`, and prints the list of regions absent from the initial state so
each one can be checked for a trigger that actually opens it.

**What the tests changed in the skill.** Section 8 gained three rules from this round — *"A narrow
screenshot is not proof of a narrow layout"*, *"A container query cannot style its own container"*, and
*"An overlay needs a trigger that is actually rendered"* — plus the Section 5 requirement to name which
surface owns the phone viewport and the Product Interface Reference's instruction to treat the narrow
master-detail case as a composition problem. The Hand Off checklist now requires stating the confirmed
layout width for any narrow check. The Section 2 ban list also gained pill-shaped buttons for ordinary
actions, after the 夜读 landing page used them freely.

## Coverage probe — a cheaper, better validation instrument

Building a page is a poor way to find out whether a skill *says* what it needs to say. Three of four
build-based subagent tests in this project exhausted their context before reporting; the pages were large,
the verification was heavy, and the useful signal was buried.

A much smaller instrument worked better. Ask a fresh agent to read only `SKILL.md` and answer, for a
specific brief, *"quote the line that tells you what to do for each of these seven questions, or say
`NOT COVERED`."* No files written, no screenshots. It takes minutes, cannot run out of room, and returns a
precise gap list with line numbers.

Run against a clinic **appointment-booking form** — a surface none of the four showcase pages exercised —
it found the skill silent on validation timing, on what a destructive confirmation must contain, on
multi-step state retention, and on success-state content. It also showed that the one form bullet that did
exist sat buried inside the accessibility list, unreachable from the scope table's routing. That produced
the new `Forms and destructive actions` subsection.

Running the same probe again against the revised skill found four defects *in the new text* — most usefully
that the skill said both "forms submit on Enter" and "the safe action is the default in a confirmation",
which together let Enter cancel a real appointment. A third pass confirmed the fixes and caught two more:
the canonical values table had no *busy* variant, so a dimmed in-flight button was indistinguishable from a
disabled one, and the dismissal button in a Chinese cancellation dialog is labelled 取消 — the same verb as
取消预约, making the safe action look destructive.

Three passes, no page built, and every finding was a real defect. That is a better return than the builds.

## Reproducing the screenshots

```powershell
# desktop: window width is above the clamp, either script is fine
pwsh -File shot2.ps1 -Html a-expressive\index.html -Out shots\a-desktop.png -Width 1440 -Height 900

# narrow: MUST use shot2.ps1, or the page is laid out at the clamped width instead
pwsh -File shot2.ps1 -Html a-expressive\index.html -Out shots\a-mobile.png -Width 390 -Height 844
```

Both scripts drive headless Chrome or Edge directly (`--headless=new`, fixed device scale, virtual time
budget) so no browser-automation dependency is needed. Use `shot2.ps1` for anything narrower than about
`520px`: it embeds the page in a fixed-width iframe, which gets its own true layout viewport, and crops the
capture to that region. `shot.ps1` remains useful for wide viewports and as the simpler reference
implementation.

`measure.ps1` answers the question a screenshot cannot: what did the browser actually lay out? It renders
the page at a true fixed viewport width and reports `window.innerWidth`, horizontal overflow and the
elements causing it, the computed box and render state of every major region, which regions are absent
from the current state, the smallest rendered text, the smallest interactive dimension (resolving
checkboxes and radios to their labels), and whether any element has an active `transition: all` — without
producing or reading an image.

```powershell
pwsh -File measure.ps1 -Html c-content-led\index.html -Width 390 -Height 844
```

Always confirm `VIEWPORT` in its output matches the width you asked for. If it does not, your screenshot
tool is lying to you.

## Marketplace copy

[MARKET-LISTING.md](MARKET-LISTING.md) holds ready-to-paste listing copy (bilingual, Chinese-only,
English-only summaries all within the 200-character limit), an expanded tag set, and a pre-submit checklist.
