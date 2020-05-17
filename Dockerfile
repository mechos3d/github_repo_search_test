FROM ruby:2.7.1-alpine3.11

ARG RAILS_ROOT=/app
WORKDIR $RAILS_ROOT

ARG BUNDLER_VERSION="2.0.1"

RUN apk update &&\
    apk add --update --no-cache build-base nodejs yarn tzdata &&\
    gem install bundler:$BUNDLER_VERSION

COPY Gemfile Gemfile.lock $RAILS_ROOT/

RUN bundle config set without 'development:test:assets' &&\
  bundle config --global frozen 1 &&\
  bundle install -j4 --retry 3 --path=vendor/bundle

COPY . $RAILS_ROOT
ENV HOME $RAILS_ROOT
CMD ["bundle", "exec", "puma"]
