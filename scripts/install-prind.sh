#!/usr/bin/env bash

check_dependencies() {
  for cmd in git docker docker-compose; do
    if ! which $cmd &> /dev/null; then
      echo "ERROR: $cmd is not installed"
      exit 1
    fi
  done
  echo "All dependencies are installed"
}

get_prind_src() {
  if [ -d $PREFIX/opt/prind ]; then
    echo "prind source already exists"
  else
    echo "Directory ~/prind does not exist, cloning..."
    git clone https://github.com/shaunmulligan/prind.git $PREFIX/opt/prind
  fi
}

pull_containers() {
  cd ~/prind
  if sudo curl --unix-socket /data/docker/run/docker.sock http://localhost/info &> /dev/null; then
    echo "Running docker compose pull"
    sudo DOCKER_HOST=unix:///data/docker/run/docker.sock docker-compose --profile mainsail pull
  else
    echo "ERROR: Docker daemon is not running!!"
    exit 1
  fi
  #docker-compose --profile mainsail up --remove-orphans 
  cd -
}

check_dependencies
get_prind_src
pull_containers
