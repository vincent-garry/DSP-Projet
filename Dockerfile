# Utiliser une image Node.js officielle comme image de base
FROM node:14

# Créer et définir le répertoire de l'application dans le conteneur
WORKDIR /app


# Copier les fichiers de votre application dans le conteneur
COPY src/* .

# Installer les dépendances
RUN npm install -g nodemon
RUN npm install -g express
RUN npm install

# # Copier le reste de votre application
# COPY src/* .

# Exposer le port sur lequel l'application s'exécute (par exemple, 3000)
EXPOSE 3000

# Command to run the application
# CMD ["npm", "start"]
CMD ["npm", "start"]
