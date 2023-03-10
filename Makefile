PROJECT_ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

BOARD = esp32

.PHONY: all shell build flash

all: docker_build build

build: docker_build
	${DOCKER_RUN_CMD} west build -b ${BOARD} -s firmware
	sed -i "s+/workdir+${PROJECT_ROOT}+g" build/compile_commands.json

flash: build
	${DOCKER_RUN_CMD} west flash

shell: docker_shell

include env/docker.mk
