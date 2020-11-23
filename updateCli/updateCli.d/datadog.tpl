source:
  name: "Get docker image digest for jenkinsciinfra/datadog:latest"
  kind: dockerDigest
  spec:
    image: "jenkinsciinfra/datadog"
    tag: "latest"
conditions:
  imageName:
    name: "Docker image name 'jenkinsciinfra/datadog@sha256' is used"
    kind: yaml
    spec:
      file: "config/default/datadog.yaml"
      key: "agents.image.repository"
      value: "jenkinsciinfraa/datadog@sha256"
    scm:
      github:
        user: "{{ .github.user }}" 
        email: "{{ .github.email }}" 
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}" 
        username: "{{ .github.username }}" 
        branch: "master"
targets:
  imageTag:
    name: "Update docker image digest fom 'jenkinsciinfra/datadog:latest'"
    kind: yaml
    spec:
      file: "config/default/datadog.yaml"
      key: "agents.image.tag"
    scm:
      github:
        user: "{{ .github.user }}" 
        email: "{{ .github.email }}" 
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}" 
        username: "{{ .github.username }}" 
        branch: "master"

