# Utiliser l'image de base Maven officielle
FROM maven:3.8.5-openjdk-17

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet
COPY . /app

# Construire le projet
RUN mvn clean install

# Exposer le port utilisé par l'application
EXPOSE 8080

# Commande pour démarrer l'application
CMD ["mvn", "spring-boot:run"]
