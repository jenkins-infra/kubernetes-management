source:
  kind: dockerDigest
  name: Get nginx:1.17 docker image digest
  spec:
    image: "nginx"
    tag: "1.17"
targets:
  nginx:
    name: "Update nginx:1.17 docker image digest"
    kind: yaml
    spec:
      file: "charts/jenkinsio/values.yaml"
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
