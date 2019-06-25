# Jenkins Infrastructure Helm Charts

**This project is still heavily in development**

This repository defines and stores helm charts used by jenkins infrastructure project to configure its clusters.

It also combines a Jenkinsfile, helmfiles and helm charts to automate Kubernetes Cluster configuration.

## Repository Structure
This project contains three main folders:

* `helmfile.d`: This folder contains [Helmfile](https://github.com/roboll/helmfile)
* `charts`: This folder contains specific jenkins infrastructure helm charts
* `config`: The configuration specific our environments.

## Secrets
Secrets are encrypted with [sops](https://github.com/mozilla/sops) and a default configuration is defined in `.sops.yaml`
Currently there are two keys, one GPG key  and a second one in an azure key vault and accessible from Kubernetes clusters.

In order to edit a secret, just run `sops <your yaml file>`

## Docker
This folder defines a custom Dockerfile in order to build a custom image to orchestrate our clusters

## Rules
* Secrets are define in `secrets.yaml` file and always encrypted

## Remarks
* When deploying nexus, the postStart strict hang from time to time and we have to manually execute while containers are in creating mode
```kubectl exec -i -t -c nexus default-release-nexus-0 /opt/sonatype/nexus/postStart.sh```

* We need one jenkins instance per cluster so we should split cluster orchestration tasks outside release.ci.jenkins.io

## Links
* [Helmfile](https://github.com/roboll/helmfile)
* [Helm Charts](https://github.com/helm/charts)
* [Sops](https://github.com/mozilla/sops)
