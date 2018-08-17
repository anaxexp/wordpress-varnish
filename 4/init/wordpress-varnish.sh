#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

function _gotpl {
    gotpl "/etc/gotpl/$1" > "$2"
}

mkdir -p /etc/varnish/conf /etc/varnish/lib

if [[ -z "${VARNISH_PURGE_KEY}" ]]; then
    export VARNISH_PURGE_KEY=$(pwgen -s 64 1)
    echo "Varnish purge key is missing. Generating random: ${VARNISH_PURGE_KEY}"
fi

_gotpl 'varnishd.init.d.tmpl' '/etc/init.d/varnishd'
#_gotpl 'secret.tmpl' '/etc/varnish/secret'
_gotpl 'default.vcl.tmpl' '/etc/varnish/default.vcl'

_gotpl 'conf/acl.vcl.tmpl'         '/etc/varnish/conf/acl.vcl'
_gotpl 'conf/backend.vcl.tmpl'     '/etc/varnish/conf/backend.vcl'
_gotpl 'lib/bigfiles.vcl.tmpl'     '/etc/varnish/lib/bigfiles.vcl'
_gotpl 'lib/cloudflare.vcl.tmpl'   '/etc/varnish/lib/cloudflare.vcl'
_gotpl 'lib/mobile_cache.vcl.tmpl' '/etc/varnish/lib/mobile_cache.vcl'
_gotpl 'lib/mobile_pass.vcl.tmpl'  '/etc/varnish/lib/mobile_pass.vcl'
_gotpl 'lib/purge.vcl.tmpl'        '/etc/varnish/lib/purge.vcl'
_gotpl 'lib/static.vcl.tmpl'       '/etc/varnish/lib/static.vcl'
_gotpl 'lib/xforward.vcl.tmpl'     '/etc/varnish/lib/xforward.vcl'
