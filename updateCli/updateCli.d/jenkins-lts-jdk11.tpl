title: Bump jenkins stable version
pipelineID: jenkinsltsjdk11
sources:
  default:
    kind: jenkins
    name: Get jenkins/jenkins:lts-jdk11 docker digest
    transformers:
      - addSuffix: "-jdk11"
    spec:
      release: stable
      github:
        username: "{{ .github.username }}"
        token: "{{ requiredEnv .github.token }}"
conditions:
  docker:
    name: "Test jenkins/jenkins docker image tag"
    kind: dockerImage
    spec:
      image: "jenkins/jenkins"
  imageName:
    name: "Test if jenkins/jenkins docker image is used"
    kind: yaml
    spec:
      file: "config/default/jenkins-release.yaml"
      key: "jenkins.controller.image"
      value: "jenkins/jenkins"
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
