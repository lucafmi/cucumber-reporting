FROM maven:3.5.3-jdk-8-alpine
ARG USERNAME
ARG PASSWORD
ARG PHASE="test"
ENV afhost 192.168.1.25
WORKDIR /usr/src/app
RUN pwd
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
COPY settings.xml /usr/src/app
COPY mvn.sh /tmp  
RUN chmod u+x /tmp/mvn.sh && /tmp/mvn.sh $PHASE $USERNAME $PASSWORD

