FROM ruby:latest

# Installation des dépendances système
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev

WORKDIR /app

# Copie des fichiers de dépendances
COPY ./src/snake-2d/Gemfile ./src/snake-2d/Gemfile.lock ./

# Installation des gems
RUN gem install bundler && bundle install


# Copie du reste de l'application
COPY . .

EXPOSE 3000

# Démarrage du serveur Rails
CMD ["ruby", "Calc.rb"]

