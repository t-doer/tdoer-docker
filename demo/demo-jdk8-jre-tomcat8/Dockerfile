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

FROM tdoer/alpine-jdk8-jre-tomcat8:1.0.2

COPY *.war /deployments/BOMS2.war

COPY extra-jars/*.jar $CATALINA_HOME/lib/

COPY context.xml $CATALINA_HOME/conf/

COPY setenv.sh $CATALINA_HOME/bin/

VOLUME [ "/deployments/conf", "/tmp/oscache" ]

