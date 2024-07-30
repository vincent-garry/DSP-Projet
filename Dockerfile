# Utiliser une image de base officielle de PHP avec Apache
FROM php:7.4-apache

# Copier les fichiers de l'application dans le répertoire de travail du conteneur
COPY ./src /var/www/html/

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Définir les bonnes permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Exposer le port 80 pour le serveur web
EXPOSE 80