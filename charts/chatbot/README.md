# Chatbot

This chart deploys [the jenkins admin irc chatbot](https://github.com/jenkins-infra/ircbot).

Bot usage instructions can be found on the [Jenkins website](https://jenkins.io/projects/infrastructure/ircbot/).

## Running this yourself

```yaml
helm install -f values.yaml -f values.local.yaml --name chatbot .
```

```yaml
helm upgrade  -f values.yaml -f values.local.yaml  chartbot .
```

You need to define some configuration locally in a separate values file

Here's an example `values.local.yaml` file:
```yaml
github:
  username: your-github-username
  password: github-password-or-api-token
jira:
  username: jira-username
  password: jira-password
ircNickPassword: jenkins-admin-irc-password
```
