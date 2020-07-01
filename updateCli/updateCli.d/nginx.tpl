source:
  kind: dockerDigest
  spec:
    image: "nginx"
    tag: "1.17"
targets:
  nginx:
    name: "nginx docker image digest"
    kind: yaml
    spec:
      file: "charts/jenkinsio/values.yaml"
      key: image.tag
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "master"
