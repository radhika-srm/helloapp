FROM maven:3.6.3-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package 

FROM openjdk:17-jre-slim
WORKDIR /app
COPY --from=build /app/target/helloapp-1.0-SNAPSHOT.jar .
CMD [ "java" "-jar" "helloapp-1.0-SNAPSHOT.jar" ]