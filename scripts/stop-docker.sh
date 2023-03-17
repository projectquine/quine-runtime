#!/data/data/com.termux/files/usr/bin/sh

if [ sudo test -f /data/docker/run/docker.pid ]; then
  # Get the process IDs for all Docker-related processes
  pids=$(sudo pgrep -f docker)

  # Send SIGTERM to all the Docker-related processes
  sudo kill -s SIGTERM $pids

  # Wait for 5 seconds
  sleep 5

  # Check if the docker.pid file has been removed
  if [ -f /data/docker/run/docker.pid ]; then
    # Send SIGKILL to all the Docker-related processes
    sudo kill -s SIGKILL $pids

    # Remove the docker.pid file
    sudo rm /data/docker/run/docker.pid
  fi
fi