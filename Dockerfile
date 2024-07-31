FROM node:18

WORKDIR /app

COPY src/package*.json ./

RUN npm install -g nodemon
RUN npm install

COPY --chown=node:node . .

EXPOSE 3000

ENV HOST=0.0.0.0 PORT=3000

RUN ls -la

CMD ["node", "server.js"]