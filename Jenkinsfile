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
  - name: helm
    image: gcr.io/eng-origin-313113/xyz
    imagePullPolicy: Always
    command:
    - cat
    tty: true
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
    - /busybox/cat
    tty: true
    volumeMounts:
    - name: kaniko-secret
      mountPath: /secret
    env:
    - name: GOOGLE_APPLICATION_CREDENTIALS
      value: /secret/eng-origin-313113-35cb905c077e.json
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
            # mvn clean install
            '''
        }
      }
    }
    stage('docker build and push') {
      steps {
        container(name: 'kaniko') {
            sh '''
            #/kaniko/executor --dockerfile  `pwd`/Dockerfile --context `pwd` --destination gcr.io/eng-origin-313113/quickstart-image:v$BUILD_NUMBER
            '''  
     }
    }
   }
    stage('deploy'){
      steps {
        container(name: 'helm'){
            sh '''
             helm ls
             '''
      }
    }
  } 
 }
}
