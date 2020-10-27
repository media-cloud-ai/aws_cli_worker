.PHONY: docker-build docker-clean docker-push-registry version

ENVFILE?=.env
ifeq ($(shell test -e $(ENVFILE) && echo -n yes),yes)
	include ${ENVFILE}
	export
endif

DOCKER_REGISTRY?=
DOCKER_IMG_NAME?=mediacloudai/aws_cli_worker
ifneq ($(DOCKER_REGISTRY), ) 
	DOCKER_IMG_NAME := /${DOCKER_IMG_NAME}
endif
VERSION="0.2.0"

ENV?=local

docker-build:
	@docker build -t ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION} .

docker-clean:
	@docker rmi ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION}

docker-registry-login:
	@docker login --username "${DOCKER_REGISTRY_LOGIN}" -p"${DOCKER_REGISTRY_PWD}" ${DOCKER_REGISTRY}
	
docker-push-registry: 
	@docker push ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION}

version:
	@echo ${VERSION}
