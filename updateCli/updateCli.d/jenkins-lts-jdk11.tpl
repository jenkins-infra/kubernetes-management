source:
  kind: dockerDigest
  spec:
    image: "jenkins/jenkins"
    tag: "lts-jdk11"
targets:
  imageTag:
    name: "jenkins/jenkins:lts-jdk11 docker digest"
    kind: yaml
    spec:
      file: "config/default/jenkins-release.yaml"
      key: "jenkins.controller.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "master"
