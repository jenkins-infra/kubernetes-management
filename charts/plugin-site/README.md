# Plugin site

This chart deploys [plugin-site-api](https://github.com/jenkins-infra/plugin-site-api) and [plugin-site](https://github.com/jenkins-infra/plugin-site)

## Running this yourself

```yaml
helm install -f values.yaml -f values.local.yaml --name plugin-site .
```

```yaml
helm upgrade  -f values.yaml -f values.local.yaml  plugin-site .
```

You need to define some configuration locally in a separate values file

Here's an example `values.local.yaml` file:
```yaml
github:
  clientId: <your-github-username>
  clientSecret: <your-github-api-token>

ingress:
  enabled: true
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
  hosts:
    - host: plugins-local.jenkins.io

restApiUrl: http://plugins-local.jenkins.io/api

# Should point to somewhere where the plugin-site's built public directory is
htmlVolume:
  hostPath:
    path: /src/path/to/your/build/public

```

The `ingress host` and the `restApiUrl` need to be reachable from both your desktop and from the k8s cluster

### Minikube gotchas


When using ingress minikube recommends adding host file entries to your machine so that you can resolve the DNS, this doesn't work in the cluster though,

Workaround, add the following to your values.local.yaml:
```yaml
hostAliases:
  - ip: "<minikube ip, can get from kubectl get ingress>"
    hostnames:
    - "plugins-local.jenkins.io"
```
