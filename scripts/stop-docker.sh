#!/data/data/com.termux/files/usr/bin/sh

docker_res=$(sudo curl -f -s  "Content-Type: application/json" --unix-socket /data/docker/run/docker.sock http://localhost/_ping)
echo $docker_res 
if [ $docker_res == "OK" ]; then
  echo "Found running docker instance"
  # Get the process IDs for all Docker-related processes
  pids=$(sudo pgrep -f docker)
  # Send SIGTERM to all the Docker-related processes
  sudo kill -s SIGTERM $pids
  # Wait for 5 seconds
  sleep 5
  # Send SIGKILL to all the Docker-related processes
  sudo kill -s SIGKILL $pids
  # Remove the docker.pid file
  sudo rm /data/docker/run/docker.pid
else
  echo "No Docker instance found running, so doing nothing!"
fi