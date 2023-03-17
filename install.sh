#!/data/data/com.termux/files/usr/bin/sh

# Get the directory path of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "The script is located in the directory: $DIR"

install_scripts_to_opt() {
    echo "installing scripts for quineOS to /opt"
    install -Dm 777 $DIR/scripts/start-docker.sh ${PREFIX}/opt/quine/scripts/start-docker.sh
    install -Dm 777 $DIR/scripts/setup-docker-networking.sh ${PREFIX}/opt/quine/setup-docker-networking.sh
    install -Dm 777 $DIR/scripts/canbus.sh ${PREFIX}/opt/quine/scripts/canbus.sh
    install -Dm 777 $DIR/scripts/build-tini.sh ${PREFIX}/opt/build-tini.sh
    install -Dm 777 $DIR/scripts/watch-tty.sh ${PREFIX}/opt/quine/scripts/watch-tty.sh
    install -Dm 777 $DIR/scripts/start-xorg.sh ${PREFIX}/opt/quine/scripts/start-xorg.sh
    install -Dm 777 $DIR/scripts/start-prind.sh ${PREFIX}/opt/quine/scripts/start-prind.sh
}

install_bash_rc() {
    install -Dm 777 $DIR/bashrc ${PREFIX}/etc/bash.bashrc
}

install_packages() {
    pkg install x11-repo
    pkg install docker docker-compose xorg-server-xvfb
    pkg install $DIR/assets/termux-x11-1.02.07-0-all.deb
}

install_scripts_to_opt
install_bash_rc
install_packages