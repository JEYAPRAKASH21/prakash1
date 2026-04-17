pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        REPO_URL = 'https://github.com/JEYAPRAKASH21/prakash1.git'
    }

    stages {

        // 🔹 Start
        stage('Start') {
            steps {
                echo "🚀 Build started"
            }
        }

        // 🔹 Checkout
        stage('Checkout') {
            steps {
                git branch: 'main', url: "${env.REPO_URL}"
            }
        }

        // 🔹 Show Branch (CLEAR OUTPUT)
        stage('Show Branch') {
            steps {
                script {
                    def branch = sh(
                        script: 'git branch --show-current',
                        returnStdout: true
                    ).trim()

                    echo "🌿 Current branch: ${branch}"
                }
            }
        }

        // 🔹 Build Docker Image
        stage('Build Docker Image') {
            steps {
                sh 'docker build --no-cache -t myapp .'
            }
        }

        // 🔹 Run Container
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
            echo "🏁 Pipeline finished successfully"
        }
    }
}
