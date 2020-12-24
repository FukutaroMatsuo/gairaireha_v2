FROM ruby:2.5.1
RUN apt-get update
RUN apt-get install -y \ 
  build-essential \
  libpq-dev \
  postgresql-client \
  yarn \
  vim
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . .
EXPOSE 3000
CMD [ "rails", "s", "-b", "0.0.0.0" ]