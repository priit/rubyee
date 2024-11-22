FROM alpine:3.20.3 AS base

RUN apk add --no-cache caddy curl

# Create a new user 'app' with /app as the home directory
RUN adduser -D -u 1000 -h /app app && \
    mkdir -p /app && \
    chown -R app:app /app

# Copy your Caddyfile to the appropriate location
COPY ./config/Caddyfile /etc/caddy/Caddyfile
RUN chown -R app:app /etc/caddy

# Throw-away build stage to reduce size of final image
FROM base AS build
RUN apk add --no-cache ruby ruby-dev build-base nodejs npm
RUN gem install bundler
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test
COPY ./source/ /app/source/
COPY ./ /app/
RUN bundle exec middleman build

#
# Final stage for app image
#
FROM base

COPY --from=build /app/build /app/build
USER app
EXPOSE 3000
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
