.PHONY: docker/build docker/clean

DOCKER_TAG := pyppeteer-trial:latest
CONTAINER_NAME := pyppeteer-trial

DEPENDENCIES := \
		main.py

.docker_build: $(DEPENDENCIES)
	docker build -t $(DOCKER_TAG) .
	touch .docker_build

docker/build: .docker_build

docker/run:
	if [ -z "`docker ps -a | grep $(CONTAINER_NAME)`" ]; then \
		docker run -it --name $(CONTAINER_NAME) $(DOCKER_TAG); \
	fi

docker/rm:
	if [ -n "`docker ps -a | grep $(CONTAINER_NAME)`" ]; then \
		docker rm $(CONTAINER_NAME); \
	fi

docker/clean:
	rm -f .docker_build
