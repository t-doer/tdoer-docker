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

# ------------------------------------------------------------------------
# References:
#  1. https://hub.docker.com/r/anapsix/alpine-java/dockerfile
#  2. https://hub.docker.com/r/crownpeak/alpine-glibc/dockerfile
#
# Download glibc apk packages from https://github.com/sgerrand/alpine-pkg-glibc into local directory

# Features:
#   1. alpine 3.8
#   2. glibc 2.28

FROM tdoer/alpine:3.8.0

MAINTAINER Htinker Hu <htinker@163.com>

COPY glibc*.apk /tmp/

# do all in one step
RUN set -ex && \
    apk -U upgrade && \
    apk add libstdc++ && \
    apk add --allow-untrusted /tmp/*.apk && \
    ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    apk del glibc-i18n && \
    rm -rfv /tmp/* /var/cache/apk/*

ENV LANG=C.UTF-8