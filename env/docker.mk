IMAGE_NAME ?= zephyr_docker
IMAGE_VERS ?= 1.0.0
IMAGE_TAG  ?= ${IMAGE_NAME}:${IMAGE_VERS}

DOCKER_ENV       = -e ZEPHYR_BASE=/workdir/os/zephyr

DOCKER_ROOT      = ${PROJECT_ROOT}/env/zephyr_docker/
DOCKER_FILE      = ${DOCKER_ROOT}/Dockerfile.devel
DOCKER_BUILD_CMD = docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t ${IMAGE_TAG} -f ${DOCKER_FILE}
DOCKER_RUN_CMD   = docker run     --privileged ${DOCKER_ENV} -v ${PROJECT_ROOT}:/workdir ${IMAGE_TAG}
DOCKER_SHELL_CMD = docker run -ti --privileged ${DOCKER_ENV} -v ${PROJECT_ROOT}:/workdir ${IMAGE_TAG}

TOKEN_LOC = ${PROJECT_ROOT}/env/tokens

.PHONY: docker_install
docker_install: ${TOKEN_LOC}/install.token
${TOKEN_LOC}/install.token: ${DOCKER_FILE}
	cd ${DOCKER_ROOT} && ${DOCKER_BUILD_CMD} ${DOCKER_ROOT}
	@touch $@

.PHONY: docker_build
docker_build: ${TOKEN_LOC}/build.token
${TOKEN_LOC}/build.token: ${TOKEN_LOC}/install.token
	${DOCKER_RUN_CMD} west update
	${DOCKER_RUN_CMD} west blobs fetch
	@touch $@

.PHONY: docker_shell
docker_shell: ${TOKEN_LOC}/build.token
	${DOCKER_SHELL_CMD}
