title: Bump nginx-ingress helm chart
pipelineID: bumpnginxingresshelmchart
sources:
  ingress-nginx-version:
    name: "Retrieve latest version of the chart ingress-nginx"
    kind: helmChart
    spec:
      url: https://kubernetes.github.io/ingress-nginx
      name: ingress-nginx
conditions:
  publicHelmfileRelease:
    name: "Check that the public-ingress references the ingress-nginx Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[0].chart"
      value:  "ingress-nginx/ingress-nginx"
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
    name: "Check that the private-ingress references the ingress-nginx Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[1].chart"
      value:  "ingress-nginx/ingress-nginx"
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
    name: "Update the version of the Helm chart ingress-nginx for public-ingress"
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
    name: "Update the version of the Helm chart ingress-nginx for private-ingress"
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
