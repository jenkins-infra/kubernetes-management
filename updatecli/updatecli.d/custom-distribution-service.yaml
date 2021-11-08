---
title: "Bump Custom Distribution Service"
pipelineID: "helmchartscustomdistributionid"
sources:
  default:
    name: Get latest jenkinsci/custom-distribution-service version
    kind: githubRelease
    spec:
      name: Get jenkinsci/custom-distribution-service latest version
      owner: "jenkinsci"
      repository: "custom-distribution-service"
      token: "{{ requiredEnv .github.token }}"
      username: "{{ .github.username }}"
      versionFilter:
        pattern: ~0
        kind: semver
conditions:
  docker:
    name: "Is latest jenkinsciinfra/custom-distribution-service docker image published"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/custom-distribution-service"
targets:
  appVersion:
    name: "custom-distribution-service appVersion"
    kind: helmChart
    spec:
      name: charts/custom-distribution-service
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
        branch: "master"
