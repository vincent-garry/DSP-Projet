# Utiliser une image Node.js officielle comme image de base
FROM node:14

# Créer et définir le répertoire de l'application dans le conteneur
WORKDIR /app

COPY src/tictactoe1 .

RUN npm install

RUN node server/index.js -d

EXPOSE 3000

# Commande pour lancer l'application
CMD ["npm", "start"]