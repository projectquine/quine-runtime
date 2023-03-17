#!/data/data/com.termux/files/usr/bin/sh

# Wait for Docker to be up and running
while ! sudo docker info &> /dev/null ; do
    sleep 1
done

echo "Docker is up and running"

# Launch prind in detached mode
cd $PREFIX/opt/prind
sudo DOCKER_HOST=unix:///data/docker/run/docker.sock docker-compose --profile mainsail --profile klipperscreen up -d

# Setup CANbus interface
bash  $PREFIX/opt/quine/scripts/canbus.sh
