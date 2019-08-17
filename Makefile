DOCKER_TAG="latest"
DIR=.
BUILD_DIR=./build

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
		node resume export resume.html --theme elegant

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
		node resume serve

clean:
	@echo Removing $$BUILD_DIR content
	@echo ----------------------
	@rm -fr $$BUILD_DIR/*

console:
	@echo Opening console into container
	@echo ----------------------
	@docker-compose run -ti --rm node ash
