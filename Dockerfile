# Using lightweight alpine image
FROM python:3.6-alpine

MAINTAINER vaultvulp

# Installing packages
RUN apk update
RUN pip install pipenv

# Creating user
RUN addgroup -S -g 1001 app && adduser -S -D -h /app -u 1001 -G app app

# Creating working directory
RUN mkdir /app/src
WORKDIR /app/src
RUN chown -R app.app /app/

# Creating environment
USER app
RUN pipenv --three

# Setting up entrypoint
RUN export ENV_PATH=$(pipenv --venv) && \
    echo '#!/bin/sh' >> /app/entrypoint.sh && \
    echo "source $ENV_PATH/bin/activate" >> /app/entrypoint.sh && \
    echo 'python "$@"' >> /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh

ENTRYPOINT ["/bin/sh"]
