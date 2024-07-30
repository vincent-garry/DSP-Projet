# Utiliser l'image officielle Swift comme base
FROM swift:latest

# Définir le répertoire de travail dans le conteneur
COPY ./src/*.php /var/www/html/

# Compiler l'application
RUN swift build -c release

# Exposer le port sur lequel l'application s'exécute (à ajuster selon votre application)
EXPOSE 80

# Commande pour exécuter l'application
CMD [".build/release/swiftApp"]