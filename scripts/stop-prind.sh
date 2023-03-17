# Stop all prind containers
cd $PREFIX/opt/prind
sudo DOCKER_HOST=unix:///data/docker/run/docker.sock docker-compose --profile mainsail --profile klipperscreen down