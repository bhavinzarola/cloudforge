# Local Development Strategy

Goal: most work should not need AWS.

| Level | Tooling | What runs | Phase |
|---|---|---|---|
| 1. Service dev | Docker Compose | 3 services + PostgreSQL (+ Prometheus/Grafana/Loki optionally) | 5 |
| 2. Cluster dev | kind | Helm chart, NetworkPolicies, Kyverno policies, ArgoCD (optional) | 5/8/10 |
| 3. AWS integration | Real AWS dev env | EKS, RDS, ECR, ALB, IRSA, Karpenter | 2-3 onward |

## Prerequisites
Docker, Python 3.12+, kubectl, helm, kind, terraform, terragrunt, make, pre-commit.

## What cannot run locally
IAM/IRSA, ALB Controller, RDS-specific behaviour, Karpenter, real Spot behaviour,
GitHub OIDC. These are validated in the AWS dev environment (and by unit/policy tests where possible).

## Conventions
- Local config via `.env` (git-ignored); `.env.example` committed.
- Local DB credentials are throwaway and never reused for AWS.
- Same container images are used locally and in EKS.
