title: Bump jenkins-wiki-exporter version
pipelineID: bumpjenkinswikiexporterversion
sources:
  default:
    kind: githubRelease
    name: "Get jenkins-infra/jenkins-wiki-exporter latest version"
    spec:
      owner: "jenkins-infra"
      repository: "jenkins-wiki-exporter"
      token: "{{ requiredEnv .github.token }}"
      username: "{{ .github.username }}"
conditions:
  docker:
    name: "Test if jenkinsciinfra/jenkins-wiki-exporter Docker Image exist"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/jenkins-wiki-exporter"
targets:
  imageTag:
    name: "Update jenkins-wiki-exporter docker image tag"
    kind: helmChart
    spec:
      name: charts/jenkins-wiki-exporter
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
        branch: "{{ .github.branch }}"
