pipeline {
  agent none
  agent {
    docker { image 'quay.io/roboll/helmfile:v0.48.0' }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    timeout(time: 30, unit: 'MINUTES')
    timestamps()
  }

  stages {
    stage('Test Lint'){
      steps {
        sh 'helmfile -f helmfile.d lint'
      }
    }
    stage('Apply'){
      when {
        branch 'master'
        environment name: 'JENKINS_URL', value: 'https://trusted.ci.jenkins.io:1443/'
      }
      steps {
        sh 'helmfile -f helmfile.d apply --suppress-secrets'
      }
    }
  }
}
