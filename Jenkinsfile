pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                echo "Build started"
            }
        }

        stage('Branch Info') {
            steps {
                sh 'echo Current branch is: $GIT_BRANCH'
            }
        }
    }
}
