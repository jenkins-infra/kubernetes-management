title: Bump Redis Helm Chart Version
pipelineID: bumpredishelmchartversion
sources:
  default:
    kind: helmChart
    spec:
      url: https://charts.bitnami.com/bitnami
      name: redis

conditions:
  helmfileRelease:
    name: "bitnami/redis Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/mirrorbits-database.yaml"
      key: "releases[0].name"
      value: "mirrorbits-database"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
targets:
  chartVersion:
    name: "stable/redis Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/mirrorbits-database.yaml"
      key: "releases[0].version"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
