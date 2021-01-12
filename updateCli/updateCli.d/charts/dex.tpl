source:
  kind: helmChart
  spec:
    url: https://charts.helm.sh/stable
    name: dex

conditions:
  exist:
    name: "Dex helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://charts.helm.sh/stable
      name: dex
  helmfileRelease:
    name: "stable/dex Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/dex.yaml"
      key: "releases[0].name"
      value: "private-dex"
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
    name: "stable/dex Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/dex.yaml"
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
