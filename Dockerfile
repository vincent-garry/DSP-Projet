# Utiliser une image Nginx comme base
FROM nginx:alpine

# Copier les fichiers HTML et CSS dans le répertoire par défaut de Nginx
COPY ./src /usr/share/nginx/html

# Exposer le port utilisé par Nginx
EXPOSE 80

# Nginx s'exécute par défaut en tant que service
CMD ["nginx", "-g", "daemon off;"]
