title: Bump oauth2-proxy helm chart
pipelineID: bumpoauth2proxyhelmchart
sources:
  default:
    kind: helmChart
    spec:
      url: https://charts.helm.sh/stable
      name: oauth2-proxy
conditions:
  helmfileRelease:
    name: "stable/oauth2-proxy Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/oauth2-proxy.yaml"
      key: "releases[0].name"
      value: "oauth2-proxy"
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
    name: "stable/oauth2-proxy Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/oauth2-proxy.yaml"
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
