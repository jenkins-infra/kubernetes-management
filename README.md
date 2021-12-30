# Jenkins Infrastructure Kubernetes Management

This repository contains the helmfile manifests values used by jenkins infrastructure project to manage the applications of its kubernetes clusters.

The charts used come from [the helm charts repository](https://github.com/jenkins-infra/helm-charts/) and from external providers.

## Contributing

The Jenkins Infrastructure Kubernetes Management project accepts contributions via GitHub pull requests,
more information in [CONTRIBUTING.md](https://github.com/jenkins-infra/kubernetes-management/blob/main/CONTRIBUTING.md)

## Issues

Any issues can be reported on our [JIRA issue tracker](https://issues.jenkins-ci.org/projects/INFRA/)

## Repository Structure

This project contains the following main directories:

* `clusters`: This folder contains the per-cluster [helmfiles](https://github.com/roboll/helmfile) with the releases to apply per cluster
* `config`: This folder contains the specific configuration for our environments
* `updatecli`: This folder contains the [updatecli](https://github.com/updatecli/updatecli/) manifests to keep all Helm charts and Docker images versions up to date

## Secrets

Secrets are encrypted with [sops](https://github.com/mozilla/sops), a default configuration is defined in `.sops.yaml`.
Currently there are two kinds of encryption keys: a GPG key and an Azure Key Vault (accessible from Kubernetes clusters).

All secrets are expected to be found in the `./secrets` folder which is absent by default and [(git)ignored](https://git-scm.com/docs/gitignore).

If you have the right to access the secrets, you can set up the local `./secrets` folder from the (private) repository [jenkins-infra/charts-secrets](https://github.com/jenkins-infra/charts-secrets.git) with the following command:

```bash
git clone https://github.com/jenkins-infra/charts-secrets.git ./secrets
```

Then, you can edit an app secret by using the `sops ./secrets/config/<app-name>/secrets.yaml` command.

## Remarks

* We need one Jenkins instance per cluster to be able to split cluster orchestration tasks outside release.ci.jenkins.io

* If RBAC is enabled on the cluster, before being able to use Helm we need to create a Service Account for Helm with the right Cluster Role Binding with this command: `kubectl apply -f helm/rbac.yaml`

## Minikube

```bash
minikube start --kubernetes-version v1.20.13
minikube addons enable ingress
helm install stable/nginx-ingress nginx-ingress # we can't install the ingress defined in this repository for local testing
kubectl -n release port-forward default-release-jenkins-77fd54976f-ns2c6 8081:8080

kubectl get secrets -n release  default-release-jenkins -o json
```

## Links

* [Helmfile](https://github.com/roboll/helmfile)
* [Kubernetes management](https://github.com/helm/kubernetes-management)
* [Helm Charts](https://github.com/helm/helm-charts)
* [Sops](https://github.com/mozilla/sops)
* [Updatecli](https://github.com/updatecli/updatecli)
