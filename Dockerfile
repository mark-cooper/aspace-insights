FROM ruby:2.7.4

ENV APP_ENV=production \
    BUNDLER_VERSION=2.2.28 \
    RACK_ENV=production \
    LANG=en_US.UTF-8

RUN mkdir -p /usr/app
WORKDIR /usr/app

COPY Gemfile* /usr/app/
RUN gem install bundler:$BUNDLER_VERSION && \
    bundle update --bundler && \
    bundle config set without 'development test' && \
    bundle install

COPY . /usr/app
RUN chmod u+x docker-entrypoint.sh

ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD ["./bin/puma", "-p", "3000"]
EXPOSE 3000
