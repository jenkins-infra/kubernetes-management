source:
  kind: dockerDigest
  name: Get jenkins/jenkins:lts-jdk11 docker digest
  spec:
    image: "jenkins/jenkins"
    tag: "lts-jdk11"
targets:
  imageTag:
    name: "Update jenkins/jenkins:lts-jdk11 docker image digest"
    kind: yaml
    spec:
      file: "config/default/jenkins-release.yaml"
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
