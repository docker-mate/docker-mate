WEB_ROOT=/var/www/html/web

##:##########################
# Shopware 5: ##
#############################

console: ## Shopware CLI
	docker compose exec -u application -w ${WEB_ROOT} app bin/console $(ARGS)

sw-install: ## Setup Shopware (installer CLI)
	docker compose exec -u application -w ${WEB_ROOT} app ./app/bin/install.sh \
		$(ARGS)

grunt: ## Dump theme configuration & start grunt
	docker compose exec -u application -w ${WEB_ROOT} app bin/console sw:theme:dump:configuration
	cd app/web/themes; grunt

plugin-update: ## Update plugin (needs env variables)
	docker compose exec -u application -w ${WEB_ROOT} app bin/console sw:store:download $(ARGS) --username ${SW_USER} --password ${SW_PASSWORD} --domain ${SW_DOMAIN}

plugin-list: ## List plugins
	docker compose exec -u application -w ${WEB_ROOT} app bin/console sw:plugin:list
