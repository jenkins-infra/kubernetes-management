# jenkins.io

This chart deploys https://jenkins.io

## Running this yourself

This guide assumes you're running minikube, adjust accordingly if you're using something else to run it.

First you need to download the latest jenkins.io site build, the files will be git ignored.

Navigate to: `https://ci.jenkins.io/job/Infra/job/jenkins.io/job/master/`
Download the latest `jenkins.io-<number>.zip`

```bash
cd charts/jenkins.io
unzip jenkins.io-<number>.zip
mv jenkins.io-* site/
mkdir -p site-zh/
echo 'Chinese version of the website' > site-zh/index.html # the build on ci.jenkins.io is broken, no easy way to get the website
minikube mount site:/host
minikube mount site-zh:/hostzh
```

```yaml
helm install -f values.yaml -f values.local.yaml --name jenkinsio .
```

```yaml
helm upgrade  -f values.yaml -f values.local.yaml  jenkinsio .
```

You need to define some configuration locally in a separate values file

Here's an example `values.local.yaml` file:
```yaml
ingress:
  enabled: true
  hosts:
    - host: local.jenkins.io
      paths:
        - path: /
          service:
            name: jenkinsio
            port:
              number: 80
        - path: /zh/
          service:
            name: jenkinsio-zh
            port:
              number: 80

htmlVolume:
  hostPath:
    path: /host

zhHtmlVolume:
  hostPath:
    path: /hostzh
```

You'll need to add `local.jenkins.io` to your hosts file, you can get the IP with `kubectl get ingress`

## Running on Azure

Here's some example configuration for running this on Azure:

```yaml
azureStorageAccountName: myaccount
azureStorageAccountKey: key
htmlVolume:
  azureFile: 
    secretName: jenkinsio
    shareName: jenkinsio
    readOnly: true

zhHtmlVolume:
  azureFile: 
    secretName: jenkinsio
    shareName: zhjenkinsio
    readOnly: true
# ... you will also need ingress configuration, add as required
```