# README

This helm chart installs the jenkins infrastructure ldap service (ldap.jenkins.io) and is designed to be working with the [jenkinsciinfra/openldap](https://github.com/jenkinsciinfra/openldap) docker image.

- [Docker](https://github.com/jenkins-infra/ldap)
- [DockerHub](https://hub.docker.com/r/jenkinsciinfra/ldap)
- [IEP](https://github.com/jenkins-infra/iep/tree/master/iep-008)


## Running this yourself

`helmfile -f helmfile.d/ldap.yaml apply`

### Minikube gotchas

Require `socat` and `cifs-utils` to mount azure file storage in Minikube

Once deployed, you can restore the latest backup by running  
`kubectl exec -i -t -n ldap -c slapd ldap-0 /entrypoint/restore`

If you don't have access to our azure file storage, you can still test this helm chart using a mock database similar to this [one](https://github.com/jenkins-infra/ldap/blob/master/mock.ldif)
