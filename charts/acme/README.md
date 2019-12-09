# Jenkins Infrastructure ACME settings
This chart is configured to use the dns challenge

https://docs.cert-manager.io/en/latest/tasks/acme/configuring-dns01/azuredns.html

The chart allows multiple dns01 configurations to be passed, where acme.dns01 accepts any valid settings as defined https://cert-manager.io/docs/configuration/acme/dns01/[here].

Example configuration:

```yaml
acme:
    clientSecrets:
    -   name: acme_secret_jenkins_io
        value: 'password'
    -   name: acme_secret_jenkinsci_org
        value: 'password2'
    dns01:
    -   azuredns:
            clientID: XXX
            clientSecretSecretRef:
                name: acme_secret_jenkinsio
                key: CLIENT_SECRET
            subscriptionID: YYY
            tenantID: ZZZ
            resourceGroupName: jenkinsio
            hostedZoneName: jenkins.io
            selector:
                dnsZones:
                - jenkins.io
    -   azuredns:
            clientID: XXX
            clientSecretSecretRef:
                name: acme_secret_jenkinsci_org
                key: CLIENT_SECRET
            subscriptionID: YYY
            tenantID: ZZZ
            resourceGroupName: jenkinsci_org
            hostedZoneName: jenkinsci.org
            selector:
                dnsZones:
                - jenkins-ci.org

```

## Links
* https://cert-manager.io/docs/configuration/acme/[cert-manager]
