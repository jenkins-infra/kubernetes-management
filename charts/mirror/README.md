# Mirror

This helm charts starts three containers:
- One to synchronize remote Jenkins mirror with a local directory using rsync command from a cronjob
- A second one that serves synchronized files using apache
- A third one that serves files using a rsyncd daemon, this third containers is only designed to be used by get.jenkins.io

# Running this yourself.

! By default the helm chart is configured to provision a volume based on the default storage class. A different persistentVolume can be specified by modifying the variable `persistent`
 
`helmfile -f helmfile.d/mirror.yaml apply`
