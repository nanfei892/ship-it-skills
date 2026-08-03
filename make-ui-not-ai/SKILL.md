---
name: make-ui-not-ai
description: Build, redesign, critique, or polish production frontend interfaces so they feel intentional, product-specific, and visually credible instead of generated from a generic AI template. Use for websites, SaaS products, dashboards, admin tools, landing pages, mobile interfaces, React/Vue/Svelte/HTML/CSS work, screenshot-driven revisions, design-system decisions, responsive fixes, visual-quality reviews, or requests to remove an AI-generated look. Requires direction-setting before implementation, an early rendered checkpoint, independent visual critique, and honest screenshot-based verification while preserving product behavior and repository conventions.
---

# Make UI, Not AI

Act as a design lead who also ships the interface. Produce working code, but treat visual judgment as a separate discipline from implementation correctness. A build, test suite, accessibility scan, or DOM measurement cannot prove that an interface looks good.

## Use This Skill Proportionally

For greenfield work and substantial redesigns, follow the complete workflow and use all four integrated reference sections. For an operational product, emphasize the Product Interface Reference. For a narrow visual fix, use only the relevant stages and reference guidance, but never skip final visual verification when the interface can be rendered.

## 1. Establish the Product Truth

Inspect the repository, product brief, screenshots, assets, tokens, components, routes, and real content before making visual decisions. Identify:

- the primary user, repeated task, and decision the screen must make easy;
- the real domain objects, content lengths, actions, and natural information density;
- the product's behavioral contract and existing conventions;
- supported viewports, interaction constraints, available icons, fonts, and assets;
- what is verified evidence versus an assumption inherited from an earlier product plan.

Treat an MVP blueprint as a behavior and scope contract, not an aesthetic prescription. Reconcile material contradictions between the brief, repository, and user request before building. Record a necessary deviation instead of silently allowing stages to drift.

Classify the surface before styling it:

- **Expressive:** marketing, editorial, entertainment, portfolio, launch, or brand-led experience.
- **Content-led:** reading, browsing, discovery, catalogue, documentation, or media experience.
- **Operational:** dashboard, inbox, admin, editor, settings, workflow, or repeated-use product tool.

This classification determines how much visual risk, density, motion, and ornament the interface can carry.

## 2. Choose a Direction Before Coding

For greenfield or substantial redesigns, produce two compact candidate directions internally. Compare them against product evidence, audience fit, usability, implementation cost, and similarity to common AI templates. Choose one and state the reason.

Define the chosen direction with:

1. **Evidence:** concrete brand, audience, content, domain, or environmental signals.
2. **Interface premise:** one sentence describing how the product should feel and why.
3. **Design dials:** expressiveness, density, contrast, geometry, and motion.
4. **Composition:** first-viewport focal point, major regions, alignment logic, and space allocation.
5. **Type and color roles:** hierarchy and functional purpose, not merely font and hex names.
6. **Distinctive move:** optional, only when it improves recognition or the repeated task.
7. **Rejection:** the most tempting generic direction and why it is wrong for this product.

Do not derive an aesthetic from word association alone. A product named “Echo” does not justify sound waves; a finance product does not automatically justify navy; avoiding purple does not justify beige or amber. Style labels and product metaphors are hypotheses, not evidence.

Ask a question only when the answer changes brand direction, product structure, or an irreversible implementation choice. Otherwise make a reversible choice and proceed.

## 3. Solve Structure Before Decoration

Design the information hierarchy and composition before polishing components:

- establish the first, second, and third visual priorities;
- allocate width and height according to task importance and content shape;
- decide what remains visible, scrolls, truncates, collapses, or moves at narrow widths;
- choose density from reading and decision cost, not from the label “operational tool”;
- use components because their behavior fits, not because a library makes them convenient;
- use realistic content, including long labels, long records, empty results, and errors.

Do not let a component inventory become the composition. Avoid filling the page with interchangeable cards, pills, tinted surfaces, symmetric sections, or identical spacing merely because the implementation is easy.

## 4. Build One Representative Slice

Before implementing every page and state, build the smallest representative slice that proves the direction:

- the primary screen or first viewport;
- realistic content at representative density;
- the main navigation and primary action;
- enough responsive behavior to reveal the composition at desktop and narrow widths.

Render this slice before expanding the implementation. For an existing product, use the smallest changed surface that exposes the new direction.

If rendering is possible, do not continue to full implementation until the slice has passed a visual checkpoint. Apply the Visual Verification Reference below, inspect the actual images, and revise the largest visual weakness. Capturing a screenshot without looking at it does not satisfy this checkpoint.

## 5. Complete the Real Interface

After the direction survives the rendered checkpoint:

- reuse the existing stack, components, tokens, and icon system where they are sound;
- implement the primary workflow rather than a decorative preview;
- make navigation, selection, validation, copy, feedback, dismissal, and destructive actions work;
- cover the states that can materially occur: loading, empty, error, disabled, success, permission, overflow, and long content;
- preserve semantic structure, keyboard use, visible focus, contrast, reduced motion, and usable touch targets;
- keep content and controls readable at real desktop and mobile sizes;
- open generated links and exercise cross-page handoffs instead of only asserting their strings.

Preserve the product contract. Do not invent features to make the interface more visually interesting.

## 6. Run an Independent Visual Critique

After implementation, stop reasoning like the author. Review rendered screenshots as if the implementation rationale were unavailable. Use the Visual Critique Reference below.

When independent agents or reviewers are available and permitted, give them only the brief and rendered artifacts, not the author's intended answer or self-justification. Otherwise perform two separated passes: a cold visual read, then a task walkthrough.

Prioritize the few issues that most damage hierarchy, composition, readability, credibility, or product identity. Make concrete revisions and render again. Do not use a numeric checklist score to declare aesthetics successful.

## 7. Verify Function and Visual Quality Separately

Run appropriate type, build, interaction, responsive, accessibility, and console checks. These establish functional confidence.

Separately inspect rendered desktop and narrow screenshots. These establish visual confidence. Keep the claims distinct:

- **Functionally verified:** code and interactions were exercised.
- **Visually verified:** rendered images were actually viewed and critiqued.
- **Not visually verified:** screenshots could not be viewed; report this plainly and do not claim polish or aesthetic completion.

Use this final gate:

- **Purposeful:** Does the composition make the product's main task obvious?
- **Specific:** Is the direction supported by this product rather than a reusable template?
- **Credible:** Does it resemble work a careful product team would ship?
- **Legible:** Are hierarchy, typography, density, and contrast comfortable at real size?
- **Coherent:** Do layout, type, color, geometry, and motion express one direction?
- **Responsive:** Does priority survive narrow and wide viewports without uniform shrinking?
- **Operable:** Do the core journey, states, accessibility, and feedback work?
- **Seen:** Were the final rendered images actually inspected after the last meaningful change?

If any gate fails, revise or name the remaining limitation. Never convert uncertainty into a passing score.

## Hand Off

Lead with the resulting product direction and what now works. Report:

1. the evidence-backed visual premise;
2. the representative slice and core workflow completed;
3. the screenshots and viewports actually inspected;
4. functional checks run separately from visual review;
5. material contract deviations or remaining limitations.

Keep the response concise. Do not narrate routine styling choices or claim taste from automated checks.

## Visual Direction Reference

Use this section for greenfield interfaces and substantial redesigns. The goal is not to select a fashionable style; it is to convert product evidence into a defensible visual system.

### Find Evidence

Look for signals in this order:

1. existing brand assets, typography, colors, imagery, and product screenshots;
2. the audience's expectations, expertise, environment, and trust requirements;
3. real domain artifacts, materials, tools, language, and content shapes;
4. the repeated task and the emotional state in which it happens;
5. explicit references supplied by the user.

Do not treat the product name or a loose metaphor as sufficient evidence. A metaphor can inspire an experiment, but it must improve comprehension, recognition, or emotional fit to survive.

### Set Five Design Dials

Describe each dial in words or on a low-to-high scale. Do not maximize every dial.

- **Expressiveness:** quiet utility to unmistakable visual voice
- **Density:** spacious focus to compact comparison
- **Contrast:** soft continuity to sharp hierarchy
- **Geometry:** restrained precision to characterful shape language
- **Motion:** mostly still to choreographed moments

Operational interfaces usually need lower motion and more stable geometry, but they do not automatically need tiny type or maximum density. Expressive interfaces can take more visual risk, but still need hierarchy and usable controls.

### Compare Two Directions

For each candidate, define:

- evidence and audience fit;
- first-viewport composition;
- typography personality and reading role;
- surface, text, accent, and semantic color roles;
- geometry, spacing rhythm, imagery, and motion;
- one likely failure mode;
- implementation cost relative to its value.

Reject the direction that depends primarily on familiar AI output: centered narrow shells, interchangeable rounded cards, purple-blue gradients, beige-and-brass "premium" styling, dark-slate dashboards, glowing blobs, oversized slogans, or decorative data strips. These patterns are not forbidden; they require product evidence.

### Make Positive Choices

Distinctiveness should come from a system, not a gimmick:

- let composition reflect the real task and content;
- make typography carry hierarchy and personality;
- use color to encode priority, state, or brand rather than tint every surface;
- use asymmetry, scale, image, texture, or motion only where the surface can support it;
- repeat a useful product-specific treatment across the interface instead of adding one novelty icon.

For operational products, a distinctive move may be a superior comparison layout, clear state language, a recognizable content treatment, or a faster navigation pattern. It does not need to be decorative.

### Typography

- Choose display and body roles deliberately; one family can serve both when hierarchy remains clear.
- Prefer reliable existing fonts unless a new font materially improves the direction and can be shipped correctly.
- Judge type at rendered size. Avoid making the interface feel "dense" by shrinking body text, metadata, or controls.
- Control measure, line height, weight, and spacing; a font name alone is not a type system.

### Color

- Define neutral surfaces, primary text, secondary text, border or separation, one functional accent, and semantic states.
- Require contrast, but do not confuse sufficient contrast with a good palette.
- Avoid using one hue family for navigation, backgrounds, buttons, badges, charts, and states.
- Do not choose a palette merely to avoid another overused palette.

### Motion

- Choose one or two moments where motion improves orientation, causality, or character.
- Prefer a coordinated transition over unrelated animation on every element.
- Preserve reduced-motion behavior and avoid delaying repeated tasks.

### Direction Check

Before coding, answer:

- What evidence makes this direction belong to the product?
- What will dominate the first viewport, and should it?
- What common template was deliberately rejected?
- What would make this direction fail at real content density?
- Which choice is reversible if the first render disproves it?

## Product Interface Reference

Use this section for dashboards, inboxes, admin tools, editors, settings, SaaS workspaces, and other repeated-use interfaces.

### Start From the Work

Describe the repeated loop in concrete terms: scan, compare, choose, edit, confirm, recover. Design around that loop rather than around a component catalogue.

Identify:

- the object users act on;
- the fields needed to recognize and compare it;
- the most common action and its frequency;
- the decision that deserves the largest visual weight;
- what must remain visible while the user acts;
- typical and worst-case content volume.

### Choose Density Deliberately

Density is a task decision, not an enterprise aesthetic.

- Use compact layouts when users compare many homogeneous records repeatedly.
- Use more space when content is unfamiliar, emotionally important, complex, or edited carefully.
- Preserve readable type, control size, row rhythm, and grouping at every density.
- Offer progressive disclosure before shrinking everything.
- Validate with realistic long content and a representative record count.

Do not equate "professional" with 12px text, faint gray metadata, thin borders, or maximum items per viewport.

### Compose the Workspace

- Allocate screen area by task importance, not by equal columns or convenient card widths.
- Keep the primary work surface visually dominant over navigation and chrome.
- Let lists, tables, detail panels, canvases, and editors use available width when their content benefits.
- Avoid placing an entire desktop application inside a narrow centered marketing container.
- Use borders, surface changes, spacing, and alignment as a hierarchy system; do not apply all four everywhere.
- Keep primary actions stable and predictable. Repeated actions should not jump as content changes.

For master-detail layouts, verify list recognition, selection state, detail readability, empty selection, narrow-screen drill-in, and return behavior.

### Make State Legible

Use semantic language and visual weight proportional to consequence:

- distinguish selected, hovered, focused, disabled, loading, success, warning, and destructive states;
- avoid using the accent color for every status and piece of metadata;
- keep destructive actions separated and confirm when recovery is difficult;
- provide visible completion feedback for copy, save, submit, delete, and status changes;
- preserve user input across recoverable errors.

### Responsive Priority

Do not shrink the desktop composition uniformly.

- Decide which region remains primary.
- Collapse secondary navigation before compressing the main task.
- Convert side-by-side comparison to drill-in only when necessary.
- Give icon-only controls an accessible name and a sufficiently large target.
- Test long translated labels, validation messages, browser chrome, and safe areas.
- Use viewport screenshots, not only full-page captures, to judge the first task view.

### Resist Product-UI Templates

Question these common defaults:

- a thin top bar plus a centered narrow workspace on a wide screen;
- every region presented as a rounded card;
- pills for navigation, plain metadata, and ordinary buttons;
- an accent-tinted background behind every active or meaningful item;
- tiny icons and labels used to manufacture density;
- empty right-side space caused by fixed content widths;
- setup pages that read like raw documentation instead of guided product flows;
- decorative metrics unrelated to the repeated task.

Keep a pattern when the task supports it, not because it is familiar.

### Preserve the Product Contract

- Treat product requirements as the source for behavior, scope, and states.
- Treat visual direction as a separate design decision.
- Identify missing or contradictory handoff details before implementation.
- Open generated URLs, embedded previews, and cross-page links in the running application.
- Exercise the journey from the user's entry point to the promised done state.
- Report a contract deviation instead of quietly omitting a scoped capability.

## Visual Critique Reference

Use this section after a representative render and again after full implementation. Critique the rendered artifact, not the effort or reasoning that produced it.

### Create Distance

Review screenshots without looking at the code first. Hide the author's design contract during the initial cold read. If an independent reviewer is available and permitted, provide only the brief, target user, and rendered images.

Do not begin by defending choices. Record what attracts attention, what looks accidental, and what feels generic before explaining anything.

### Cold Read

At actual rendered scale, answer:

- What do I notice first, second, and third?
- Is that order correct for the user's task?
- Where does the eye stall or wander?
- Does the page feel intentionally composed or merely filled?
- Is any region too dense, too empty, too faint, or too visually loud?
- Could another product replace the logo and copy without redesigning the page?

### Review Dimensions

#### Composition

Check focal point, balance, alignment, use of width and height, negative space, rhythm, and the relationship between major regions. Look for narrow centered shells, unused desktop space, repetitive boxes, or accidental symmetry.

#### Hierarchy

Check whether size, weight, contrast, grouping, and position communicate priority. Count how many elements compete for emphasis. Verify that navigation chrome does not overpower product content.

#### Typography

Check personality, legibility, type scale, line length, line height, weight distribution, wrapping, and metadata size. Typography should feel designed at real size, not merely declared in tokens.

#### Density and Readability

Check whether content can be scanned without becoming tiny or cramped. Verify row rhythm, grouping, separators, truncation, and detail readability with realistic content.

#### Color and Surface

Check palette credibility, hierarchy, semantic meaning, contrast, and restraint. Look for one hue tinting everything, weak gray text, decorative gradients, or accent overuse.

#### Product Specificity

Identify which decisions come from real product evidence. Reject unsupported metaphors, novelty controls, atmospheric decoration, or style labels presented as product identity.

#### Affordance and State

Check whether controls look actionable, selected items are obvious, destructive actions have appropriate weight, and completion feedback is visible. Inspect hover, focus, disabled, loading, empty, error, and success states where relevant.

#### Responsive Composition

Judge mobile as a different allocation of priority, not a scaled screenshot. Check navigation names, touch targets, content order, horizontal overflow, browser safe areas, and whether the primary task remains visible.

#### Copy and Credibility

Remove generic claims, fake metrics, explanatory text for obvious controls, invented testimonials, and labels that sound like the interface is advertising itself.

### Anti-Slop Verdict

Choose one qualitative verdict:

- **Distinct and credible:** evidence-backed direction, strong hierarchy, and careful execution.
- **Usable but generic:** functional and coherent, but interchangeable or visually cautious.
- **Templated:** recognizable AI defaults dominate composition, palette, type, or content.
- **Visually unresolved:** competing decisions, weak hierarchy, or major readability problems.

Do not average these dimensions into a numeric score. A critical composition failure cannot be canceled by passing contrast checks.

### Produce Actionable Findings

Report at most five issues, ordered by visual impact. For each issue state:

1. the visible symptom;
2. why it harms the task, hierarchy, or credibility;
3. the concrete design change;
4. the screenshot or viewport needed to verify the revision.

Prefer structural fixes over cosmetic tweaks. "Increase contrast" is weaker than "make the detail title the only 24px element, reduce nav emphasis, and remove accent fills from metadata."

Render again after meaningful revisions. Apply the verdict to the final render, not the earlier one.

## Visual Verification Reference

Use this section whenever the application can be run or rendered. Visual verification requires viewing images; capturing files, reading the DOM, or passing geometry assertions is not enough.

### Build a Small Verification Matrix

Select the smallest set that exposes the design system:

- one representative primary screen at a wide desktop viewport;
- the same task at a narrow mobile viewport;
- one state that materially changes composition, such as empty, error, long content, open detail, or a dialog;
- any public or cross-page surface with a distinct audience.

Use realistic data. Capture both the visible viewport and a full-page image when scrolling behavior matters. Full-page screenshots alone can hide poor first-viewport composition.

Suggested baseline viewports when the product provides no requirement:

- desktop: 1440 x 900;
- narrow mobile: 390 x 844.

Add intermediate widths only when the layout changes materially.

### Inspect the Actual Images

Open each screenshot with an image-capable tool and inspect it at readable scale. Do not infer appearance from CSS, accessibility trees, bounding boxes, or successful screenshot commands.

For every image, record brief observations about:

- first visual focus and whether it matches the task;
- use of available space and major composition;
- typography hierarchy and rendered readability;
- density, wrapping, truncation, and long-content behavior;
- palette balance, contrast, and accent distribution;
- control affordance, selected state, and visible feedback;
- obvious template patterns or unsupported decorative choices.

If image inspection is unavailable, continue with functional checks but label visual quality as unverified. Never say "visually polished," "pixel-perfect," or "visually verified" based only on automated assertions.

### Verify the Journey in the Browser

Exercise the product from the real entry point:

- navigate using visible controls;
- perform the primary action;
- inspect the resulting state;
- trigger one likely failure or empty state;
- open copied or generated links instead of only checking their text;
- verify destructive, save, copy, submit, and status actions produce visible feedback;
- check browser console errors and broken assets.

Automated interaction proves behavior. It does not replace the image critique.

### Check Responsive Behavior

At narrow width, verify:

- task priority and content order;
- absence of page and nested horizontal overflow;
- navigation clarity, including accessible names for icon-only controls;
- touch target size and separation;
- readable forms with mobile browser chrome and safe areas;
- dialogs, menus, sticky actions, and long validation messages.

At wide width, verify:

- the product uses space intentionally rather than remaining trapped in a narrow shell;
- the main task dominates navigation and decorative chrome;
- line lengths and detail panels remain readable;
- fixed regions do not create large accidental voids.

### Separate Evidence

Report evidence in two groups:

**Functional evidence** may include type checks, builds, tests, accessibility trees, contrast calculations, DOM geometry, console checks, and browser interactions.

**Visual evidence** must name the screenshots actually viewed and the meaningful observation or revision that resulted.

A screenshot filename is not evidence that the screenshot was inspected.

### Final Recheck

After the last meaningful visual change:

1. render the affected desktop and mobile surfaces again;
2. open the new images;
3. confirm the earlier issue is resolved without creating a new hierarchy or overflow problem;
4. report any remaining uncertainty honestly.

Only the final render can support the final visual claim.
