#!/data/data/com.termux/files/usr/bin/bash

# Check if we have sudo privileges yet
if [[ $(sudo ls 2>&1) == *"Permission denied"* ]]; then
    echo "You don't have sudo privileges."
    echo "Please grant them in the Magisk app!"
    # Keep trying until user gets sudo privileges
    while [[ $(sudo ls 2>&1) == *"Permission denied"* ]]; do
        sleep 1
    done
fi
# Once the user has sudo privileges
echo "You now have sudo privileges."

write_start_sshd() {
    echo '#!/data/data/com.termux/files/usr/bin/sh' > "$HOME"/.termux/boot/start-sshd
    echo termux-wake-lock >> "$HOME"/.termux/boot/start-sshd
    echo 'sshd' >> "$HOME"/.termux/boot/start-sshd   
}

write_boot_dockerd() {
    echo '#!/data/data/com.termux/files/usr/bin/sh' > "$HOME"/.termux/boot/boot-dockerd
    echo exec 2>&1 >> "$HOME"/.termux/boot/boot-dockerd
    echo bash $PREFIX/opt/quine/scripts/setup-docker-networking.sh >> "$HOME"/.termux/boot/boot-dockerd
    echo exec $PREFIX/opt/quine/scripts/start-docker.sh >> "$HOME"/.termux/boot/boot-dockerd
}

write_boot_xorg() {
    echo '#!/data/data/com.termux/files/usr/bin/sh' > "$HOME"/.termux/boot/boot-xorg
    echo exec 2>&1 >> "$HOME"/.termux/boot/boot-xorg
    echo exec $PREFIX/opt/quine/scripts/start-xorg.sh >> "$HOME"/.termux/boot/boot-xorg
}

write_boot_serial_watcher() {
    echo '#!/data/data/com.termux/files/usr/bin/sh' > "$HOME"/.termux/boot/boot-serial-watcher
    echo exec 2>&1 >> "$HOME"/.termux/boot/boot-serial-watcher
    echo exec $PREFIX/opt/quine/scripts/watch-tty.sh >> "$HOME"/.termux/boot/boot-serial-watcher
}

write_boot_quine() {
    echo '#!/data/data/com.termux/files/usr/bin/sh' > "$HOME"/.termux/boot/boot-quine
    echo exec 2>&1 >> "$HOME"/.termux/boot/boot-quine
    echo exec $PREFIX/opt/quine/scripts/start-prind.sh >> "$HOME"/.termux/boot/boot-quine
}

# Create the start-services script in ~/.termux/boot to launch all other services using runit
# TODO: do this without sudo, based on : https://github.com/termux/termux-packages/discussions/8292#discussioncomment-5102555
sudo pm list packages | grep com.termux.boot >/dev/null && export a=1 || export a=0  
if [ "$a" -eq 1 ]; then
        mkdir -p "$HOME"/.termux/boot/                  
        write_start_sshd
        write_boot_dockerd
        write_boot_xorg
        write_boot_quine                                                       
fi

# Check if we are connected to the internet for the install
echo "Checking for internet access..."
while ! ping -c 1 google.com &> /dev/null; do
    echo "No internet access. Waiting for 5 seconds..."
    sleep 5
done
echo "Internet access is available."

# Setup default password:
yes quine | passwd

# Generate SSH key
echo "generating ssh keys"
ssh-keygen -A

# Pull and install quine runtime
echo "cloning quine runtime"
git clone --depth 1 https://github.com/projectquine/quine-runtime.git $TMPDIR/quine-runtime
bash $TMPDIR/quine-runtime/install.sh

echo "cloning quine prind repo"
git clone --depth 1 https://github.com/projectquine/prind.git $PREFIX/opt/prind

# delete this script, prevent re-execution.     
rm "$PREFIX"/etc/profile.d/first-boot.sh > /dev/null 

# Reboot once everything is installed
echo "Rebooting system to start system"
sudo /system/bin/reboot