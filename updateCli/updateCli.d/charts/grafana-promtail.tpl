source:
  kind: helmChart
  spec:
    url: https://grafana.github.io/loki/charts
    name: promtail

conditions:
  exist:
    name: "Promtail helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://grafana.github.io/loki/charts
      name: promtail

targets:
  chartVersion:
    name: "Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/promtail.yaml"
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
