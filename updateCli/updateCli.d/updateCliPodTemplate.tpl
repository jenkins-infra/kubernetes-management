# Retrieve last updatecli version according Github Releases
title: Bump updatecli PodTemplate
pipelineID: updateCliPodTemplate
sources:
  default:
    kind: githubRelease
    name: Get latest updatecli version
    spec:
      owner: "updatecli"
      repository: "updatecli"
      token: "{{ requiredEnv .github.token }}"
      username: "{{ .github.username }}"
conditions:
  # Ensure that a container name 'updatecli' is correctly defined in the PodTemplate
  # and located in the array position spec.containers[1], as needed for the target
  default:
    name: "Is Updatecli correctly defined in PodTemplates.yaml"
    kind: yaml
    spec:
      file: "PodTemplates.yaml"
      key: spec.containers[1].name
      value: "updatecli"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
    # Ensure that a docker image tag matching the value retrieved from the latest Github Release is available on dockerhub
  docker:
    name: "Test if ghcr.io/updatecli/updatecli docker image published on registry"
    kind: dockerImage
    spec:
      image: "ghcr.io/updatecli/updatecli"
      token: "{{ requiredEnv .github.token }}"
targets:
  # Update updatecli version in the PodTemplate
  imageTag:
    name: "Update Updatecli version in PodTemplates.yaml"
    kind: yaml
    transformers:
      - addPrefix: "ghcr.io/updatecli/updatecli:"
    spec:
      file: "PodTemplates.yaml"
      key: spec.containers[1].image
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
