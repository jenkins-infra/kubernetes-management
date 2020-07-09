source:
  kind: helmChart
  spec:
    url: https://grafana.github.io/loki/charts
    name: promtail

conditions:
  exist:
    name: "Promtail helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://grafana.github.io/loki/charts
      name: promtail
  helmfileRelease:
    name: "grafana/promtail Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/promtail.yaml"
      key: "releases[0].name"
      value: "promtail"
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
    name: "grafana/promtail Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/promtail.yaml"
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
