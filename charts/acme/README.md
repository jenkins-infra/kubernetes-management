# Jenkins Infrastructure ACME settings
This chart is configured to use the dns challenge

https://docs.cert-manager.io/en/latest/tasks/acme/configuring-dns01/azuredns.html

The chart allows multiple dns01 configurations to be passed, currently only one client secret though.

Example configuration:

```yaml
acme:
  azureClientSecret: adsaasdsa

  email: "your-email@example.com"

  dns01:
    - azure:
        clientID: "123"
        clientSecretSecretRef:
          name: azuredns-config-{{ .Values.acme.id }}
          key: CLIENT_SECRET
        subscriptionID: 1213-21312-3-1212
        tenantID: 1234-12313-12312-321
        resourceGroupName: rg-1
        hostedZoneName: first.io
    - azure:
        clientID: "123"
        clientSecretSecretRef:
          name: azuredns-config-{{ .Values.acme.id }}
          key: CLIENT_SECRET
        subscriptionID: 1233-4567
        tenantID: 3123-21312312
        resourceGroupName: rg-2
        hostedZoneName: second.org
```
