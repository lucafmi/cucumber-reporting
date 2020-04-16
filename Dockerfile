FROM maven:3.5.3-jdk-8-alpine
WORKDIR /usr/src/app
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean test

