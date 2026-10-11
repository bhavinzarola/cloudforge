# Security Model (Phase 1 baseline)

The full threat model (`threat-model.md`) is produced in Phase 10. This document
sets the principles every phase must follow.

## Principles
1. **No long-lived credentials.** GitHub Actions assumes AWS roles via OIDC; pods use IRSA/Pod Identity; humans use SSO.
2. **Least privilege everywhere.** Separate IAM roles per purpose (CI-build, CI-terraform-plan, CI-terraform-apply, ESO, Karpenter, LB Controller). Trust policies pin repo, branch/environment.
3. **No secrets in Git.** Secrets live in AWS Secrets Manager, synced by External Secrets. Gitleaks runs on every PR and in pre-commit.
4. **Private by default.** Workloads and RDS live in private subnets; only the ALB is public. Cluster API endpoint access is restricted. RDS accepts traffic only from workload security groups.
5. **Encrypt everything.** KMS CMKs for EKS secrets, RDS, S3, ECR, Secrets Manager; TLS in transit.
6. **Policy as code at admission.** Kyverno enforces: non-root, approved registries, requests/limits, no privileged, no hostNetwork, no `latest`, required labels. Rollout: Audit, then Enforce.
7. **Default-deny networking.** Each namespace starts with a deny-all NetworkPolicy; flows are explicitly allowed (e.g. order-service to payment-service).
8. **Supply-chain integrity.** Pinned dependencies and base images, Trivy scans, SBOM (Syft), keyless signing (Cosign), signature verification at admission.
9. **Auditability.** EKS control-plane logs, CloudTrail, application audit logs, and Git history as deployment audit trail.

## Where each scanner runs
| Tool | Stage | Fails the build when |
|---|---|---|
| Gitleaks | Pre-commit, PR | Any verified secret found |
| Checkov | PR on `infrastructure/` | High/critical findings without documented skip |
| Trivy (fs/deps) | PR | Critical vulnerabilities with a fix available |
| Trivy (image) | After build, before push | Critical vulnerabilities |
| SAST (CodeQL/Bandit) | PR | High-severity findings |
| Kyverno CLI | PR (policy tests) | Test or manifest violates a policy |
| Cosign verify | Admission (cluster) | Unsigned or untrusted image |

## Trust boundaries (summary)
Developer to GitHub (SSO, MFA, signed commits recommended) | GitHub to AWS (OIDC) | CI to registry (push-only role) | ArgoCD to cluster (in-cluster) | ESO to Secrets Manager (path-scoped) | Workloads to RDS (SG-restricted).

## Branch protection recommendations
Require PRs, 1+ review, passing status checks (CI, security, terraform plan), CODEOWNERS review for `infrastructure/` and `.github/`, no force pushes, linear history. Production deploys require a protected GitHub Environment with manual approval.
