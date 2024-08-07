FROM alpine:latest

ARG VERSION

ENV ENV="/etc/profile"

RUN apk update && apk upgrade && apk add --no-cache --virtual .deps tar curl && \
    ARCH=$(apk info --print-arch) && \
    case "$ARCH" in \
        x86)    _arch=i386      ;; \
        x86_64) _arch=x86_64    ;; \
        arm64)  _arch=aarch64    ;; \
        armv7)  _arch=armhf     ;; \
        *)      _arch="$ARCH"   ;; \
    esac && \
    cd /tmp && \
    curl -sSL https://install.speedtest.net/app/cli/ookla-speedtest-${VERSION}-linux-${_arch}.tgz | tar xz && \
    mv /tmp/speedtest /usr/local/bin/ && \
    rm -rf /tmp/speedtest.* && \
    speedtest --accept-license --accept-gdpr && \
    echo "alias vi='vim'" > ~/.profile && \
    echo "alias l='ls -alF'" >> ~/.profile && \
    echo "alias ls='ls -alF --color=auto'" >> ~/.profile && \
    echo "alias speedtest='/usr/local/bin/speedtest --accept-license --accept-gdpr'" >> ~/.profile && \
    apk del .deps

COPY scripts/aliases.sh /etc/profile.d/aliases.sh

CMD ["/bin/sh", "-l"]