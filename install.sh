#!/data/data/com.termux/files/usr/bin/sh

# Get the directory path of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "The script is located in the directory: $DIR"

install_scripts_to_opt() {
    echo "installing scripts for quineOS to /opt"
    install -Dm 777 $DIR/scripts/start-docker.sh ${PREFIX}/opt/quine/scripts/start-docker.sh
    install -Dm 777 $DIR/scripts/stop-docker.sh ${PREFIX}/opt/quine/scripts/stop-docker.sh
    install -Dm 777 $DIR/scripts/setup-docker-networking.sh ${PREFIX}/opt/quine/scripts/setup-docker-networking.sh
    install -Dm 777 $DIR/scripts/canbus.sh ${PREFIX}/opt/quine/scripts/canbus.sh
    install -Dm 777 $DIR/scripts/build-tini.sh ${PREFIX}/opt/quine/scripts/build-tini.sh
    install -Dm 777 $DIR/scripts/watch-tty.sh ${PREFIX}/opt/quine/scripts/watch-tty.sh
    install -Dm 777 $DIR/scripts/start-xorg.sh ${PREFIX}/opt/quine/scripts/start-xorg.sh
    install -Dm 777 $DIR/scripts/start-prind.sh ${PREFIX}/opt/quine/scripts/start-prind.sh
    install -Dm 777 $DIR/scripts/stop-prind.sh ${PREFIX}/opt/quine/scripts/stop-prind.sh
}

install_bash_rc() {
    echo "installing bashrc file"
    install -Dm 777 $DIR/bashrc ${PREFIX}/etc/bash.bashrc
}

install_packages() {
    echo "installing pkg dependencies"
    pkg install -y x11-repo
    pkg install -y docker docker-compose xorg-server-xvfb
    pkg install -y $DIR/assets/termux-x11-1.02.07-0-all.deb
}

install_scripts_to_opt
install_bash_rc
install_packages