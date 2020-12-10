
# docker pull quay.io/roboll/helmfile:v0.48.0

#sops -e -i values/datadog/secrets.yaml
init:
	kubectl apply -f helm/rbac.yaml
	helm init --service-account tiller

lint:
	helmfile -f helmfile.d lint

apply:
	helmfile -f helmfile.d apply --suppress-secrets

delete:
	helmfile -f helmfile.d delete --purge

diff:
	helmfile -f helmfile.d diff --suppress-secrets

release:
	helmfile -f helmfile.d/release.yaml apply --suppress-secrets

yamllint:
	yamllint --config-file yamllint.config config/
