# Javadoc

This chart deploys https://javadoc.jenkins.io

## Running this yourself

This guide assumes you're running minikube, adjust accordingly if you're using something else to run it.

First you need to download the latest javadoc site build, the files will be git ignored.

```bash
cd charts/javadoc
wget https://ci.jenkins.io/job/Infra/job/javadoc/job/master/lastSuccessfulBuild/artifact/build/javadoc-site.tar.bz2
tar xjf javadoc-site.tar.bz2 # this will take some time
minikube mount site:/host
```

```yaml
helm install -f values.yaml -f values.local.yaml --name javadoc .
```

```yaml
helm upgrade  -f values.yaml -f values.local.yaml  javadoc .
```

You need to define some configuration locally in a separate values file

Here's an example `values.local.yaml` file:
```yaml
ingress:
  enabled: true
  hosts:
    - host: javadoc-local.jenkins.io
      paths:
        - path: /
          pathType: Prefix
          service:
            name: ?????
            port: http

htmlVolume:
  hostPath:
    path: /host
```

You'll need to add `javadoc-local.jenkins.io` to your hosts file, you can get the IP with `kubectl get ingress`

## Running on Azure

Here's some example configuration for running this on Azure:

```yaml
azureStorageAccountName: myaccount
azureStorageAccountKey: key
htmlVolume:
  azureFile: 
    secretName: reports
    shareName: reports
    readOnly: true
# ... you will also need ingress configuration, add as required
```
