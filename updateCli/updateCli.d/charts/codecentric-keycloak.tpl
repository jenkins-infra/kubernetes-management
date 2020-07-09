source:
  kind: helmChart
  spec:
    url: https://codecentric.github.io/helm-charts
    name: keycloak
conditions:
  exist:
    name: "Keycloack helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://codecentric.github.io/helm-charts
      name: keycloak
  helmfileRelease:
    name: "codecentric/keycloak Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/keycloak.yaml"
      key: "releases[0].name"
      value: "keycloak"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
        username: "{{ .github.username }}"
        branch: "master"
targets:
  chartVersion:
    name: "codecentric/keycloak Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/keycloak.yaml"
      key: "releases[0].version"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
        username: "{{ .github.username }}"
        branch: "master"
