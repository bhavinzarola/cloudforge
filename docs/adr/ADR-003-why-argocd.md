# ADR-003: Why ArgoCD?

- Status: Accepted
- Date: 2026-10-04

## Context
Deployments must be declarative, auditable and self-healing, with Git as the single source of truth and an easy rollback path.

## Decision
Use ArgoCD with the app-of-apps pattern. CI never talks to the cluster; it only commits desired state to the GitOps config.

## Alternatives considered
- Flux: excellent and lighter, but weaker UI for demonstrating drift/rollback.
- Push-based kubectl/helm from CI: needs cluster credentials in CI, no drift correction.

## Consequences
- Positive: drift detection and auto-heal, visual health, no cluster credentials in CI.
- Negative: ArgoCD itself is critical infrastructure and needs hardening (SSO/RBAC, no public admin UI).
- Rollback is a Git revert (preferred) or an ArgoCD history rollback in an incident.
