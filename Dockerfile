# Utiliser l'image officielle Swift comme base
FROM swift:latest

WORKDIR /root

# Définir le répertoire de travail dans le conteneur
COPY ./src/* .

# Compiler l'application
RUN swift build -c release

# Exposer le port sur lequel l'application s'exécute (à ajuster selon votre application)
# EXPOSE 80

# Commande pour exécuter l'application
CMD [".build/release/swiftApp"]