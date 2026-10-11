# ADR-006: Why Kyverno?

- Status: Accepted
- Date: 2026-10-04

## Context
Guardrails (non-root, approved registries, resource limits, no latest tags, required labels) must be enforced at admission, not just documented.

## Decision
Use Kyverno with policies written as Kubernetes YAML, tested in CI with the Kyverno CLI, rolled out in Audit mode before Enforce.

## Alternatives considered
- OPA Gatekeeper: powerful but Rego has a steeper learning curve.
- Pod Security Admission only: covers pod hardening but not registries, labels, or image signatures.

## Consequences
- Positive: readable policies, image signature verification, mutation for defaults.
- Negative: webhook failures can block deployments; mitigated with HA replicas and exclusions for system namespaces.
- Every policy is documented with intent, scope and exceptions.
