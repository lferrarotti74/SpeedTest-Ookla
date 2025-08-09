FROM alpine:3

# Define an optional build argument to invalidate cache
ARG CACHEBUST=1

ARG VERSION

LABEL org.opencontainers.image.title="SpeedTest-Ookla"
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.description="SpeedTest-Ookla - Internet connection measurement for developers"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/lferrarotti74/SpeedTest-Ookla"

ENV ENV="/etc/profile"

RUN apk --no-cache update && apk --no-cache upgrade && apk --update --no-cache --virtual .deps add tar curl && \
    ARCH=$(apk info --print-arch) && \
    case "$ARCH" in \
        x86)    _arch=i386      ;; \
        x86_64) _arch=x86_64    ;; \
        arm64)  _arch=aarch64    ;; \
        armv7)  _arch=armhf     ;; \
        *)      _arch="$ARCH"   ;; \
    esac && \
    cd /tmp && \
    curl --proto "=https" --tlsv1.2 -sSf -L https://install.speedtest.net/app/cli/ookla-speedtest-${VERSION}-linux-${_arch}.tgz | tar xz && \
    mv /tmp/speedtest /usr/local/bin/ && \
    rm -rf /tmp/speedtest.* && \
    speedtest --accept-license --accept-gdpr && \
    echo "alias vi='vim'" > ~/.profile && \
    echo "alias l='ls -alF'" >> ~/.profile && \
    echo "alias ls='ls -alF --color=auto'" >> ~/.profile && \
    echo "alias speedtest='/usr/local/bin/speedtest --accept-license --accept-gdpr'" >> ~/.profile && \
    rm -rf /var/cache/apk/* && \
    apk del .deps

# Add copy script and/or files from local to base image
COPY scripts/aliases.sh /etc/profile.d/aliases.sh

CMD ["/bin/sh", "-l"]
