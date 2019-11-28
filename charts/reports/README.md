# reports

This chart deploys https://reports.jenkins.io

## Running this yourself

This guide assumes you're running minikube, adjust accordingly if you're using something else to run it.

First you need to download the latest reports site build, the files will be git ignored.

```bash
cd charts/reports
wget https://reports.jenkins.io/artifactory-ldap-users-report.json
wget https://reports.jenkins.io/github-jenkinsci-permissions-report.json
# not sure best way to get taglib

minikube mount site:/host
```

```yaml
helm install -f values.yaml -f values.local.yaml --name reports .
```

```yaml
helm upgrade  -f values.yaml -f values.local.yaml  reports .
```

You need to define some configuration locally in a separate values file

Here's an example `values.local.yaml` file:
```yaml
ingress:
  enabled: true
  hosts:
    - host: reports-local.jenkins.io
      paths:
        - path: /
          port: http

htmlVolume:
  hostPath:
    path: /host
```

You'll need to add `reports-local.jenkins.io` to your hosts file, you can get the IP with `kubectl get ingress`
