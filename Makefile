THEME=jsonresume-theme-even
NPM=yarn
NPM_SUBCOMMAND=resumed
DOCKER_TAG="latest"
DOCKER_OPTS= \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		--user $(id -u):$(id -g)

.PHONY : install build test
.DEFAULT_GOAL := build

install:
	@echo Installing dependencies
	@echo -------------------------------
	@mkdir -p $$PWD/src/node_modules
	@docker run \
		${DOCKER_OPTS} \
		node:${DOCKER_TAG} \
		${NPM} install

build: install test
	@echo Generating CV
	@echo -------------------------------
	@mkdir -p $$PWD/src/public
	@docker run \
		${DOCKER_OPTS} \
		node:${DOCKER_TAG} \
		${NPM} ${NPM_SUBCOMMAND} export --output public/index.html --theme ${THEME}

test: install
	@echo Testing resume.json
	@echo -------------------------------
	@docker run \
		${DOCKER_OPTS} \
		node:${DOCKER_TAG} \
		${NPM} ${NPM_SUBCOMMAND} validate

console:
	@echo Opening console into container
	@echo -------------------------------
	@docker run \
		${DOCKER_OPTS} \
		-ti \
		node:${DOCKER_TAG} \
		bash -l

clean:
	@echo Cleaning project
	@echo -------------------------------
	@rm -fr src/public src/node_modules