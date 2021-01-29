source:
  kind: dockerDigest
  name: "Get jenkinsciinra/ldap:cron-latest docker image digest"
  spec:
    image: "jenkinsciinfra/ldap"
    tag: "cron-latest"
targets:
  imageTag:
    name: "Update jenkinsciinra/ldap:cron-latest image digest"
    kind: yaml
    spec:
      file: "charts/ldap/values.yaml"
      key: "image.crond.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
