# Using lightweight alpine image
FROM python:3.7-alpine

MAINTAINER vaultvulp

RUN apk update \
        && apk add --no-cache git openssh-client \
        && pip install pipenv \
        && addgroup -S -g 1001 app \
        && adduser -S -D -h /app -u 1001 -G app app

# Creating working directory
RUN mkdir /app/src
WORKDIR /app/src
RUN chown -R app.app /app/

# Creating environment
USER app

CMD ["/bin/sh"]
