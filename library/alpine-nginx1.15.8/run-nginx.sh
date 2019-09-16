#!/bin/sh

# Fail on a single failed command in a pipeline (if supported)
(set -o | grep -q pipefail) && set -o pipefail

# Fail on error and undefined vars
set -eu

HTML_TAR=$DEPLOYMENT_DIR/html.tar.gz
HTML_DIR=$NGINX_ROOT/html
CONFD_TAR=$DEPLOYMENT_DIR/conf.d.tar.gz
CONFD_DIR=$NGINX_ROOT/conf.d

is_empty_or_not_exist(){
  if [ -d $1 ]; then
    count=`ls $1 |wc -w`
    if [ "$count" = "0" ]; then
      return 0
    fi
  else
    return 0
  fi

  return 1
}

# handle html
if [ -f $HTML_TAR ]; then
  echo "Unzipping $HTML_TAR to $NGINX_ROOT"
  tar -zxC  $NGINX_ROOT -f $HTML_TAR
  echo "DONE"
elif is_empty_or_not_exist $HTML_DIR ; then
  echo "INFO: $HTML_TAR is not found, $HTML_DIR volume should be mounted"
  exit 1
fi

# handle conf.d
if [ -f $CONFD_TAR ]; then
  echo "Unzipping $CONFD_TAR to $NGINX_ROOT"
  tar -zxC  $NGINX_ROOT -f $CONFD_TAR
  echo "DONE"
elif is_empty_or_not_exist $CONFD_DIR ; then
  echo "INFO: $CONFD_TAR is not found, $CONFD_DIR volume should be mounted"
  exit 1
fi

echo "Run Nginx with daemon off"
/opt/nginx/sbin/nginx -g "daemon off;"


