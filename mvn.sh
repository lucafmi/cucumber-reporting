#!/bin/bash

if [ $1 = "test" ]
then 
    mvn -f /usr/src/app/pom.xml clean test
    apk add --no-cache zip zlib-dev
    zip report.zip -r /usr/src/app/target/demo/cucumber-html-reports/
    curl -u $2:$3 -X PUT "http://${afhost}:8082/artifactory/generic-local/report.zip" -T report.zip
    exit 0
elif [ $1 = "deploy" ]
then
    mvn clean deploy -Dlocal.repo.username=$2 -Dlocal.repo.password=$3 -s settings.xml    
exit 0
fi
