FROM openjdk:13
VOLUME /tmp
EXPOSE 8080
ADD ./FirstDevopsJob-0.0.1-SNAPSHOT.jar devops.jar
ENTRYPOINT ["java","-jar","/devops.jar"]