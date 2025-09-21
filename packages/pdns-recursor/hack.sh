#!/usr/bin/env sh
sed -i '/ARG APT_URL/r ../Dockerfile.hack' ./builder-support/dockerfiles/Dockerfile.target.debian-buster
