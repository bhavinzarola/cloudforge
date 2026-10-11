# ADR-007: Why External Secrets Operator with AWS Secrets Manager?

- Status: Accepted
- Date: 2026-10-04

## Context
Secrets must never be stored in Git, and applications must receive credentials (e.g., database) without hard-coding.

## Decision
Store secrets in AWS Secrets Manager (KMS-encrypted). External Secrets Operator syncs them into Kubernetes Secrets using IRSA/Pod Identity with read access scoped per path.

## Alternatives considered
- Sealed Secrets/SOPS: encrypted secrets in Git; rotation and audit are harder.
- CSI Secrets Store driver: valid alternative; ESO chosen for simpler app consumption.

## Consequences
- Positive: central rotation and audit, no secrets in repos.
- Negative: Kubernetes Secrets remain base64 in etcd (mitigated by EKS envelope encryption with KMS).
- ESO is a trust boundary; its IAM policy is least-privilege by secret path.
