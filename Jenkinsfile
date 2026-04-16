pipeline {
    agent any

    // ─── Triggers ────────────────────────────────────────────────────────────
    triggers {
        githubPush() // fires on every Git webhook push
    }

    // ─── Global Environment ───────────────────────────────────────────────────
    environment {
        BRANCH_NAME = "${env.GIT_BRANCH?.replaceAll('origin/', '') ?: env.BRANCH_NAME ?: 'unknown'}"
        REPO_URL = 'https://github.com/JEYAPRAKASH21/prakash1.git'
        CREDENTIALS = 'github-credentials'
        DEPLOY_SERVER = 'ubuntu@localhost'
    }

    // ─── Stages ───────────────────────────────────────────────────────────────
    stages {

        // 1. Checkout ──────────────────────────────────────────────────────────
        stage('Checkout') {
            steps {
                echo "═══════════════════════════════════════"
                echo " 🌿 Branch : ${env.BRANCH_NAME}"
                echo " 📌 Stage : Checkout"
                echo "═══════════════════════════════════════"
                git branch: "${env.BRANCH_NAME}",
                    credentialsId: "${env.CREDENTIALS}",
                    url: "${env.REPO_URL}"
            }
        }

        // 2. Build ─────────────────────────────────────────────────────────────
        stage('Build') {
            steps {
                echo "═══════════════════════════════════════"
                echo " 🌿 Branch : ${env.BRANCH_NAME}"
                echo " 🔨 Stage : Build"
                echo "═══════════════════════════════════════"
                sh '''
                echo "Building on branch: $BRANCH_NAME"
                # Add your build command here, e.g.:
                # mvn clean package -DskipTests
                # npm install && npm run build
                # gradle build
                '''
            }
        }

        // 3. Test ──────────────────────────────────────────────────────────────
        stage('Test') {
            steps {
                echo "═══════════════════════════════════════"
                echo " 🌿 Branch : ${env.BRANCH_NAME}"
                echo " 🧪 Stage : Test"
                echo "═══════════════════════════════════════"
                sh '''
                echo "Running tests on branch: $BRANCH_NAME"
                # Add your test command here, e.g.:
                # mvn test
                # npm test
                # pytest
                '''
            }
        }

        // 4. Code Quality ──────────────────────────────────────────────────────
        stage('Code Quality') {
            steps {
                echo "═══════════════════════════════════════"
                echo " 🌿 Branch : ${env.BRANCH_NAME}"
                echo " 🔍 Stage : Code Quality"
                echo "═══════════════════════════════════════"
                sh '''
                echo "Running code quality checks on branch: $BRANCH_NAME"
                # Add SonarQube or similar, e.g.:
                # sonar-scanner -Dsonar.projectKey=myproject
                '''
            }
        }

        // 5. Deploy — branch-aware ─────────────────────────────────────────────
        stage('Deploy') {
            steps {
                echo "═══════════════════════════════════════"
                echo " 🌿 Branch : ${env.BRANCH_NAME}"
                echo " 🚀 Stage : Deploy"
                echo "═══════════════════════════════════════"
                script {
                    if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') {
                        echo "📦 Deploying to PRODUCTION from branch: ${env.BRANCH_NAME}"
                        sh """
                        echo "Deploy to Production"
                        # ssh ${env.DEPLOY_SERVER} 'cd /var/www/app && git pull && ./deploy.sh prod'
                        """
                    } else if (env.BRANCH_NAME == 'staging') {
                        echo "📦 Deploying to STAGING from branch: ${env.BRANCH_NAME}"
                        sh """
                        echo "Deploy to Staging"
                        # ssh ${env.DEPLOY_SERVER} 'cd /var/www/app && git pull && ./deploy.sh staging'
                        """
                    } else if (env.BRANCH_NAME.startsWith('feature/') || env.BRANCH_NAME.startsWith('dev')) {
                        echo "📦 Deploying to DEV from branch: ${env.BRANCH_NAME}"
                        sh """
                        echo "Deploy to Dev"
                        # ssh ${env.DEPLOY_SERVER} 'cd /var/www/app && git pull && ./deploy.sh dev'
                        """
                    } else {
                        echo "⚠️ Branch '${env.BRANCH_NAME}' — skipping deploy (no matching environment)."
                    }
                }
            }
        }

        // 6. Notify ────────────────────────────────────────────────────────────
        stage('Notify') {
            steps {
                echo "═══════════════════════════════════════"
                echo " 🌿 Branch : ${env.BRANCH_NAME}"
                echo " 🔔 Stage : Notify"
                echo "═══════════════════════════════════════"
                script {
                    echo "Pipeline complete for branch: ${env.BRANCH_NAME}"
                    // Slack notification example:
                    // slackSend channel: '#deployments',
                    // message: "✅ Build SUCCESS | Branch: ${env.BRANCH_NAME} | Job: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
                }
            }
        }
    }

    // ─── Post Actions ─────────────────────────────────────────────────────────
    post {
        success {
            echo "✅ Pipeline PASSED for branch: ${env.BRANCH_NAME}"
        }
        failure {
            echo "❌ Pipeline FAILED for branch: ${env.BRANCH_NAME}"
            // mail to: 'team@yourcompany.com',
            // subject: "FAILED: ${env.BRANCH_NAME} - Build #${env.BUILD_NUMBER}",
            // body: "Check Jenkins: ${env.BUILD_URL}"
        }
        always {
            echo "🏁 Pipeline finished — Branch: ${env.BRANCH_NAME} | Build: #${env.BUILD_NUMBER}"
            cleanWs() // clean workspace after every run
        }
    }
}
