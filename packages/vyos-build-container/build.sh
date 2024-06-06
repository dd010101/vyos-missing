#!/bin/sh
set -e

cd vyos-build/docker

echo "Cleaning previous image of ${BRANCH_NAME}..."
docker rmi --force "vyos/vyos-build:${BRANCH_NAME}" || true
docker rmi --force "${CUSTOM_DOCKER_REPO}/vyos/vyos-build:$BRANCH_NAME" || true

echo "Building docker build container for branch ${BRANCH_NAME}..."
docker build --no-cache -t "vyos/vyos-build:${BRANCH_NAME}" .

echo "Pushing ${BRANCH_NAME} image to registry ${CUSTOM_DOCKER_REPO}..."
docker tag "vyos/vyos-build:${BRANCH_NAME}" "${CUSTOM_DOCKER_REPO}/vyos/vyos-build:${BRANCH_NAME}"
docker push "${CUSTOM_DOCKER_REPO}/vyos/vyos-build:$BRANCH_NAME"

echo "Cleaning local registry..."
docker exec registry registry garbage-collect /etc/docker/registry/config.yml --delete-untagged=true

echo "Image ${BRANCH_NAME} was successfully built and pushed to registry ${CUSTOM_DOCKER_REPO}."
