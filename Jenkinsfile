pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        REPO_URL = 'https://github.com/JEYAPRAKASH21/prakash1.git'
        CREDENTIALS = 'github-credentials'
        BRANCH_NAME = "${env.GIT_BRANCH?.replaceAll('origin/', '') ?: 'main'}"
    }

    stages {

        stage('Start') {
            steps {
                echo "🚀 Build started"
            }
        }

        stage('Show Branch') {
            steps {
                echo "🌿 Current branch: ${env.BRANCH_NAME}"
            }
        }

        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}",
                    credentialsId: "${env.CREDENTIALS}",
                    url: "${env.REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build --no-cache -t myapp .'
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
            echo "🏁 Finished build for branch: ${env.BRANCH_NAME}"
        }
    }
}
