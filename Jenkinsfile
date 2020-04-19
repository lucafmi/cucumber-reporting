pipeline {
    agent any
    stages{
        stage ('Test & push report') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'artifactory_id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    // available as an env variable, but will be masked if you try to print it out any which way
                    // note: single quotes prevent Groovy interpolation; expansion is by Bourne Shell, which is what you want
                    script {
                        app = docker.build("cucumber", "--build-arg PHASE=test --build-arg USERNAME=$USERNAME --build-arg PASSWORD=$PASSWORD --no-cache .")
                    }
                }
            }    
        }
        stage ('Download report') {
            steps {
                script {
                    def server = Artifactory.server("artifactory")
                    def downloadSpec = """{
                            "files": [
                                    {
                                        "pattern": "generic-local/report.zip",
                                        "target": "reports/"
                                    }
                                ]
                            }"""
                    server.download(downloadSpec)
                }
            }
        }
        stage("Unzip report"){
            steps {
                unzip zipFile: 'reports/report.zip', dir: 'reports'
                // publish html
                publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'reports/target/demo/cucumber-html-reports/',
                    reportFiles: '*.*',
                    reportName: 'Cucumber SelfTest Report'
                ]
            }
        }
        stage ('Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'artifactory_id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    // available as an env variable, but will be masked if you try to print it out any which way
                    // note: single quotes prevent Groovy interpolation; expansion is by Bourne Shell, which is what you want
                    script {
                        app = docker.build("cucumber", "--build-arg PHASE=deploy --build-arg USERNAME=$USERNAME --build-arg PASSWORD=$PASSWORD --no-cache .")
                    }
                }
            }    
        }
    }
}
