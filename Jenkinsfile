pipeline {
  agent {
    kubernetes {
      label 'helmfile'
      yamlFile 'Environment.yaml'
      inheritFrom 'jnlp-linux'
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
    disableConcurrentBuilds()
  }

  triggers {
    cron 'H/15 * * * *'
  }

  stages {
    stage('Helm Client Init'){
      steps {
        container('helmfile'){
          checkout scm
          sh 'helm init --client-only'
        }
      }
    }
    stage('Test Lint'){
      steps {
        container('helmfile'){
          sh 'helmfile -f helmfile.d lint'
        }
      }
    }
    stage('Diff'){
      steps {
        container('helmfile'){
          sh 'helmfile -f helmfile.d diff --suppress-secrets'
        }
      }
    }
    stage('Apply'){
      steps {
        container('helmfile'){
          sh 'helmfile -f helmfile.d apply --suppress-secrets'
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
