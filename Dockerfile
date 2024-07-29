# Utiliser une image de base avec Maven préinstallé
FROM maven:3.8.6-openjdk-11 AS build

# Créer un répertoire de travail
WORKDIR /app

# Copier le fichier pom.xml et le répertoire source
COPY pom.xml .
COPY src ./src

# Construire le projet
RUN mvn clean install

# Utiliser une image Java pour exécuter l'application
FROM openjdk:11-jre-slim

# Créer un répertoire de travail
WORKDIR /app

# Copier le JAR construit depuis l'étape de build
COPY --from=build /app/target/your-app.jar .

# Exposer le port utilisé par l'application
EXPOSE 8080

# Définir la commande pour exécuter l'application
CMD ["java", "-jar", "your-app.jar"]