incrementals-publisher
======================
incrementals-publisher

Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| artifactory.key | string | `""` | key to upload to artifactory |
| fullnameOverride | string | `""` |  |
| github.token | string | `""` | token to update github checks and look up commits |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"halkeye/incrementals-publisher"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.tls | list | `[]` |  |
| jenkins.auth | string | `""` | username:accesskey to  talk to jenkins apis to pull build metadata |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `nil` |  |
| tolerations | list | `[]` |  |
