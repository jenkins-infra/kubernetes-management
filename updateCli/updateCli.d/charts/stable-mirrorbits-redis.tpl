source:
  kind: helmChart
  spec:
    url: https://kubernetes-charts.storage.googleapis.com
    name: redis

conditions:
  exist:
    name: "Redis helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://kubernetes-charts.storage.googleapis.com
      name: redis

targets:
  chartVersion:
    name: "stable/redis Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/mirrorbits.yaml"
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
