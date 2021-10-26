# Accountapp

This chart deploys [accountapp](https://github.com/jenkins-infra/account-app)

## Running this yourself

```yaml
helm install -f values.yaml -f values.local.yaml --name accountapp .
```

```yaml
helm upgrade  -f values.yaml -f values.local.yaml  accountapp .
```

You need to define some configuration locally in a separate values file

Here's an example `values.local.yaml` file:
```yaml
ingress:
  enabled: true
  hosts:
    - host: accountapp-local.jenkins.io
      paths:
        - path: /
          service:
            name: 
            port:
              number: 80

ldap:
  url: ...
  password: ...

jira:
  password: ...

smtp:
  user: ...
  password: ...
```
