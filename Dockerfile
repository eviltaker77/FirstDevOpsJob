
FROM maven:3.6.3-jdk-11-slim AS build
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package

#FROM openjdk:8-jdk-alpine
FROM  openjdk:13
VOLUME /tmp
EXPOSE 8080
ADD ./FirstDevopsJob-0.0.1-SNAPSHOT.jar devops.jar
ENTRYPOINT ["java","-jar","/devops.jar"]
