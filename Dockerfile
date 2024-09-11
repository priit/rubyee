FROM alpine:3.20.3
RUN apk add --no-cache caddy curl

# Create a new user 'app' with /app as the home directory
RUN adduser -D -u 1000 -h /app app && \
    mkdir -p /app && \
    chown -R app:app /app

COPY ./build/ /app/

# Copy your Caddyfile to the appropriate location
COPY ./config/Caddyfile /etc/caddy/Caddyfile
RUN chown -R app:app /etc/caddy

USER app
EXPOSE 3000
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
