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
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
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
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
