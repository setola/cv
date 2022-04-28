DOCKER_TAG="latest"
DIR=.
BUILD_DIR=./build
THEME=even

.PHONY : install build test

install:
	@echo Generating CV
	@echo -------------------------------
	@docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		node \
		yarn install

build:
	@echo Generating CV
	@echo -------------------------------
	@docker run \
		--rm \
		-ti \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		node \
		resume export resume.html --theme ${THEME}

test:
	@echo Testing resume.json
	@echo -------------------------------
	@docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		node resume validate

serve: install build test
	@echo Serving CV
	@echo -------------------------------
	@docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		--publish 4000:4000 \
		node resume serve

console:
	@echo Opening console into container
	@echo -------------------------------
	@docker-compose run --rm node ash -l
