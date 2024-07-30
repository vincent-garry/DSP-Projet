# Utiliser l'image officielle Swift comme base
FROM swift:latest

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier tous les fichiers du projet dans le conteneur
COPY . .

# Compiler l'application
RUN swift build -c release

# Exposer le port 80
EXPOSE 80

# Commande pour exécuter l'application
CMD [".build/release/swiftApp"]