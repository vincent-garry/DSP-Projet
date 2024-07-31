# Étape de build
FROM maven:3.8.4-openjdk-11-slim AS build

WORKDIR /app
COPY src/Jeu_Puissance4/Puissance4/sources /app/src/main/java

# Création d'un pom.xml
COPY <<EOF /app/pom.xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>Jeu_Puissance4</artifactId>
    <version>1.0-SNAPSHOT</version>
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.2.0</version>
                <configuration>
                    <archive>
                        <manifest>
                            <addClasspath>true</addClasspath>
                            <mainClass>sources.Controleur</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
EOF

RUN mvn clean package

# Étape finale
FROM openjdk:11-jre-slim

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    supervisor \
    fluxbox \
    libxrender1 \
    libxtst6 \
    libxi6 \
    fontconfig \
    libfreetype6 \
    fonts-dejavu \
    wget \
    unzip \
    net-tools \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Installation de noVNC
RUN mkdir -p /usr/local/novnc \
    && wget -qO- https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz | tar xz --strip 1 -C /usr/local/novnc \
    && wget -qO- https://github.com/novnc/websockify/archive/v0.10.0.tar.gz | tar xz --strip 1 -C /usr/local/novnc/utils/websockify

WORKDIR /app
COPY --from=build /app/target/Jeu_Puissance4-1.0-SNAPSHOT.jar /app/Jeu_Puissance4.jar

# Configuration de supervisord
COPY <<EOF /etc/supervisor/conf.d/supervisord.conf
[supervisord]
nodaemon=true

[program:xvfb]
command=/usr/bin/Xvfb :99 -screen 0 1024x768x16
autorestart=true

[program:x11vnc]
command=/usr/bin/x11vnc -display :99 -forever -shared
autorestart=true

[program:novnc]
command=/usr/local/novnc/utils/launch.sh --vnc localhost:5900 --listen 8080
autorestart=true

[program:fluxbox]
command=/usr/bin/fluxbox
autorestart=true
environment=DISPLAY=:99

[program:java]
command=java -jar /app/Jeu_Puissance4.jar
autorestart=true
environment=DISPLAY=:99
EOF

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]