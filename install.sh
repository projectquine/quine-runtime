echo "installing scripts for quineOS to /opt"
install -Dm 777 ./scripts/docker.sh ${PREFIX}/opt/docker.sh
install -Dm 777 ./scripts/network.sh ${PREFIX}/opt/network.sh
install -Dm 777 ./scripts/canbus.sh ${PREFIX}/opt/canbus.sh
install -Dm 777 ./scripts/build-tini.sh ${PREFIX}/opt/build-tini.sh
install -Dm 777 ./scripts/find-serial.sh ${PREFIX}/opt/find-serial.sh

install -Dm 777 ./bashrc ${PREFIX}/etc/bash.bashrc
