{{/*
Define a default fully qualified app name
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "datadog.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 -}}
{{- end -}}

