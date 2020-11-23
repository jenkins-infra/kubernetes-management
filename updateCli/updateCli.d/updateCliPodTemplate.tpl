# Retrieve last updatecli version according Github Releases
source:
  kind: githubRelease
  spec:
    owner: "olblak"
    repository: "updatecli"
    token: "{{ requiredEnv .github.token }}"
    username: "olblak"
    version: "latest"
conditions: 
  # Ensure that a container name 'updatecli' is correctly defined in the PodTemplate
  # and located in the array position spec.containers[1], as needed for the target 
  containerSpec:
    name: "Updatecli"
    kind: yaml
    spec:
      file: "PodTemplates.yaml"
      key: spec.containers[1].name
      value: "updatecli"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "master"
    # Ensure that a docker image tag matching the value retrieved from the latest Github Release is available on dockerhub
  docker:
    name: "Docker Image Published on Registry"
    kind: dockerImage
    spec:
      image: "ghcr.io/olblak/updatecli"
      token: "{{ requiredEnv .github.token }}"
targets:
  # Update updatecli version in the PodTemplate
  imageTag:
    name: "Updatecli"
    kind: yaml
    prefix: "olblak/updatecli:"
    spec:
      file: "PodTemplates.yaml"
      prefix: "ghcr.io/olblak/updatecli:"
      key: spec.containers[1].image
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "jenkins-infra"
        repository: "charts"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "master"
