# Launch prind in detached mode
cd $PREFIX/opt/prind
sudo DOCKER_HOST=unix:///data/docker/run/docker.sock docker-compose --profile mainsail --profile klipperscreen up -d

# Setup CANbus interface
bash  $PREFIX/opt/scripts/canbus.sh
