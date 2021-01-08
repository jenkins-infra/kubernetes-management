source:
  name: Get latest jenkinsciinfra/rsyncd:latest image digest
  kind: dockerDigest
  spec:
    image: "jenkinsciinfra/rsyncd"
    tag: "latest"

conditions:
  defaultCiDockerImage:
    name: "Ensure mirror rsyncd image name is set to jenkinsciinfra/rsyncd@sha256"
    kind: yaml
    spec:
      file: "charts/mirror/values.yaml"
      key: "images.rsyncd.tag"
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
    name: "Update mirror helm chart with latest rsyncd image digest"
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
