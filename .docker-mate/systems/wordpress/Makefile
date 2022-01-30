WEB_ROOT=/var/www/html/web

##:##########################
# Wordpress: ##
#############################

wp: ## Wordpress CLI
	docker compose exec -u application -w ${WEB_ROOT} app wp $(ARGS)
