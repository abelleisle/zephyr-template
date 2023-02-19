# Zephyr Docker Template
Template for Docker-based Zephyr build environments.

This template uses Docker for building and flashing to prevent clogging the host system with Python packages and different Zephyr toolchain versions.

## Structure
The following directory structure is used:

* `firmware` - Location of the actual firmware
* `env` - Docker file build instructions and token storage
* `.west` - Instructions given to west (Zephyr build system) related to file locations

## Building
The way this toolchain is set up, you can just use `make` to build the code. This will automatically build the docker toolchain defined in the `env` directory.

## Tagging
By default, the Docker image will be tagged as: `zephyr_docker:1.0.0`. If you'd like to change this, define the following variables in your root Makefile:

* `IMAGE_NAME`
  * The base name of the Docker image
  * Default Value: `zephyr_docker`
* `IMAGE_VERS`:
  * The version tag of the Docker image
  * Default Value: `1.0.0`
* `IMAGE_TAG`:
  * The actual image tag. If this doesn't rely on the previous two tags, they don't have to be redefined.
  * Default Value: `${IMAGE_NAME}:${IMAGE_TAG}`
