---
source:
  kind: githubRelease
  spec:
    owner: "jenkinsci"
    repository: "custom-distribution-service"
    token: "{{ requiredEnv .github.token }}"
    username: "olblak"
    version: "latest"
conditions:
  docker:
    name: "Docker Image Published on Registry"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/custom-distribution-service"
targets:
  appVersion:
    name: "Chart appVersion"
    kind: yaml
    spec:
      file: "charts/custom-distribution-service/Chart.yaml"
      key: appVersion
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "olblak"
        branch: "master"
