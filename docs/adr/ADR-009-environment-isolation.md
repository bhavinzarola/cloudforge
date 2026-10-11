# ADR-009: Environment isolation and cost-conscious operation

- Status: Accepted
- Date: 2026-10-04

## Context
The brief requires development, staging and production isolation, but every EKS cluster has a fixed hourly cost and this is a one-engineer portfolio project.

## Decision
Target design is one VPC and one EKS cluster per environment with separate Terraform state. Operationally, only dev runs routinely; staging and production are applied for demos/tests and destroyed after. A documented 'lite mode' lets the dev cluster host dev and staging namespaces for people who cannot afford multiple clusters.

## Alternatives considered
- Single shared cluster with namespaces: cheapest, but weaker blast-radius isolation and not a realistic production pattern.
- Separate AWS accounts per environment: best practice in organisations; documented as a future improvement because of setup overhead (Organizations, SSO).

## Consequences
- Positive: realistic isolation story with controlled spend.
- Negative: more Terraform apply/destroy cycles; destroy scripts must be reliable.
- Production resources are never claimed to be continuously running.
