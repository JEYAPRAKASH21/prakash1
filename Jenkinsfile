pipeline {
    agent any

    stages {

        stage('Start') {
            steps {
                echo "🚀 Build started"
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Show Branch') {
            steps {
                echo "🌿 Current branch: ${env.BRANCH_NAME}"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker stop myapp || true
                docker rm myapp || true
                docker run -d -p 80:80 --name myapp myapp
                '''
            }
        }
    }

    post {
        always {
            echo "🏁 Pipeline finished"
        }
    }
}
