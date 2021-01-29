source:
  name: "Get Jenkins latest weekly version"
  kind: jenkins
  postfix: "-jdk11"
  spec:
    release: weekly
    github:
      username: "{{ .github.username }}"
      token: "{{ requiredEnv .github.token }}"
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
        branch: "{{ .github.branch }}"
