# ADR-008: Why Karpenter?

- Status: Accepted
- Date: 2026-10-04

## Context
Pods need to scale from 3 to 10+ replicas and trigger new nodes quickly, using Spot where safe, and consolidate when load drops.

## Decision
Karpenter provisions nodes for application workloads. A small on-demand managed node group runs system components, including Karpenter itself.

## Alternatives considered
- Cluster Autoscaler: works, but slower and less flexible on instance selection and consolidation.
- Fargate: no node management but different constraints and higher per-pod cost for some workloads.

## Consequences
- Positive: fast right-sized capacity, Spot support, consolidation reduces idle cost.
- Negative: more IAM/SQS/interruption handling setup; NodePool limits are required to cap spend.
- Savings are reported only from measured load tests.
