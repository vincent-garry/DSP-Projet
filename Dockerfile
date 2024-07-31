# Utiliser une image Node.js officielle comme image de base
FROM node:latest

# Créer et définir le répertoire de l'application dans le conteneur
WORKDIR /app

# Copier les fichiers de votre application dans le conteneur
COPY src/package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste de votre application
COPY . .

# Exposer le port sur lequel l'application s'exécute (par exemple, 3000)
EXPOSE 3000

RUN pwd && ls -l
# Commande pour lancer l'application
CMD ["node", "src/server.js"]
