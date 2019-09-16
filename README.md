# Images

Image Tree

```
alpine (alpine)
  |- glibc (alpine-glibc)
       |- oracle jdk (alpine-jdk8-jre)
            |- base java app (alpine-jdk8-jre-java)
                 |- base tomcat (alpine-jdk8-jre-tomcat8)
                      |- tomcat #1
                      |- tomcat #2
                      |- tomcat ...
                      
                 |- springboot #1
                 |- springboot #2
                 |- ...
                 |- other java applications
           
  |- nginx (alpine-nginx1.15.8)
       |- static web#1
       |- static web#2
       |- ...
       |- php-fpm (alpine-nginx1.15.8-php5.6-fpm)
           |- php web application#1
           |- php web application#2
           |- ...                                                 
```

## library

#### library/alpine

Build command:

```
docker build -t tdoer/alpine:3.8.0 .
```

Features:

  1. Alpine 3.8
  2. Support bash shell
  3. Set default timezone to Asia/Shanghai
  
Basic Info:

- Tag: tdoer/alpine:3.8.0
- Base Image: docker.io/alpine:3.8
- Base Image's Doc: https://hub.docker.com/_/alpine
- Basic Image's Dockerfile: https://github.com/gliderlabs/docker-alpine/blob/63a4b585539aec349a3b1b5109be7bfece856cff/versions/library-3.8/x86_64/Dockerfile

Usage Example:

```
docker run --name alpine -it --rm tdoer/alpine:3.8.0 /bin/bash
```

In the bash shell, input **date**, system will show Shanghai timezone properly, for example:

```
bash-4.4# date
Thu Feb  7 22:27:29 CST 2019
```

#### library/alpine-glibc

Build command:

```
docker build -t tdoer/alpine-glibc:1.0.0 .
```

Features:

  1. Alpine 3.8
  2. glibc 2.28
  
Basic Info:

- Tag: tdoer/alpine-glibc:1.0.0
- Base Image: tdoer/alpine:3.8.0

Usage Example:

```
docker run --name alpine-glibc -it --rm tdoer/alpine-glibc:1.0.0 /bin/bash
```

In the bash shell, input **apk list glibc***, system will show installed glibc apk packages, for example:

```
bash-4.4# apk list glibc*
WARNING: Ignoring APKINDEX.adfa7ceb.tar.gz: No such file or directory
WARNING: Ignoring APKINDEX.efaa1f73.tar.gz: No such file or directory
glibc-bin-2.28-r0 x86_64 {glibc} (LGPL) [installed]
glibc-2.28-r0 x86_64 {glibc} (LGPL) [installed]

```

#### library/alpine-jdk8-jre

Build command:

```
docker build -t tdoer/alpine-jdk8-jre:1.0.0 .
```

Features:

  1. Alpine 3.8
  2. Hotspot JRE 1.8 + unlimited JCE
  3. Use /dev/urandom as random source

Basic Info:

- Tag: tdoer/alpine-openjdk8-jre:1.0.0
- Base Image: tdoer/alpine-glibc:1.0.0

Usage Example:

```
docker run --name alpine-jdk8-jre -it --rm tdoer/alpine-jdk8-jre:1.0.0 java -version
```

#### library/alpine-jdk8-jre-java

Latest Tag: 1.0.0

Build command:

```
docker build -t tdoer/alpine-jdk8-jre-java:1.0.0 .
```

Features:

  1. An [Agent Bond](https://github.com/fabric8io/agent-bond) agent with [Jolokia](http://www.jolokia.org) and Prometheus' [jmx_exporter](https://github.com/prometheus/jmx_exporter). The agent is installed as `/opt/agent-bond/agent-bond.jar`. See below for configuration options.
  2. A startup script [`/deployments/run-java.sh`](#startup-script-run-javash) for starting up Java applications.
  3. Run Java application with "bybon:root" user.
     

Basic Info:

- Tag: tdoer/alpine-jdk8-jre-java:1.0.0
- Base Image: tdoer/alpine-jdk8-jre:1.0.0
- Reference Image: docker.io/fabric8/java-alpine-openjdk8-jre:1.5.4
- Reference Image's Doc: https://github.com/fabric8io-images/java/tree/master/images/alpine/openjdk8/jre
- Reference Image's Dockerfile: https://hub.docker.com/r/fabric8/java-alpine-openjdk8-jre/dockerfile
- Source Repository: https://github.com/fabric8io-images/java

Usage Example:

```
docker run --name alpine-jdk8-jre-java -it --rm tdoer/alpine-jdk8-jre-java:1.0.0 /bin/bash
```

Use it as a base image:

```
FROM tdoer/alpine-jdk8-jre-java:1.0.0

COPY common-eureka*.jar /deployments/

EXPOSE 7020 7021
```

#### library/alpine-jdk8-jre-tomcat8

A empty tomcat image which only be used as a base image.

Latest Tag: 1.0.0

Build command:

```
docker build -t tdoer/alpine-jdk8-jre-tomcat8:1.0.0 .
```

Features:

  * Tomcat Version: **8.5.32**
  * Port: **8080**
  * Documentation, examples, host-manager, manager and ROOT have been removed
  * Command: `/opt/tomcat/bin/deploy-and-run.sh` which links .war files from *${DEPLOY_DIR} to
  */opt/tomcat/webapps* and then calls `/opt/tomcat/bin/catalina.sh run`
     

Basic Info:

- Tag: tdoer/alpine-jdk8-jre-tomcat8:1.0.0
- Base Image: tdoer/alpine-jdk8-jre-java:1.0.0

- Reference Image: docker.io/fabric8/java-alpine-openjdk8-jre:1.5.4
- Reference Image's Doc: https://github.com/fabric8io-images/java/tree/master/images/alpine/openjdk8/jre
- Reference Image's Dockerfile: https://hub.docker.com/r/fabric8/java-alpine-openjdk8-jre/dockerfile
- Source Repository: https://github.com/fabric8io-images/java

Usage Example: 

```
docker run --name alpine-jdk8-jre-tomcat8 -it --rm tdoer/alpine-jdk8-jre-tomcat8:1.0.0 /bin/bash
```

Use it as a base image:

```
FROM tdoer/alpine-jdk8-jre-java:1.0.0

COPY *.war /deployments/BOMS2.war

COPY extra-jars/*.jar $CATALINA_HOME/lib/

COPY context.xml $CATALINA_HOME/conf/

COPY setenv.sh $CATALINA_HOME/bin/

VOLUME [ "/deployments/conf" ]
```

#### library/alpine-nginx1.15.8

A base nginx image. The image can only be used as a base image.
Its descendant image should add `html` and `conf.d` by deploying the named package `html.tar.gz` 
and `conf.d.tar.gz` into `/deployments`. `html.tar.gz` contains 'html' path, for example, `html/index.html`
and `conf.d.tar.gz` contains `con.d/default.conf`.  

Latest Tag: 1.0.1

Build command:

```
docker build -t tdoer/alpine-nginx1.15.8:1.0.1 .
```

Features:

  * Nginx Version: **1.15.8**
  * Port: **80**
  * Installation Pathes:
  
  ```
  /opt/nginx
  /opt/nginx/sbin/nginx
  /opt/nginx/modules
  /opt/nginx/conf/nginx.conf
  /opt/nginx/logs/error.log
  /opt/nginx/logs/access.log
  /opt/nginx/html/
  /etc/nginx/conf.d/
  /etc/nginx/cert/
  /etc/nginx/acl/
  /var/run/nginx.pid
  /var/run/nginx.lock
  /var/cache/nginx/client_temp
  /var/cache/nginx/proxy_temp
  /var/cache/nginx/fastcgi_temp
  /var/cache/nginx/uwsgi_temp
  /var/cache/nginx/scgi_temp
  ```
  
  * Forward request and error logs to docker log collector
  * Tuned nginx configuration, see /etc/nginx/nginx.conf
     
Basic Info:

- Tag: tdoer/alpine-nginx1.15.8:1.0.1
- Base Image: htdoer/alpine:3.8.0

- Reference Image: docker.io/nginx:1.5.8-alpine
- Reference Image's Doc: https://hub.docker.com/_/nginx
- Reference Image's Dockerfile: https://github.com/nginxinc/docker-nginx/blob/2364fdc54af554d28ef95b7be381677d10987986/mainline/alpine/Dockerfile
- Source Repository: https://nginx.org/download/nginx-1.15.8.tar.gz

Usage Example: Check Installation

```
docker run --name alpine-nginx -it --rm tdoer/alpine-nginx1.15.8:1.0.0 /bin/bash
```

Use it as a base image:

```
FROM tdoer/alpine-nginx1.15.8:1.0.0

LABEL maintainer="Htinker Hu <htinker@163.com>"

COPY conf.d.tar.gz /deployments/
COPY html.tar.gz /deployments/
```

Run it with local volume

```
docker run --name alpine-nginx -p80:80 -v /path/to/html:/opt/nginx/html -v /path/to/conf.d:/opt/nginx/conf.d tdoer/alpine-nginx1.15.8:1.0.0
```


#### library/alpine-nginx1.15.8-php5.6-fpm

A base nginx image. The image can only be used as a base image.
Its descendant image should add `html` by deploying the named package `html.tar.gz` 
into `/deployments`. `html.tar.gz` contains 'html' path, for example, `html/index.html`. 


Latest Tag: 1.0.0

Build command:

```
docker build -t tdoer/alpine-nginx1.15.8-php5.6-fpm:1.0.0 .
```

Features:

  * Nginx Version: **1.15.8**
  * PHP Version: **5.6**
  * Nginx Port: **80**
  * PHP Port: **9000**
  * Installation Pathes: 
  
  ```
  /usr/local/
  /user/local/etc/php/
  /user/local/etc/php/conf.d
  /user/local/etc/php-fpm.d
  /usr/local/bin/docker-php-*
  ```
     
Basic Info:

- Tag: tdoer/alpine-nginx1.15.8-php5.6-fpm:1.0.0 .
- Base Image: tdoer/alpine-nginx1.15.8:1.0.0


Usage Example: Check Installation

```
docker run --name alpine-nginx-php-fpm -it --rm tdoer/alpine-nginx1.15.8-php5.6-fpm:1.0.0 /bin/bash
```

Use it as a base image:

```
FROM tdoer/alpine-nginx1.15.8-php5.6-fpm:1.0.0

LABEL maintainer="Htinker Hu <htinker@163.com>"

COPY html.tar.gz /deployments/
```
