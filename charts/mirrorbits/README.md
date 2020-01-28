# Mirrorbits

This chart deploys [mirrorbits](https://github.com/etix/mirrorbits)

A "Quick Start" is available on [etix/mirrorbits](repository)

Docker image used in this chart is defined on [olblak/mirrorbits](https://github.com/olblak/mirrorbits)

## Settings

```
`replicaCount`
`image.reposotiry`
`image.tag`
`image.pullPolicy`
`nameOverride`:
`fullnameOverride`:
`imagePullSecrets`:
`serviceAccount.create`:
`serviceAccount.name`:
`securityContext`:
`podSecurityContext`:
`service.type`:
`service.port`:
`ingress.enabled`:
`ingress.annotations`:
`ingress.hosts`
`ingress.tls`
`resources.limits.cpu`:
`resources.limits.memory`:
`resources.requests.cpu`:
`resources.requests.memory`:
`nodeSelector`:
`tolerations`:
`affinity`:
`mirrorbits.conf`: "Define the mirrorbits.conf data"
`repository.name`: "Enforce repository resource name used for secret-persistentVolume - persistentvolumeClaim"
`repository.persistentVolumeClaim.enabled`: _"Enable the persistentVolumeClaim for the repository directory"_
`repository.persistentVolumeClaim.spec`: _Define the persistentVolumeClaim Spec_
`repository.persistentVolume.enabled`: _Enable the persistentVolume for repository directory_
`repository.persistentVolume.spec`: _Define the persistentVolume Spec_
`repository.secrets.enabled`: _Enable the secrets resource for repository directory_
`repository.secrets.spec`: _Define the secret data_


## Requirements
This chart requires a redis database which can be deployed with the redis helm [chart](https://github.com/helm/charts/tree/master/stable/redis)

## Links

* [Mirrorbits](https://github.com/etix/mirrorbits) - Upstream project
* [Mirrorbits](https://github.com/olblak/mirrorbits) - Docker Image
