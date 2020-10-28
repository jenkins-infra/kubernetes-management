source:
  kind: githubRelease
  postfix: "-jdk11"
  replaces:
    - from: "jenkins-"
      to: ""
  spec:
    owner: "jenkinsci"
    repository: "jenkins"
    username: "{{ .github.username }}"
    token: "{{ requiredEnv .github.token }}"
    version: latest
conditions:
  docker:
    name: "Docker Image Published on Registry"
    kind: dockerImage
    spec:
      image: "jenkins/jenkins"
targets:
  imageTag:
    name: "jenkins/jenkins docker tag"
    kind: yaml
    spec:
      file: "charts/jenkins/values.yaml"
      key: "jenkins.master.imageTag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "master"
