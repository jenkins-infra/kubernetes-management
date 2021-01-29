---
source:
  kind: githubRelease
  name: Get jenkins-infra/plugin-site-api latest version
  spec:
    owner: "jenkins-infra"
    repository: "plugin-site-api"
    token: "{{ requiredEnv .github.token }}"
    username: "olblak"
    version: "latest"
conditions:
  docker:
    name: "Test if jenkinsciinfra/plugin-site-api exist"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/plugin-site-api"
targets:
  imageTag:
    name: "jenkinsciinfra/plugin-site-api docker image"
    kind: yaml
    spec:
      file: "charts/plugin-site/values.yaml"
      key: "backend.image.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
  appVersion:
    name: "Update plugin-site-api chart Chart appVersion"
    kind: yaml
    spec:
      file: "charts/plugin-site/Chart.yaml"
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
