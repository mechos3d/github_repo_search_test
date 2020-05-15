FROM ruby:2.7.1-alpine3.11

ARG RAILS_ROOT=/app
WORKDIR $RAILS_ROOT

ARG BUILD_PACKAGES="build-base curl-dev git"
ARG DEV_PACKAGES="yaml-dev zlib-dev nodejs yarn libxml2-dev libxslt-dev"
ARG RUBY_PACKAGES="tzdata less"
ARG BUNDLER_VERSION="2.0.1"

RUN apk update &&\
    apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES &&\
    gem install bundler:$BUNDLER_VERSION

COPY Gemfile Gemfile.lock $RAILS_ROOT/

RUN bundle config set without 'development:test:assets' &&\
  bundle config --global frozen 1 &&\
  bundle install -j4 --retry 3 --path=vendor/bundle
  # &&\
  # Remove unneeded files (cached *.gem, *.o, *.c)
  # rm -rf vendor/bundle/ruby/2.7.1/cache/*.gem &&\
  # find vendor/bundle/ruby/2.7.1/gems/ -name "*.c" -delete &&\
  # find vendor/bundle/ruby/2.7.1/gems/ -name "*.o" -delete

# RUN adduser --no-create-home --disabled-password heroku
# USER heroku

COPY . $RAILS_ROOT
ENV HOME $RAILS_ROOT
CMD ["bundle", "exec", "puma"]
