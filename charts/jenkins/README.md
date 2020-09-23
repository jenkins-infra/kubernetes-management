# Jenkins Core Release Environment - master Helm Chart

This Helm chart defines a Jenkins master for the [Jenkins Core Release Environment](https://github.com/jenkins-infra/release).
Chart for Jenkins Core Release Environment environment is available [here](/helmfile.d/jenkins-release.yaml).

## Details

The chart is based on the official [Helm Chart for Jenkins LTS](https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/values.yaml).
It includes a number of plugins needed to run the Jenkins packaging and release Pipelines, and also the required system configuration and secrets.
At the moment, the chart includes only the Jenkins master and Linux/Windows agents which are provisioned on-demand within Kubernetes.
