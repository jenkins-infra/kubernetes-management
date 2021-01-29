---
source:
  kind: githubRelease
  name: Get jenkins-infra/incrementals-publish latest version
  spec:
    owner: "jenkins-infra"
    repository: "incrementals-publisher"
    token: "{{ requiredEnv .github.token }}"
    username: "{{ .github.username }}"
    version: "latest"
conditions:
  docker:
    name: "Test if jenkinsciinfra/incrementals-publish docker image is published"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/incrementals-publisher"
targets:
  appVersion:
    name: "Update incrementals-publisher appVersion"
    kind: yaml
    spec:
      file: "charts/incrementals-publisher/Chart.yaml"
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
