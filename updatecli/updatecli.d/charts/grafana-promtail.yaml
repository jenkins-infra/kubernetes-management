
title: Bump promtail helm chart version
pipelineID: bumppromtailhelmchartversion
sources:
  default:
    kind: helmChart
    spec:
      url: https://grafana.github.io/helm-charts
      name: promtail
conditions:
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
