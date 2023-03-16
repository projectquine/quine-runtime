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

# Create the start-services script in ~/.termux/boot to launch all other services using runit
sudo pm list packages | grep com.termux.boot >/dev/null && export a=1 || export a=0
if [ "$a" -eq 1 ]; then
        mkdir -p "$HOME"/.termux/boot/                  
        echo '#!/data/data/com.termux/files/usr/bin/sh' > "$HOME"/.termux/boot/start-services
        echo termux-wake-lock >> "$HOME"/.termux/boot/start-services
        echo '. $PREFIX/etc/profile' >> "$HOME"/.termux/boot/start-services                                                                 
fi

# Check if we are connected to the internet for the install
echo "Checking for internet access..."
while ! ping -c 1 google.com &> /dev/null; do
    echo "No internet access. Waiting for 5 seconds..."
    sleep 5
done
echo "Internet access is available."

# Pull and install quine runtime
git clone --depth 1 https://github.com/projectquine/quine-runtime.git $TMPDIR/quine-runtime
bash $TMPDIR/quine-runtime/install.sh

# delete this script, prevent re-execution.     
rm "$PREFIX"/etc/profile.d/first-boot.sh > /dev/null 

# Reboot once everything is installed
sudo /system/bin/reboot