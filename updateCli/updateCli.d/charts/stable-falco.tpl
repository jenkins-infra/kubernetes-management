source:
  kind: helmChart
  spec:
    url: https://hub.helm.sh/charts
    name: falco

conditions:
  exist:
    name: "Falco helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://hub.helm.sh/charts
      name: falco
  helmfileRelease:
    name: "stable/falco Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/falco.yaml"
      key: "releases[0].name"
      value: "falco"
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
    name: "stable/falco Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/falco.yaml"
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
