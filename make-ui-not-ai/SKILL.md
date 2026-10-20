---
name: make-ui-not-ai
description: Build, redesign, critique, or polish production frontend interfaces so they feel intentional, product-specific, and visually credible instead of generated from a generic AI template. Use for websites, SaaS products, dashboards, admin tools, landing pages, mobile interfaces, React/Vue/Svelte/HTML/CSS work, screenshot-driven revisions, design-system decisions, responsive fixes, visual-quality reviews, or requests to remove an AI-generated look. Also use for UI polish work such as hover/focus/loading states, enter and exit animations, micro-interactions, border radius, optical alignment, shadows, borders, icon weight, tabular numbers, text wrapping, transition performance, or "the interface feels off". Also use for form and flow work: field validation and where its errors appear, submit and loading states, multi-step flows that must keep entered data, destructive confirmations, empty states, and success screens that must say what now exists. Also use when an interface reads as off-brand or interchangeable with a competitor's, and when a rendered result must be judged rather than merely built.
---

# Make UI, Not AI

Act as a design lead who also ships the interface. Produce working code, but treat visual judgment as a separate discipline from implementation correctness. A build, test suite, accessibility scan, or DOM measurement cannot prove that an interface looks good.

Two facts drive this skill:

1. **A model asked for interface work without design direction falls back on defaults, and "avoid the AI look" mostly swaps one default for another.** The only instruction that works is naming the specific patterns to refuse. Section 2 is a ban list, and it is meant to grow.
2. **Polish is not a coat of paint; it is a set of exact values applied consistently.** Section 6 is the canonical value table. When a number is needed, take it from there rather than inventing a nearby one.

## Use This Skill Proportionally

| Task | Apply |
| --- | --- |
| Greenfield build or substantial redesign | Full workflow (1–8) and all reference sections |
| Operational product (dashboard, admin, editor, tool) | Full workflow; weight the Ban List, *Forms and destructive actions*, and Product Interface Reference |
| Anything with data entry, validation, or a destructive action | *Forms and destructive actions* before the component work, not after |
| Narrow visual fix, restyle, or polish pass | Sections 2, 6, 7, 8 only; never skip rendering verification |
| "It feels off" / "make it feel better" | Sections 6 and 7, then re-render and compare |

Never skip Section 8 when the interface can be rendered. A design that cannot be looked at has not been verified, whatever the tests say.

## 1. Establish the Product Truth

Inspect the repository, product brief, screenshots, assets, tokens, components, routes, and real content before making visual decisions. Read the source rather than recalling it: open the theme file, the tokens, the component being changed. Exact hex codes and spacing values from the repo beat a recollection of roughly how the app looks.

Identify:

- the primary user, the repeated task, and the decision the screen must make easy;
- the real domain objects, content lengths, actions, and natural information density;
- the product's behavioral contract and existing visual conventions;
- supported viewports, interaction constraints, available icons, fonts, and assets;
- what is verified evidence versus an assumption inherited from an earlier product plan.

Treat an MVP blueprint as a behavior and scope contract, not an aesthetic prescription. Reconcile material contradictions between the brief, repository, and user request before building. Record a necessary deviation instead of silently allowing stages to drift.

Classify the surface before styling it:

- **Expressive:** marketing, editorial, entertainment, portfolio, launch, brand-led.
- **Content-led:** reading, browsing, discovery, catalogue, documentation, media.
- **Operational:** dashboard, inbox, admin, editor, settings, workflow, repeated-use tool.

The classification sets how much visual risk, density, motion, and ornament the surface can carry.

### Ask, but only once and only when it pays

Asking well is a bigger lever than drawing well; bad design comes from missing context, not missing skill. Ask when the answer changes audience, format, brand, structure, or an irreversible implementation choice. Skip when the user gave you enough, when it is a small tweak, or when the task is "recreate this."

One consolidated round, never a drip of single questions across turns. Do not ask what you can derive — if a brand guide is attached, its primary color is not a question. Do not ask to feel safe; a question is justified by the impact of its answer. For genuinely open work the useful set is: starting point (existing system/kit/screenshots?), audience, the desired feel in three adjectives, references admired *and what specifically about them*, off-limits tropes, novelty level, and what should be live-tweakable at the end.

Never invent customer research, legal compliance, pricing, technical constraints, or integrations.

## 2. Name What You Refuse

Before styling, read this list and treat it as binding. These are legitimate for some briefs, but they are defaults rather than choices, and they appear regardless of subject. When the brief genuinely calls for one, follow the brief and say so explicitly.

**Five default clusters to refuse:**

1. **Warm editorial.** Cream or off-white background near `#F4F1EA`, high-contrast serif display, terracotta or warm-clay accent near `#D97757`. That accent is Anthropic's own Claude-interaction color, so on a user's brief it reads as a tell.
2. **Acid dark.** Near-black background with a single bright acid-green or vermilion accent.
3. **Broadsheet.** Hairline rules, zero border-radius, dense newspaper columns.
4. **SaaS card kit.** Content chopped into identical rounded cards, one border-radius regardless of hierarchy, the same soft grey shadow `rgba(0,0,0,.1)` under each, gradient washes as decoration.
5. **Template chrome** that appears whatever the subject: a tracked-out ALL-CAPS eyebrow above every heading; meta strings joined with middle dots (`A · B · C`); labels built as `WORD — fragment` with a spaced em dash; tinted near-black (`#0B0B0B`, `#111`) standing in for black; a monospace face for small data labels; a `→` appended to link and button text.

**Formatting defaults to refuse:** accenting a single word or phrase in a headline (one word italic, bold, or recolor); all-caps for labels; unnecessary typographic labels above content; numbered markers (`01 / 02 / 03`) unless the content genuinely is a sequence; `border-radius: 12px` plus `border-left: 4px solid` as the default card; pill-shaped buttons for ordinary actions, everywhere from landing pages to consoles (segmented controls, tags, and toggles are different objects); rainbow or 3+ color gradients; saturated purple-to-pink and orange-to-pink hero gradients; decorative emoji before headlines or list items; pure `#FFFFFF` on pure `#000000`; fonts reached for as silent defaults (Inter, Roboto, Arial, bare system stacks, and the serif-display defaults Georgia, Playfair Display, Fraunces); hand-drawn SVG illustrations of people, scenes, or concepts; off-scale spacing values (`padding: 7px 15px`, `gap: 13px`); invented colors that trace to no token (five slightly different blues in one file).

**Motion defaults to refuse:** fade-and-slide-up on every section; hover transitions on every card; `transition: all`; keyframed animations on interactive toggles; motion as the only feedback channel; entrance animation on every keystroke or row hover.

**Ban the property, not the hex string.** A list of exact color values is trivially evaded by a near-miss: told to avoid `#F4F1EA`, output will reach for `#F4F2ED` — a value two hex digits away, perceptually the same paper, and formally compliant. The same evasion happens with any enumerated value: avoid "12px radius" and get 13px; avoid "Inter" and get another neutral grotesque. So state what the pattern *is* — "a warm off-white paper tone used as the page base," "a high-contrast serif headline against that paper," "one uniform radius applied to every surface" — and judge the render against the description. Treating the list as a string-match checklist is the failure mode this section exists to prevent, and it survives even an explicit ban.

**The loop that makes this work.** After the first render, inspect what new defaults the output reached for instead, add them to this list, and iterate. Check a near-miss, not just an exact hit. The list is a living document per project; noting tried-and-rejected directions in a scratch file prevents circling back to them.

## 3. Choose a Direction Before Coding

For greenfield work or a substantial redesign, produce two compact candidate directions internally. Compare them against product evidence, audience fit, usability, implementation cost, and similarity to the patterns in Section 2. Choose one and state the reason.

Ground the direction in subject matter, not word association. A product named "Echo" does not justify sound waves; a finance product does not automatically justify navy; avoiding purple does not justify beige or amber. The subject's industry, materials, vernacular, and audience are where distinctive choices come from — a toy for 8–11 year olds and a dashboard for financial analysts should not converge.

Define the chosen direction with:

1. **Evidence:** concrete brand, audience, content, domain, or environmental signals.
2. **Interface premise:** one sentence on how the product should feel and why.
3. **Design dials:** expressiveness, density, contrast, geometry, motion — described in words, not all maximized.
4. **Composition:** first-viewport focal point, major regions, alignment logic, space allocation.
5. **Type and color roles:** hierarchy and function, not just a font name and a hex.
6. **Distinctive move:** optional, only when it improves recognition or the repeated task.
7. **Rejection:** the most tempting generic direction and why it is wrong here.

When no brand exists and the direction is genuinely open, propose four concretely specified candidates — each with background hex, accent hex, display and body typeface, density, radius, and motion mode, plus a one-line rationale — and let the user pick. The candidates must not share a palette family: four takes on warm cream is one direction, not four. Make at least one deliberately off-distribution.

### Commit on every axis

Vague statements ("modern and clean") produce generic design. Pin each axis: **typography** (1–2 families maximum, with roles and weights); **color** (a committed tone — warm, cool, or neutral — plus one accent, semantic states, and a neutral scale); **density** (tight, normal, or loose, on a 4px or 8px base); **radius and shadow** (sharp 0–2px, soft 4–8px, or pill — one elevation system, not a mix); **component style** (filled, ghost, outlined, or elevated as the default, with secondaries for hierarchy); **motion** (quiet, expressive, or playful — one mode, since mixed motion reads as unintentional).

Write the direction down before coding — a comment block at the top of the source is enough. Every later value references those tokens rather than introducing new inline ones; if a new value is needed, add it to the direction first.

Then review the plan against the brief before building. If any part of it would come out the same for a similar prompt, revise that part and say what changed and why.

### Spend boldness in one place

Let one element be the memorable thing and keep everything around it quiet and disciplined. One orchestrated moment lands better than scattered effects. Build to a quality floor without announcing it: responsive to mobile, visible keyboard focus, reduced motion respected, visually accessible palette. Chanel's rule applies — before shipping, look in the mirror and remove one accessory.

## 4. Content Earns Its Place

Words and elements appear for one reason: to make the interface easier to understand and use. Bring the same minimalism to copy that you bring to spacing.

**Five-question test** for every element:

1. Does it answer a question the user actually has? (No → remove)
2. Does it advance the narrative or the task? (No → remove)
3. Could the user complete the task without it? (Yes → remove)
4. Is there a clearer, shorter way to say this? (Yes → do that)
5. Does it serve the user or the designer? (Designer → remove)

**What counts as filler:** lorem ipsum where real copy belongs; invented statistics; "Learn more" with no destination; decorative dividers; headlines, subheadings, and paragraphs saying the same thing; icons that repeat adjacent text; emoji used for color; data slop ("Since 2019", "99.9% uptime") that supports no message; tables with columns nobody reads.

**When an area feels empty, that is a layout problem, not a content problem.** Solve it with composition. Empty space is breathing room, not failure. If you believe added sections or copy would help, ask rather than adding scope unilaterally.

Write from the user's perspective and name things by what users understand, not by how the system is built — a user manages notifications, not webhook config. Use active voice; a CTA names exactly what happens ("Save changes," not "Submit"), and an action keeps one name through the whole flow, so a "Publish" button produces a "Published" toast. Errors state what went wrong and how to fix it, never apologize, and are never vague. An empty screen is an invitation to act. Keep sentence case, plain verbs, no filler.

## 5. Structure Before Decoration, Then Build One Slice

Design hierarchy and composition before polishing components:

- establish the first, second, and third visual priorities;
- allocate width and height by task importance and content shape;
- decide what stays visible, scrolls, truncates, collapses, or moves at narrow widths, and name which surface owns the phone viewport when the desktop layout is a multi-pane shell;
- choose density from reading and decision cost, not from the label "operational tool";
- use components because their behavior fits, not because a library makes them convenient;
- use realistic content — long labels, long records, empty results, errors.

Do not let a component inventory become the composition. Avoid filling the page with interchangeable cards, pills, tinted surfaces, symmetric sections, or identical spacing merely because the implementation is easy.

**Then build the smallest representative slice** that proves the direction: the primary screen or first viewport, realistic content at representative density, main navigation and primary action, and enough responsive behavior to reveal the composition at desktop and narrow widths.

Render this slice before expanding. For an existing product, use the smallest changed surface that exposes the new direction. If rendering is possible, do not continue to full implementation until the slice passes a visual checkpoint — apply Section 8, inspect the actual images, and revise the largest visual weakness. Capturing a screenshot without looking at it does not satisfy this.

## 6. Build the Real Interface

After the direction survives the rendered checkpoint:

- reuse the existing stack, components, tokens, and icon system where they are sound;
- implement the primary workflow, not a decorative preview;
- make navigation, selection, validation, copy, feedback, dismissal, and destructive actions work;
- cover the states that can materially occur: loading, empty, error, disabled, success, permission, overflow, long content;
- preserve semantic structure, keyboard use, visible focus, contrast, reduced motion, and usable touch targets;
- keep content and controls readable at real desktop and mobile sizes;
- open generated links and exercise cross-page handoffs instead of only asserting their strings.

Preserve the product contract. Do not invent features to make the interface more visually interesting.

Never introduce a second styling system to apply a fix. Identify the project's existing system — Tailwind in a Tailwind project, plain CSS in a CSS project, the established CSS-in-JS approach — and express every change in it.

### Canonical values

Use these exact numbers. They are the difference between polish and near-polish, and drifting to a nearby value ("0.95 instead of 0.96", "bounce 0.1 instead of 0") reads as amateur. Do not deviate without a stated reason.

| Concern | Value |
| --- | --- |
| State change (hover, focus, active) | `150–200ms`, `ease-out` |
| Enter transition | `300ms`, `ease-out` |
| Exit transition | `150ms`, `ease-out` — shorter and softer than enter |
| High-frequency interaction (row hover, keystroke) | ≤`150ms` on `background-color` or `opacity` only |
| Micro-interaction ceiling | `500ms`; beyond that it feels sluggish, at `0s` it feels broken |
| Entry offset | `translateY(12px)` + `opacity 0→1` + `blur(4px)→0` |
| Exit offset | `translateY(-12px)` — a small fixed distance, never full height |
| Stagger, semantic groups | `~100ms` between groups; `~80ms` between words in a headline |
| Scale on press | `scale(0.96)`, `150ms`, `ease-out`; never below `0.95` |
| Contextual icon swap | `scale 0.25→1`, `opacity 0→1`, `blur(4px)→0`; spring `duration 0.3`, `bounce 0` |
| No-motion-library easing | `cubic-bezier(0.2, 0, 0, 1)` |
| Concentric radius | `outerRadius = innerRadius + padding`; above `24px` padding treat layers as separate surfaces |
| Icon-side button padding | text-side padding − `2px` |
| Play-triangle optical shift | `margin-left: 2px` |
| Hit area | `44×44px` touch/mobile; at least `40×40px` in dense desktop |
| Focus ring | `2px` solid, `2px` offset, `3:1` contrast against the adjacent background |
| Icon stroke (24px grid) | `1.5px` beside 400 @14–16px; `2px` beside 500–600; `2.5px` beside 700 |
| Body line length | under `80` characters |
| Body size floor | `16px` mobile, `14–16px` desktop |
| Contrast | `4.5:1` normal text, `3:1` large text and UI components |
| Spacing scale | `4px` or `8px` base — every margin, padding, and gap snaps to it |
| Disabled | `opacity 0.6`, `cursor: not-allowed`, no hover effect |
| Busy (request in flight) | label change or in-place progress; **never** only `opacity 0.6`, which is the disabled look |
| Palette size | 3–5 colors total, plus tints and shades |
| Type families | 1–2 maximum |

### Motion craft

**Interruptible by default.** CSS transitions interpolate toward the latest state and retarget mid-flight; keyframes run a fixed timeline and restart from the beginning. Use transitions for anything interactive — hover, toggle, open/close — so clicking again mid-animation smoothly reverses. Reserve keyframes for one-shot staged sequences such as an initial load or a loading state. A keyframed drawer that snaps or restarts when closed mid-animation is the canonical failure.

**Split and stagger entrances, sparingly.** For an infrequent staged entrance where sequence communicates hierarchy — a hero's first load, a success state, an empty state — break the container into semantic chunks (title, description, actions) and stagger them. Never stagger routine interactions: row hovers, keystrokes, or repeated tab changes.

**Exits are softer than enters.** The user's focus is already moving on; do not fight for it. Use a small fixed offset that indicates direction, not a dramatic full-height slide. Remove immediately with no animation when motion adds no information, when the interaction repeats frequently, or under reduced motion.

**Animate icons with opacity, scale, and blur** rather than toggling visibility. When no motion library is installed, keep both icons in the DOM with one absolutely positioned, and cross-fade them — the non-absolute icon defines the layout size. Do not add a dependency just for an icon transition. Check `package.json` first: import from the installed package, and never mix the `motion` and `framer-motion` import paths.

**Motion restraint.** Motion is a budget, not a garnish:

- no custom animation on high-frequency interactions — the attention cost repeats on every trigger;
- motion is never the only feedback channel; every animated state change also needs a static cue (color, icon, or label);
- brief and precise beats prominent; if a shorter, smaller animation communicates the same thing, use it;
- skip entrance animations on first render for elements that are already in their default state, but not where the first-time entrance is the point;
- honor `prefers-reduced-motion`: keep the static cue, drop the movement.

### Surfaces and geometry

**Concentric radius.** Mismatched radii on nested elements is the most common single cause of an interface feeling off. Nest a `12px` inner surface inside `8px` of padding and the outer must be `20px`, not `12px`.

**Optical over geometric alignment.** When geometric centering looks wrong, it usually is wrong. Buttons with a trailing icon need less padding on the icon side. Play triangles need a small right shift. Fix asymmetric icons in the SVG viewBox where possible; margin is the fallback.

**Shadows for elevation, borders for structure.** Where a border exists only to fake depth on a button, card, or container, prefer a layered transparent `box-shadow` — shadows adapt to any background, solid borders do not. Keep borders that communicate real structure or state: dividers, layout separators, table cell boundaries, form-input outlines for accessibility, and selected or focus states. Use one elevation system, not a mix.

Light mode, three layers:

```css
--shadow-border:
  0 0 0 1px oklch(0 0 0 / 0.06),
  0 1px 2px -1px oklch(0 0 0 / 0.06),
  0 2px 4px 0 oklch(0 0 0 / 0.04);
```

Dark mode collapses to a single ring, because layered depth is invisible on dark backgrounds:

```css
--shadow-border: 0 0 0 1px oklch(1 0 0 / 0.08);
```

**Image outlines** need `1px` at low opacity, inset so they add no layout size. The color is non-negotiable: pure black in light mode (`oklch(0 0 0 / 0.1)`), pure white in dark (`oklch(1 0 0 / 0.1)`). Never a near-black or near-white from the project palette (slate-900, zinc-900, `#0a0a0a`, `#111827`) and never the accent or ink color. A tinted outline picks up the surface beneath it and reads as dirt on the image edge.

**Hit areas extend with a pseudo-element** when the visible control is smaller than the minimum, as in a 20px checkbox. Two interactive elements must never have overlapping hit areas; shrink the extension rather than allowing a collision.

### Typography craft

**Set a real scale and stay on it.** Arbitrary sizes — `17px`, `23px` in a `16/20/24` system — are the most common rhythm defect. Control measure, line height, weight, and spacing; a font name is not a type system.

**Rendering details, applied once at the root:**

- `-webkit-font-smoothing: antialiased` with `-moz-osx-font-smoothing: grayscale` on `html`. Applying it per-element makes headings thinner than body text. It affects macOS only, so it is safe universally.
- `text-wrap: balance` on headings. The browser silently ignores it past 6 lines (Chromium) or 10 (Firefox), so never put it on long paragraphs.
- `text-wrap: pretty` on short-to-medium text — paragraphs, descriptions, captions, list items, card text. It kills orphaned words with no line-count limit. For 10+ lines, code, or preformatted text, use neither and accept the default wrapping.
- `font-variant-numeric: tabular-nums` for numbers that update — counters, timers, prices, numeric table columns. Not for static display numbers, phone numbers, or version strings. Some faces widen and center the digit `1` under this property; verify at real size.

**Line height has a language floor.** The tight display leading that suits Latin headlines (`1.0–1.05`) crushes CJK, which has taller glyph boxes and no descender gap to absorb the difference; `line-height: 1.02` on a 40px Chinese heading makes the lines visibly collide. Keep display leading at or above `1.15` when the text can contain CJK, and above `1.25` if a fallback font may render before a webfont loads — a fallback face's larger default line box is enough to overlap a nominally fine value. If the intended typeface is not guaranteed to load, pick leading that survives the fallback rather than the webfont. (This defect is invisible in the CSS and obvious in a narrow screenshot; it is the reason Section 8 requires looking.)

**Deliberate type choices.** Choose display and body roles on purpose; one family can serve both when hierarchy stays clear. Judge type at rendered size, never by shrinking body text or metadata to manufacture density. Do not introduce a paid or proprietary face merely to satisfy a checklist; if the brand calls for one, name a practical fallback stack beside it. These rendering details never override the project's chosen fonts.

Avoid all-caps for anything longer than a short label: reading depends on word shapes, which all-caps destroys.

### Icons

An icon next to text carries that text's optical weight — match the stroke width to the weight rather than accepting the set's default. Use one stroke weight per icon set on a surface, and never mix libraries on one surface.

Draw every icon with `currentColor` and drive hover, selected, and disabled states from CSS color and opacity. Strip hardcoded `fill` and `stroke` on import. Never ship separate assets per state. Outline is the default; fill marks the active state, and the swap between them is a contextual icon animation.

Size inline icons relative to cap height, typically `1em`–`1.25em`, and use the set's native grid sizes (`16`, `20`, `24`) rather than arbitrary fractional scales. Test every icon at the smallest size it will render, often `16px`; prefer a simplified glyph over scaled-down detailed artwork. Use SVG, not raster.

Flip directional icons for RTL — back and forward arrows, navigation chevrons, indent — but never logos, checkmarks, clocks, or media playback controls. Analyze composite icons part by part, since an overlay may keep its position while the base glyph flips. Give every icon-only control an accessible name.

### Performance hygiene

**Never `transition: all`.** It makes the browser watch every property for changes, causes transitions on properties you never intended to animate, and blocks optimization. Name the exact properties: `transition-property: scale, background-color`. Note that Tailwind's bare `transition` is a curated list, not `all`, and `transition-transform` covers `transform, translate, scale, rotate`; use bracket syntax for mixed sets.

**`will-change` sparingly.** It pre-promotes an element to its own GPU layer to avoid a first-frame micro-stutter, and only helps for `transform`, `opacity`, and `filter`. It does nothing for layout or paint properties, it is never `all`, and each extra layer costs memory. Add it only after observing stutter, not preemptively; Safari benefits most. Only `transform` and `opacity` are reliably GPU-compositable — prefer animating those.

### Forms and destructive actions

**Validate on blur, then on change.** An untouched field never shows an error. A field's first error appears when the user leaves it, and from then on it corrects as they type, so the message clears the moment it is fixed. Re-validate everything on submit, move focus to the first invalid field, and bring it into view. Validating on every keystroke from the start shouts at someone who is halfway through typing their own phone number.

**Put each error at its field.** The message sits beside or beneath the input and is programmatically associated with it, so a screen reader announces it with the field. Reserve a summary at the top for long forms or for a submit that reveals several errors at once. Never use a toast for field validation: it is detached from the field, expires on a timer, and is gone by the time the user looks back. The message names the fix ("请输入 11 位手机号"), not the verdict ("格式错误").

**Disable the control that started the request while it is in flight**, and restore it when it settles. This covers save, submit, delete, approve, and cancel alike — not only a form's submit button, and not only the first request on the screen. It is the only guard against a double submit, and on a booking, order, or payment form a missing guard creates two real records rather than one duplicate request. A control in flight must read as *busy*, not as unavailable: the canonical disabled style is `opacity 0.6`, so a button that only dims is indistinguishable from one the user is not allowed to press. Change its label or show progress in place.

**A destructive confirmation names the object and the consequence.** "确定要取消吗？" is a coin flip, not a confirmation; "取消 3 月 14 日 11:00 与张医生的预约？取消后需重新排队" is one. The confirm button repeats the verb ("取消预约"), not "确定". Initial focus and the Enter key both go to the safe action, never to the destructive one, so the dialog cannot be completed by reflex — the destructive control requires a deliberate click. The dismissal control must not reuse the verb being confirmed: when the action *is* a cancellation, a button labelled 取消 is indistinguishable from 取消预约, so label it 返回 or 保留预约.

**Multi-step flows keep their state.** Show which step of how many, let the user go back without retyping anything, never re-ask for a value they already gave, and say what happens on the final step before it happens.

**An empty state explains the cause and offers the next action.** "今日无号" leaves the user stuck; add why, plus the way forward — the next day with availability, a phone number, or a waitlist.

**When a submit loses a race, keep everything the user typed.** Booking, ordering, and reserving all fail this way: the slot, seat, or item was taken between selection and submit. A generic failure that resets the form makes the user re-enter data that was never wrong. Preserve the entered values, name the specific collision ("11:00 与张医生的号刚被约走"), keep the failed choice visible and marked as no longer available, and offer the nearest alternative in the same view.

**A success state says what now exists and what happens next.** It is not a toast. State the created object by identity — number, date, time, who or what it is with — plus the next action and where the user can find or change it later. If the object can be cancelled or edited, that path belongs in the same view rather than in an email the user may never open.

### Accessibility is the floor, not the ceiling

- **Contrast:** `4.5:1` for normal text, `3:1` for large text (18px+ bold or 24px+) and UI components. Compute real ratios for resolvable pairs. When a borderline case sits at `4.4:1`, fix it anyway.
- **Never signal by color alone.** Pair with an icon, text, or position. Red and green are the most common colorblindness pairing.
- **Right element for the role.** `<button>` not `<div onclick>`; `<a href>` not a styled div; `<label for>` linked to its input; landmarks (`nav`, `main`, `article`, `section`, `aside`); exactly one `<h1>` with no skipped levels. ARIA is a patch for when semantic HTML cannot express the role.
- **Keyboard:** everything clickable is Tab-reachable in logical order; modals close on Escape; menus open with Enter or Space and navigate with arrows; forms submit on Enter — except inside a confirmation dialog, where Enter performs the safe action rather than the destructive one.
- **Focus:** never `outline: none` without a replacement meeting `3:1` against the adjacent background. Prefer `:focus-visible` over `:focus`.
- **Forms:** placeholder text is not a label; errors are specific ("Email address is invalid," not "Invalid") and tied to the field; required fields are marked with text or an icon, not color alone; use `type` and `autocomplete` for mobile keyboards and autofill. Validation timing, where an error appears, and what a destructive confirmation must say are all in *Forms and destructive actions* above.
- **Motion:** wrap animation beyond a couple hundred milliseconds in `prefers-reduced-motion`; the standard guard neutralizes durations rather than deleting the rule, so the static cue survives.
- Never flash content more than 3 times per second.

## 7. Run an Independent Visual Critique

After implementation, stop reasoning like the author. Review rendered screenshots as if the implementation rationale were unavailable.

When independent agents or reviewers are available and permitted, give them only the brief and the rendered artifacts — not the intended answer or any self-justification. Otherwise perform two separated passes: a cold visual read, then a task walkthrough. Do not begin by defending choices; record what attracts attention and what looks accidental before explaining anything.

**Cold read at actual rendered scale:**

- What do I notice first, second, and third — and is that order correct for the task?
- Where does the eye stall or wander?
- Does the page feel intentionally composed or merely filled?
- Is any region too dense, too empty, too faint, or too loud?
- Could another product swap in its logo and copy without a redesign?

**The 5-second test:** a first-time user should know what to look at and what to do within five seconds. If the eye has to hunt, the hierarchy is broken.

**Review dimensions:** composition (focal point, balance, use of width, negative space, accidental symmetry, narrow centered shells); hierarchy (how many elements compete, whether chrome overpowers content); typography (personality, scale, measure, metadata size, wrapping at real size); density and readability (scanability, row rhythm, truncation with realistic content); color and surface (palette credibility, semantic meaning, restraint, one hue tinting everything, weak gray text, accent overuse); product specificity (which decisions trace to real evidence, and whether any are unsupported metaphor or decoration); affordance and state (does it look actionable, is selection obvious, do destructive actions carry appropriate weight, is completion feedback visible); responsive composition (mobile as a different allocation of priority, not a scaled screenshot); copy and credibility (generic claims, fake metrics, invented testimonials, self-advertising labels).

**Weak hierarchy and reversed hierarchy** are the two most common failures. Random spacing and arbitrary font sizes snap to the project's scale; flat hierarchy gains contrast; reversed hierarchy swaps the signals so the buried primary moves up and the loud unimportant element goes quiet. When unsure, lean toward stronger hierarchy — too-strong is easier to dial back than too-weak to dial up.

**Verdict** — pick one, never average a numeric score:

- **Distinct and credible:** evidence-backed direction, strong hierarchy, careful execution.
- **Usable but generic:** functional and coherent, but interchangeable or visually cautious.
- **Templated:** recognizable AI defaults dominate composition, palette, type, or content.
- **Visually unresolved:** competing decisions, weak hierarchy, or major readability problems.

A critical composition failure cannot be canceled by passing contrast checks. Report at most five issues ordered by visual impact; for each, state the visible symptom, why it harms the task or credibility, the concrete design change, and the screenshot needed to verify it. Prefer structural fixes over cosmetic tweaks: "make the detail title the only 24px element, reduce nav emphasis, and remove accent fills from metadata" is stronger than "increase contrast." Render again after meaningful revisions and apply the verdict to the final render.

## 8. Verify Function and Visual Quality Separately

Run appropriate type, build, interaction, responsive, accessibility, and console checks. These establish functional confidence.

Separately inspect rendered desktop and narrow screenshots. These establish visual confidence. Keep the claims distinct:

- **Functionally verified:** code and interactions were exercised.
- **Visually verified:** rendered images were actually viewed and critiqued.
- **Not visually verified:** screenshots could not be viewed; report this plainly and do not claim polish or aesthetic completion.

### Build a small verification matrix

The smallest set that exposes the design system:

- one representative primary screen at a wide desktop viewport;
- the same task at a narrow mobile viewport;
- one state that materially changes composition — empty, error, long content, open detail, or a dialog;
- any public or cross-page surface with a distinct audience.

Use realistic data. Capture the visible viewport as well as a full-page image when scrolling matters; full-page captures alone hide poor first-viewport composition. Suggested baseline viewports when the product states none: desktop `1440×900`, mobile `390×844`. Add intermediate widths only where the layout changes materially.

### Inspect the actual images

Open each screenshot with an image-capable tool and look at it at readable scale. Do not infer appearance from CSS, an accessibility tree, bounding boxes, or a successful screenshot command.

**Capturing a screenshot is not verifying it.** Generating a file proves the command ran; it says nothing about what the file shows. A saved PNG that was never opened is an unverified artifact, and a report of "rendered and checked at four viewports" based only on files on disk is false. Read every image you cite, at every viewport you cite, and treat the narrow width as the one most likely to hide a defect.

**A narrow screenshot is not proof of a narrow layout.** A headless browser window can be clamped to a minimum width, so a `--window-size=390,844` request may silently lay the page out at a wider viewport and then scale the capture down: the PNG measures 390px and the page was never laid out at 390px, so every narrow-width media query you wrote stayed inactive. Read the layout width back from inside the page — `window.innerWidth`, plus an assertion that a narrow media query actually matched — or render the page inside a fixed-width iframe, before trusting any narrow capture. A responsive check that never reached the narrow viewport proves nothing, and it fails silently in the direction that flatters the work.

For each image, record brief observations about first visual focus and whether it matches the task; use of available space; typography hierarchy and rendered readability; density, wrapping, truncation, and long-content behavior; palette balance and accent distribution; control affordance, selected state, and visible feedback; and any obvious template pattern. Clicking through a screenshot and viewing it are different acts; only the second is verification.

**Slow the interface down to review motion.** Replay animation at 10% speed and walk every state — hover, focus, active, loading, empty. What feels wrong at 10% speed is what is subtly wrong at full speed.

### Verify the journey in the browser

Exercise the product from the real entry point: navigate using visible controls; perform the primary action; inspect the resulting state; trigger one likely failure or empty state; open copied or generated links rather than only checking their text; confirm destructive, save, copy, submit, and status actions produce visible feedback; check the console for errors and broken assets. Automated interaction proves behavior; it does not replace the image critique.

### Check responsive behavior

At narrow width, verify task priority and content order; absence of page and nested horizontal overflow; navigation clarity including accessible names for icon-only controls; touch target size and separation; readable forms with mobile browser chrome and safe areas; and dialogs, menus, sticky actions, and long validation messages.

**A narrower sidebar is not a narrow-width layout.** The most common responsive failure in operational products is a desktop app shell — persistent sidebar, list, detail panel — carried to a phone unchanged, so the primary work surface is crushed into a sliver beside a sidebar that eats the viewport. Adding one breakpoint that shrinks the sidebar from `300px` to `250px` is still the same layout, and it is the version most likely to ship, because it looks fine in a wide screenshot and the code contains a media query that appears to address the problem. At narrow width the shell must *recompose*: the primary work surface takes the viewport width, navigation collapses behind a control, and master-detail becomes list → drill-in with a visible return path. Judge it by measurement, not impression — the primary surface should hold the large majority of the viewport width, and no fixed sidebar should persist above roughly a quarter of it. A dense desktop console that has merely been squeezed is not responsive; it is a scaled screenshot.

**A container query cannot style its own container.** Declaring `container-name` on an element and then writing a rule that queries that name *and targets that same element* does nothing at all — the rule silently never applies, so the intended recomposition never happens while the stylesheet looks like it contains the right code. This is worth checking by inspection, because no build error and no console warning will surface it. Query a name declared on an ancestor, and make the queried element a descendant of the container.

**An overlay needs a trigger that is actually rendered.** A filter panel, drawer, or sheet positioned `absolute; inset: 0` at narrow widths will permanently cover the work surface unless some control toggles it. Verify the trigger element is present and visible: a toggle left at `display: none`, or one that no state ever enables, means the overlay is open forever and the primary content is unreachable — a mobile navigation strategy that exists in the CSS and cannot be used by any user.

At wide width, verify that the product uses space intentionally rather than remaining trapped in a narrow shell; that the main task dominates navigation and decorative chrome; that line lengths and detail panels stay readable; and that fixed regions do not create large accidental voids.

### Final recheck

After the last meaningful visual change: render the affected desktop and mobile surfaces again; open the new images; confirm the earlier issue is resolved without creating a new hierarchy or overflow problem; report remaining uncertainty honestly. Only the final render can support the final visual claim.

## Hand Off

Lead with the resulting product direction and what now works. Report:

1. the evidence-backed visual premise;
2. the representative slice and core workflow completed;
3. the screenshots and viewports actually inspected, stating the confirmed layout width for any narrow check;
4. functional checks run separately from visual review;
5. material contract deviations or remaining limitations.

Keep it concise. State caveats and next steps only — do not narrate routine styling choices or recap work the user just watched, and never claim taste from an automated check.

## Product Interface Reference

For dashboards, inboxes, admin tools, editors, settings, and other repeated-use surfaces.

**Start from the work.** Describe the repeated loop concretely — scan, compare, choose, edit, confirm, recover — and design around it rather than around a component catalogue. Identify the object users act on; the fields needed to recognize and compare it; the most common action and its frequency; the decision that deserves the largest visual weight; what must stay visible while the user acts; and typical versus worst-case content volume.

**Choose density deliberately.** Density is a task decision, not an enterprise aesthetic. Compact layouts suit users comparing many homogeneous records repeatedly; more space suits content that is unfamiliar, emotionally important, complex, or carefully edited. Preserve readable type, control size, row rhythm, and grouping at every density, and offer progressive disclosure before shrinking everything. Do not equate "professional" with 12px text, faint gray metadata, thin borders, or maximum items per viewport.

**Compose the workspace.** Allocate screen area by task importance, not equal columns or convenient card widths. Keep the primary work surface visually dominant over navigation and chrome. Let lists, tables, detail panels, canvases, and editors use available width when their content benefits. Avoid placing an entire desktop application inside a narrow centered marketing container. Use borders, surface changes, spacing, and alignment as a hierarchy system — but do not apply all four everywhere. Keep primary actions stable; repeated actions should not jump as content changes. For master-detail layouts, verify list recognition, selection state, detail readability, empty selection, narrow-screen drill-in, and return behavior. Treat the narrow-width case as a composition problem, not a width problem: decide before building which single surface owns the viewport on a phone, and how the user gets back.

**Make state legible.** Distinguish selected, hovered, focused, disabled, loading, success, warning, and destructive states. Avoid using the accent color for every status and every piece of metadata. Keep destructive actions separated and confirm when recovery is difficult. Provide visible completion feedback for copy, save, submit, delete, and status changes, and preserve user input across recoverable errors. A control that only reveals its interactivity on hover is invisible to touch and keyboard users.

**Animate vs. don't animate icons:** animate icons that appear on hover, change with state (play→pause, like→liked), sit in contextual toolbars, or indicate loading and success. Do not animate static navigation icons, decorative icons, always-visible icons, or the text beside an icon.

**Resist product-UI templates.** Question a thin top bar plus a centered narrow workspace on a wide screen; every region as a rounded card; pills for navigation, plain metadata, and ordinary buttons; an accent-tinted background behind every active item; tiny icons and labels manufacturing density; empty right-side space from fixed content widths; setup pages that read like raw documentation instead of guided flows; and decorative metrics unrelated to the repeated task. Keep a pattern when the task supports it, not because it is familiar.

**Interaction states.** Every interactive element needs a default, hover, active, focus, disabled, and (where it triggers async work) loading state. Elements that look interactive at rest; hover that shifts color and may add lift — never opacity reduction, which reads as disabled; active feedback that confirms the click registered; disabled that is visibly distinct and explains why when a condition gates it; loading that reads as busy rather than unavailable, and prevents a second submission (*Forms and destructive actions*). Skeleton, spinner, or progress indicator for data fetched on render. For long tasks: a determinate bar when the percentage is knowable, a step indicator for multi-stage work, and an honest indeterminate indicator otherwise — never just a spinner. Silent successes and silent failures both feel broken.

**Preserve the product contract.** Treat requirements as the source for behavior, scope, and states, and visual direction as a separate decision. Identify missing or contradictory handoff details before implementing. Report a contract deviation rather than quietly omitting a scoped capability.

## Direction Check

Before coding, answer:

- What evidence makes this direction belong to this product rather than a similar one?
- What will dominate the first viewport, and should it?
- Which specific pattern from Section 2 was deliberately rejected, and what replaces it?
- What would make this direction fail at real content density?
- Which choice is reversible if the first render disproves it?
- What single element is the memorable one, and is everything around it quiet?
