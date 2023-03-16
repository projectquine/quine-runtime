#!/data/data/com.termux/files/usr/bin/sh

# Get the directory path of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "The script is located in the directory: $DIR"

install_scripts_to_opt() {
    echo "installing scripts for quineOS to /opt"
    install -Dm 777 $DIR/scripts/docker.sh ${PREFIX}/opt/quine/scripts/docker.sh
    install -Dm 777 $DIR/scripts/network.sh ${PREFIX}/opt/quine/scripts/network.sh
    install -Dm 777 $DIR/scripts/canbus.sh ${PREFIX}/opt/quine/scripts/canbus.sh
    install -Dm 777 $DIR/scripts/build-tini.sh ${PREFIX}/opt/build-tini.sh
    install -Dm 777 $DIR/scripts/watch-tty.sh ${PREFIX}/opt/quine/scripts/watch-tty.sh
    install -Dm 777 $DIR/scripts/start-xorg.sh ${PREFIX}/opt/quine/scripts/start-xorg.sh
}

install_bash_rc() {
    install -Dm 777 $DIR/bashrc ${PREFIX}/etc/bash.bashrc
}

install_dockerd_service() {
    mkdir $PREFIX/var/service/dockerd
    mkdir $PREFIX/var/service/dockerd/log
    ln -sf $PREFIX/share/termux-services/svlogger $PREFIX/var/service/dockerd/log/run
    install -Dm 777 $DIR/services/dockerd/run $PREFIX/var/service/dockerd/run
    sv-enable dockerd
}

install_serialwatcher_service() {
    mkdir $PREFIX/var/service/serialwatcher
    mkdir $PREFIX/var/service/serialwatcher/log
    ln -sf $PREFIX/share/termux-services/svlogger $PREFIX/var/service/serialwatcher/log/run
    install -Dm 777 $DIR/services/serialwatcher/run $PREFIX/var/service/serialwatcher/run
    sv-enable serialwatcher
}

install_xorg_service() {
    mkdir $PREFIX/var/service/xorg
    mkdir $PREFIX/var/service/xorg/log
    ln -sf $PREFIX/share/termux-services/svlogger $PREFIX/var/service/xorg/log/run
    install -Dm 777 $DIR/services/xorg/run $PREFIX/var/service/xorg/run
    sv-enable xorg
}

install_scripts_to_opt
install_bash_rc

# Initialize /etc/profile, so that sv-enable works
. $PREFIX/etc/profile
sv-enable sshd

install_dockerd_service
install_serialwatcher_service
install_xorg_service
