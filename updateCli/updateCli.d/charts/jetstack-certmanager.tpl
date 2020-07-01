source:
  kind: helmChart
  spec:
    url: https://charts.jetstack.io
    name: cert-manager

conditions:
  exist:
    name: "Certmanager helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://charts.jetstack.io
      name: cert-manager

targets:
  chartVersion:
    name: "jetstack/cert-manager Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/cert-manager.yaml"
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
