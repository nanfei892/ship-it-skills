---
name: ship-it-performance
description: "Measure, diagnose, optimize, and verify user-visible performance across frontend, backend, API, database, job, and full-stack product flows. Use when an application feels slow, latency or throughput regresses, Core Web Vitals or bundle size miss targets, an endpoint or query is expensive, memory or CPU grows, load capacity is unknown, caching is being considered, or a release needs performance baselines and budgets. Establish a reproducible baseline, identify the highest-impact bottleneck with evidence, implement focused improvements, compare before and after under equivalent conditions, and add regression protection. Do not use for general feature work, visual redesign, standalone security review, cloud architecture, or cost optimization without a measured performance problem."
---

# Ship It: Performance

Improve one important product journey with measurements users can feel and reviewers can reproduce. Optimize the bottleneck, not the most fashionable layer or an isolated benchmark score.

## Commit to a measurable outcome

- Treat the product blueprint, critical frontend flow, backend contract, security handoff, repository, and available telemetry as inputs.
- Respect the requested mode. For diagnosis, measure and report without editing. For optimization, implement focused changes and verify them.
- Preserve correctness, security invariants, accessibility, data freshness, and product behavior. Never gain speed by weakening authorization, validation, privacy, durability, or user feedback.
- Ask only when the target journey, representative workload, environment, production testing authority, or a behavior-changing tradeoff cannot be inferred safely.
- Do not run load tests against production or third-party services without explicit authorization. Prefer local, test, or staging environments with bounded traffic.
- Preserve the existing stack and observability patterns. Add dependencies only when existing tools cannot produce the evidence needed.
- Do not promise scale, capacity, or production latency from a development-machine benchmark alone.

## Inspect the system and its constraints

1. Read repository instructions, manifests, build configuration, deployment assumptions, test commands, telemetry, and the current worktree.
2. Trace the critical journey across browser work, network requests, server handlers, external calls, database access, serialization, queues, and rendering.
3. Inspect nearby performance patterns: pagination, indexes, caches, batching, streaming, image and font handling, code splitting, connection pools, timeouts, and limits.
4. Identify the security constraints from the previous stage, especially tenant isolation, authorization, rate limits, sensitive data, and cache boundaries.
5. Choose an environment and dataset representative enough for the decision. Record important differences from production.

Prefer an end-to-end trace of the slow journey before profiling individual functions.

## Define the performance contract

Write a compact contract before changing code:

- **Journey:** the user action or system operation being improved.
- **Workload:** data size, concurrency, request mix, device, network, cache state, and warm or cold conditions.
- **Primary metric:** the one measure that best represents user or operational impact.
- **Guardrails:** correctness, errors, freshness, memory, CPU, database load, bundle size, or cost signals that must not regress.
- **Target:** an existing product budget, or a clearly labeled proposed target when none exists.
- **Environment:** exact command, build mode, runtime, dataset, and tooling needed to reproduce the measurement.

Choose only relevant metrics:

| Surface | Useful measures |
| --- | --- |
| User experience | LCP, INP, CLS, time to usable content, interaction completion time |
| Network and frontend | TTFB, request count, transferred bytes, critical resource timing, JavaScript and CSS size, render count |
| API and jobs | p50/p95/p99 latency, throughput, error rate, queue delay, work per operation |
| Database | query count, query time, rows scanned, plan shape, lock time, connection use |
| Runtime | CPU time, memory, allocations, event-loop or thread saturation, garbage collection |

Do not substitute a synthetic score for the product metric it approximates.

## Establish a trustworthy baseline

- Build and run in the mode relevant to release; do not compare a development build with a production build.
- Warm up runtimes when appropriate, then run enough repetitions to expose variance. Report a distribution or median and tail, not only the best run.
- Keep hardware, dataset, cache state, concurrency, network conditions, and measurement tooling equivalent between comparisons.
- Capture correctness and error rate with the timing. A faster failed request is not an improvement.
- Save the command and key settings needed to reproduce the baseline. Use existing benchmark or profiling harnesses when available.
- Mark noisy, simulated, or environment-limited measurements honestly.

If no credible baseline can be obtained, stop short of claiming an improvement. Report the instrumentation or environment gap instead.

## Locate the dominant bottleneck

Decompose elapsed time or resource use across the journey, then use the closest evidence source:

- browser performance traces, network waterfalls, component profilers, and bundle analyzers;
- server traces, request timing, sampling or instrumenting profilers, and structured logs;
- database query logs, query plans, row estimates, lock observations, and query counts;
- queue timing, dependency timing, allocation profiles, and saturation metrics.

Form one testable hypothesis at a time. Prefer the bottleneck with the highest user impact, evidence confidence, and reversible improvement cost. Reject changes whose theoretical benefit is outside the measured hot path.

## Optimize the responsible layer

Apply the smallest change that removes the measured constraint:

- **Frontend:** shorten the critical rendering path, reduce shipped or executed code, stabilize rendering, load media appropriately, split non-critical work, and virtualize only genuinely large collections.
- **Network:** remove duplicate requests, compress and shape payloads, reuse connections, prioritize critical resources, and avoid serial dependencies where semantics allow concurrency.
- **Backend:** eliminate repeated work, batch compatible operations, bound fan-out, reuse expensive clients, move non-critical work off the response path only when delivery semantics remain correct, and stream when it improves real latency.
- **Database:** remove N+1 access, select only needed data, paginate bounded results, batch writes safely, and add or change indexes only after validating the query plan and write cost.
- **Cache:** define ownership, key dimensions, tenant isolation, freshness, invalidation, TTL, eviction, stampede behavior, failure mode, and observability before adding it.
- **Runtime:** reduce allocations or contention in demonstrated hot paths, right-size concurrency and pools from measurements, and keep backpressure explicit.

Change one dominant variable at a time when practical. Avoid broad rewrites, speculative micro-optimizations, and complexity whose maintenance cost exceeds the measured gain.

## Verify the improvement

1. Run the same workload and measurement procedure before and after the change.
2. Compare the primary metric, relevant tail, variance, error rate, and guardrails.
3. Run correctness, security, type, lint, build, and integration checks appropriate to the changed path.
4. Exercise cold and warm behavior when caching, startup, compilation, or connection setup affects the result.
5. Test representative low and high data volumes. Check that improvement does not collapse at realistic scale.
6. Revert or revise changes whose gain is within noise, shifts cost to another critical resource, or introduces unacceptable complexity.

For load and capacity tests, define rate, duration, concurrency, data isolation, success criteria, and stop conditions before running. Stop on unexpected errors, unsafe resource saturation, or impact outside the authorized environment.

## Prevent regression

Add the lightest durable guard that fits the repository:

- a focused benchmark for a stable hot path;
- a query-count or query-plan assertion for database regressions;
- a bundle-size or asset budget;
- a browser journey budget for a stable lab environment;
- an API latency or throughput threshold in a controlled performance test;
- telemetry and an alert recommendation when CI cannot reproduce production behavior.

Keep noisy benchmarks out of blocking CI until variance is understood. Store budgets beside the configuration or test that enforces them, using existing project conventions.

## Definition of done

Do not call the scoped journey optimized until:

- the baseline and comparison are reproducible and use equivalent conditions;
- evidence identifies the changed code or resource as a meaningful bottleneck;
- the primary metric improves beyond expected noise or meets the agreed budget;
- correctness, error rate, security invariants, accessibility, and data freshness remain intact;
- CPU, memory, database load, bundle size, and external calls have no material hidden regression relevant to the change;
- a regression budget, test, or monitoring recommendation protects the gain;
- environment limits and remaining bottlenecks are explicit;
- the release handoff states whether the product meets its performance gate.

## Hand off the result

Lead with the user-visible or operational improvement, then report:

1. **Gate:** meets budget, improved but below budget, unchanged within noise, or blocked.
2. **Measurement:** journey, workload, environment, commands, and primary metric.
3. **Result:** compact before/after comparison including guardrails.
4. **Change:** the proven bottleneck and the focused fix.
5. **Regression protection:** budget, test, or telemetry added.
6. **Remaining limits:** the next bottleneck, unverified production assumptions, and safe follow-up.

Reference the changed files. Do not bury the comparison under a file-by-file implementation log or claim improvement from code inspection alone.

## Related Skills

Pipeline: **ship-it-mvp** → **make-ui-not-ai** (set the visual direction and build the real interface) → **ship-it-backend** → **ship-it-security** → **ship-it-performance** (this skill).

Frontend stage: [make-ui-not-ai](https://github.com/nanfei892/ship-it-skills/tree/master/make-ui-not-ai).
