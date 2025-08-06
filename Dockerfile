FROM ubuntu:22.04

LABEL AboutImage="Grass miner"
LABEL Maintainer="Alone <hi@anlo.ng>"

ARG APP_VERSION
ENV VNC_PASS="CHANGE_IT" \
    VNC_TITLE="Grass (Referral code: IlJGw0ovdrhi_mk)" \
    VNC_RESOLUTION="360x640" \
    VNC_SHARED=false \
    MIHOMO_CONFIG="" \
    PORT=8080 \
    DISPLAY=:0 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai \
    VER_JSON="https://files.getgrass.io/file/grass-extension-upgrades/desktop-installer-latest.json"

COPY rootfs/ /

RUN set -eux; \
    sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list; \
    sed -i 's@//ports.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list; \
    apt update; \
    apt install -y tzdata ca-certificates; \
    cat /usr/share/zoneinfo/$TZ > /etc/localtime; \
   	apt install -y curl jq supervisor xvfb x11vnc websockify openbox aptitude iptables; \
    \
    arch=$(uname -m); \
    if [ "$arch" = "arm64" ] || [ "$arch" = "aarch64" ]; then \
        aptitude install -y qemu-user-static libc-bin; \
        update-binfmts --enable qemu-x86_64; \
        dpkg --add-architecture amd64; \
        cat /etc/sources.arm64 > /etc/apt/sources.list; \
        aptitude update; \
        aptitude install -y libc6:amd64 fuse:amd64 libayatana-appindicator3-1:amd64 libwebkit2gtk-4.1-0:amd64 libgtk-3-0:amd64; \
    else \
        apt install -y fuse libayatana-appindicator3-1 libwebkit2gtk-4.1-0 libgtk-3-0; \
    fi; \
    if [ -n "$APP_VERSION" ]; then \
        DEB_NAME="Grass_${APP_VERSION}_amd64.deb"; \
        DEB_PATH=https://files.getgrass.io/file/grass-extension-upgrades/v${APP_VERSION}/$DEB_NAME; \
    else \
        DEB_NAME='grass.deb'; \
        DEB_PATH=$(curl -s "$VER_JSON" | jq -r '.platforms."linux-x86_64".url'); \
    fi; \
    curl -fL -o $DEB_NAME $DEB_PATH; \
    dpkg -i $DEB_NAME; \
    rm -f $DEB_NAME; \
	openssl req -new -newkey rsa:4096 -days 36500 -nodes -x509 -subj "/C=IN/O=Dis/CN=www.google.com" \
                -keyout /etc/ssl/novnc.key -out /etc/ssl/novnc.cert > /dev/null 2>&1; \
	chmod a+x /entrypoint.sh;

COPY --from=metacubex/mihomo /mihomo /use/bin/
COPY --from=metacubex/mihomo /root/.config/mihomo/ /root/.config/mihomo/
VOLUME [ "/root/.config/mihomo" ]

CMD ["/entrypoint.sh", "supervisord", "-l", "/var/log/supervisord.log", "-c", "/etc/supervisord.conf"]
