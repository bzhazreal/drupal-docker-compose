# https://hub.docker.com/_/drupal/
FROM drupal:9.0.7-fpm-buster

WORKDIR /var/www/html

RUN apt-get update \
  && apt-get install -y git mariadb-client unzip \
  && apt-get clean \
  && apt-get autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/*