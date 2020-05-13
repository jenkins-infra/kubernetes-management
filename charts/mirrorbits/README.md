# Mirrorbits

This chart deploys two services [mirrorbits](https://github.com/etix/mirrorbits) and a simple nginx service that return every file

A "Quick Start" is available on [etix/mirrorbits](repository)

Docker image used in this chart is defined from [olblak/mirrorbits](https://github.com/olblak/mirrorbits)


## Settings

```
`replicaCount`
`image.mirrorbits.reposotiry`
`image.mirrorbits.tag`
`image.mirrorbits.pullPolicy`
`image.files.reposotiry`
`image.files.tag`
`image.files.pullPolicy`
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
```

## Requirements
This chart requires a redis database which can be deployed with the redis helm [chart](https://github.com/helm/charts/tree/master/stable/redis)

## Configuration

Currently mirrorbits do not provide a way to configure mirrors through a configuration file and considering that this is not something that changes regularly, I will run the following commands once via "kubectl" exec

```
mirrorbits add -rsync rsync://mirror.serverion.com/jenkins -ftp ftp://mirror.serverion.com/jenkins -http https://mirror.serverion.com/jenkins -sponsor-name serverion -sponsor-url serverion.com -admin-email "desmond@serverion.com" -admin-name "Desmond van der Winden" serverion.com

mirrorbits add -http https://mirror.esuni.jp/jenkins/ -admin-email "kuriyama@FreeBSD.org" esuni.jp

mirrorbits add -http http://mirrors.tuna.tsinghua.edu.cn/jenkins/ -rsync rsync://mirrors.tuna.tsinghua.edu.cn/jenkins/ -admin-name "Yuzhi Wang" -admin-email "yuzhi.wang@tuna.tsinghua.edu.cn" tsinghua.edu.cn

mirrorbits add -http https://mirror.xmission.com/jenkins/ -rsync rsync://mirror.xmission.com/jenkins/  -ftp ftp://mirror.xmission.com/jenkins/ xmission.org

# jenkins not synced on rsync
mirrorbits add -http https://ftp-nyc.osuosl.org/pub/jenkins -rsync rsync://ftp-nyc.osuosl.org/jenkins -ftp ftp://ftp-nyc.osuosl.org/pub/jenkins ftp-nyc.osuosl.org

mirrorbits add -http https://ftp-chi.osuosl.org/pub/jenkins -rsync rsync://ftp-chi.osuosl.org/jenkins -ftp ftp://ftp-chi.osuosl.org/pub/jenkins ftp-chi.osuosl.org

mirrorbits add -http https://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/ -rsync rsync://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/ -admin-name "Tomohiro Ito" -admin-email "tomohiro@yz.yamagata-u.ac.jp"  yamagata-u.ac.jp

mirrorbits add -http https://mirror.gruenehoelle.nl/jenkins/ -rsync rsync://esme.gruenehoelle.nl/mirror/jenkins/ -admin-name "gunter@grodotzki.com" -admin-email "gunter@grodotzki.com" gruenehoelle.nl
```

## Links

* [Mirrorbits](https://github.com/etix/mirrorbits) - Upstream project
* [Mirrorbits](https://github.com/olblak/mirrorbits) - Docker Image
