# Helm Chart for the Jenkins Core Release Environment

This Helm chart defines the release environment for Jenkins Core.
See [jenkins-infra/release](https://github.com/jenkins-infra/release) for more information about the deployments and usage of this environment.

## Details

The chart is based on the official [Helm Chart for Jenkins LTS](https://github.com/helm/charts/blob/master/stable/jenkins/values.yaml).
It includes a number of plugins needed to run the Jenkins packaging and release Pipelines, and also the required system configuration and secrets.
At the moment, the chart includes only the Jenkins master and Linux/Windows agents which are provisioned on-demand within Kubernetes.
