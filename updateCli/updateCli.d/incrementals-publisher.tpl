---
source:
  kind: githubRelease
  spec:
    owner: "jenkins-infra"
    repository: "incrementals-publisher"
    token: "{{ requiredEnv .github.token }}"
    username: "olblak"
    version: "latest"
conditions:
  docker:
    name: "Docker Image Published on Registry"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/incrementals-publisher"
targets:
  appVersion:
    name: "incrementals-publisher appVersion"
    kind: yaml
    spec:
      file: "charts/incrementals-publisher/Chart.yaml"
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
