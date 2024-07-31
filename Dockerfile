FROM node:18

WORKDIR /app

COPY src/package*.json ./

RUN npm ci

COPY --chown=node:node . .

EXPOSE 3000

ENV HOST=0.0.0.0 PORT=3000

RUN ls -la && pwd

CMD ["node", "server.js"]