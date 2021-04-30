# Docker Mate
## For local PHP based project development

Easy-to-use [Docker](https://www.docker.com/) setup for local development by [Docker Mate](https://github.com/docker-mate/docker-mate).

*please note that this is intended for local development - deploying it to production is probably a bad idea*

## Features
- Fast configuration: Choose system, enter your project's name and maybe add a git
- Backup/Restore routines for the database
- [MailHog](https://github.com/mailhog/MailHog): Catch all outgoing mail for easy mail debugging
- [phpMyAdmin](https://github.com/phpmyadmin/phpmyadmin): Direct database access

## Documentation

Please take a look into documentation.

## Quick overview

### Linux
- `docker` & `docker-compose`
- Configure your system to resolve `.docker` domains to `127.0.0.1` e.g. with dnsmasq

### macOS
- For native docker installs you need to configure your system to resolve `.docker` domains to `127.0.0.1`
- envsubstr for creating the env file & mkcert for SSL support

## Usage

### First time setup
1. `git clone https://github.com/docker-mate/docker-mate.git your-project`
1. `cd your-project`
1. Run `make up` and follow the instructions
1. Adjust your projects name (use [kebap-case](https://stackoverflow.com/questions/11273282/whats-the-name-for-hyphen-separated-case/12273101#12273101) as this is also used for your local development domain)
1. Your new project should start and you should be greeted with the local URLs where you can access it
1. clone/put what-ever in app and app/web is document root

### Starting, stopping etc
Run `make up` to start everything and all other `make` commands and how to extend them can be found in the documentation.

