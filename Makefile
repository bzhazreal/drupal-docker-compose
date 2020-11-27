###
#
# Drupal docker-compose makefile.
#
# This file contains make command to manage project.
#
###

###
#
# Project containers management.
#
###
env-build: ## Build and up container
	bin/scripts/build_env.sh --build

env-purge: ## Clean env and src files and docker container
	bin/scripts/build_env.sh --purge

start: ## Start project containers.
	docker-compose up -d

stop: ## Stop project containers.
	docker-compose stop

restart: ## Restart project containers.
	docker-compose stop && docker-compose start

status: ## Print project status.
	docker-compose ps

tty: ## Enter container shell
	docker-compose exec $(filter-out $@,$(MAKECMDGOALS)) bash

.PHONY: env-build env-purge start stop restart status tty
