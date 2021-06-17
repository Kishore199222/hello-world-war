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
    image: maven:3.8.1-adoptopenjdk-11
    imagePullPolicy: Always
    command:
    - cat
    tty: true
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
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
    stage(docker build and push) {
      steps {
        container(name: 'kaniko') {
            sh '''
             /kaniko/executor --dockerfile  `pwd`/Dockerfile --context `pwd` --destination=gcr.io/kaniko-project/executor:v$BUILD_NUMBER
               '''  
       }
      }
    }
  }
}
