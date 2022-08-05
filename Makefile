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
	@mkdir -p src/public
	@docker run \
		--rm \
		-ti \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		node \
		yarn resume export public/index.html --theme ${THEME}

test:
	@echo Testing resume.json
	@echo -------------------------------
	@docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		node \
		yarn resume validate

serve: install build test
	@echo Serving CV
	@echo -------------------------------
	@docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		--publish 4000:4000 \
		node \
		yarn resume serve

console:
	@echo Opening console into container
	@echo -------------------------------
	@docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		--publish 4000:4000 \
		-ti \
		node \
		bash -l
