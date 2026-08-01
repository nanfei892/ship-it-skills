---
name: make-ui-not-ai
description: Build, redesign, or review production frontend interfaces so they feel specific to the product instead of generated from a generic AI template. Use for websites, web apps, dashboards, admin panels, landing pages, mobile interfaces, React/Vue/Svelte/HTML/CSS work, screenshot-driven UI revisions, visual polish, responsive fixes, design-system decisions, or requests to remove an "AI-generated" look while preserving usability and existing product conventions.
---

# Make UI, Not AI

Produce a working interface with a clear product identity. Derive visual decisions from the users, tasks, content, and codebase; do not begin from a fashionable style label or a reusable landing-page formula.

## Read the Product Before Styling It

Inspect the repository, supplied screenshots, assets, design tokens, and existing components before making visual decisions. Identify:

- the primary user and the action they repeat most often
- the real domain objects, their important fields, and their natural density
- the screen's single priority and the actions that must remain easy to find
- existing brand, component, navigation, spacing, and typography conventions
- technical constraints, supported viewports, and available icon or chart libraries

If the brief is incomplete, infer only reversible design details. State assumptions in the response, not as instructional copy inside the interface. Ask a question only when the answer would change the product structure or brand direction.

## Establish a Design Contract

Before implementation, write a compact internal contract with these decisions:

1. **Product signal:** The object, workflow, or artifact that makes the product recognizable in the first viewport.
2. **Information shape:** Dense table, focused editor, feed, catalogue, canvas, timeline, or another structure justified by the task.
3. **Visual premise:** One sentence connecting the interface's character to its subject and audience.
4. **Type system:** Display and body roles, scale, weights, and line lengths. Prefer existing project fonts; add a font only when the environment supports it reliably.
5. **Color system:** Neutral surfaces, readable text, one functional accent, and semantic success/warning/error colors. Derive color from the product rather than defaulting to purple-blue, beige, or dark slate.
6. **Geometry and rhythm:** Container width, grid, spacing increments, control heights, radii, and borders.
7. **Signature decision:** One defensible detail that belongs to this product, such as a domain-specific visualization, navigation behavior, content treatment, or interaction.

Keep the contract coherent with the product type. Operational tools should optimize scanning, comparison, and repeated action. Editorial, entertainment, portfolio, and brand experiences may use more expressive composition when the content supports it.

## Build the Real Interface

Implement the primary workflow, not a decorative preview of it.

- Reuse the project's stack, components, tokens, and icon library.
- Use realistic content shapes and labels. Avoid filler metrics, generic testimonials, vague calls to action, and repeated marketing copy.
- Match components to behavior: icons for familiar tools, tabs for views, toggles for binary settings, menus for option sets, inputs for values, and tables or lists for comparable data.
- Make controls functional. Include expected navigation, selection, validation, feedback, and dismissal behavior.
- Cover loading, empty, error, disabled, success, permission, overflow, and long-content states when they can occur.
- Preserve accessibility: semantic elements, labels, keyboard use, visible focus, sufficient contrast, reduced-motion behavior, and touch targets.
- Use assets that reveal the actual product or subject. Do not substitute atmospheric decoration when users need to inspect an object, place, person, or result.

## Remove Template Tells

Run a deliberate second pass and revise any pattern that lacks a product reason:

- a huge slogan where the product itself should be visible
- a three-stat strip, feature-card grid, or bento layout added only to fill space
- every section floating in a rounded card, especially cards nested inside cards
- pills used for ordinary buttons, labels, navigation, or plain metadata
- excessive gradients, glass effects, blurred color blobs, shadows, or accent glows
- one hue family tinting every surface and state
- arbitrary `01 / 02 / 03` labels for content that is not a sequence
- oversized headings inside compact tools, sidebars, tables, or cards
- identical spacing and alignment across every section regardless of content
- animations on every element instead of one purposeful transition
- instructional text that explains obvious controls or advertises the UI itself

Do not remove a pattern merely because it appears on this list. Keep it when the product, content hierarchy, or established design system clearly calls for it. The test is whether the choice is specific and useful, not whether it is fashionable.

## Make It Survive Real Viewports

Define stable layout constraints for boards, grids, toolbars, counters, media, and other fixed-format elements. Verify that dynamic content cannot resize controls or overlap adjacent content.

For responsive behavior:

- preserve task priority instead of shrinking the desktop composition uniformly
- decide what reflows, scrolls, collapses, truncates, or moves into a menu
- keep important product content visible in the first viewport
- allow long words, translated copy, validation messages, and empty states to fit
- avoid viewport-width font scaling; use a deliberate responsive type scale

## Verify Before Calling It Done

When tools permit, run the application and inspect screenshots at a desktop viewport and a narrow mobile viewport. Exercise the primary workflow and at least one non-happy state. Check console errors, broken assets, overflow, overlap, focus visibility, and interaction feedback.

Do not claim visual verification if the interface was not rendered. Report what was checked and any remaining uncertainty.

Use this finish gate:

- **Specific:** Could the interface belong to a different product without meaningful changes? If yes, revise it.
- **Useful:** Is the primary task obvious and efficient without explanatory UI copy?
- **Complete:** Do controls work and expected states exist?
- **Coherent:** Do type, color, geometry, density, and motion express one direction?
- **Responsive:** Does the task remain usable at both narrow and wide widths?
- **Accessible:** Can keyboard, touch, and assistive-technology users operate it?
- **Verified:** Was the rendered result inspected rather than inferred from code alone?

## Report the Work

Keep the final response concise. Name the product-specific direction, the key behavior implemented, the viewports or workflows verified, and any genuine remaining limitation. Do not narrate routine styling decisions.
