#!/data/data/com.termux/files/usr/bin/sh

# this requires x11-repo and xorg-server-xvfb to be installed already
echo "Staring X11 server"
Xvfb :0 -ac &
DISPLAY=:0 termux-x11 &

