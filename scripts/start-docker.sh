#!/data/data/com.termux/files/usr/bin/sh

# It will make storage writable to add some file and folders docker require
sudo mount -o remount,rw /

# It will make cgroup mountable as existing process in dockerd can not mount properly

sudo mount -t tmpfs -o mode=755 tmpfs /sys/fs/cgroup
sudo mkdir -p /sys/fs/cgroup/devices
sudo mount -t cgroup -o devices cgroup /sys/fs/cgroup/devices

# Now gracefully start docker
# iptables command not required as we have now network access

sudo dockerd # --iptables=false
