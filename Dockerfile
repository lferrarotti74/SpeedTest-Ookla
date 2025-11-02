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

# Update packages to latest versions to fix CVEs and install required packages
# Use --no-cache to avoid package cache and explicitly upgrade curl and libcurl to ensure CVE fixes are applied
RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache tar curl && \
    apk upgrade --no-cache curl libcurl && \
    ARCH=$(apk info --print-arch) && \
    case "$ARCH" in \
        x86)    _arch=i386      ;; \
        x86_64) _arch=x86_64    ;; \
        arm64)  _arch=aarch64    ;; \
        armv7)  _arch=armhf     ;; \
        *)      _arch="$ARCH"   ;; \
    esac && \
    cd /tmp && \
    curl --proto "=https" --tlsv1.2 -sSf -L "https://install.speedtest.net/app/cli/ookla-speedtest-${VERSION}-linux-${_arch}.tgz" | tar xz && \
    mv /tmp/speedtest /usr/local/bin/ && \
    rm -rf /tmp/speedtest.* && \
    rm -rf /var/cache/apk/* && \
    addgroup -S speedtest \
    && adduser -S speedtest -G speedtest -g "speedtest" -h /home/speedtest

# Copy aliases script (make sure it's executable)
COPY scripts/aliases.sh /etc/profile.d/aliases.sh
RUN chmod +x /etc/profile.d/aliases.sh

USER speedtest
WORKDIR /home/speedtest
RUN mkdir -p /home/speedtest/.config/ookla/
COPY scripts/speedtest-cli.json /home/speedtest/.config/ookla/speedtest-cli.json
#RUN speedtest --accept-license --accept-gdpr --help > /dev/null 2>&1 || true

CMD ["/bin/sh", "-l"]
