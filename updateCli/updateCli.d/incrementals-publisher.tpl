---
title: Bump incremental publisher
pipelineID: incrementals-publisher
sources:
  default:
    kind: githubRelease
    name: Get jenkins-infra/incrementals-publish latest version
    spec:
      owner: "jenkins-infra"
      repository: "incrementals-publisher"
      token: "{{ requiredEnv .github.token }}"
      username: "{{ .github.username }}"
conditions:
  default:
    name: "Test if jenkinsciinfra/incrementals-publish docker image is published"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/incrementals-publisher"
targets:
  default:
    name: "Update incrementals-publisher appVersion"
    kind: helmChart
    spec:
      name: charts/incrementals-publisher
      key: image.tag
      appVersion: true
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
