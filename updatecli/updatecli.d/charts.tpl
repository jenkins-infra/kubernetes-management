# yamllint disable-line rule:braces
{{ range $chart, $val := .charts }}
---
# yamllint disable rule:line-length
name: "Bump `{{ $chart }}` Helm chart version"

scms:
  default:
    kind: github
    spec:
      user: "{{ $.github.user }}"
      email: "{{ $.github.email }}"
      owner: "{{ $.github.owner }}"
      repository: "{{ $.github.repository }}"
      token: "{{ requiredEnv $.github.token }}"
      username: "{{ $.github.username }}"
      branch: "{{ $.github.branch }}"

sources:
  lastChartVersion:
    kind: helmchart
    name: "get last {{ $chart }} chart version"
    spec:
      url: '{{ $val.repositoryUrl | default "https://jenkins-infra.github.io/helm-charts" }}'
      name: "{{ $chart }}"

targets:
  updateChartVersion:
    name: bump `{{ $chart }}` helm chart version to {{ source "lastChartVersion" }}
    kind: file
    scmid: default
    spec:
      files:
      {{ range $target := $val.targets }}
        - "{{ $target }}"
      {{ end }}
      matchpattern: 'chart: {{ $val.repositoryName | default "jenkins-infra" }}\/{{ $chart }}((\r\n|\r|\n)(\s+))version: .*'
      replacepattern: 'chart: {{ $val.repositoryName | default "jenkins-infra" }}/{{ $chart }}${1}version: {{ source "lastChartVersion" }}'

actions:
  default:
    kind: github/pullrequest
    scmid: default
    title: Bump `{{ $chart }}` helm chart version to {{ source "lastChartVersion" }}
    spec:
      labels:
        - dependencies
        - "{{ $chart }}"
      {{- range $label := $val.additionalLabels }}
        - "{{ $label }}"
      {{- end }}
...
{{- end -}}
