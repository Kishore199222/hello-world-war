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
    image: gcr.io/kaniko-project/executor:latest
    imagePullPolicy: Always
    command:
    - cat
    tty: true
    volumeMounts:
    - name: kaniko-secret
      mountPath: /secret
    env:
    - name: GOOGLE_APPLICATION_CREDENTIALS
      value: /secret/kaniko-secret.json
  volumes:
  - name: kaniko-secret
    secret:
      secretName: kaniko-secret
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
    stage(docker build and push ) {
      steps {
        container(name: 'kaniko') {
            sh '''
            /kaniko/executor --dockerfile  `pwd`/Dockerfile --context `pwd` --destination=docker push gcr.io/eng-origin-313113/quickstart-image:v$BUILD_NUMBER
            '''  
}}}
  }
}
