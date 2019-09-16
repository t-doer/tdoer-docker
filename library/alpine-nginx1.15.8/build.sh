#! /bin/bash

set -eo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: ./build.sh <VERSION>"
    echo "Example: ./build.sh 1.0.0"
    exit 1
fi

IMAGE_TAG="tdoer/alpine-nginx1.15.8:$1"

echo "Step 1: Build image: ${IMAGE_TAG}"
docker build -t ${IMAGE_TAG} .

if [ $? -eq 0 ]; then
     echo "DONE"
  else
     echo "Failed"
     exit 1
fi

echo "Step 2: Push image to docker registry"
docker push ${IMAGE_TAG}

if [ $? -eq 0 ]; then
     echo "DONE"
  else
     echo "Failed"
     exit 1
fi
