title: Bump nginx:stable docker image digest
pipelineID: nginxdockerdigest
sources:
  default:
    kind: dockerDigest
    name: Get nginx:stable docker image digest
    spec:
      image: "nginx"
      tag: "stable"
conditions:
  ENJenkinsio:
    name: "Update nginx:stable docker image digest for jenkins.io"
    kind: yaml
    spec:
      file: charts/jenkinsio/values.yaml
      key: images.en.repository
      value: nginx@sha256
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
  ZHJenkinsio:
    name: "Update nginx:stable docker image digest for jenkins.io/zh"
    kind: yaml
    spec:
      file: charts/jenkinsio/values.yaml
      key: images.zh.repository
      value: nginx@sha256
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
  USJenkinsio:
    name: "Update nginx:stable docker image digest"
    kind: helmChart
    spec:
      name: charts/jenkinsio
      key: images.en.tag
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
  ZHJenkinsio:
    name: "Update nginx:stable docker image digest"
    kind: helmChart
    spec:
      name: charts/jenkinsio
      key: images.zh.tag
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
