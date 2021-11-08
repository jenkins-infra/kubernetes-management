title: Bump nginx-ingress helm chart
pipelineID: bumpnginxingresshelmchart
sources:
  ingressNginxLatestVersion:
    name: "Retrieve latest version of the chart ingress-nginx"
    kind: helmChart
    spec:
      url: https://kubernetes.github.io/ingress-nginx
      name: ingress-nginx
  defaultBackendImageLatestVersion:
    name: "Retrieve the latest tag of the Docker image for the default backend"
    kind: githubRelease
    spec:
      owner: "jenkins-infra"
      repository: "docker-404"
      token: "{{ requiredEnv .github.token }}"
      username: "{{ .github.username }}"
conditions:
  publicHelmfileRelease:
    name: "Check that the public-ingress references the ingress-nginx Helm Chart"
    kind: yaml
    sourceID: ingressNginxLatestVersion
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
  publicDefaultBackend:
    name: "Check that the public-ingress has the expected Docker image for default backend"
    kind: yaml
    sourceID: defaultBackendImageLatestVersion
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[0].values[0].defaultBackend.image.repository"
      value:  "jenkinsciinfra/404"
  privateHelmfileRelease:
    name: "Check that the private-ingress references the ingress-nginx Helm Chart"
    kind: yaml
    sourceID: ingressNginxLatestVersion
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
  privateDefaultBackend:
    name: "Check that the private-ingress has the expected Docker image for default backend"
    kind: yaml
    sourceID: defaultBackendImageLatestVersion
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[1].values[0].defaultBackend.image.repository"
      value:  "jenkinsciinfra/404"
targets:
  updatePublicIngressChartVersion:
    name: "Update the version of the Helm chart ingress-nginx for public-ingress"
    kind: yaml
    sourceID: ingressNginxLatestVersion
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
  updatePublicBackendImage:
    name: "Update the Image tag for public-ingress default backend"
    kind: yaml
    sourceID: defaultBackendImageLatestVersion
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[0].values[0].defaultBackend.image.tag"
  updatePrivateIngressChartVersion:
    name: "Update the version of the Helm chart ingress-nginx for private-ingress"
    kind: yaml
    sourceID: ingressNginxLatestVersion
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
  updatePrivateBackendImage:
    name: "Update the Image tag for private-ingress default backend"
    kind: yaml
    sourceID: defaultBackendImageLatestVersion
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[1].values[0].defaultBackend.image.tag"
