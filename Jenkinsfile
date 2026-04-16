pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/JEYAPRAKASH21/prakash1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("myapp")
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker stop myapp || true'
                sh 'docker rm myapp || true'
                sh 'docker run -d -p 80:80 --name myapp myapp'
            }
        }
    }
}
