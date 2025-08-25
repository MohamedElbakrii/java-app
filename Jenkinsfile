pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/MohamedElbakrii/java-app.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Post') {
            steps {
                echo 'Pipeline finished!'
            }
        }
    }
}
