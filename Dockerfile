FROM ruby:latest

# Installation des dépendances système
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /app

# Copie des fichiers de dépendances
COPY Gemfile Gemfile.lock ./

# Installation des gems
RUN gem install bundler && bundle install


# Copie du reste de l'application
COPY . .

# Précompilation des assets pour la production
# RUN bundle exec rake assets:precompile

EXPOSE 3000

# Démarrage du serveur Rails
CMD ["ruby", "Calc.rb"]

