pipeline {
    agent any
    stages{
        stage("Build Docker Image"){
            steps {
                sh 'ls -l'
                dir ('target') {
                    writeFile file:'dummy', text:''
                }
                sh 'ls -l'
                script {
                    app = docker.build("test")
                }
                
                // publish html
                publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'target/',
                    reportFiles: 'overview-features.html',
                    reportName: 'Cucumber SelfTest Report'
                ]
            }
        }
    }
}
