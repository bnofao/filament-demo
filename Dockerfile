############################################
# Base Image
############################################

# Learn more about the Server Side Up PHP Docker Images at:
# https://serversideup.net/open-source/docker-php/
FROM serversideup/php:8.2-fpm-alpine AS base

ENV S6_CMD_WAIT_FOR_SERVICES=1

COPY --chmod=755 ./entrypoint.d/ /etc/entrypoint.d/

# Switch to root before installing our PHP extensions
USER root
RUN install-php-extensions bcmath gd intl

# As root, run the docker-php-serversideup-s6-init script
RUN docker-php-serversideup-s6-init

############################################
# Production Image
############################################
FROM base AS deploy
COPY --chown=www-data:www-data . /var/www/html
USER www-data

# RUN composer self-update --1 && composer install --quiet --prefer-dist --optimize-autoloader
