FROM maven:3.5.3-jdk-8-alpine
WORKDIR /usr/src/app
RUN pwd
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean test
COPY ./target/demo/cucumber-html-reports/ /usr/src/app/target/demo/cucumber-html-reports/

