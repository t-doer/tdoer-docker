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

# ----------------------------------------------------------------------
# References
#  1. https://hub.docker.com/r/fabric8/tomcat-8
#  2. https://hub.docker.com/r/davidcaste/alpine-tomcat/dockerfile
# Download apache-tomcat-8.5.32.tar.gz from http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz
# and other files from https://github.com/fabric8io-images/tomcat/tree/master/images/8
# Features:
#  * Tomcat Version: **8.5.32**
#  * Port: **8080**
#  * Documentation, examples, host-manager, manager and ROOT have been removed
#  * Command: `/opt/tomcat/bin/deploy-and-run.sh` which links .war files from *${DEPLOY_DIR} to
#  */opt/tomcat/webapps* and then calls `/opt/tomcat/bin/catalina.sh run`


FROM tdoer/alpine-jdk8-jre-java:1.0.0

MAINTAINER Htinker Hu <htinker@163.com>

EXPOSE 8080

ENV TOMCAT_VERSION 8.5.32
ENV DEPLOY_DIR /deployments

USER root

# Overwrite base image's jmx_exporter_config.yml
ADD jmx_exporter_config.yml /opt/agent-bond/

# Copy javaagent
COPY javaagent /deployments/

# Get and Unpack Tomcat
COPY apache-tomcat-${TOMCAT_VERSION}.tar.gz /tmp/catalina.tar.gz

RUN tar xzf /tmp/catalina.tar.gz -C /opt \
 && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
 && rm /tmp/catalina.tar.gz

# Startup script
ADD deploy-and-run.sh /opt/apache-tomcat-${TOMCAT_VERSION}/bin/

RUN chmod 755 /opt/apache-tomcat-${TOMCAT_VERSION}/bin/deploy-and-run.sh \
 && rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs \
           /opt/tomcat/webapps/host-manager /opt/tomcat/webapps/manager \
           /opt/tomcat/webapps/ROOT /opt/tomcat/bin/*.bat

COPY server.xml /opt/tomcat/conf/

VOLUME [ "/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root" ]

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

CMD ["/opt/tomcat/bin/deploy-and-run.sh"]


