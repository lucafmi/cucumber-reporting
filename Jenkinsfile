pipeline {
    agent any
    stages{
        stage ('Push Report') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'artifactory_id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    // available as an env variable, but will be masked if you try to print it out any which way
                    // note: single quotes prevent Groovy interpolation; expansion is by Bourne Shell, which is what you want
                    sh 'echo $PASSWORD'
                    // also available as a Groovy variable
                    echo USERNAME
                    // or inside double quotes for string interpolation
                    echo "username is $USERNAME"
                    script {
                        app = docker.build("test2", "--build-arg USERNAME=$USERNAME --build-arg PASSWORD=$PASSWORD --no-cache .")
                    }
                }
            }    
        }
        stage ('Download') {
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
        stage("Unzip"){
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
        stage ("Publish"){
            steps {
                script {
                    def server = Artifactory.server("artifactory")
                    def rtMaven = Artifactory.newMavenBuild()
                    rtMaven.tool = 'maven tool name'
                    rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'
                    def buildInfo = rtMaven.run pom: 'pom.xml', goals: 'clean install'
                    server.publishBuildInfo buildInfo
                }
            }
        }
    }
}
