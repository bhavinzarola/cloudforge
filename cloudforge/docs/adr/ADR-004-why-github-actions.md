# ADR-004: Why GitHub Actions?

- Status: Accepted
- Date: 2026-10-04

## Context
CI/CD must run where the code is hosted, authenticate to AWS without long-lived keys, and be reusable across generated service repos.

## Decision
GitHub Actions with reusable workflows, OIDC federation to narrowly scoped IAM roles, third-party actions pinned to commit SHAs, and protected environments for approvals.

## Alternatives considered
- Jenkins: self-hosting overhead and plugin risk.
- GitLab CI/CodePipeline: would split tooling from the code host.

## Consequences
- Positive: no static AWS keys; easy reuse via templates; native secret scanning integration.
- Negative: supply-chain exposure through actions (mitigated by SHA pinning and Dependabot).
- IAM trust policy must restrict repo, branch and environment claims.
