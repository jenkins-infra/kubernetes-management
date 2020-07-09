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
  # Ensure that container template name 'updatecli' is correctly defined in the PodTemplate
  # and also that's defined in array location 1, as needed for the target 
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
    # Ensure that a docker image for the latest version is available on dockerhub
  docker:
    name: "Docker Image Published on Registry"
    kind: dockerImage
    spec:
      image: "olblak/updatecli"
targets:
  # Update updatecli version in the PodTemplate
  imageTag:
    name: "Updatecli"
    kind: yaml
    spec:
      file: "PodTemplates.yaml"
      prefix: "olblak/updatecli:"
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
