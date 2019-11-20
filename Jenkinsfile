pipeline {
  agent {
    kubernetes {
      label 'helmfile'
      yamlFile 'PodTemplates.yaml'
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
    cron 'H/30 * * * *'
  }

  stages {
    stage('Init Secrets') {
      steps {
        container('jnlp') {
          dir ('secrets'){
            git branch: 'master', credentialsId: 'release-key', url: 'git@github.com:jenkins-infra/charts-secrets.git'
          }
        }
      }
    }
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
          sh 'helmfile -f clusters/publick8s.yaml lint'
        }
      }
    }
    stage('Diff'){
      steps {
        container('helmfile'){
          sh 'helmfile -f clusters/publick8s.yaml diff --suppress-secrets'
        }
      }
    }
    stage('Apply'){
      steps {
        container('helmfile'){
          sh 'helmfile -f clusters/publick8s.yaml apply --suppress-secrets'
        }
      }
    }
  }
}
