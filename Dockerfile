# Utiliser une image de base officielle de PHP avec Apache
FROM php:7.4-apache

# Copier les fichiers de l'application dans le répertoire de travail du conteneur
COPY ./src /var/www/html/

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN chmod -R 755 /var/www/html/

# Exposer le port 80 pour le serveur web
EXPOSE 80
