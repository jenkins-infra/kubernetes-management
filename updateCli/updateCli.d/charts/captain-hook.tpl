source:
  kind: helmChart
  spec:
    url: https://garethjevans.github.io/captain-hook
    name: captain-hook


conditions:
  exist:
    name: "Captain Hook Helm Chart Published on Registry"
    kind: helmChart
    spec:
      url: https://garethjevans.github.io/captain-hook
      name: captain-hook
  chartVersion:
    name: "captain-hook/captain-hook Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/captain-hook.yaml"
      key: "releases[0].name"
      value: "captain-hook"
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
    name: "captain-hook/captain-hook Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/captain-hook.yaml"
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
