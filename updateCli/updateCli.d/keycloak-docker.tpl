---
source:
  kind: githubRelease
  name: "Get latest keycloak release version"
  spec:
    owner: "keycloak"
    repository: "keycloak"
    token: "{{ requiredEnv .github.token }}"
    username: "{{ .github.username }}"
    version: "latest"
conditions:
  docker:
    name: "Docker Image Published on Registry"
    kind: dockerImage
    spec:
      image: "docker.io/jboss/keycloak"
  yaml:
    name: "Image set to docker.io/jboss/keycloak"
    kind: yaml
    spec:
      file: "config/default/keycloak.yaml"
      key: "image.repository"
      value: "docker.io/jboss/keycloak"
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
    name: "Update docker image tag if needed"
    kind: yaml
    spec:
      file: "config/default/keycloak.yaml"
      key: "image.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
