# Jenkins Infrastructure Helm Charts

This repository defines and stores helm charts used by jenkins infrastructure project to configure its clusters.

It combines a Jenkinsfile, helmfiles and helm charts to automate Kubernetes Cluster configuration.

## Contributing

The Jenkins Infratructure Charts project accepts contributions via GitHub pull requests, more information in [CONTRIBUTING.md](https://github.com/jenkins-infra/charts/blob/master/CONTRIBUTING.md)
Sign Your Work

## Issues

Any issues can be reported on our [ticket system](https://issues.jenkins-ci.org/projects/INFRA/)

## Repository Structure

This project contains three main folders:

* `helmfile.d`: This folder contains [Helmfile](https://github.com/roboll/helmfile)
* `charts`: This folder contains specific jenkins infrastructure helm charts
* `config`: The configuration specific our environments.

## Secrets

Secrets are encrypted with [sops](https://github.com/mozilla/sops) and a default configuration is defined in `.sops.yaml`
Currently there are two kinds of encryption keys: a GPG key and an Azure Key-Vault (accessible from Kubernetes clusters).

All secrets are expected to be found in the `./secrets` folder which is absent (gitignored) by default.

If you can access the secrets, you have to set up the local `./secrets` folder from the (private) repository [jenkins-infra/charts-secrets](https://github.com/jenkins-infra/charts-secrets.git) with the following command:

```bash
git clone https://github.com/jenkins-infra/charts-secrets.git ./secrets
```

Then, you can edit a secret by usingh the `sops ./secrets/.../<your yaml file>` command.

## Docker

This folder defines a custom Dockerfile in order to build a custom image to orchestrate our clusters

## Remarks

* When deploying nexus, the postStart strict hang from time to time and we have to manually execute while containers are in creating mode
```kubectl exec -i -t -c nexus default-release-nexus-0 export PASSWORD=`cat /nexus-data/admin.password`; /opt/sonatype/nexus/postStart.sh```

* We need one jenkins instance per cluster so we should split cluster orchestration tasks outside release.ci.jenkins.io

* If RBAC is enabled on the cluster, before being able to use helm, we need to create a service acccount for helm with the right cluster role binding.
we can run following command: ```kubectl apply -f helm/rbac.yaml```

## Minikube

```bash
minikube start --kubernetes-version v1.15.11
minikube addons enable ingress
helm install stable/nginx-ingress nginx-ingress, we can't install the ingress defined in this repository for testing servers
kubectl -n release port-forward default-release-jenkins-77fd54976f-ns2c6 8081:8080

kubectl get secrets -n release  default-release-jenkins -o json
```

## Links

* [Helmfile](https://github.com/roboll/helmfile)
* [Helm Charts](https://github.com/helm/charts)
* [Sops](https://github.com/mozilla/sops)
