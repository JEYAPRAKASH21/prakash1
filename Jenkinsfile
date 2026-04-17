pipeline {
    agent any

    stages {

        stage('Start') {
            steps {
                echo "🚀 Build started"
            }
        }

        stage('Show Branch') {
            steps {
                script {
                    def branch = sh(
                        script: "git rev-parse --abbrev-ref HEAD",
                        returnStdout: true
                    ).trim()

                    echo "🌿 Current branch: ${branch}"
                }
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
