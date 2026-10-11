# ADR-005: Why Prometheus, Grafana, Loki and OpenTelemetry?

- Status: Accepted
- Date: 2026-10-04

## Context
We need metrics, logs and traces with golden-signal dashboards, SLOs and alerting, portable across clouds.

## Decision
Prometheus (+Alertmanager) for metrics, Grafana for dashboards, Loki for logs, OpenTelemetry SDK/Collector for traces and correlation. Applications emit structured JSON logs with trace_id.

## Alternatives considered
- CloudWatch only: convenient but weaker K8s-native dashboards/alerting and less portable.
- SaaS (Datadog/New Relic): fast but costly and less demonstrative of platform engineering.
- ELK/OpenSearch: heavier to run.

## Consequences
- Positive: open standards, strong community dashboards, cheap log storage.
- Negative: we operate storage and retention; sized conservatively for a portfolio.
- Trace backend (Tempo or Jaeger) is chosen in Phase 9.
