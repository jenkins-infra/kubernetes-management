
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
