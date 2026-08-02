---
name: ship-it-backend
description: Turn product requirements, MVP plans, frontend flows, or rough backend requests into production-minded, verified server-side vertical slices in new or existing codebases. Use for adding or completing an API endpoint, database-backed feature, service workflow, webhook or job, authorization rule, or backend integration including the contract, schema and migrations, business logic, validation, stable errors, integrity controls, focused tests, and a frontend-ready handoff. Preserve an existing repository's stack and patterns. For a new project, let the user choose the database, cache, and relevant middleware before implementation. Do not use for standalone deep security audits, performance tuning, infrastructure design, or cloud deployment.
---

# Ship It: Backend

Ship one backend capability end to end. Turn intent into running code and evidence, not an architecture proposal or a collection of disconnected layers.

## Commit to the outcome

- Treat product requirements, an MVP blueprint, UI flows, tickets, and existing code as inputs to one implementation.
- Resolve ordinary ambiguity from repository conventions and the smallest coherent product behavior. State material assumptions in the handoff.
- Ask only for required greenfield stack choices or when an answer would change an irreversible data contract, a security boundary, an external system, or the fundamental product behavior.
- Preserve the current language, framework, database, package manager, architecture, and local conventions unless the user explicitly requests a change.
- When no backend exists, follow the greenfield selection workflow below instead of silently choosing infrastructure.
- Keep the slice narrow. Do not introduce speculative abstractions, services, queues, caches, or dependencies.
- Finish implementation and proportional verification in the same task. Do not stop after scaffolding, pseudocode, or a plan unless the user asks for one.

## Let the user choose a greenfield stack

When a project has no established backend, obtain the user's infrastructure choices before scaffolding or installing dependencies. Do not ask again for choices already stated in the request or fixed by the repository, hosting environment, or product constraints.

Present one compact selection prompt. Recommend an option when context supports it, explain the recommendation in one sentence, and still let the user choose. Include these choices for every relevant category:

| Category | Example options |
| --- | --- |
| Database | PostgreSQL, MySQL or MariaDB, SQLite, a document database such as MongoDB, none, or a custom choice |
| Cache | Redis or Valkey, in-process cache, none, or a custom choice |
| Background jobs or messaging | Database-backed jobs, RabbitMQ, Kafka, a managed queue, none, or a custom choice |
| Feature-specific middleware | Object storage, search, email delivery, or another dependency only when the product requires it; none or a custom choice |

If the language or framework is also undecided, include two to four compatible options in the same prompt plus a custom choice. Keep the decision understandable by describing product impact such as operational effort, local simplicity, scaling characteristics, or hosting compatibility rather than listing brand names without context.

- Always offer **Custom** so the user can enter a component not listed.
- Always offer **None** for optional middleware. Choosing none means do not install, configure, or scaffold that component.
- Do not propose a queue, cache, search engine, or object store without a concrete requirement for it.
- Flag incompatible combinations and offer compatible alternatives, but leave the final choice to the user.
- Wait for confirmation before provisioning services, adding infrastructure dependencies, or creating framework-specific persistence code.
- After confirmation, start with one deployable service and establish migrations and a test harness with the first slice.
- Record the selected components and intentionally omitted middleware in the final handoff.

## Inspect before designing

Read the repository before choosing an implementation:

1. Find repository instructions, manifests, configuration, and the commands used for tests, linting, type checks, migrations, and local execution.
2. Trace one nearby feature through its route or handler, validation, authorization, domain or service logic, persistence, errors, and tests.
3. Inspect the current schema, migration history, transaction helpers, ID and timestamp conventions, and test fixtures.
4. Identify shared API response shapes, pagination rules, error middleware, logging, background-job patterns, and external-client wrappers.
5. Check the worktree and preserve unrelated user changes.

Prefer the closest working local pattern over generic framework advice. Add a new abstraction only when the requested slice cannot fit the existing structure cleanly.

## Define the contract

Before editing, reduce the request to a compact delivery contract:

- **Actor and capability:** who performs which action.
- **Inputs:** path, query, body, headers, event payload, or job arguments.
- **Success:** observable response or side effect, including status and response shape when applicable.
- **Invariants:** truths that must hold regardless of entry point, such as ownership, legal state transitions, uniqueness, limits, and resource availability.
- **Failures:** invalid input, unauthenticated or forbidden access, missing resources, conflicts, dependency failure, and retry behavior relevant to this capability.
- **State change:** records created or modified, external effects, and transaction boundary.

Infer this contract from the product flow and existing API style. Do not create a separate specification file unless the repository already treats one as the source of truth.

## Model truth and invariants

- Put business invariants in the domain or service layer so every entry point shares them; do not rely on the UI to enforce them.
- Use database constraints for truths the database can guarantee: uniqueness, nullability, referential integrity, and valid bounded values when supported locally.
- Keep transport DTOs, domain values, and persisted records distinct when their semantics differ. Avoid mapping layers that merely rename identical fields.
- Use the repository's ID, money, time, timezone, enum, soft-delete, and audit-field conventions. Store money and time without lossy floating-point or locale assumptions.
- Make migrations deterministic and compatible with the project's deployment style. Prefer an additive migration and staged backfill when existing rows make a direct constraint unsafe.
- Never silently rewrite or delete existing production data. Surface destructive or irreversible migration decisions before executing them.

## Implement the vertical slice

Work through the full path while keeping each layer responsible for one kind of decision:

1. Add or update the schema and migration when persistence changes.
2. Define the public contract using the repository's route, schema, serializer, or event conventions.
3. Validate and normalize untrusted input at the boundary. Reject unknown or malformed values according to local policy.
4. Authenticate the actor and enforce authorization or resource ownership server-side.
5. Implement business rules in a service or domain unit that is callable outside the transport handler.
6. Perform persistence through existing repositories, ORM patterns, or query helpers.
7. Map outcomes to stable success and error responses without leaking internals.
8. Wire the slice into routing, dependency injection, jobs, configuration, or module registration.

Keep handlers thin enough to expose the flow. Keep services concrete enough that following a state change does not require jumping through ceremonial layers.

## Protect integrity and failure behavior

Apply these controls when the capability actually needs them:

- Wrap dependent writes in one transaction. Keep network calls outside long-running database transactions when possible.
- Treat read-then-write checks as concurrency-sensitive. Prefer constraints, conditional updates, row/version checks, or the established locking pattern.
- Add idempotency for retryable commands, webhooks, payment-like operations, or jobs that may be delivered more than once. Define what identifies the same operation and what response a replay receives.
- Set explicit timeouts and translate expected dependency failures at external boundaries. Preserve enough context for logs without exposing credentials, tokens, stack traces, SQL, or private data to clients.
- Use stable, machine-readable error codes when the project has an error envelope. Keep HTTP status, error code, and retry semantics consistent.
- Log operationally useful events using local structured logging. Do not log secrets or entire sensitive payloads.

Do not turn this work into a broad security audit or performance rewrite. Fix security and integrity issues directly on the requested path; report material adjacent risks separately.

## Test real behavior

Add focused tests at the lowest level that still proves the contract. Reuse the repository's harness and fixtures.

Cover:

- the primary success path and persisted state or side effect;
- invalid input and one relevant authorization or ownership failure;
- missing resource or business conflict behavior;
- rollback for multi-write failures, when transactional integrity matters;
- duplicate delivery, concurrent conflict, or external failure when the slice has that risk;
- migration behavior or schema constraints when they carry important invariants.

Assert observable behavior and stable contracts, not private call order. Avoid mocks for the core persistence behavior when the repository already supports an integration-test database. Mock true external boundaries deterministically.

Run the narrowest relevant tests first, then the repository's normal quality gates that fit the change. If a gate cannot run, distinguish an environment limitation from a code failure and report the exact unverified area.

## Definition of done

Do not call the capability complete until:

- the public entry point is reachable and wired;
- validation, authentication, authorization, and invariants execute on the server;
- schema changes include a valid migration and preserve existing data;
- multi-step state changes have appropriate atomicity and retry behavior;
- expected failures use stable, non-leaking responses;
- focused success and critical failure tests pass;
- generated artifacts or API schemas are refreshed when the repository requires them;
- no placeholder, dead route, bypass, or unrelated refactor remains;
- the frontend or next consumer has an exact integration contract.

## Hand off the result

Lead with what now works. Then report only information needed to review or integrate it:

1. **Shipped:** the user-visible capability and key business rules.
2. **Contract:** method and path or event/job name, auth requirement, request fields, success shape, and stable errors. Use a compact example when it removes ambiguity.
3. **Data:** migration and important constraints or state transitions.
4. **Verification:** commands run and meaningful cases proven.
5. **Assumptions or gaps:** only material decisions, blocked checks, and follow-up risks.

Reference the changed files. Do not bury the outcome under a file-by-file activity log.
