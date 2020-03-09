# Mirror

This helm charts starts two containers one that synchronize remote Jenkins mirror with a local directory and a second one that serves synchronized files

# Running this yourself.

! By default the helm chart is configured to provision a volume based on the default storage class. A different persistentVolume can be specified by modifying the variable `persistent`
 
`helmfile -f helmfile.d/mirror.yaml apply`
