FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y \ 
  build-essential \
  libpq-dev \
  postgresql-client \
  yarn \
  vim

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT 
WORKDIR $RAILS_ROOT

ENV RAILS_SERVE_STATIC_FILES=true

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]