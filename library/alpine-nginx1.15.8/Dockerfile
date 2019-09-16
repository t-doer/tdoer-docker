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

FROM tdoer/alpine:3.8.0

LABEL maintainer="Htinker Hu <htinker@163.com>"

ENV NGINX_VERSION 1.15.8

COPY nginx-1.15.8.tar.gz /tmp/nginx.tar.gz

RUN   CONFIG="\
		--prefix=/opt/nginx \
		--sbin-path=/opt/nginx/sbin/nginx \
		--modules-path=/opt/nginx/modules \
		--conf-path=/opt/nginx/conf/nginx.conf \
		--error-log-path=/opt/nginx/logs/error.log \
		--http-log-path=/opt/nginx/logs/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/var/cache/nginx/client_temp \
		--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
		--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
		--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
		--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
		--user=nginx \
		--group=nginx \
		--with-http_ssl_module \
		--with-http_realip_module \
		--with-http_addition_module \
		--with-http_sub_module \
		--with-http_dav_module \
		--with-http_flv_module \
		--with-http_mp4_module \
		--with-http_gunzip_module \
		--with-http_gzip_static_module \
		--with-http_random_index_module \
		--with-http_secure_link_module \
		--with-http_stub_status_module \
		--with-http_auth_request_module \
		--with-http_xslt_module=dynamic \
		--with-http_image_filter_module=dynamic \
		--with-http_geoip_module=dynamic \
		--with-threads \
		--with-stream \
		--with-stream_ssl_module \
		--with-stream_ssl_preread_module \
		--with-stream_realip_module \
		--with-stream_geoip_module=dynamic \
		--with-http_slice_module \
		--with-mail \
		--with-mail_ssl_module \
		--with-compat \
		--with-file-aio \
		--with-http_v2_module \
	" \
	&& addgroup -S nginx \
	&& adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx \
	&& apk add --no-cache --virtual .build-deps \
		gcc \
		libc-dev \
		make \
		openssl-dev \
		pcre-dev \
		zlib-dev \
		linux-headers \
		curl \
		gnupg1 \
		libxslt-dev \
		gd-dev \
		geoip-dev \
	&& mkdir -p /usr/src \
	&& tar -zxC /usr/src -f /tmp/nginx.tar.gz \
	&& rm /tmp/nginx.tar.gz \
	&& cd /usr/src/nginx-$NGINX_VERSION \
	&& ./configure $CONFIG \
	&& make -j$(getconf _NPROCESSORS_ONLN) \
	&& make install \
	&& chmod 755 /opt/nginx/sbin/nginx \
	&& mkdir /opt/nginx/cert/ \
	&& mkdir /opt/nginx/conf.d/ \
	&& strip /opt/nginx/sbin/nginx* \
	&& strip /opt/nginx/modules/*.so \
	&& rm -rf /opt/nginx/html/ \
	&& rm -rf /usr/src/nginx-$NGINX_VERSION \
	\
	# Bring in gettext so we can get `envsubst`, then throw
	# the rest away. To do this, we need to install `gettext`
	# then move `envsubst` out of the way so `gettext` can
	# be deleted completely, then move `envsubst` back.
	&& apk add --no-cache --virtual .gettext gettext \
	&& mv /usr/bin/envsubst /tmp/ \
	\
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' /opt/nginx/sbin/nginx /opt/nginx/modules/*.so /tmp/envsubst \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --no-cache --virtual .nginx-rundeps $runDeps \
	&& apk del .build-deps \
	&& apk del .gettext \
	&& mv /tmp/envsubst /usr/local/bin/ \
	\
	# forward request and error logs to docker log collector
	&& ln -sf /dev/stdout /opt/nginx/logs/access.log \
	&& ln -sf /dev/stderr /opt/nginx/logs/error.log \
	&& mkdir -p /deployments

COPY nginx.conf /opt/nginx/conf/nginx.conf
COPY proxy.conf /opt/nginx/conf/proxy.conf
COPY run-nginx.sh /deployments/run-nginx.sh

EXPOSE 80

RUN mkdir /opt/nginx/acl/

VOLUME ["/opt/nginx/html", "/opt/nginx/conf.d", "/opt/nginx/cert/", "/opt/nginx/acl/"]

RUN chmod 755 /deployments/run-nginx.sh

# DEPLOYMENT_DIR is used by run-nginx.sh for finding the binaries
ENV DEPLOYMENT_DIR=/deployments \
    NGINX_ROOT=/opt/nginx

STOPSIGNAL SIGTERM

CMD ["/deployments/run-nginx.sh"]

