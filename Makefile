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

# Build and up container
env-build:
	bin/scripts/manage_env.sh --build

# Clean env and src files and docker container
env-purge:
	bin/scripts/manage_env.sh --purge

# Start project containers.
start:
	docker-compose up -d

# Stop project containers.
stop:
	docker-compose stop

# Restart project containers.
restart:
	docker-compose stop && docker-compose start

# Print project status.
status:
	docker-compose ps

# Enter container shell
tty:
	docker-compose exec $(filter-out $@,$(MAKECMDGOALS)) bash

.PHONY: env-build env-purge start stop restart status tty

help:
	@awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t