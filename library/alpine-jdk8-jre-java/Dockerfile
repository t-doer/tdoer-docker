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

# --------------------------------------------------------------------------
# References:
#   1. https://hub.docker.com/r/fabric8/java-alpine-openjdk8-jre/dockerfile
#   2. https://hub.docker.com/r/fabric8/java-centos-openjdk8-jdk/dockerfile
# Download agent-bond-agent-1.2.0.jar from http://central.maven.org/maven2/io/fabric8/agent-bond-agent/1.2.0/
# and other files from https://github.com/fabric8io-images/java
# Features:
#   1. An [Agent Bond](https://github.com/fabric8io/agent-bond) agent with [Jolokia](http://www.jolokia.org) and Prometheus' [jmx_exporter](https://github.com/prometheus/jmx_exporter). The agent is installed as `/opt/agent-bond/agent-bond.jar`. See below for configuration options.
#   2. A startup script [`/deployments/run-java.sh`](#startup-script-run-javash) for starting up Java applications.
#   3. Run Java application with "bybon:root" user.

FROM tdoer/alpine-jdk8-jre:1.0.0

MAINTAINER Htinker Hu <htinker@163.com>

USER root

RUN mkdir -p /deployments

# JAVA_APP_DIR is used by run-java.sh for finding the binaries
ENV JAVA_APP_DIR=/deployments \
    JAVA_MAJOR_VERSION=8

# Agent bond including Jolokia and jmx_exporter
COPY agent-bond-opts /opt/run-java-options
COPY agent-bond-agent-1.2.0.jar /opt/agent-bond/agent-bond.jar
COPY jmx_exporter_config.yml /opt/agent-bond/
COPY run-java.sh /deployments/

RUN set -ex && \
    chmod 444 /opt/agent-bond/agent-bond.jar && \
    chmod 755 /opt/run-java-options && \
    chmod 755 /deployments/run-java.sh

EXPOSE 8778 9779

CMD [ "/deployments/run-java.sh" ]