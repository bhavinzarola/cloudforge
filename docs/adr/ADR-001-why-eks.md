# ADR-001: Why Amazon EKS?

- Status: Accepted
- Date: 2026-10-04

## Context
We need a Kubernetes platform that demonstrates production patterns (RBAC, NetworkPolicies, autoscaling, IRSA) without operating the control plane ourselves.

## Decision
Use Amazon EKS with a small managed node group for system components and Karpenter-provisioned nodes for applications.

## Alternatives considered
- Self-managed Kubernetes (kubeadm/kops): more operational burden, no portfolio value beyond what EKS shows.
- ECS/Fargate: simpler but does not exercise Kubernetes, GitOps or Kyverno.
- GKE/AKS: viable, but the brief targets AWS.

## Consequences
- Positive: managed control plane, native IAM integration, ALB controller.
- Negative: fixed per-cluster hourly fee; cost-control scripts are mandatory.
- Operational: we own add-on upgrades and node lifecycle.
