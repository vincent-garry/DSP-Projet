# Utiliser une image Node.js officielle comme image de base
FROM node:latest

# Créer et définir le répertoire de l'application dans le conteneur
WORKDIR /app

# Copier les fichiers package.json et package-lock.json dans le répertoire de travail
COPY src/ .

# Installer les dépendances
RUN npm install 

# Exposer le port sur lequel l'application s'exécute (par exemple, 3000)
EXPOSE 3000

# Commande pour lancer l'application
CMD ["node", "server.js"]
