source:
  kind: helmChart
  spec:
    url: https://kubernetes-charts.storage.googleapis.com
    name: prometheus

conditions:
  exist:
    name: "Prometheus helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://kubernetes-charts.storage.googleapis.com
      name: prometheus

targets:
  chartVersion:
    name: "stable/prometheus Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/prometheus.yaml"
      key: "releases[0].version"
    scm:
      github:
        user: "updatecli"
        email: "updatecli@olblak.com"
        owner: "jenkins-infra"
        repository: "charts"
        token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
        username: "olblak"
        branch: "master"
