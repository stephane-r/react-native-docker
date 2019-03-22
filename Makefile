# User ID
USER_ID=`id -u`

# include .env variables
-include .env
export $(shell sed 's/=.*//' .env)

DOCKERCOMPO = USER_ID=$(USER_ID) docker-compose -p $(COMPOSE_PROJECT_NAME)
DOCKERRM = ${DOCKERCOMPO} run --rm --service-ports
DOCKERANDROID = $(DOCKERRM) android
DOCKEREMULATOR = $(DOCKERRM) -d emulator
DOCKERYARN = $(DOCKERANDROID) yarn

# Help
.SILENT:
.PHONY: help

help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


##########
# Docker #
##########
docker-down:
	@echo "--> Stopping docker services"
	$(DOCKERCOMPO) down
docker-run:
	@echo "--> Run Docker container"
	$(DOCKERANDROID) bash


########
# Yarn #
########
yarn-install:
	@echo "--> Install project dependencies"
	$(DOCKERYARN)
yarn-add:
	@echo "--> Add dependency"
	$(DOCKERYARN) add ${DEP}
yarn-add-dev:
	@echo "--> Add dev dependency"
	$(DOCKERYARN) add -D ${DEP}
yarn-remove:
	@echo "--> Remove dependency"
	$(DOCKERYARN) remove ${DEP}


##############
# FLOW TYPED #
##############
flow-install:
	@echo "--> Add flow-typed libdefs"
	# https://github.com/flow-typed/flow-typed
	$(DOCKERFLOW) install ${DEP} # Example : make flow-install DEP="react-navigation"


###########
# Web App #
###########
web-start:
	@echo "--> Run app on android devices"
	$(DOCKERYARN) web:start


##############
# Native App #
##############
android-run:
	@echo "--> Run app on Android devices"
	$(DOCKERYARN) mobile:android:run
android-run-emulator:
	@echo "--> Run Docker container"
	$(DOCKEREMULATOR)
