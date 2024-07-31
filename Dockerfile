FROM ruby:latest

# Installation des dépendances système
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev

WORKDIR /app

# Copie des fichiers de dépendances
COPY ./src/ .

# Installation des gems
RUN cd src/snake-2d/ && gem install bundler && bundle install


# Copie du reste de l'application
COPY . .

EXPOSE 3000

CMD ["ruby", "src/snake-2d/src/app.rb"]

