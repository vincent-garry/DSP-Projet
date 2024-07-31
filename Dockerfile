# Utiliser une image Node.js officielle comme image de base
FROM node:14

# Créer et définir le répertoire de l'application dans le conteneur
WORKDIR /app

# Copier package.json et package-lock.json
COPY package*.json ./

# Lister les fichiers pour vérifier la copie
RUN ls -la /app

# Installer les dépendances
RUN npm install

# Lister les fichiers pour vérifier l'installation des dépendances
RUN ls -la /app/node_modules

# Copier le reste de votre application
COPY src .

# Lister les fichiers pour vérifier la copie
RUN ls -la /app

# Exposer le port sur lequel l'application s'exécute (par exemple, 3000)
EXPOSE 3000

# Commande pour lancer l'application
CMD ["npm", "start"]
