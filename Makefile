ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

.PHONY: help
.DEFAULT_GOAL := help

#############################
# Environment
#############################
-include app/.docker-mate/.env
-include .env

COMPOSE_FILE=docker-compose.yml${COMPOSE_FILE_PROJECT}${COMPOSE_FILE_LOCAL}
export

# Support additional non docker domain
ifeq ($(origin ADDITIONAL_DOMAIN), undefined)
	ADDITIONAL_DOMAIN_VHOST =
	MAIN_DOMAIN = $(addsuffix .docker,$(PROJECT_NAME))
else
	ADDITIONAL_DOMAIN_VHOST = $(addprefix , , $(ADDITIONAL_DOMAIN))
	MAIN_DOMAIN = ${ADDITIONAL_DOMAIN}
endif


# INCLUDE SYSTEM MAKEFILE
-include .docker-mate/systems/${PROJECT_TYPE}/Makefile

# INCLUDE PROJECT MAKEFILE
-include ./app/.docker-mate/Makefile

#############################
# Helper
#############################

_load-env: # Load project
	[ -d "app" ] || bash .docker-mate/utils/load.sh

_setup: # Setup project
	[ -d "app" ] || bash .docker-mate/systems/${PROJECT_TYPE}/create.sh
	[ -d "app" ] && bash .docker-mate/utils/init-git.sh

_phpini: # Write php.ini in container
	rm -f .docker-mate/docker/app/.env
	if [ -f ".docker-mate/systems/${PROJECT_TYPE}/.env.phpini" ]; then cat .docker-mate/systems/${PROJECT_TYPE}/.env.phpini > .docker-mate/docker/app/.env; fi
	if [ -f "./app/.docker-mate/.env" ]; then cat ./app/.docker-mate/.env  >> .docker-mate/docker/app/.env; fi
	cat ./.env  >> .docker-mate/docker/app/.env

_config: # Write nginx config/vhost
	ln -f .docker-mate/systems/${PROJECT_TYPE}/app.sh .docker-mate/docker/app/
	[ -f "app/.docker-mate/site.conf" ] && ln -f app/.docker-mate/site.conf .docker-mate/docker/web/site.conf \
		|| ln -f .docker-mate/systems/${PROJECT_TYPE}/site.conf .docker-mate/docker/web/site.conf
	make _phpini

#############################
# Certificates/tls: ##
#############################

gen-cert: ## Generate a cert based on installed root-cert for set domain (mkcert)
	mkdir -p ~/.dinghy/certs
	mkcert -cert-file ~/.dinghy/certs/${CERT_NAME}.crt \
		-key-file ~/.dinghy/certs/${CERT_NAME}.key \
		${ADDITIONAL_DOMAIN} ${PROJECT_NAME}.docker "*.${PROJECT_NAME}.docker"
	make upgrade

cert-install: ## Install root cert in browsers and supported systems (mkcert)
	bash .docker-mate/utils/message.sh info "Install root certificate in browsers and supported systems."
	mkcert -install


##:##########################
# Container operations: ##
#############################

init: ## Create a new project
	bash .docker-mate/utils/init.sh
	make _setup
	make gen-cert

load: ## Load an existing project via git and execute load hooks
	bash .docker-mate/utils/init.sh
	make _load-env
	make gen-cert

up: ## Start docker project or initialize
	echo ""
	[ -f ".env" ] || make init
	bash .docker-mate/utils/message.sh info "Starting your project..."
	make check-proxy
	make _phpini
	docker-compose up -d
	make urls

stop: ## Stop docker project
	bash .docker-mate/utils/message.sh info "Stopping your project..."
	docker-compose stop

upgrade: ## Upgrade docker containers
	bash .docker-mate/utils/message.sh info "Upgrading your project..."
	make _config
	docker-compose build --pull
	make up

restart: ## Restart docker containers (stop & start)
	make stop
	make up

destroy: ## Destroy containers/volumes (keep app folder)
	make stop
	bash .docker-mate/utils/message.sh info "Deleting all containers..."
	docker-compose down --rmi all --remove-orphans

rebuild: ## Rebuild docker container (destroy & upgrade)
	make destroy
	make upgrade

state: ## Show docker status
	docker-compose ps

logs: ## Show docker logs
	docker-compose logs -f --tail=50 $(ARGS)

##:##########################
# Container access: ##
#############################

ssh: ## SSH access to a specified container (sh)
	docker-compose exec $(ARGS) sh

ssh-app: ## SSH access to app container (bash)
	docker-compose exec -u application app bash


##:##########################
# Utils MySQL: ##
#############################

mysql-backup: ## Backup MySQL Database into backup folder
	bash .docker-mate/utils/mysql-backup.sh

mysql-restore: ## Restore MySQL Database from backup folder
	bash .docker-mate/utils/mysql-restore.sh

##:##########################
# Info: ##
#############################

urls:
	bash .docker-mate/utils/urls.sh

check-proxy: ## Check docker reverse proxy
	bash .docker-mate/utils/check-proxy.sh


help: ## Generate this command list
	@awk -F ':|##' '/^[^\t]#?.+?:.*?##/ { printf "\033[36m%-25s\033[0m %s\n", $$1, $$NF }' $(MAKEFILE_LIST)
	@echo -e "\n\033[1mDocker Mate Documentation https://docker-mate.dev/\033[0m"

#############################
# Argument fix
#############################
%:
	@:
