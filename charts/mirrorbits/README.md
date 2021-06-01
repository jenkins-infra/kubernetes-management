# Mirrorbits

This chart deploys two services [mirrorbits](https://github.com/etix/mirrorbits) and a simple nginx service that return every file

A "Quick Start" is available on [etix/mirrorbits](repository)

Docker image used in this chart is defined from [olblak/mirrorbits](https://github.com/olblak/mirrorbits)


Parameters can be added to a file url to display various information like:
```
https://get.jenkins.io/windows/2.251/jenkins.msi.sha256?mirrorlist
https://get.jenkins.io/windows/2.251/jenkins.msi.sha256?mirrorstats
https://get.jenkins.io/windows/2.251/jenkins.msi.sha256?stats
```


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

## HowTo

Mirrorbits is configured using its cli. The configuration is stored in the redis database which means that you can either store a configuration 
locally and run the cli from your machine or you can connect inside one of the pod running to use the cli.

### Access mirrobits cli
 
You need to first identify a pod name and then run a bash command inside it.

* ```kubectl get pods -n mirrorbits -l "app.kubernetes.io/name=mirrorbits"```
* ```kubectl exec -i -t -n mirrorbits -c mirrorbits <POD_NAME> bash```

### Disable Mirrors

You need to identify the mirror identifier that you wand to disable and then disable it.

* ```mirrorbits list```
* ```mirrorbits disable [IDENTIFIER]```

### Add Mirrors Configuration

Currently mirrorbits do not provide a way to configure mirrors through a configuration file and considering that this is not something that changes regularly, I will run the following commands once via "kubectl" exec

```
mirrorbits add -rsync rsync://mirror.serverion.com/jenkins -ftp ftp://mirror.serverion.com/jenkins -http https://mirror.serverion.com/jenkins -sponsor-name serverion -sponsor-url serverion.com -admin-email "desmond@serverion.com" -admin-name "Desmond van der Winden" serverion.com

mirrorbits add -http https://mirror.esuni.jp/jenkins/ -admin-email "kuriyama@FreeBSD.org" esuni.jp

mirrorbits add -http https://mirrors.tuna.tsinghua.edu.cn/jenkins/ -rsync rsync://mirrors.tuna.tsinghua.edu.cn/jenkins/ -admin-name "Yuzhi Wang" -admin-email "yuzhi.wang@tuna.tsinghua.edu.cn" tsinghua.edu.cn

mirrorbits add -http https://mirror.xmission.com/jenkins/ -rsync rsync://mirror.xmission.com/jenkins/  -ftp ftp://mirror.xmission.com/jenkins/ xmission.org

# jenkins not synced on rsync
mirrorbits add -http https://ftp-nyc.osuosl.org/pub/jenkins -rsync rsync://ftp-nyc.osuosl.org/jenkins -ftp ftp://ftp-nyc.osuosl.org/pub/jenkins ftp-nyc.osuosl.org

mirrorbits add -http https://ftp-chi.osuosl.org/pub/jenkins -rsync rsync://ftp-chi.osuosl.org/jenkins -ftp ftp://ftp-chi.osuosl.org/pub/jenkins ftp-chi.osuosl.org

mirrorbits add -http https://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/ -rsync rsync://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/ -admin-name "Tomohiro Ito" -admin-email "tomohiro@yz.yamagata-u.ac.jp"  yamagata-u.ac.jp

mirrorbits add -http https://mirror.gruenehoelle.nl/jenkins/ -rsync rsync://esme.gruenehoelle.nl/mirror/jenkins/ -admin-name "gunter@grodotzki.com" -admin-email "gunter@grodotzki.com" gruenehoelle.nl

mirrorbits add -http https://ftp.halifax.rwth-aachen.de/jenkins/ -rsync rsync://ftp.halifax.rwth-aachen.de/jenkins/ -ftp ftp://ftp.halifax.rwth-aachen.de/jenkins/ -admin-name "ftp@halifax.rwth-aachen.de" -admin-email "ftp@halifax.rwth-aachen.de" rwth-aachen.de

# `20.62.81.57` is a dynamic generated IP retrieved using command `kubectl get service -n mirror  mirror-rsyncd`
# `20.62.81.57` can be replaced by `mirror-rsyncd.mirror` if on the same kubernetes cluster
mirrorbits add -http https://mirror.azure.jenkins.io/ -rsync rsync://mirror-rsyncd.mirror/jenkins/ -admin-name "Jenkins Infrastructure" -admin-email "jenkinsci-infra@googlegroups.com" mirror.azure.jenkins.io

mirrorbits add -http https://ftp.belnet.be/mirror/jenkins/ -rsync rsync://rsync.belnet.be -admin-name "Belnet" -admin-email "ftpmaint@belnet.be" ftp.belnet.be

# Low priority mirrors

```shell
mirrorbits add -rsync rsync://archives.jenkins.io/jenkins/ -http https://archives.jenkins.io/jenkins -sponsor-name Jenkins-infra -sponsor-url www.jenkins.io -admin-email "jenkinsci-infra@googlegroups.com" -admin-name "Jenkins" archives.jenkins.io -score -1
```

## Links

* [Mirrorbits](https://github.com/etix/mirrorbits) - Upstream project
* [Mirrorbits](https://github.com/olblak/mirrorbits) - Docker Image
