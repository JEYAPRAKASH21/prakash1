pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build --no-cache -t myapp .'
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
