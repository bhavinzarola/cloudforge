.DEFAULT_GOAL := help
ENV ?= dev

.PHONY: help
help: ## Show targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-18s\033[0m %s\n",$$1,$$2}'

.PHONY: fmt
fmt: ## Format Terraform (more formatters are added per phase)
	terraform fmt -recursive infrastructure/

.PHONY: lint
lint: ## Lint (filled in as phases land: tflint, ruff, helm lint, kyverno test)
	@echo "Phase 1: nothing to lint yet"

.PHONY: local-up
local-up: ## Start local stack (Phase 5)
	@echo "Available from Phase 5 (docker compose / kind)"

.PHONY: destroy
destroy: ## Destroy AWS resources for ENV (default dev): make destroy ENV=dev
	./scripts/destroy.sh $(ENV)
