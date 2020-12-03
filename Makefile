#!/usr/bin/env make

include makefile.env
export

dc := docker-compose.yml

mh := mongo-home
md := mongo-db

remove_volumes:
	@if [ -d ${mh} ]; then \
		sudo rm -rf ${mh}; \
	 fi
	@if [ -d ${md} ]; then \
		sudo rm -rf ${md}; \
	 fi
create_volumes:
	@if [ ! -d ${mh} ]; then \
		mkdir ${mh} && \
		MONGO_USER=`docker run --rm mongo:latest id -u mongodb` && \
		MONGO_GROUP=`docker run --rm mongo:latest id -g mongodb` && \
		sudo chown ${MONGO_USER}:${MONGO_GROUP} ${mh}; \
	 fi
up:
	@docker-compose --file ${dc} up --detach
down:
	@docker-compose --file ${dc} down --volumes
ps:
	@docker-compose --file ${dc} ps
logs:
	@docker-compose --file ${dc} logs --follow

pure_up: remove_volumes create_volumes up
pure_down: down remove_volumes
pure_restart: pure_down pure_up