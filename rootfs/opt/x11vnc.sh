sed -i "s/\$DESKTOP/$VNC_TITLE/g" /opt/novnc/index.html
if ((VNC_SHARED==false)); then
  x11vnc -storepasswd $VNC_PASS /etc/.xpass
  x11vnc -usepw -rfbport 5900 -rfbauth /etc/.xpass \
         -geometry $VNC_RESOLUTION \
         -forever -alwaysshared -permitfiletransfer -noxrecord -noxfixes -noxdamage -dpms -bg \
         -desktop "$VNC_TITLE"
else
  x11vnc -storepasswd $VNC_PASS /etc/.xpass
  x11vnc -usepw -rfbport 5900 -rfbauth /etc/.xpass \
         -geometry $VNC_RESOLUTION -forever -shared -alwaysshared -permitfiletransfer -bg \
         -desktop "$VNC_TITLE"
fi