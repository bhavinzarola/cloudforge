# Technology Decisions

Why it exists, what it solves, alternatives, main risk. Major choices have ADRs in `../adr/`.

| Component | Why / problem solved | Chosen over | Main risk / cost driver |
|---|---|---|---|
| AWS | Primary target; strong EKS/RDS/IAM integration | GCP, Azure | Cost if left running |
| Terraform | Declarative IaC, large ecosystem, reusable modules | CloudFormation, CDK, Pulumi | State management discipline |
| Terragrunt | DRY env config, dependency ordering, state wiring | Workspaces, copy-paste per env | Extra tool; keep usage thin |
| EKS | Managed control plane, no etcd/API-server ops | Self-managed K8s, ECS | Fixed hourly control-plane fee per cluster |
| Managed node group (system) + Karpenter (apps) | Stable system pool; fast, cost-aware app scaling incl. Spot | Cluster Autoscaler only | Karpenter IAM/SQS setup |
| ArgoCD | Pull-based GitOps, drift detection, UI, rollback, app-of-apps | Flux, push-based CD | Needs hardening/HA in prod |
| GitHub Actions | Code lives there; OIDC to AWS; reusable workflows | Jenkins, GitLab CI | Third-party action supply chain: pin by SHA |
| Helm | Parameterised charts, per-env values | Kustomize only, raw YAML | Template sprawl: one shared chart |
| Kyverno | Policy as Kubernetes YAML; validate/mutate/verifyImages | OPA Gatekeeper | Untested policies can block rollouts |
| External Secrets + Secrets Manager | No secrets in Git; rotation-friendly | Sealed Secrets, SOPS | Operator is a trust boundary |
| Prometheus, Alertmanager, Grafana | Standard K8s metrics/alerting/dashboards | CloudWatch only, SaaS APM | Storage and retention sizing |
| Loki | Cheap label-indexed logs, Grafana-native | ELK/OpenSearch | Label cardinality |
| OpenTelemetry | Vendor-neutral traces/metrics/logs | Vendor agents | Instrumentation effort |
| FastAPI + Pydantic | Typed APIs, auto OpenAPI | Flask, Django | None significant |
| RDS PostgreSQL | Managed backups, Multi-AZ, encryption | Self-run Postgres, Aurora | A top cost item |
| Trivy / Checkov / Gitleaks | Image+deps / IaC / secrets scanning | Snyk, tfsec alone | False-positive triage policy needed |
| Cosign + Syft | Keyless image signing + SBOM | Notary v2 | Verification must be enforced (Kyverno) |
| Typer | Small typed CLI | argparse, Click | None |
| kind | Local K8s close to real clusters | minikube, k3d | RAM usage |

## Deliberate scope limits

- No service mesh in v1 (not needed for the goals; listed under Future Improvements).
- No dedicated API gateway beyond ALB/Ingress in v1.
- Canary via Argo Rollouts is optional; rollback is ArgoCD + Git revert.
- Multi-region DR is documented and reviewed by runbook, not run continuously (cost).
