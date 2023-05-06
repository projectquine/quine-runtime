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

install_fake_os_release() {
    install -Dm 777 $DIR/os-release ${PREFIX}/usr/lib/os-release
}

install_fake_systemctl() {
    install -Dm 777 $DIR/scripts/fake_systemctl ${PREFIX}/bin/systemctl
}

install_bash_rc() {
    echo "installing bashrc file"
    install -Dm 777 $DIR/bashrc ${PREFIX}/etc/bash.bashrc
}

install_packages() {
    echo "installing pkg dependencies"
    pkg install -y x11-repo
    pkg install -y docker docker-compose xorg-server-xvfb jq
    pkg install -y $DIR/assets/termux-x11-1.02.07-0-all.deb
}

configure_docker_daemon() {
    echo "configuring Docker daemon"
    DAEMON_JSON_PATH="/data/data/com.termux/files/usr/etc/docker/daemon.json"

    # Read the existing JSON content and decode it
    existing_content=$(cat $DAEMON_JSON_PATH)
    json=$(echo "$existing_content" | jq '.')

    # Update the "hosts" key by adding "tcp://127.0.0.1:2375"
    updated_json=$(echo "$json" | jq '.hosts += ["tcp://127.0.0.1:2375"]')

    # Write the updated JSON content back to the daemon.json file
    echo "$updated_json" > $DAEMON_JSON_PATH
}

# Check if the 'jq' command is available, install it if not
if ! command -v jq >/dev/null; then
    echo "Installing 'jq' package"
    pkg install -y jq
fi

install_scripts_to_opt
install_bash_rc
install_packages
install_fake_os_release
configure_docker_daemon
