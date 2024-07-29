# Dockerfile.html-css
FROM nginx:alpine

# Copie des fichiers HTML/CSS dans le répertoire de contenu de Nginx
COPY . /usr/share/nginx/html

# Expose le port 80
EXPOSE 80

# Commande pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
