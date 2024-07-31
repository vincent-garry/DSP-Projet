# Utiliser une image Node.js officielle comme image de base
FROM node:14

# Créer et définir le répertoire de l'application dans le conteneur
WORKDIR /app

# Copier package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install --only=production

# Installer nodemon seulement si nécessaire pour le développement
# RUN npm install -g nodemon

# Copier le reste de votre application
COPY ./src .

# Exposer le port sur lequel l'application s'exécute (par exemple, 3000)
EXPOSE 3000

# Commande pour lancer l'application
CMD ["npm", "start"]