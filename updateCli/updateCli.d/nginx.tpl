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
  usJenkinsio:
    name: "Update nginx:stable docker image digest for jenkins.io"
    kind: yaml
    spec:
      file: charts/jenkinsio
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
  zhJenkinsio:
    name: "Update nginx:stable docker image digest for jenkins.io/zh"
    kind: helmChart
    spec:
      file: charts/jenkinsio
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
  usJenkinsio:
    name: "Update nginx:stable docker image digest"
    kind: helmChart
    spec:
      name: charts/jenkinsio
      key: images.us.tag
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
  zhJenkinsio:
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
