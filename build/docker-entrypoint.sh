#!/usr/bin/env sh

/opt/nginx/sbin/nginx -v
/opt/nginx/sbin/nginx -g "daemon off;" "$@"
