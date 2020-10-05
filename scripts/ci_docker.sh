#!/usr/bin/env bash

GIT_SHORT_COMMIT=`git rev-parse --short HEAD`
TIMESTAMP=`date -u +%Y%m%d%H%M%S`
IMAGE_NAME="chainsafe/chainbridge-substrate-chain"
TAG=${TAG:-"${TIMESTAMP}-${GIT_SHORT_COMMIT}"}


case $TARGET in
  "default")
    echo "Pushing image with tag $TAG"
    docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${TAG}
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    docker push ${IMAGE_NAME}:${TAG}
    ;;

  "release")
    echo "Pushing image with tag $TAG"
    docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${TAG}
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    docker push ${IMAGE_NAME}:${TAG}
    ;;
esac

