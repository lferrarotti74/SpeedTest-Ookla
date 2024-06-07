FROM alpine:latest

ARG VERSION

ENV ENV="/etc/profile"

RUN apk add --no-cache --virtual .deps tar curl && \
    ARCH=$(apk info --print-arch) && \
    case "$ARCH" in \
        x86)    _arch=i386      ;; \
        x86_64) _arch=x86_64    ;; \
        armv7)  _arch=armhf     ;; \
        *)      _arch="$ARCH"   ;; \
    esac && \
    cd /tmp && \
    curl -sSL https://install.speedtest.net/app/cli/ookla-speedtest-${VERSION}-linux-${_arch}.tgz | tar xz && \
    mv /tmp/speedtest /usr/local/bin/ && \
    rm -rf /tmp/speedtest.* && \
    speedtest --accept-license --accept-gdpr && \
    apk del .deps

COPY scripts/aliases.sh /etc/profile.d/aliases.sh