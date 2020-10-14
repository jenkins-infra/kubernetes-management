source:
  kind: helmChart
  spec:
    url: https://charts.bitnami.com/bitnami
    name: redis

conditions:
  exist:
    name: "Redis helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://charts.bitnami.com/bitnami
      name: redis
  helmfileRelease:
    name: "bitnami/redis Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/mirrorbits.yaml"
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
