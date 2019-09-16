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
    echo "Example: ./build.sh v1.0.0"
    echo """Note: Jenkins will call the command to build and pull image to Docker Registry,
      and the 'VERSION' is calculated from Git branch or tag name selected"""
    exit 1
fi

echo "Target jar is: $1 and version is: $2"

# copy target jar into the Dockerfile's current directory
echo "Step 1: Copy $1 into $(pwd)"
cp -f "$1" $(pwd)

if [ $? -eq 0 ]; then
     echo "DONE"
  else
     echo "Failed"
     exit 1
fi

IMAGE_TAG="harbor.tdoer.cn/common/common-eureka-server:$2"

echo "Step 2: Build image: ${IMAGE_TAG}"
docker build -t ${IMAGE_TAG} .

if [ $? -eq 0 ]; then
     echo "DONE"
  else
     echo "Failed"
     exit 1
fi

echo "Step 3: Push image to docker registry"
docker push ${IMAGE_TAG}

if [ $? -eq 0 ]; then
     echo "DONE"
  else
     echo "Failed"
     exit 1
fi

echo "Step 4: Remove $(pwd)/$(basename $1)"
rm $(pwd)/$(basename $1)
echo "Done"