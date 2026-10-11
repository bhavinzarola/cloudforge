# Definition of Done

## Per phase
- [ ] Files are complete (no TODO placeholders in shipped code) and live in the documented paths.
- [ ] Formatters and linters pass (`terraform fmt`, `ruff`, `helm lint`, etc., as applicable).
- [ ] Tests exist and pass; how to run them is documented.
- [ ] Security scans pass or findings are explicitly documented.
- [ ] Documentation updated: what, why, how to test, common errors.
- [ ] Anything applied to AWS has been destroyed cleanly or is listed as running.
- [ ] No secrets, account IDs or credentials committed.

## Project-level
- [ ] A new developer can follow the golden-path guide to deploy a service end to end.
- [ ] CI quality gates block: failing tests, critical vulnerabilities, invalid Terraform/Helm, policy violations.
- [ ] Drift demo, rollback demo and the four chaos experiments are performed with evidence (logs/screenshots).
- [ ] DR restore tested at least once; RTO/RPO labelled as targets with measured results alongside.
- [ ] Cost numbers come from measurements only.
- [ ] `make destroy` leaves no billable orphans (verified by tag query).
- [ ] README, ADRs, threat model, runbooks, demo script complete; every badge works.
- [ ] No fake metrics, stars, or production claims.
