---
name: ship-it-security
description: "Threat-model, review, harden, and verify security for a product, feature, frontend, backend, API, authentication flow, integration, or release candidate. Use for dedicated security reviews, secure-by-default implementation, OWASP-style application checks, authorization and tenant-isolation audits, session or token handling, secret exposure, dependency risk, file upload, webhook, payment, privacy, or pre-release security readiness. Produce evidence-backed findings, implement focused fixes when authorized, add regression tests, and hand off explicit release blockers and residual risk. Do not use for routine security inside a single backend feature, performance tuning, compliance certification, or unauthorized penetration testing."
---

# Ship It: Security

Make the requested product path meaningfully safer and prove it. Prioritize reachable, high-impact abuse cases over checklist completion, scanner volume, or speculative hardening.

## Commit to a safe scope

- Treat the repository, product brief, frontend flow, backend contract, deployment configuration, and previous handoffs as inputs.
- Respect the requested mode. For a review, inspect and report without changing files. For hardening or fixing, implement focused remediations and verify them.
- Work only on systems and environments the user has placed in scope. Do not probe third parties or run intrusive tests against production without explicit authorization.
- Never print, copy, commit, or replay live secrets or private user data. Redact evidence while preserving enough context to reproduce the issue safely.
- Ask only when authorization, the target environment, a breaking security decision, credential rotation, destructive migration, or accepted risk requires the user's choice.
- Preserve existing product behavior and repository conventions unless they create the security defect being fixed.
- Do not claim compliance, certification, exhaustive coverage, or absence of vulnerabilities.

## Inspect before judging

1. Read repository instructions, manifests, lockfiles, configuration, environment examples, test commands, and the current worktree.
2. Trace the sensitive user journeys through client code, routes, validation, identity, authorization, business rules, persistence, external calls, and logging.
3. Inspect session and token handling, tenant or ownership boundaries, privileged operations, secret loading, dependency controls, browser security, uploads, webhooks, and administrative paths that are relevant to the scope.
4. Identify existing security middleware, shared policies, error envelopes, audit events, rate limits, cryptographic libraries, and test fixtures before proposing replacements.
5. Distinguish source-code evidence from deployment assumptions. Mark controls that depend on proxies, cloud settings, secret stores, or runtime configuration as unverified unless they can be inspected.

Prefer one complete trace of each critical path over shallow scanning of every file.

## Build a compact threat model

Define the security contract before editing:

- **Assets:** data, money, credentials, privileged actions, availability, or trust that must be protected.
- **Actors:** anonymous, authenticated, tenant member, owner, administrator, service, webhook sender, or attacker capabilities relevant to the path.
- **Entry points:** UI actions, APIs, jobs, files, redirects, webhooks, headers, cookies, messages, and configuration.
- **Trust boundaries:** browser to server, service to service, tenant to tenant, application to database, and application to external provider.
- **Security invariants:** statements that must remain true regardless of entry point or client behavior.
- **Abuse cases:** the smallest credible ways an actor could violate an invariant.

Rank abuse cases by reachability, required access, impact, affected population, and existing defenses. Start with the highest combined risk.

## Investigate by attack surface

Cover only surfaces that exist in the scoped product path:

- **Identity and access:** authentication bypass, account recovery, session lifecycle, token audience and expiry, authorization, ownership, role changes, and tenant isolation.
- **Input and execution:** injection, unsafe deserialization, path traversal, template or command execution, open redirects, and server-side request forgery.
- **State and integrity:** CSRF, replay, mass assignment, race conditions, duplicate operations, invalid state transitions, and missing transaction boundaries.
- **Browser and client:** XSS, unsafe HTML, sensitive browser storage, cross-origin policy, clickjacking, content security policy, and source-map or debug leakage.
- **Data and privacy:** over-broad responses, logs, exports, backups, retention, error leakage, encryption assumptions, and access to sensitive fields.
- **Files and external boundaries:** upload type and size, archive extraction, object access, webhook authenticity, callback validation, dependency timeouts, and untrusted provider responses.
- **Supply chain and configuration:** vulnerable reachable dependencies, lockfile integrity, unsafe defaults, debug mode, exposed services, permissive headers, and secrets committed to source.

Do not label a category as safe merely because a scanner is quiet. Do not report a vulnerability without a concrete code path, unsafe condition, or missing control.

## Prove and prioritize findings

For every material finding, record:

1. the affected asset and invariant;
2. the exact reachable path and attacker prerequisites;
3. concise redacted evidence;
4. realistic impact and scope;
5. the smallest durable remediation;
6. a test or observation that proves the remediation.

Use severity labels consistently:

| Severity | Release meaning |
| --- | --- |
| Critical | Credible path to catastrophic compromise; block release and address immediately. |
| High | Credible path to major unauthorized access, data loss, fraud, or code execution; block release. |
| Medium | Meaningful weakness with constrained impact or prerequisites; fix before release when feasible or record an owner and deadline. |
| Low | Limited-impact hardening or defense-in-depth gap; schedule deliberately. |

Lower severity when exploitability depends on an unverified assumption. Raise confidence only when evidence supports it. Avoid inflated scores and duplicate findings with one root cause.

## Fix the root cause

When changes are authorized:

- Enforce identity, authorization, ownership, and state invariants on the trusted server boundary.
- Validate and normalize untrusted input before use; encode output for its destination; use parameterized or framework-safe data access.
- Use established, reviewed libraries for passwords, tokens, signatures, encryption, and randomness. Never invent cryptographic schemes.
- Make sessions and credentials short-lived and revocable where the product requires it; use secure cookie and transport settings appropriate to the runtime.
- Protect retryable or externally triggered actions with authenticity checks, replay controls, idempotency, and bounded resource use.
- Minimize sensitive data collection, response fields, logs, browser storage, and privilege. Prefer secure defaults and explicit allowlists.
- Keep migrations additive and data-preserving. Surface credential rotation, forced logout, key replacement, or compatibility breaks before executing them.
- Upgrade only the dependencies needed to remove a reachable risk, then inspect changelogs and run the repository's normal gates.

Do not silence a scanner, hide an error, add a header, or wrap code in validation unless it closes the demonstrated path.

## Add security regression evidence

Add focused tests at the lowest level that proves the security invariant. Prefer an exploit-shaped negative test plus a legitimate positive test.

Exercise relevant cases such as:

- anonymous, wrong-role, wrong-owner, and cross-tenant access;
- malformed, oversized, duplicate, expired, replayed, or tampered input;
- unsafe state transitions and concurrent attempts;
- output encoding, redirect allowlists, file boundaries, and webhook signatures;
- secret and sensitive-field redaction in responses and logs;
- dependency or external-service failure without fail-open behavior.

Run the narrowest tests first, then applicable type, lint, build, integration, dependency, and configuration checks. Use the repository's existing security tools when present. Introduce a new scanner only when it materially improves coverage and its output can be triaged.

## Set the release gate

Do not call the scoped path security-ready until:

- assets, trust boundaries, invariants, and credible abuse cases are explicit;
- every Critical and High finding is fixed and verified, or the user explicitly accepts the documented risk;
- server-side access control and validation cover every scoped entry point;
- secrets and sensitive data are absent from committed code, client bundles, errors, and logs examined;
- relevant replay, concurrency, upload, external-call, and resource-exhaustion risks have bounded behavior;
- regression tests prove the fixed path without breaking legitimate use;
- environment-dependent controls and unverified assumptions are clearly separated from proven controls;
- performance follow-up receives the security constraints it must not weaken, especially authorization, validation, privacy, rate limits, and cache isolation.

## Hand off the result

Lead with the release decision, then report:

1. **Gate:** ready, ready with accepted risk, or blocked.
2. **Fixed:** root causes removed and security invariants now enforced.
3. **Findings:** remaining items ordered by severity, each with evidence, impact, and remediation.
4. **Verification:** commands and meaningful attack-shaped cases exercised.
5. **Assumptions:** deployment controls, external systems, or paths that were not verifiable.
6. **Performance constraints:** controls the next optimization stage must preserve.

Reference the affected files and keep proof redacted. Do not bury release blockers under informational hardening notes.
