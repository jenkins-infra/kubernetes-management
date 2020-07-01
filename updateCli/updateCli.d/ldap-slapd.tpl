source:
  kind: dockerDigest
  spec:
    image: "jenkinsciinfra/ldap"
    tag: "latest"
targets:
  imageTag:
    name: "Ldap docker image tag"
    kind: yaml
    spec:
      file: "charts/ldap/values.yaml"
      key: "image.slapd.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "master"
