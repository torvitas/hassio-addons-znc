ARG BUILD_FROM=hassioaddons/base:4.0.2
FROM $BUILD_FROM

ARG VERSION_EXTRA=""

# musl silently doesn't support AI_ADDRCONFIG yet, and ZNC doesn't support Happy Eyeballs yet.
# Together they cause very slow connection. So for now IPv6 is disabled here.
ARG CMAKEFLAGS="-DVERSION_EXTRA=${VERSION_EXTRA} -DCMAKE_INSTALL_PREFIX=/opt/znc -DWANT_CYRUS=YES -DWANT_PERL=YES -DWANT_PYTHON=YES -DWANT_IPV6=NO"
ARG MAKEFLAGS=""

ARG ZNC_VERSION

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Add env
ENV TERM="xterm-256color"


RUN set -x \
    && adduser -S znc \
    && addgroup -S znc \
    && apk add --no-cache --virtual runtime-dependencies \
        znc \
        znc-extra \
        znc-modpython \
        znc-modperl \
        znc-doc \
        ca-certificates \
        cyrus-sasl \
        icu \
        su-exec \
        tini \
        tzdata

COPY src/ /

VOLUME /znc-data
EXPOSE 1337

ENTRYPOINT ["/entrypoint.sh"]

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="ZNC IRC Bouncer" \
    io.hass.description="ZNC, an advanced IRC bouncer" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Sascha Marcel Schmidt <mail@saschaschmidt.net>" \
    org.label-schema.description="ZNC, an advanced IRC bouncer" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="ZNC IRC Bouncer" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.usage="https://github.com/torvitas/hassio-addons-znc/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/torvitas/hassio-addons-znc" \
    org.label-schema.vendor="Community Hass.io Add-ons"
