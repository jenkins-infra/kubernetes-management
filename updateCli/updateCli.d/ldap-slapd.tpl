source:
  kind: dockerDigest
  name: Get jenkinsciinfra/ldap:latest docker image digest
  spec:
    image: "jenkinsciinfra/ldap"
    tag: "latest"
targets:
  imageTag:
    name: "Update jenkinsciinfra/ldap:latest docker image digest"
    kind: yaml
    spec:
      file: "charts/ldap/values.yaml"
      key: "image.slapd.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
