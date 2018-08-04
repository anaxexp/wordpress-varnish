ARG BASE_IMAGE_TAG

FROM anaxexperience/varnish:${BASE_IMAGE_TAG}

COPY templates /etc/gotpl
COPY init /docker-entrypoint-init.d/