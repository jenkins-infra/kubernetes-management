pipeline {
  agent none
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    timeout(time: 30, unit: 'MINUTES')
    timestamps()
  }

  stages {
    stage('Test Lint'){
      agent { label 'quay.io/roboll/helmfile:v0.48.0' }
      steps {
        sh 'helmfile -f helmfile.d lint'
      }
    }
    stage('Apply'){
      steps {
        sh 'helmfile -f helmfile.d apply --suppress-secrets'
      }
    }
  }
}
