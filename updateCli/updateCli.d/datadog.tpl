---
source:
  name: "Get jenkinsciinfra/datadog:latest docker image digest"
  kind: dockerDigest
  spec:
    image: "jenkinsciinfra/datadog"
    tag: "latest"
conditions:
  imageName:
    name: "Test if 'jenkinsciinfra/datadog@sha256' docker image is set"
    kind: yaml
    spec:
      file: "config/default/datadog/datadog.yaml"
      key: "agents.image.repository"
      value: "jenkinsciinfra/datadog@sha256"
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
  imageTag:
    name: "Update 'jenkinsciinfra/datadog:latest' docker image digest"
    kind: yaml
    spec:
      file: "config/default/datadog/datadog.yaml"
      key: "agents.image.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
