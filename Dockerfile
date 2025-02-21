FROM ubuntu:22.04

LABEL AboutImage="Grass miner"
LABEL Maintainer="Alone <hi@anlo.ng>"

ENV VNC_PASS="CHANGE_IT" \
    VNC_TITLE="Grass (Referral code: IlJGw0ovdrhi_mk)" \
    VNC_RESOLUTION="360x640" \
    VNC_SHARED=false \
    PORT=8080 \
    DISPLAY=:0 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEB_PATH="Grass_5.1.0_amd64.deb"

COPY rootfs/ /

RUN set -eux; \
    # sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list; \
    # sed -i 's@//ports.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list; \
    apt update; \
   	apt install -y wget supervisor xvfb x11vnc websockify openbox ca-certificates; \
    \
    arch=$(uname -m); \
    if [ "$arch" = "arm64" ] || [ "$arch" = "aarch64" ]; then \
        apt install -y qemu-user-static libc-bin; \
        update-binfmts --enable qemu-x86_64; \
        dpkg --add-architecture amd64; \
        cat /etc/sources.arm64 > /etc/apt/sources.list; \
        apt update; \
        apt install -y libc6:amd64 fuse:amd64 libayatana-appindicator3-1:amd64 libwebkit2gtk-4.1-0:amd64; \
    else \
        apt install -y fuse libayatana-appindicator3-1 libwebkit2gtk-4.1-0; \
    fi; \
    wget https://files.getgrass.io/file/grass-extension-upgrades/ubuntu-22.04/$DEB_PATH; \
    dpkg -i $DEB_PATH; \
    rm -f $DEB_PATH; \
	openssl req -new -newkey rsa:4096 -days 36500 -nodes -x509 -subj "/C=IN/O=Dis/CN=www.google.com" \
                -keyout /etc/ssl/novnc.key -out /etc/ssl/novnc.cert > /dev/null 2>&1; \
	chmod a+x /entrypoint.sh;

CMD ["/entrypoint.sh", "supervisord", "-l", "/var/log/supervisord.log", "-c", "/etc/supervisord.conf"]
