FROM maven:3.5.3-jdk-8-alpine
ARG USERNAME
ARG PASSWORD
ENV afhost 192.168.1.25
WORKDIR /usr/src/app
RUN pwd
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean test
RUN apk add --no-cache zip zlib-dev
RUN zip report.zip -r target/demo/cucumber-html-reports/
RUN curl -u USERNAME:PASSWORD -X PUT "http://${afhost}:8082/artifactory/generic-local/report.zip" -T report.zip


