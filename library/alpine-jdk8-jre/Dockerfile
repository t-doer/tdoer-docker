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
# Reference the Dockerfile: https://hub.docker.com/r/anapsix/alpine-java/dockerfile
# Download packages from Oracle Java sites into local directory
# Features:
#   1. Alpine 3.8
#   2. Oracle JRE 8 + JCE
#   3. Use /dev/urandom as random source

FROM tdoer/alpine-glibc:1.0.0

MAINTAINER Htinker Hu <htinker@163.com>

# Java Version and other ENV
ARG JAVA_VERSION_MAJOR=8
ARG JAVA_VERSION_MINOR=201

ENV JAVA_HOME=/usr/local/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}
ENV PATH=${JAVA_HOME}/bin:${PATH}

# Copy local jre files into image's /tmp directory
COPY jre* /tmp/

# do all in one step
RUN set -ex && \
    gunzip /tmp/jre-*linux-x64.tar.gz && \
    mkdir -p /usr/local && \
    tar -C /usr/local -xf /tmp/jre-*linux-x64.tar && \
    ln -s ${JAVA_HOME} /usr/local/jre && \
    cd /tmp && unzip /tmp/jre-jce-policy-${JAVA_VERSION_MAJOR}.zip && \
    cp -v /tmp/UnlimitedJCEPolicyJDK${JAVA_VERSION_MAJOR}/*.jar ${JAVA_HOME}/lib/security/ && \
    rm -rf /usr/local/jre/plugin \
           /usr/local/jre/bin/javaws \
           /usr/local/jre/bin/jjs \
           /usr/local/jre/bin/orbd \
           /usr/local/jre/bin/pack200 \
           /usr/local/jre/bin/policytool \
           /usr/local/jre/bin/rmid \
           /usr/local/jre/bin/rmiregistry \
           /usr/local/jre/bin/servertool \
           /usr/local/jre/bin/tnameserv \
           /usr/local/jre/bin/unpack200 \
           /usr/local/jre/lib/javaws.jar \
           /usr/local/jre/lib/deploy* \
           /usr/local/jre/lib/desktop \
           /usr/local/jre/lib/*javafx* \
           /usr/local/jre/lib/*jfx* \
           /usr/local/jre/lib/amd64/libdecora_sse.so \
           /usr/local/jre/lib/amd64/libprism_*.so \
           /usr/local/jre/lib/amd64/libfxplugins.so \
           /usr/local/jre/lib/amd64/libglass.so \
           /usr/local/jre/lib/amd64/libgstreamer-lite.so \
           /usr/local/jre/lib/amd64/libjavafx*.so \
           /usr/local/jre/lib/amd64/libjfx*.so \
           /usr/local/jre/lib/ext/jfxrt.jar \
           /usr/local/jre/lib/ext/nashorn.jar \
           /usr/local/jre/lib/oblique-fonts \
           /usr/local/jre/lib/plugin.jar \
           /tmp/* && \

    # /dev/urandom is used as random source, which is perfectly safe
    # according to http://www.2uo.de/myths-about-urandom/
    echo "securerandom.source=file:/dev/urandom" >> /usr/local/jre/lib/security/java.security


# EOF