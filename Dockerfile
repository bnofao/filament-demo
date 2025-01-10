############################################
# Base Image
############################################

# Learn more about the Server Side Up PHP Docker Images at:
# https://serversideup.net/open-source/docker-php/
FROM serversideup/php:8.4-fpm-nginx AS base

COPY --chmod=755 ./entrypoint.d/ /etc/entrypoint.d/

# Switch to root before installing our PHP extensions
USER root
RUN install-php-extensions bcmath gd

############################################
# Production Image
############################################
FROM base AS deploy
COPY --chown=www-data:www-data . /var/www/html
USER www-data
