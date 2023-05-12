pipeline {
  agent any
  stages {
    stage('Clone repository') {
      steps {
        checkout([
          $class: 'GitSCM',
          branches: [
            [name: '*/master']
          ],
          userRemoteConfigs: [
            [url: 'https://github.com/LpCodes/DummyFlaskApp']
          ]
        ])
      }
    }

    stage('Read Dockerfile') {
      steps {
        script {
          echo pwd
          cd /var/lib/jenkins/workspace/mye2o
          echo pwd
          dockerfile = readFile('/var/lib/jenkins/workspace/mye2o/Dockerfile')
          echo "Dockerfile content: \n ${dockerfile}"
        }
      }
    }

    stage('Build Docker image') {
      steps {
        script {
          def dockerImage
          dockerImage = docker.build("basicflask2:${env.BUILD_NUMBER}", "-f /var/lib/jenkins/workspace/mye2o/Dockerfile .")
          if (dockerImage) {
            env.BUILD_NUMBER = env.BUILD_NUMBER.toInteger() + 1
            echo "Docker image built successfully"
          } else {
            error "Failed to build Docker image"
          }
        }
      }
    }


    stage('Deploy Docker image') {
            steps {
                sh 'docker run -p 80:80 basicflask2:${env.BUILD_NUMBER}'
            }
        }

    stage('Push Docker image') {
      steps {
        script {
          def dockerImage = docker.image("basicflask2:${env.BUILD_NUMBER - 1}")
          withCredentials([usernamePassword(credentialsId: 'lpcdocks', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            dockerImage.push("${DOCKER_USER}", "${DOCKER_PASS.replaceAll('[\n\r]', '')}")
            echo "Docker image pushed successfully"
          }
        }
      }
    }


  }
}
