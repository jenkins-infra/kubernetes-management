source:
  kind: githubRelease
  name: "Get jenkins-infra/jenkins-wiki-exporter latest version"
  spec:
    owner: "jenkins-infra"
    repository: "jenkins-wiki-exporter"
    token: "{{ requiredEnv .github.token }}"
    username: "{{ .github.username }}"
    version: "latest"
conditions:
  docker:
    name: "Test if jenkinsciinfra/jenkins-wiki-exporter Docker Image exist"
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/jenkins-wiki-exporter"
targets:
  imageTag:
    name: "Update jenkins-wiki-exporter docker image tag"
    kind: yaml
    spec:
      file: "charts/jenkins-wiki-exporter/values.yaml"
      key: image.tag
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
  appVersion:
    name: "Update jenkins-wiki-exporter appversion"
    kind: yaml
    spec:
      file: "charts/jenkins-wiki-exporter/Chart.yaml"
      key: appVersion
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
