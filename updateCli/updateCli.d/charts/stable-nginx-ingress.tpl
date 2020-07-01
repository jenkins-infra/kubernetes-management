source:
  kind: helmChart
  spec:
    url: https://kubernetes-charts.storage.googleapis.com
    name: nginx-ingress

conditions:
  exist:
    name: "Nging ingress helm chart available on Registry"
    kind: helmChart
    spec:
      url: https://kubernetes-charts.storage.googleapis.com
      name: nginx-ingress

targets:
  public-nginx-ingress:
    name: "public stable/nginx-ingress Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[0].version"
    scm:
      github:
        user: "updatecli"
        email: "updatecli@olblak.com"
        owner: "jenkins-infra"
        repository: "charts"
        token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
        username: "olblak"
        branch: "master"
  private-nginx-ingress:
    name: "private stable/nginx-ingress Helm Chart"
    kind: yaml
    spec:
      file: "helmfile.d/nginx-ingress.yaml"
      key: "releases[1].version"
    scm:
      github:
        user: "updatecli"
        email: "updatecli@olblak.com"
        owner: "jenkins-infra"
        repository: "charts"
        token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
        username: "olblak"
        branch: "master"
