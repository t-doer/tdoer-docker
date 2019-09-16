#!/bin/sh

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

# Fail on a single failed command
set -eo pipefail

appDir=${DEPLOY_DIR:-/deployments}
echo "Checking *.war in $appDir"
if [ -d ${appDir} ]; then
  target="/opt/tomcat/webapps"
  for i in ${appDir}/*.war; do
     file=$(basename ${i})
     echo "Linking $i --> $target"
     if [ -f "${target}/${file}" ]; then
         rm "${target}/${file}"
     fi
     dir=$(basename ${i} .war)
     if [ x${dir} != x ] && [ -d "${target}/${dir}" ]; then
         rm -r "$target/${dir}"
     fi
     ln -s ${i} "${target}/${file}"
  done
fi

export CATALINA_OPTS="${CATALINA_OPTS} $(/deployments/run-java.sh options)"

/opt/tomcat/bin/catalina.sh run
