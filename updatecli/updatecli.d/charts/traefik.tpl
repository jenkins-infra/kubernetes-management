title: Bump Traefik Helm Chart Version
pipelineID: bumptraefikhelmchartversion

sources:
  default:
    kind: helmChart
    spec:
      url: https://helm.traefik.io/traefik
      name: traefik
conditions:
  publicHelmfileRelease:
    name: "public traefik/traefik Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/traefik.yaml"
      key: "releases[0].name"
      value:  "public-traefik"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
  privateHelmfileRelease:
    name: "private traefik/traefik Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/traefik.yaml"
      key: "releases[1].name"
      value: "private-traefik"
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
  public-traefik:
    name: "public traefik/traefik Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/traefik.yaml"
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
  private-traefik:
    name: "private traefik/traefik Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/traefik.yaml"
      key: "releases[1].version"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
