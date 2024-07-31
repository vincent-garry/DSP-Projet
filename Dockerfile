FROM openjdk:11-jdk-slim as build

WORKDIR /app
COPY src /app/src
COPY pom.xml /app

RUN apt-get update && apt-get install -y maven
RUN mvn clean package

FROM openjdk:11-jre-slim

WORKDIR /app
COPY --from=build /app/target/Jeu_Puissance4.jar /app/Jeu_Puissance4.jar

EXPOSE 8080
CMD ["java", "-jar", "Jeu_Puissance4.jar"]