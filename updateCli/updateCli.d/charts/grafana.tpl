source:
  kind: helmChart
  spec:
    url: https://grafana.github.io/helm-charts
    name: grafana

conditions:
  helmfileRelease:
    name: "grafana/grafana Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/grafana.yaml"
      key: "releases[0].name"
      value: "grafana"
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
    name: "grafana/grafana Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/grafana.yaml"
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
