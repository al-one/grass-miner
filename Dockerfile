FROM ubuntu:22.04

LABEL AboutImage="Grass miner"
LABEL Maintainer="Alone <hi@anlo.ng>"

ENV	VNC_PASS="CHANGE_IT" \
	VNC_TITLE="Grass (Referral code: IlJGw0ovdrhi_mk)" \
	VNC_RESOLUTION="360x640" \
	VNC_SHARED=false \
	DEB_PATH="grass_4.28.2_amd64.deb" \
	DISPLAY=:0 \
	NOVNC_PORT=$PORT \
	PORT=8080 \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	TZ="Asia/Shanghai"

COPY rootfs/ /
RUN chmod a+x /entrypoint.sh

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
    apt update
RUN	apt install -y tzdata wget supervisor xvfb x11vnc websockify openbox libayatana-appindicator3-1 libwebkit2gtk-4.1-0 && \
    wget https://files.getgrass.io/file/grass-extension-upgrades/ubuntu-22.04/$DEB_PATH && \
    dpkg -i $DEB_PATH && \
    rm -f $DEB_PATH && \
	openssl req -new -newkey rsa:4096 -days 36500 -nodes -x509 -subj "/C=IN/O=Dis/CN=www.google.com" -keyout /etc/ssl/novnc.key -out /etc/ssl/novnc.cert > /dev/null 2>&1 && \
	cp /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone

ENTRYPOINT ["/entrypoint.sh", "supervisord", "-l", "/var/log/supervisord.log", "-c"]
CMD ["/etc/supervisord.conf"]
