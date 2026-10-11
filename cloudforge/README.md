# CloudForge

**An Internal Developer Platform for Self-Service Cloud-Native Application Delivery on AWS**

> **Status: Phase 1 of 18 (architecture and repository foundation).**
> Nothing in this repository has been deployed yet. Sections are marked with the
> phase that delivers them; this README will be updated as the platform is built.
> Badges are added only once the workflows behind them exist.

## Overview
CloudForge lets a developer request a standardised microservice and get a repo, CI/CD,
Helm config, GitOps registration, observability and security guardrails automatically,
using Terraform/Terragrunt, GitHub Actions, ArgoCD and Amazon EKS.
Principle: *golden paths over custom snowflakes.*

## Architecture
See [`docs/architecture/overview.md`](docs/architecture/overview.md) (system context, component, delivery-flow and tracing diagrams) and [technology decisions](docs/architecture/technology-decisions.md).

## Why CloudForge?
Every component has a documented reason, alternatives, security/cost/operational implications and failure modes: see the [ADRs](docs/adr/README.md).

## Features (planned)
| Area | Status |
|---|---|
| Terraform/Terragrunt AWS foundation (VPC, EKS, RDS, ECR, KMS, IAM) | Phase 2-3 |
| Kubernetes platform (RBAC, NetworkPolicies, Kyverno, ESO) | Phase 4, 10 |
| user/order/payment FastAPI services | Phase 5 |
| GitHub Actions CI with OIDC and security gates | Phase 6-7 |
| ArgoCD app-of-apps GitOps, drift and rollback demo | Phase 8 |
| Prometheus, Grafana, Loki, OpenTelemetry, SLOs, alerts | Phase 9 |
| Autoscaling (HPA + Karpenter), FinOps | Phase 11-12 |
| DR, chaos experiments, runbooks | Phase 13-14 |
| cloudforge-api and CLI | Phase 15-16 |

## Repository Structure
```
cloudforge/
├── infrastructure/
│   ├── terraform/modules/      # vpc eks rds ecr iam kms s3 route53 security-groups monitoring
│   └── terragrunt/environments/{dev,staging,production}
├── platform/                   # argocd, kyverno, external-secrets, karpenter, observability, network-policies, rbac
├── gitops/{dev,staging,production}   # desired state (own repo from Phase 8)
├── helm/service-template/      # shared chart
├── services/                   # user-service, order-service, payment-service
├── platform-api/               # cloudforge-api (FastAPI)
├── cli/                        # cloudforge CLI (Typer)
├── templates/service-python/   # golden-path service template
├── local/                      # docker-compose, kind
├── runbooks/                   # operational runbooks
├── docs/                       # architecture, adr, security, dr, chaos, roadmap, demo
├── tests/                      # policy, pipeline, integration
├── scripts/                    # destroy.sh and helpers
└── .github/                    # workflows, CODEOWNERS
```

## Prerequisites
Docker, Python 3.12+, kubectl, helm, kind, terraform, terragrunt, make, AWS account (from Phase 2). See [local development](docs/local-development.md).

## Documentation Index
- [Roadmap](docs/roadmap.md) and [Definition of Done](docs/definition-of-done.md)
- [Security model](docs/security/security-model.md)
- [AWS cost control](docs/cost-control.md)
- [Local development](docs/local-development.md)

## Estimated AWS Cost
Intentionally no figures yet. See [cost control](docs/cost-control.md) for expensive resources; measured numbers arrive in Phase 12. **Run `make destroy ENV=<env>` when finished.**

## Sections added in later phases
Terraform, Kubernetes, GitHub Actions, ArgoCD, Observability, Autoscaling, Disaster Recovery, Chaos Engineering, Troubleshooting, Runbooks, Demo, Screenshots, Future Improvements, Lessons Learned.

## Author
Add your name and links here.

## License
MIT
