source:
  kind: dockerDigest
  spec:
    image: "jenkinsciinfra/datadog"
    tag: "latest"
#conditions:
#  imageName:
#    name: "Docker image name set to jenkinsciinfra/datadog@sha256"
#    kind: yaml
#    spec:
#      file: "config/default/datadog.yaml"
#      key: "agents.image.repository"
#      value: "jenkinsciinfraa/datadog@sha256"
#    scm:
#      github:
#        user: "{{ .github.user }}" 
#        email: "{{ .github.email }}" 
#        owner: "jenkins-infra"
#        repository: "charts"
#        token: "{{ requiredEnv .github.token }}" 
#        username: "{{ .github.username }}" 
#        branch: "master"
targets:
  imageTag:
    name: "jenkinsci-infra/datadog docker digest"
    kind: yaml
    spec:
      file: "config/default/datadog.yaml"
      key: "agents.image.tag"
    scm:
      github:
        user: "{{ .github.user }}" 
        email: "{{ .github.email }}" 
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}" 
        username: "{{ .github.username }}" 
        branch: "master"


