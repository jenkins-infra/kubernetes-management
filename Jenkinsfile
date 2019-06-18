pipeline {
  agent {
    kubernetes {
      label 'helmfile'
      defaultContainer 'jnlp'
      yaml '''
apiVersion: v1
kind: Pod
metadata:
  labels:
    role: helmfile
spec:
  containers:
  - name: helmfile
    image: quay.io/roboll/helmfile:v0.78.0
    imagePullPolicy: IfNotPresent
    workdir: /home/jenkins
    env:
      - name: HOME
        value: "/home/jenkins/workspace"
    command:
    - cat
    tty: true
  serviceAccountName: cluster-admin
'''
    }
  }
  environment {
    AZURE_TENANT_ID       = credentials('sops-tenant-id')
    AZURE_CLIENT_ID       = credentials('sops-client-id')
    AZURE_CLIENT_SECRET   = credentials('sops-client-secret')
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    timeout(time: 30, unit: 'MINUTES')
  }

  stages {
    stage('Helm Client Init'){
      steps {
        container('helmfile'){
          sh 'helm init --client-only'
          sh 'helm plugin install https://github.com/futuresimple/helm-secrets'
          sh 'helm plugin install https://github.com/databus23/helm-diff --version master'
        }
      }
    }
    stage('Test Lint'){
      steps {
        container('helmfile'){
          sh 'helmfile -f helmfile.d/release.yaml lint'
        }
      }
    }
    stage('Diff'){
      steps {
        container('helmfile'){
          sh 'helmfile -f helmfile.d/release.yaml diff --suppress-secrets'
        }
      }
    }
    stage('Apply'){
      steps {
        container('helmfile'){
          sh 'helmfile -f helmfile.d/release.yaml apply --suppress-secrets'
        }
      }
    }
  }
  post {
    failure {
      input '''Pipeline failed.
We will keep the build pod around to help you diagnose any failures.
Select Proceed or Abort to terminate the build pod'''
      
    }
  }
}
