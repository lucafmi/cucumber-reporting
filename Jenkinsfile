pipeline {
    agent any
    stages{
        stage("Build Docker Image"){
            steps {
                script {
                    app = docker.build("test")
                }
                
                // publish html
                publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'target/demo/cucumber-html-reports/',
                    reportFiles: 'overview-features.html',
                    reportName: 'Cucumber SelfTest Report'
                ]
            }
        }
    }
}
