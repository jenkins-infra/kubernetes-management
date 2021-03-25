title: Bump nginx:stable docker image digest
pipelineID: nginxdockerdigest
sources:
  default:
    kind: dockerDigest
    name: Get nginx:stable docker image digest
    spec:
      image: "nginx"
      tag: "stable"
targets:
  nginx:
    name: "Update nginx:stable docker image digest"
    kind: helmChart
    spec:
      name: charts/jenkinsio
      key: image.tag
      versionIncrement: patch
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
