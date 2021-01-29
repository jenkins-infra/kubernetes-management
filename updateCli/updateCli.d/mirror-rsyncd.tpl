source:
  name: Get jenkinsciinfra/rsyncd:latest docker image digest
  kind: dockerDigest
  spec:
    image: "jenkinsciinfra/rsyncd"
    tag: "latest"

conditions:
  defaultCiDockerImage:
    name: "Test if rsyncd docker image is set to jenkinsciinfra/rsyncd@sha256"
    kind: yaml
    spec:
      file: "charts/mirror/values.yaml"
      key: "images.rsyncd.repository"
      value: "jenkinsciinfra/rsyncd@sha256"
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
      file: "charts/mirror/values.yaml"
      key: "images.rsyncd.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository}}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
