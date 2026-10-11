# ADR-002: Why Terraform (with Terragrunt)?

- Status: Accepted
- Date: 2026-10-04

## Context
All AWS infrastructure must be reproducible, reviewable and destroyable across three environments without copy-pasted code.

## Decision
Terraform modules (vpc, eks, rds, ecr, iam, kms, s3, route53, monitoring) with Terragrunt wiring per-environment inputs, remote state (S3 + locking) and dependencies.

## Alternatives considered
- CloudFormation/CDK: AWS-only, less module ecosystem.
- Pulumi: strong, but Terraform is the more commonly expected skill.
- Terraform workspaces only: weak isolation of state and config between environments.

## Consequences
- Positive: DRY environments, plan-before-apply review, strong scanning ecosystem (Checkov, tflint).
- Negative: Terragrunt is an additional tool; we keep its usage to inputs, state and dependencies.
- Risk: state is sensitive; the bucket is encrypted, versioned, private, and never destroyed by make destroy.
