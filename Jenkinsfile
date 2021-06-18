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
    image: alpine/helm
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
    image: gcr.io/kaniko-project/executor:latest
    imagePullPolicy: Always
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
    - name: kaniko-secret
      mountPath: /secret
    env:
    - name: GOOGLE_APPLICATION_CREDENTIALS
<<<<<<< HEAD
      value: /secret/kaniko-secret.json
=======
      value: /secret/eng-origin-313113-35cb905c077e.json
>>>>>>> b135f24b3540c9ccaa1786b1c4bc4bca476d9f78
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
    stage('docker build and push') {
      steps {
        container(name: 'kaniko') {
            sh '''
<<<<<<< HEAD
            /kaniko/executor --dockerfile  `pwd`/Dockerfile --context `pwd` --destination=docker push gcr.io/eng-origin-313113/quickstart-image:v$BUILD_NUMBER
=======
            /kaniko/executor --dockerfile  `pwd`/Dockerfile --context `pwd` --destination gcr.io/eng-origin-313113/quickstart-image:v$BUILD_NUMBER
>>>>>>> b135f24b3540c9ccaa1786b1c4bc4bca476d9f78
            '''  
     }
    }
   }
    stage('deploy'){
      steps {
        container(name: helm){
            sh '''
             helm install tsetdep tsetdep/
             '''
      }
    }
  } 
 }
}
