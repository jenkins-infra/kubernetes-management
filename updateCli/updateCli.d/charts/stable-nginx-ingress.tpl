title: Bump nginx-ingress helm chart
pipelineID: bumpnginxingresshelmchart
sources:
  default:
    kind: helmChart
    spec:
      url: https://charts.helm.sh/stable
      name: nginx-ingress

conditions:
  publicHelmfileRelease:
    name: "public stable/nginx-ingress Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[0].name"
      value:  "public-nginx-ingress"
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
    name: "private stable/nginx-ingress Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[1].name"
      value: "private-nginx-ingress"
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
  public-nginx-ingress:
    name: "public stable/nginx-ingress Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
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
  private-nginx-ingress:
    name: "private stable/nginx-ingress Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
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
