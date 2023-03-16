#!/data/data/com.termux/files/usr/bin/bash
sudo pm list packages | grep com.termux.boot >/dev/null && export a=1 || export a=0
if [ "$a" -eq 1 ]; then
        mkdir -p "$HOME"/.termux/boot/                  echo '#!/data/data/com.termux/files/usr/bin/sh' > "$HOME"/.termux/boot/start-services
        echo termux-wake-lock >> "$HOME"/.termux/boot/start-services
        echo '. $PREFIX/etc/profile' >> "$HOME"/.termux/boot/start-services                             # delete this script, prevent re-execution.
        rm "$PREFIX"/etc/profile.d/boot.sh > /dev/null                                          
fi
