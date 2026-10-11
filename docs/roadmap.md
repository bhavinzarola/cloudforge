# Development Roadmap

Rule: do not start a phase until the previous phase meets its exit criteria.
Phases map 1:1 to the master brief. Suggested order of effort is roughly one
phase per focused weekend; Phases 9-14 are the longest.

| # | Phase | Key deliverables | Exit criteria |
|---|---|---|---|
| 1 | Architecture & repo foundation | This repo skeleton, ADRs, security/cost/local strategy | Docs reviewed; CI placeholder green |
| 2 | Terraform AWS foundation | Remote state, VPC, KMS, S3, IAM, ECR modules; Terragrunt envs | `fmt/validate/plan` clean; Checkov passes; dev applies and destroys cleanly |
| 3 | EKS | EKS module, system node group, IRSA/Pod Identity, LB Controller | `kubectl get nodes` ok; test ingress serves traffic |
| 4 | Kubernetes platform | Namespaces, RBAC, NetworkPolicies, Pod Security labels | Default-deny verified with a test pod |
| 5 | Microservices | 3 FastAPI services, tests, Dockerfiles, compose/kind | `pytest` green; stack runs locally; inter-service calls work |
| 6 | GitHub Actions | Reusable CI workflows, OIDC, scans, quality gates | PR fails on critical vuln / failing test (proved) |
| 7 | ECR | Repos, lifecycle, scan-on-push, immutability, signing | Signed image pushed from CI |
| 8 | ArgoCD | Install, projects, app-of-apps, GitOps split, drift demo | Drift auto-healed; rollback works |
| 9 | Observability | Prom, Alertmanager, Grafana, Loki, OTel, dashboards, alerts | Trace spans order -> payment -> DB visible |
| 10 | Security | Kyverno policies, External Secrets, threat model, SBOM | Policy tests pass; bad manifests rejected |
| 11 | Autoscaling | HPA, Karpenter, load test | Measured scale-out/in recorded |
| 12 | Cost optimisation | Tagging, Spot, schedules, cost dashboard | Savings reported only from measurements |
| 13 | Disaster recovery | Backups, restore tests, DR docs | A restore actually tested; RTO/RPO measured vs targets |
| 14 | Chaos engineering | 4 experiments documented with results | Evidence (screenshots/logs) per experiment |
| 15 | Platform API | cloudforge-api endpoints, auth, audit log, tests | OpenAPI served; API tests green |
| 16 | Developer CLI | Typer CLI over the API | `init/validate/deploy/status/rollback` work |
| 17 | Documentation | README, golden-path guide, demo script, runbooks | A newcomer can follow the guide |
| 18 | Production-readiness review | Checklist, gap list, final cleanup | DoD satisfied |

Phase 1 files created here: see `docs/definition-of-done.md` for project-wide DoD.
