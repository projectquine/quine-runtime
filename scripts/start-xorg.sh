#!/data/data/com.termux/files/usr/bin/sh

# this requires x11-repo and xorg-server-xvfb to be installed already
echo "Staring X11 server"
Xvfb :0 -ac &
DISPLAY=:0 termux-x11 &

# TODO: use `am start activity` to launch the x11 app and bring it to the foreground
