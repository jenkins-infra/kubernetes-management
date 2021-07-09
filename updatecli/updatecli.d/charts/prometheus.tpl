title: Bump prometheus helm chart version
pipelineID: bumpprometheushelmchartversion
source:
  kind: helmChart
  spec:
    url: https://prometheus-community.github.io/helm-charts
    name: prometheus
conditions:
  helmfileRelease:
    name: "stable/prometheus Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/prometheus.yaml"
      key: "releases[0].name"
      value: "prometheus"
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
    name: "stable/prometheus Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/prometheus.yaml"
      key: "releases[0].version"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
