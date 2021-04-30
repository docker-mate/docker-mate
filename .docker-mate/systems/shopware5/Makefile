WEB_ROOT=/var/www/html/web

##:##########################
# Shopware 5: ##
#############################

console: ## Shopware CLI
	docker-compose exec -u application -w ${WEB_ROOT} app bin/console $(ARGS)

sw-install: ## Setup Shopware (installer CLI)
	docker-compose exec -u application -w ${WEB_ROOT} app php recovery/install/index.php \
		--db-host="${DB_HOST}" \
		--db-user="${DB_USER}" \
		--db-password="${DB_PASSWORD}" \
		--db-name="${DB_NAME}" \
		--shop-host="${PROJECT_NAME}.docker" \
		$(ARGS)

grunt: ## Dump theme configuration & start grunt
	docker-compose exec -u application -w ${WEB_ROOT} app bin/console sw:theme:dump:configuration
	cd app/web/themes; grunt

plugin-update: ## Update plugin (needs env variables)
	docker-compose exec -u application -w ${WEB_ROOT} app bin/console sw:store:download $(ARGS) --username ${SW_USER} --password ${SW_PASSWORD} --domain ${SW_DOMAIN}

plugin-list: ## List plugins
	docker-compose exec -u application -w ${WEB_ROOT} app bin/console sw:plugin:list
