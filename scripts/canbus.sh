# Teardown old
sudo ip link set can0 down
sudo ip link set vxcan0 down
sudo ip link del vxcan0

# Setup Can0 interface to forward traffic to klipper docker container.
DOCKERPID=$(sudo docker inspect -f '{{ .State.Pid }}' prind-klipper-1)

sudo ip link add vxcan0 type vxcan peer name vxcan1 netns $DOCKERPID

sudo cangw -A -s can0 -d vxcan0 -e
sudo cangw -A -s vxcan0 -d can0 -e

sudo ip link set vxcan0 up
sudo ip link set can0 type can bitrate 500000

sudo ip link set can0 up
sudo nsenter -t $DOCKERPID -n ip link set vxcan1 up
