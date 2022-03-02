#!/usr/bin/make
# choco install make

.DEFAULT_GOAL := help

help:  ## Display this help
	@echo "Help"

##@ Initialize work

init: ## Start a new develop environment
	cp .env.example .env
	cp docker-compose.yml.example docker-compose.yml

	docker-compose up -d

	@sleep 10

	docker-compose exec todo-nginx bash -c "su -c 'composer install' application"

	docker-compose exec todo-nginx bash -c "su -c 'php artisan migrate' application"

##@ Initialize work
starter: ## do algo
    docker-compose exec todo-nginx bash -c "su -c 'composer create-project laravel/laravel:^8.0 example-app' application"

##@ Docker actions

dev: ## Start containers detached
	docker-compose up -d

logs: ## Show the output logs
	docker-compose logs

log: ## Open the logs and follow the news
	docker-compose logs --follow

restart: ## Restart the app container
	docker-compose restart todo-nginx

##@ Bash shortcuts

nginx: ## Enter bash todo-nginx container
	docker-compose exec todo-nginx bash

mysql: ## Enter bash todo-nginx container
	docker-compose exec mysql bash

##@ Database tools

migration: ## Create migration file
	docker-compose exec todo-nginx bash -c "su -c \"php artisan make:migration $(name)\" application"

migrate: ## Perform migrations
	docker-compose exec todo-nginx php artisan migrate

rollback: ## Rollback migration
	docker-compose exec todo-nginx php artisan migrate:rollback

##@ Composer

install: ## Composer install dependencies
	docker-compose exec todo-nginx bash -c "su -c \"composer install\" application"

autoload: ## Run the composer dump
	docker-compose exec todo-nginx bash -c "su -c \"composer dump-autoload\" application"

##@ General commands

route: ## List the routes of the app
	docker-compose exec todo-nginx php artisan route:list
