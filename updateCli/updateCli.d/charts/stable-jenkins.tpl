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
      url: https://kubernetes-charts.storage.googleapis.com
      name: jenkins

targets:
  chartVersion:
    name: "Helm Chart"
    kind: yaml
    spec:
      file: "charts/jenkins/requirements.yaml"
      key: "dependencies[0].version"
    scm:
      github:
        user: "updatecli"
        email: "updatecli@olblak.com"
        owner: "jenkins-infra"
        repository: "charts"
        token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
        username: "olblak"
        branch: "master"
