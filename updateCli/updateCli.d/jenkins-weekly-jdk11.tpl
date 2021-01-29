source:
  name: "Get Jenkins latest weekly version"
  kind: maven
  postfix: "-jdk11"
  spec:
    owner: "maven"
    url: "repo.jenkins-ci.org"
    repository: "releases"
    groupID: "org.jenkins-ci.main"
    artifactID: "jenkins-war"
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
