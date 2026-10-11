#!/usr/bin/env bash
# Tear down all AWS resources for one CloudForge environment.
# Usage: ./scripts/destroy.sh <dev|staging|production>
set -euo pipefail

ENV="${1:-}"
case "$ENV" in dev|staging|production) ;; *)
  echo "Usage: $0 <dev|staging|production>" >&2; exit 2;; esac

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TG_DIR="$ROOT/infrastructure/terragrunt/environments/$ENV"

if [[ ! -f "$TG_DIR/terragrunt.hcl" && -z "$(find "$TG_DIR" -name terragrunt.hcl 2>/dev/null)" ]]; then
  echo "No Terragrunt config under $TG_DIR yet (arrives in Phase 2). Nothing to destroy."; exit 0
fi

echo "About to DESTROY all CloudForge resources in environment: $ENV"
[[ "$ENV" == "production" ]] && echo "WARNING: this is the production environment."
read -r -p "Type the environment name to confirm: " CONFIRM
[[ "$CONFIRM" == "$ENV" ]] || { echo "Aborted."; exit 1; }

# 1. Remove things Kubernetes created outside Terraform's knowledge
#    (ALBs, target groups, EBS volumes) so they don't block VPC deletion
#    or keep billing. Full implementation lands in Phase 3/8.
echo "[1/3] Deleting ArgoCD applications and Ingress/LoadBalancer resources..."
echo "      (implemented in Phase 8)"

# 2. Destroy infrastructure in reverse dependency order
echo "[2/3] terragrunt run-all destroy..."
( cd "$TG_DIR" && terragrunt run-all destroy --terragrunt-non-interactive )

# 3. Report anything left behind
echo "[3/3] Checking for orphaned resources tagged Project=CloudForge,Environment=$ENV..."
aws resourcegroupstaggingapi get-resources \
  --tag-filters "Key=Project,Values=CloudForge" "Key=Environment,Values=$ENV" \
  --query 'ResourceTagMappingList[].ResourceARN' --output text || true
echo "Done. Terraform state bucket is intentionally NOT destroyed."
