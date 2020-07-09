source:
  kind: helmChart
  spec:
    url: https://kubernetes-charts.storage.googleapis.com
    name: oauth2-proxy

conditions:
  exist:
    name: Ooauth2-proxy helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://kubernetes-charts.storage.googleapis.com
      name: oauth2-proxy
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
