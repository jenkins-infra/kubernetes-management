source:
  kind: helmChart
  spec:
    url: https://charts.jetstack.io
    name: cert-manager

conditions:
  exist:
    name: "Certmanager helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://charts.jetstack.io
      name: cert-manager
  helmfileRelease:
    name: "jetstack/cert-manager Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/cert-manager.yaml"
      key: "releases[0].name"
      value: "cert-manager"
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
    name: "jetstack/cert-manager Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/cert-manager.yaml"
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
