#!/usr/bin/env bash

VERSION=$(sed -n "s/__version__ = ['\"]\([^'\"]*\)['\"]/\1/p" bout_install/__init__.py)_$(date +%Y%m%d)
docker build -f docker/Dockerfile -t loeiten/fruit_classifier:"$VERSION" .
# NOTE: It appears that DOCKER_PASSWORD and DOCKER_USERNAME cannot be
#       set as an travis environment variable. Instead it can be set by
#       travis env set DOCKER_USERNAME myusername
#       travis env set DOCKER_PASSWORD mypasswor
#       See
#       https://docs.travis-ci.com/user/docker/#building-a-docker-image-from-a-dockerfile
#       for detaills
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push loeiten/fruit_classifier:"$VERSION"
docker tag loeiten/fruit_classifier:"$VERSION" loeiten/fruit_classifier:latest
docker push loeiten/fruit_classifier:latest