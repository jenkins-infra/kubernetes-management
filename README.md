# Jenkins Infrastructure Kubernetes Management

This repository contains the helmfile manifests' values used by the Jenkins infrastructure project to manage the applications on its Kubernetes clusters.

The charts used come from [the helm charts repository](https://github.com/jenkins-infra/helm-charts/) and external providers.

## Contributing

The Jenkins Infrastructure Kubernetes Management project accepts contributions via GitHub pull requests,
more information in [CONTRIBUTING.md](https://github.com/jenkins-infra/kubernetes-management/blob/main/CONTRIBUTING.md)

## Issues

Any issue can be reported on our [help desk issue tracker](https://github.com/jenkins-infra/helpdesk/).

## Repository Structure

This project contains the following main directories:

* `clusters`: This folder contains the per-cluster [helmfiles](https://github.com/helmfile/helmfile) with the releases to apply per cluster
* `config`: This folder contains the specific configuration for our environments
* `updatecli`: This folder contains the [updatecli](https://github.com/updatecli/updatecli/) manifests to keep all Helm charts and Docker images versions up to date

## Requirements

This project requires the following tools (more details within the [DockerFile](https://github.com/jenkins-infra/docker-helmfile/blob/main/Dockerfile)):

* `az`
* `awscli`
* `doctl`
* `kubectl`
* `helm`
* `helmfile`
* `sops`
* the following 3 Helm plugins:
    * `helm-diff`
    * `helm-secrets`
    * `helm-git`


## Secrets

Secrets are encrypted with [sops](https://github.com/mozilla/sops), a default configuration is defined in `.sops.yaml`.
Currently there are two kinds of encryption keys: a GPG key and an Azure Key Vault (accessible from Kubernetes clusters).

All secrets are expected to be found in the `./secrets` folder which is absent by default and [(git)ignored](https://git-scm.com/docs/gitignore).

If you have the right to access the secrets, you can set up the local `./secrets` folder from the (private) repository [jenkins-infra/charts-secrets](https://github.com/jenkins-infra/charts-secrets.git) with the following command:

```bash
git clone https://github.com/jenkins-infra/charts-secrets.git ./secrets
```

Then, you can edit an app secret by using the `sops ./secrets/config/<app-name>/secrets.yaml` command that will create a blank secrets.yaml file ready to get encrypted as soon as it's saved and closed (you may need to add your ip on the azure key vault to get access) [sops examples](https://github.com/mozilla/sops#creating-a-new-file).

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

## How to debug deployments

```
helmfile template --no-color -f clusters/<cluster-name>.yaml -l name=<release-name>
```

## Links

* [Helmfile](https://github.com/helmfile/helmfile)
* [Kubernetes management](https://github.com/helm/kubernetes-management)
* [Helm Charts](https://github.com/helm/helm-charts)
* [Sops](https://github.com/mozilla/sops)
* [Updatecli](https://github.com/updatecli/updatecli)
