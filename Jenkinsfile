pipeline {
    agent any
    stages{
        stage("Build Docker Image"){
            steps {
                script {
                    app = docker.build("test")
                }
            }
        }
    }
}
