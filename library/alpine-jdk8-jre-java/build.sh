#! /bin/bash

# Copyright 2019 T-Doer (tdoer.com).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: ./build.sh <VERSION>"
    echo "Example: ./build.sh 1.0.0"
    exit 1
fi

IMAGE_TAG="tdoer/alpine-jdk8-jre-java:$1"

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
