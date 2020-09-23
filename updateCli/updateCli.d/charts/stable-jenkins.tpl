source:
  kind: helmChart
  spec:
    url: https://kubernetes-charts.storage.googleapis.com
    name: jenkins

conditions:
  exist:
    name: "Jenkins Helm Chart Published on Registry"
    kind: helmChart
    spec:
      url: https://charts.jenkins.io
      name: jenkins
  chartVersion:
    name: "jenkinsci/jenkins Helm Chart"
    kind: yaml
    spec:
      file: "charts/jenkins/requirements.yaml"
      key: "dependencies[0].name"
      value: "jenkins"
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
  chartVersion:
    name: "jenkinsci/jenkins Helm Chart"
    kind: yaml
    spec:
      file: "charts/jenkins/requirements.yaml"
      key: "dependencies[0].version"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
