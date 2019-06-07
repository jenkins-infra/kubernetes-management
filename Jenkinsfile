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
    image 'quay.io/roboll/helmfile:v0.48.0'
    imagePullPolicy: Always
    workdir: /home/jenkins
    env:
      - name: HOME
        value: "/home/jenkins/workspace"
    command:
    - cat
    tty: true
'''
    }
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
    stage('Diff'){
      steps {
        sh 'helmfile -f helmfile.d diff --suppress-secrets'
      }
    }
    stage('Apply'){
      steps {
        sh 'helmfile -f helmfile.d apply --suppress-secrets'
      }
    }
  }
}
