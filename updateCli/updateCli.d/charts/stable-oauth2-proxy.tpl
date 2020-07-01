source:
  kind: helmChart
  spec:
    url: https://kubernetes-charts.storage.googleapis.com
    name: oauth2-proxy

conditions:
  exist:
    name: Ooauth2-proxy helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://kubernetes-charts.storage.googleapis.com
      name: oauth2-proxy

targets:
  chartVersion:
    name: "stable/oauth2-proxy Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/oauth2-proxy.yaml"
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
