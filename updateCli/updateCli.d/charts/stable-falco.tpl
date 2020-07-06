source:
  kind: helmChart
  spec:
    url: https://hub.helm.sh/charts
    name: falco

conditions:
  exist:
    name: "Falco helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://hub.helm.sh/charts
      name: falco

targets:
  chartVersion:
    name: "stable/falco Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/falco.yaml"
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
