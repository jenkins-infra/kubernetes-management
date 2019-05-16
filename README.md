# Jenkins Infrastructure Helm Charts

This repository is used to define and store helm charts used on jenkins infrastructure project

## Repository Structure
This project contains three main folders:

* `helmfile.d`: This folder contains helmfile configure to deploy kubernetes helm charts
* `charts`: This folder contains specific jenkins infrastructure helm charts
* `config`: The configuration specific our environments.

Secrets are encrypted by sops and its configuration is in `.sops.yaml`

## Links
* [Helmfile](https://github.com/roboll/helmfile)
* [Helm Charts](https://github.com/helm/charts)
* [Sops](https://github.com/mozilla/sops)
