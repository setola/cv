DOCKER_TAG="latest"
DIR=.
BUILD_DIR=./build
THEME="ks"

images:
	@echo Generating Docker images
	@echo ----------------------
	@find $$DIR -type f -name Dockerfile -exec sh -c 'docker build --no-cache --rm -t $$(basename $$(dirname "$${0}")):${DOCKER_TAG} -f $${0} ./' {} \;

build:
	@echo Generating CV
	@echo ----------------------
	docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		node resume export resume.html --theme ${THEME}

test:
	@echo Testing resume.json
	@echo ----------------------
	docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		node resume test

serve:
	@echo Generating CV
	@echo ----------------------
	docker run \
		--rm \
		--volume $$PWD/src:/home/node/app \
		--workdir /home/node/app \
		--publish 4000:4000 \
		node resume serve \
		--theme /home/node/app/node_modules/

console:
	@echo Opening console into container
	@echo ----------------------
	@docker-compose run --rm node ash -l
