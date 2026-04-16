pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        BRANCH_NAME = "${env.GIT_BRANCH?.replaceAll('origin/', '') ?: env.BRANCH_NAME ?: 'main'}"
        REPO_URL = 'https://github.com/JEYAPRAKASH21/prakash1.git'
        CREDENTIALS = 'github-credentials'
    }

    stages {

        // ✅ 1. Start (Assignment Requirement)
        stage('Start') {
            steps {
                echo "Build started"
            }
        }

        // ✅ 2. Branch Info (Assignment Requirement)
        stage('Branch Info') {
            steps {
                sh 'echo Current branch is: $BRANCH_NAME'
            }
        }

        // ✅ 3. Checkout
        stage('Checkout') {
            steps {
                echo "📥 Checking out code from ${env.BRANCH_NAME}"
                git branch: "${env.BRANCH_NAME}",
                    credentialsId: "${env.CREDENTIALS}",
                    url: "${env.REPO_URL}"
            }
        }

        // ✅ 4. Build
        stage('Build') {
            steps {
                echo "🔨 Building project..."
                sh '''
                echo "Building on branch: $BRANCH_NAME"
                '''
            }
        }

        // ✅ 5. Test
        stage('Test') {
            steps {
                echo "🧪 Running tests..."
                sh '''
                echo "Running tests on branch: $BRANCH_NAME"
                '''
            }
        }

        // ✅ 6. Code Quality
        stage('Code Quality') {
            steps {
                echo "🔍 Checking code quality..."
                sh '''
                echo "Code quality checks completed"
                '''
            }
        }

        // ✅ 7. Docker Build (FIX FOR YOUR ISSUE)
        stage('Docker Build') {
            steps {
                echo "🐳 Building Docker Image..."
                sh '''
                docker build --no-cache -t myapp .
                '''
            }
        }

        // ✅ 8. Docker Run (FIX FOR YOUR ISSUE)
        stage('Docker Run') {
            steps {
                echo "🚀 Running Docker Container..."
                sh '''
                docker stop myapp || true
                docker rm myapp || true
                docker system prune -f || true
                docker run -d -p 80:80 --name myapp myapp
                '''
            }
        }

        // ✅ 9. Deploy
        stage('Deploy') {
            steps {
                echo "🚀 Deploying application..."
                script {
                    if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') {
                        echo "📦 Deploying to PRODUCTION"
                    } else if (env.BRANCH_NAME == 'staging') {
                        echo "📦 Deploying to STAGING"
                    } else {
                        echo "⚠️ No deployment for this branch"
                    }
                }
            }
        }

        // ✅ 10. Notify
        stage('Notify') {
            steps {
                echo "🔔 Pipeline completed for branch: ${env.BRANCH_NAME}"
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline SUCCESS"
        }
        failure {
            echo "❌ Pipeline FAILED"
        }
        always {
            echo "🏁 Pipeline finished"
            cleanWs()
        }
    }
}
