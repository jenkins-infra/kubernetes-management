# Mirrorbits

This chart deploys [mirrorbits](https://github.com/etix/mirrorbits)

A "Quick Start" is available on [etix/mirrorbits](repository)

Docker image used in this chart is defined on [olblak/mirrorbits](https://github.com/olblak/mirrorbits)

## Settings

Most important configuration are:

```
# mirrorbits.conf - https://github.com/etix/mirrorbits/blob/master/mirrorbits.conf
mirrorbits: |
  RedisAddress: 10.0.0.1:6379 
  RedisPassword: supersecure
  RedisDB: 0
  ...

To mount an azure file storage at /srv/repo
storageAccountName:
storageAccountKey:
```

## Requirements
This chart requires a redis database which can be deployed with the redis helm [chart](https://github.com/helm/charts/tree/master/stable/redis)

## Links

* [Mirrorbits](https://github.com/etix/mirrorbits) - Upstream project
* [Mirrorbits](https://github.com/olblak/mirrorbits) - Docker Image
