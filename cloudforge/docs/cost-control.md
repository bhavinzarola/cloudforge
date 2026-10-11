# AWS Cost-Control Strategy

> No prices are quoted here on purpose. Use the AWS Pricing Calculator with current
> prices for your region, and record the actual figures you observe in AWS Cost
> Explorer. A measured section will be added in Phase 12.

## Expensive resources (usual suspects)
| Resource | Why it costs | Mitigation |
|---|---|---|
| EKS control plane | Hourly per cluster | Run one env at a time; destroy after use |
| NAT Gateway | Hourly + per-GB processed | Single NAT in dev/staging; VPC endpoints for ECR/S3/STS/Logs |
| EC2 worker nodes | Hourly per instance | Spot for apps, small system pool, Karpenter consolidation, NodePool CPU/memory limits |
| ALB | Hourly + LCU | Share one ALB across services via IngressGroup |
| RDS | Instance + storage + backups | Smallest class in dev, single-AZ; stop/destroy when idle; Multi-AZ only in prod |
| EBS volumes (Prometheus/Loki) | Persist after cluster deletion | Short retention; destroy script checks for orphans |
| CloudWatch Logs | Ingestion + storage | Short retention; ship app logs to Loki instead |
| Elastic IPs / orphaned LBs | Bill when forgotten | Tag-based orphan check in `destroy.sh` |

## Guardrails
- **Tagging:** `Project`, `Environment`, `ManagedBy`, `Owner` on all resources; activate as cost allocation tags.
- **Budgets:** AWS Budgets alarm (email) created in Phase 2 with a threshold you set.
- **Destroy workflow:** `make destroy ENV=dev` runs `scripts/destroy.sh`: remove K8s-created LBs/volumes first, then `terragrunt run-all destroy`, then list orphans. The Terraform state bucket is intentionally preserved.
- **Non-production shutdown:** scheduled scale-to-zero of dev node pools/RDS stop (Phase 12), implemented and measured, not assumed.
- **Defaults:** smallest viable instance sizes, 2 AZs (not 3) in dev/staging, short retention.

## Rules
- Savings numbers are reported only from measured before/after tests (see master brief section 32).
- Always destroy at the end of a session unless you are demoing.
