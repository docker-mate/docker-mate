WEB_ROOT=/var/www/html/web

##:##########################
# Grav: ##
#############################

gpm: ## GPM (Grav Package Manager) CLI
	docker-compose exec -u application --workdir ${WEB_ROOT} app bin/gpm $(ARGS)

grav: ## Grav CLI
	docker-compose exec -u application -w ${WEB_ROOT} app bin/grav $(ARGS)

grav-plugin: ## Grav plugin CLI
	docker-compose exec -u application -w ${WEB_ROOT} app bin/plugin $(ARGS)

grav-add-admin-user: ## Add Grav admin user
	docker-compose exec -u application -w ${WEB_ROOT} app bin/plugin login new-user $(ARGS)
