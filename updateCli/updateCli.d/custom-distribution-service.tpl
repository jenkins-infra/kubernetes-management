---
source:
  kind: githubRelease
  spec:
    name: Get jenkinsci/custom-distribution-service latest version
    owner: "jenkinsci"
    repository: "custom-distribution-service"
    token: "{{ requiredEnv .github.token }}"
    username: "{{ .github.username }}"
    version: "latest"
conditions:
  docker:
    name: "Docker Image Published on Registry"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/custom-distribution-service"
targets:
  appVersion:
    name: "custom-distribution-service appVersion"
    kind: yaml
    spec:
      file: "charts/custom-distribution-service/Chart.yaml"
      key: appVersion
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
