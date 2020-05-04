---
source:
  kind: githubRelease
  spec:
    owner: "jenkins-infra"
    repository: "plugin-site-api"
    token: "{{ requiredEnv .github.token }}"
    username: "olblak"
    version: "latest"
conditions:
  docker:
    name: "Docker Image Published on Registry"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/plugin-site-api"
targets:
  imageTag:
    name: "Docker Image"
    kind: yaml
    spec:
      file: "charts/plugin-site/values.yaml"
      key: "backend.image.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "olblak"
        branch: "master"
  appVersion:
    name: "Chart appVersion"
    kind: yaml
    spec:
      file: "charts/plugin-site/Chart.yaml"
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
