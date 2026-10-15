# Skill Showcase — make-ui-not-ai in practice

Three pages built with the rewritten [`make-ui-not-ai`](../make-ui-not-ai/SKILL.md) skill, deliberately
divergent in style, on one shared subject: a Chinese food-ordering product (饭点 / 食记). All three were
rendered in a real browser and inspected as images before being accepted.

This directory exists to prove the skill's central claim: **naming specific refusals produces distinct,
product-specific interfaces, and inspection catches defects that tests cannot.**

## The three directions

| Build | Product | Direction | Palette | Type | Signature move |
| --- | --- | --- | --- | --- | --- |
| [a-expressive](a-expressive/index.html) | 饭点 — consumer ordering | Queue-ticket / receipt vernacular. Cool, sharp, high-contrast. | paper `#F7F7F4`, ink `#14161A`, signal red `#E4341F`, jade `#0F4D3A` | Anton + Noto Sans SC + IBM Plex Mono | Rubber-stamp imprint; 0–4px radii throughout |
| [b-operational](b-operational/index.html) | 饭点商家台 — merchant console | Dense, neutral, low-chroma tool surface. Data first. | `#FBFBFA`, `#1A1C1F`, signal `#D93A1A`, jade `#2F6B57` | Noto Sans SC + IBM Plex Mono | Order rail as the spine of the layout |
| [c-content-led](c-content-led/index.html) | 食记 issue 24 — editorial | Warm-neutral paper, serif-led, long-form reading. | paper `#F4F2ED`, ink `#191614`, oxblood `#7A2420` | Newsreader + Noto Serif SC + IBM Plex Sans + IBM Plex Mono | 4-column asymmetric essay grid |

Note that all three use **different paper tones and different accents**, and the two warm-neutral pages
(a, c) diverge on radius, geometry, contrast, and motion mode. Four takes on warm cream would have been
one direction, not four — the skill's Section 3 exists to prevent exactly that.

## Verified results

Measured in-browser at the stated viewports:

| Check | a-expressive | b-operational | c-content-led |
| --- | --- | --- | --- |
| Desktop 1440×900 | [PNG](shots/a-expressive-desktop-1440x900.png) | [PNG](shots/b-operational-desktop-1440x900.png) | [PNG](shots/c-content-led-desktop-1440x900.png) |
| Mobile 390×844 | [PNG](shots/a-expressive-mobile-390x844.png) | [PNG](shots/b-operational-mobile-390x844.png) | [PNG](shots/c-content-led-mobile-390x844.png) |
| Body measure (desktop) | — | — | 504px, 18px/35.1px, ~23.2 CJK chars/line |
| Body measure (mobile) | — | — | 350px, 17px, ~19.3 CJK chars/line |
| `transition: all` occurrences | 0 | 0 | 0 |
| Focus ring | 2px + 2px offset | 2px + 2px offset | 2px `rgb(122,36,32)` + 2px offset |
| Hit areas ≥44px | yes | yes | yes |

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

## Reproducing the screenshots

```powershell
pwsh -File shot.ps1 -Html a-expressive\index.html -Out shots\a.png -Width 1440 -Height 900
pwsh -File shot.ps1 -Html a-expressive\index.html -Out shots\a-mobile.png -Width 390 -Height 844
```

`shot.ps1` drives headless Chrome or Edge directly (`--headless=new`, fixed device scale, virtual time
budget) so no browser-automation dependency is needed.

## Marketplace copy

[MARKET-LISTING.md](MARKET-LISTING.md) holds ready-to-paste listing copy (bilingual, Chinese-only,
English-only summaries all within the 200-character limit), an expanded tag set, and a pre-submit checklist.
