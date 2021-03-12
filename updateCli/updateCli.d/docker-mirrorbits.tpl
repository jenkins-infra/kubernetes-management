source:
  name: Get latest version of jenkinsciinfra/mirrorbits
  kind: githubRelease
  spec:
    user: "{{ .github.user }}"
    email: "{{ .github.email }}"
    owner: "{{ .github.owner }}"
    repository: "docker-mirrorbits"
    token: "{{ requiredEnv .github.token }}"
    username: "{{ .github.username }}"
    branch: "{{ .github.branch }}"

conditions:
  dockerImage:
    name: Ensure that the image "jenkinsciinfra/mirrorbits:<found_version>" is published on the DockerHub
    kind: dockerImage
    spec:
      image: "jenkinsciinfra/mirrorbits"
  defaultCiDockerImage:
    name: "Test if mirrorbits docker image is set to jenkinsciinfra/mirrorbits"
    kind: yaml
    spec:
      file: "charts/mirrorbits/values.yaml"
      key: "image.mirrorbits.repository"
      value: "jenkinsciinfra/mirrorbits"
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
    name: "Update jenkinsciinfra/rsyncd:latest docker image digest"
    kind: yaml
    spec:
      file: "charts/mirrorbits/values.yaml"
      key: "image.mirrorbits.tag"
      value: "jenkinsciinfra/mirrorbits"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository}}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
