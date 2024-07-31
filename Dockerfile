FROM openjdk:11-jdk-slim as build

WORKDIR /app
COPY src/Jeu_Puissance4/Puissance4/sources /app/src/main/java

# Création d'un pom.xml avec configuration du plugin JAR et spécification correcte de la classe principale
RUN echo '<?xml version="1.0" encoding="UTF-8"?>\
<project xmlns="http://maven.apache.org/POM/4.0.0" \
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" \
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 \
         http://maven.apache.org/xsd/maven-4.0.0.xsd">\
    <modelVersion>4.0.0</modelVersion>\
    <groupId>com.example</groupId>\
    <artifactId>Jeu_Puissance4</artifactId>\
    <version>1.0-SNAPSHOT</version>\
    <properties>\
        <maven.compiler.source>11</maven.compiler.source>\
        <maven.compiler.target>11</maven.compiler.target>\
    </properties>\
    <build>\
        <plugins>\
            <plugin>\
                <groupId>org.apache.maven.plugins</groupId>\
                <artifactId>maven-jar-plugin</artifactId>\
                <version>3.2.0</version>\
                <configuration>\
                    <archive>\
                        <manifest>\
                            <addClasspath>true</addClasspath>\
                            <mainClass>sources.Controleur</mainClass>\
                        </manifest>\
                    </archive>\
                </configuration>\
            </plugin>\
        </plugins>\
    </build>\
</project>' > pom.xml

RUN apt-get update && apt-get install -y maven
RUN mvn clean package

FROM openjdk:11-jre-slim

WORKDIR /app
COPY --from=build /app/target/Jeu_Puissance4-1.0-SNAPSHOT.jar /app/Jeu_Puissance4.jar

EXPOSE 8080
CMD ["java", "-jar", "Jeu_Puissance4.jar"]