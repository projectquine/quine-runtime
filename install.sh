#!/data/data/com.termux/files/usr/bin/sh

install_scripts_to_opt() {
    echo "installing scripts for quineOS to /opt"
    install -Dm 777 ./scripts/docker.sh ${PREFIX}/opt/quine/scripts/docker.sh
    install -Dm 777 ./scripts/network.sh ${PREFIX}/opt/quine/scripts/network.sh
    install -Dm 777 ./scripts/canbus.sh ${PREFIX}/opt/quine/scripts/canbus.sh
    install -Dm 777 ./scripts/build-tini.sh ${PREFIX}/opt/build-tini.sh
    install -Dm 777 ./scripts/watch-tty.sh ${PREFIX}/opt/quine/scripts/watch-tty.sh
    install -Dm 777 ./scripts/start-xorg.sh ${PREFIX}/opt/quine/scripts/start-xorg.sh
}

install_bash_rc() {
    install -Dm 777 ./bashrc ${PREFIX}/etc/bash.bashrc
}

install_dockerd_service() {
    mkdir $PREFIX/var/service/dockerd
    mkdir $PREFIX/var/service/dockerd/log
    ln -sf $PREFIX/share/termux-services/svlogger $PREFIX/var/service/dockerd/log/run
    install -Dm 777 ./services/dockerd/run $PREFIX/var/service/dockerd/run
    sv-enable dockerd
}

install_serialwatcher_service() {
    mkdir $PREFIX/var/service/serialwatcher
    mkdir $PREFIX/var/service/serialwatcher/log
    ln -sf $PREFIX/share/termux-services/svlogger $PREFIX/var/service/serialwatcher/log/run
    install -Dm 777 ./services/serialwatcher/run $PREFIX/var/service/serialwatcher/run
    sv-enable serialwatcher
}

install_sshd_service() {
    # the rest is setup by default when openssh is installed
    sv-enable sshd
}

install_xorg_service() {
    mkdir $PREFIX/var/service/xorg
    mkdir $PREFIX/var/service/xorg/log
    ln -sf $PREFIX/share/termux-services/svlogger $PREFIX/var/service/xorg/log/run
    install -Dm 777 ./services/xorg/run $PREFIX/var/service/xorg/run
    sv-enable xorg
}

install_scripts_to_opt
install_bash_rc
install_dockerd_service
install_serialwatcher_service
install_sshd_service
install_xorg_service