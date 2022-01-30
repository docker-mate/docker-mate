WEB_ROOT=/var/www/html

##:##########################
# Shopware plattform: ##
#############################

console: ## Shopware CLI
	docker compose exec -u application -w ${WEB_ROOT} app bin/console $(ARGS)
