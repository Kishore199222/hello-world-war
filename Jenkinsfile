pipeline {
  agent {
    kubernetes {
      //cloud 'kubernetes'
      yaml """
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: maven
    image: maven 
    imagePullPolicy: Always
    command:
    - cat
    tty: true
"""
    }
  }
  stages {
    stage('Build') {
      steps {
        container(name: 'maven') {
            sh '''
             mvn clean install
            '''
        }
      }
    }
  }
}
