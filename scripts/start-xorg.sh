#!/data/data/com.termux/files/usr/bin/sh

# this requires x11-repo and xorg-server-xvfb to be installed already
echo "Staring X11 server"
Xvfb :0 -ac &
DISPLAY=:0 termux-x11 &

# launch the x11 app. This will only bring it to the foreground if termux is on screen when it runs.
am start -n com.termux.x11/.MainActivity
