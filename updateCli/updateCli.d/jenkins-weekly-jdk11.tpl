source:
  name: "Retrieve latest jenkins weekly version"
  kind: githubRelease
  postfix: "-jdk11"
  replaces:
    - from: "jenkins-"
      to: ""
  spec:
    owner: "jenkinsci"
    repository: "jenkins"
    token: "{{ requiredEnv .github.token }}"
    username: "{{ .github.username }}"
    version: "latest"
conditions:
  docker:
    name: "Test jenkins/jenkins docker image tag"
    kind: dockerImage
    spec:
      image: "jenkins/jenkins"
targets:
  imageTag:
    name: "Update jenkins/jenkins docker image tag"
    kind: yaml
    spec:
      file: "charts/jenkins/values.yaml"
      key: "jenkins.controller.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "master"
