
# docker pull quay.io/roboll/helmfile:v0.48.0

#sops -e -i values/datadog/secrets.yaml
init:
	kubectl apply -f helm/rbac.yaml
	helm init --service-account tiller

lint:
	helmfile -f clusters lint

apply:
	helmfile -f clusters apply --suppress-secrets

delete:
	helmfile -f clusters delete --purge

diff:
	helmfile -f clusters diff --suppress-secrets

yamllint:
	yamllint --config-file yamllint.config config/

validate: yamllint lint ## Run all validation checks (yamllint + helmfile lint)
	@echo "All validation checks passed."

check-tools: ## Verify required tools are installed
	@echo "Checking required tools..."
	@command -v kubectl >/dev/null 2>&1 || { echo "ERROR: kubectl is not installed"; exit 1; }
	@command -v helm >/dev/null 2>&1 || { echo "ERROR: helm is not installed"; exit 1; }
	@command -v helmfile >/dev/null 2>&1 || { echo "ERROR: helmfile is not installed"; exit 1; }
	@command -v sops >/dev/null 2>&1 || { echo "ERROR: sops is not installed"; exit 1; }
	@command -v yamllint >/dev/null 2>&1 || { echo "ERROR: yamllint is not installed"; exit 1; }
	@echo "All required tools are available."

help: ## Display this help message
	@echo "Jenkins Infrastructure Kubernetes Management"
	@echo ""
	@echo "Available targets:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Core targets (no help text):"
	@echo "  init           Initialize Helm with RBAC"
	@echo "  lint           Run helmfile lint on all clusters"
	@echo "  apply          Apply helmfile changes to all clusters"
	@echo "  delete         Delete all helmfile releases"
	@echo "  diff           Show helmfile diff for all clusters"
	@echo "  yamllint       Lint YAML config files"

.PHONY: init lint apply delete diff yamllint validate check-tools help
