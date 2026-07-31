---
name: ship-it-mvp
description: "Turn a rough product or app idea into a build-ready MVP blueprint: a focused product brief, scope, user flow, acceptance criteria, architecture recommendation, and dependency-ordered implementation plan. Use when a user says 'build my idea', asks for an MVP, PRD, product requirements, product spec, app scope, feature breakdown, user flow, acceptance tests, launch plan, or needs to make a vague software concept actionable."
---

# Ship It: MVP Blueprint

Create a decision-ready blueprint before writing code. Optimize for a small first release that proves one valuable user outcome, not for feature completeness.

## Intake

Extract these facts from the request, repository, and supplied material:

- target user and the moment they need help
- painful job-to-be-done and desired end state
- platform, constraints, integrations, deadline, and existing assets
- evidence of success and the riskiest unknown

Ask at most three decisive questions only when an answer would materially change the MVP. Otherwise proceed with a short `Assumptions` section. Do not invent customer research, legal compliance, pricing, technical constraints, or integrations.

## Scope the MVP

Define exactly one primary user, one core job, and one end-to-end happy path. Include no more than three supporting capabilities unless the user explicitly requires more.

Classify every requested capability:

| Class | Meaning |
| --- | --- |
| Now | Required for the primary journey to reach its done state. |
| Next | Valuable after the first user outcome has been proven. |
| Not now | Deliberately excluded; name the reason or trigger for reconsidering it. |

Prefer a reversible local implementation when an external service, account, API key, payment flow, or production infrastructure is not already available. Surface the biggest risk early with a low-cost validation step.

## Deliver the Blueprint

Use these headings in order. Keep language concrete enough that a designer or engineer can begin work without a follow-up meeting.

```markdown
# [Product] MVP Blueprint

## Outcome
- **Primary user:**
- **Job:** When ..., I want to ..., so I can ...
- **Success signal:**

## Assumptions
- ...

## MVP Scope
| Now | Next | Not now |
| --- | --- | --- |
| ... | ... | ... |

## Core User Flow
1. ...
2. ...
3. ...

## Requirements and Acceptance Criteria
### [Capability]
- Requirement: ...
- Given ..., when ..., then ...
- Empty, loading, error, and permission states: ...

## Technical Shape
- **Recommended stack:**
- **Data entities:**
- **Interfaces/integrations:**
- **Security and privacy:** State only constraints supported by the brief; otherwise list open questions.

## Build Plan
1. [Milestone] - deliverable, dependencies, and proof it works.
2. ...

## Risks and Validation
| Risk | Cheapest validation | Decision after result |
| --- | --- | --- |
| ... | ... | ... |
```

Write acceptance criteria for every `Now` capability. Cover a successful result plus the state most likely to block that user. Define observable outcomes rather than implementation details.

## Repository-Aware Work

When an existing codebase is in scope, inspect its project structure, package manifest, routing, data model, and tests before proposing a stack or plan. Preserve established conventions. Identify the narrowest files or modules likely to change, then map each build-plan item to them where possible.

When the user asks to implement immediately, present the blueprint briefly, state the assumptions that affect behavior, then build the first milestone. Keep `Next` and `Not now` work out of the implementation unless the user expands scope.

## Optional Generator

Use `scripts/make_mvp_blueprint.py` when a reusable Markdown file is useful. Supply a JSON brief and generate a deterministic starter blueprint:

```powershell
python scripts/make_mvp_blueprint.py --input brief.json --output mvp-blueprint.md
```

Use this input shape. `now`, `next`, and `not_now` may be empty arrays.

```json
{
  "product_name": "DeskFocus",
  "primary_user": "Remote workers who lose track of deep-work sessions",
  "job": "start and finish one distraction-free work block",
  "success_signal": "A user completes a timed focus session",
  "assumptions": ["The first release is a browser app."],
  "now": ["Create a named session", "Run a timer", "Show completion"],
  "next": ["Weekly history"],
  "not_now": ["Team workspaces"],
  "flow": ["Name a session", "Start timer", "See completion"],
  "risks": [{"risk": "Users may not return", "validation": "Test with five target users", "decision": "Add history only if repeat use is observed"}]
}
```
