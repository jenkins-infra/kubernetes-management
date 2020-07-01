source:
  kind: dockerDigest
  spec:
    image: "jenkinsciinfra/ldap"
    tag: "cron-latest"
targets:
  imageTag:
    name: "Ldap crond docker image digest"
    kind: yaml
    spec:
      file: "charts/ldap/values.yaml"
      key: "image.crond.tag"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "master"
